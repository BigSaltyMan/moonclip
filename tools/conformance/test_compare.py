"""Offline tests for contour comparison, catalog integrity and generation failures."""
import copy
import importlib.util
import io
import json
import os
from pathlib import Path
import random
import subprocess
import sys
import tarfile
import tempfile
import unittest
from unittest import mock
from compare import *
ROOT = Path(__file__).resolve().parents[2]

def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result

runner = module("oracle_generate", ROOT / "tools/oracle/generate.py")
builder = module("oracle_build", ROOT / "tools/oracle/build.py")

def contour(points):
    return {"status": "success", "paths": [points], "tree": {"children": [{"path": points, "children": []}]}}

def rect(x=0, y=0, size=4):
    return [[x,y],[x+size,y],[x+size,y+size],[x,y+size]]

class CompareTests(unittest.TestCase):
    def setUp(self):
        self.simple = contour(rect())
        self.nested = load(ROOT / "testdata/comparator/valid/nested.json", True)

    def test_rotated_start(self):
        path = rect()
        compare(self.simple, contour(path[2:]+path[:2]))

    def test_paths_and_siblings_reordered(self):
        compare(self.nested, load(ROOT / "testdata/comparator/valid/reordered.json", True))

    def test_empty_results(self):
        empty = {"status":"success", "paths":[], "tree":{"children":[]}}
        compare(empty, empty)

    def test_repeated_minimum_uses_entire_cycle(self):
        path = [[0,0],[3,0],[0,0],[0,3],[3,3]]
        for i in range(len(path)):
            compare(contour(path), contour(path[i:]+path[:i]))

    def test_normalization_is_idempotent(self):
        value = normalize_path([[2,0],[10,0],[-1,3]])
        self.assertEqual(normalize_path(value), value)
        self.assertEqual(normalize_paths(self.nested["paths"]), normalize_paths(normalize_paths(self.nested["paths"])))

    def test_minimal_rotation_matches_brute_force_for_repeated_points(self):
        rng = random.Random(20261017)
        for length in range(1, 70):
            path = [(rng.randrange(-2,3),rng.randrange(-2,3)) for _ in range(length)]
            expected = min(tuple(path[i:]+path[:i]) for i in range(length))
            self.assertEqual(normalize_path(path), expected)

    def test_integer_sorting_not_decimal_string_order(self):
        paths = [rect(10,0),rect(2,0),rect(-10,0)]
        self.assertEqual([p[0][0] for p in normalize_paths(paths)], [-10,2,10])

    def test_fixture_rejections(self):
        paths = sorted((ROOT / "testdata/comparator/invalid").glob("*.json"))
        self.assertGreaterEqual(len(paths), 10)
        for path in paths:
            with self.subTest(fixture=path.name):
                expected = self.nested if path.name.startswith("nested_") else self.simple
                with self.assertRaises(Invalid):
                    compare(expected, load(path, True), path.name)

    def test_wrong_hole_owner_and_island_depth_fail_tree_comparison_only(self):
        for path in sorted((ROOT / "testdata/comparator/invalid").glob("nested_*.json")):
            actual = load(path, True)
            validate_geometry(actual)
            self.assertEqual(normalize_paths(self.nested["paths"]), normalize_paths(actual["paths"]))
            with self.subTest(fixture=path.name), self.assertRaisesRegex(Invalid, r"\.tree"):
                compare(self.nested, actual)

    def test_all_valid_fixture_files_are_validated(self):
        paths = sorted((ROOT / "testdata/comparator/valid").glob("*.json"))
        self.assertEqual(len(paths), 5)
        for path in paths:
            validate_geometry(load(path, True), path.name)

    def test_duplicate_multiplicity_is_not_a_set(self):
        doubled = copy.deepcopy(self.simple)
        doubled["paths"] *= 2
        doubled["tree"]["children"] *= 2
        with self.assertRaisesRegex(Invalid,"paths"):
            compare(self.simple,doubled)

    def test_equal_area_is_not_equal_shape(self):
        # 4x4 square and 8x2 rectangle both have area2 32; written independently.
        other = contour([[0,0],[8,0],[8,2],[0,2]])
        self.assertEqual(metrics(self.simple)["paths"][0]["area2"], "32")
        self.assertEqual(metrics(other)["paths"][0]["area2"], "32")
        with self.assertRaisesRegex(Invalid,"contours differ"):
            compare(self.simple,other)

    def test_collinear_vertex_must_not_be_deleted(self):
        expected = load(ROOT / "testdata/comparator/valid/collinear.json", True)
        with self.assertRaisesRegex(Invalid, "contours differ"):
            compare(expected, self.simple)

    def test_winding_is_not_ignored(self):
        with self.assertRaises(Invalid):
            compare(self.simple,contour(list(reversed(rect()))))

    def test_all_contours_reversed_is_not_equivalent(self):
        other = copy.deepcopy(self.nested)
        for path in other["paths"]:
            path.reverse()
        def reverse_nodes(nodes):
            for node in nodes:
                node["path"].reverse()
                reverse_nodes(node["children"])
        reverse_nodes(other["tree"]["children"])
        with self.assertRaises(Invalid):
            compare(self.nested,other)

    def test_exact_metrics_and_hierarchy(self):
        result = metrics(self.nested)
        self.assertEqual((result["path_count"],result["vertex_count"],result["tree_depth"],result["hole_count"]),(6,24,3,3))
        large = contour(rect(-1000000000,-1000000000,2000000000))
        self.assertEqual(metrics(large)["paths"][0]["area2"],"8000000000000000000")
        self.assertEqual(metrics(large)["paths"][0]["bounds"],[-1000000000,-1000000000,1000000000,1000000000])

    def test_output_repeated_closing_vertex_rejected(self):
        with self.assertRaisesRegex(Invalid,"closing"):
            validate_geometry(contour(rect()+[rect()[0]]))

    def test_contour_vertex_limit(self):
        with self.assertRaisesRegex(Invalid,"limit"):
            validate_geometry(contour([[0,0]]*(MAX_VERTICES+1)))

    def test_contour_count_limit(self):
        value = {"status":"success","paths":[rect()]*(MAX_PATHS+1),"tree":{"children":[]}}
        with self.assertRaisesRegex(Invalid,"limit"):
            validate_geometry(value)

    def test_tree_depth_limit(self):
        node = {"path":rect(),"children":[]}
        for _ in range(MAX_DEPTH):
            node = {"path":rect(),"children":[node]}
        with self.assertRaisesRegex(Invalid,"depth"):
            walk_tree({"children":[node]})

    def test_invalid_tree_root_and_node(self):
        for tree in ({"path":rect(),"children":[]},{"children":[{"children":[]}]},{"children":True}):
            with self.subTest(tree=tree), self.assertRaises(Invalid):
                walk_tree(tree)

    def test_flat_tree_inconsistency(self):
        value = copy.deepcopy(self.simple)
        value["tree"]["children"] = []
        with self.assertRaisesRegex(Invalid,"flat contours"):
            validate_geometry(value)

    def test_failure_cannot_be_a_successful_empty_result(self):
        with self.assertRaisesRegex(Invalid,"tool failure"):
            compare({"status":"success","paths":[],"tree":{"children":[]}}, {"status":"error","paths":[],"tree":{"children":[]}})

class CatalogTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name).resolve()
        for directory in ("tools/oracle","testdata/upstream/inputs","testdata/upstream/expected"):
            (self.root/directory).mkdir(parents=True)
        self.lock = load(ROOT/"tools/oracle/upstream-lock.json",True)
        self.write("tools/oracle/upstream-lock.json",self.lock)
        self.case = {"format_version":1,"case_id":"sample","source":{"kind":"moonclip_constructed","intent":"unit test","group":"unit"},"operation":"Union","fill_rule":"EvenOdd","options":{"preserve_collinear":False,"reverse_solution":False},"subject":[rect()],"clip":[]}
        self.write("testdata/upstream/inputs/sample.json",self.case)
        self.result = contour(rect())
        self.result.update({"format_version":1,"case_id":"sample","input_sha256":sha256(canonical_bytes(self.case)),"oracle_commit":self.lock["commit"],"adapter_protocol_version":1})
        self.result["metrics"] = metrics(self.result)
        self.write("testdata/upstream/expected/sample.json",self.result)
        self.manifest={"format_version":1,"oracle_lock":"tools/oracle/upstream-lock.json","cases":[{"case_id":"sample","input":"testdata/upstream/inputs/sample.json","expected":"testdata/upstream/expected/sample.json","status":"reference_only"}]}
        self.save_manifest()

    def write(self,name,value):
        (self.root/name).write_bytes(canonical_bytes(value))

    def save_manifest(self):
        self.write("testdata/manifest.json",self.manifest)

    def check(self):
        return read_manifest(self.root,self.root/"testdata/manifest.json",strict=True)

    def test_valid_catalog(self):
        self.assertEqual(len(self.check()[1]),1)

    def test_duplicate_case_ids(self):
        self.manifest["cases"] *= 2
        self.save_manifest()
        with self.assertRaisesRegex(Invalid,"duplicate"):
            self.check()

    def test_input_hash_mismatch(self):
        self.case["subject"][0][1][0] = 5
        self.write("testdata/upstream/inputs/sample.json",self.case)
        with self.assertRaisesRegex(Invalid,"hash mismatch"):
            self.check()

    def test_missing_expected(self):
        (self.root/"testdata/upstream/expected/sample.json").unlink()
        with self.assertRaisesRegex(Invalid,"missing"):
            self.check()

    def test_missing_input(self):
        (self.root/"testdata/upstream/inputs/sample.json").unlink()
        with self.assertRaisesRegex(Invalid,"missing"):
            self.check()

    def test_orphan_expected(self):
        self.write("testdata/upstream/expected/orphan.json",self.result)
        with self.assertRaisesRegex(Invalid,"orphan"):
            self.check()

    def test_silently_unlisted_input(self):
        self.write("testdata/upstream/inputs/orphan.json",self.case)
        with self.assertRaisesRegex(Invalid,"unlisted"):
            self.check()

    def test_unknown_status(self):
        self.manifest["cases"][0]["status"]="passed"
        self.save_manifest()
        with self.assertRaisesRegex(Invalid,"status"):
            self.check()

    def test_unknown_input_version(self):
        self.case["format_version"]=2
        with self.assertRaisesRegex(Invalid,"version"):
            validate_input(self.case,"sample")

    def test_unknown_adapter_protocol(self):
        self.result["adapter_protocol_version"]=2
        self.write("testdata/upstream/expected/sample.json",self.result)
        with self.assertRaisesRegex(Invalid,"protocol"):
            self.check()

    def test_unknown_enum_and_options(self):
        for field,value in (("operation","Offset"),("fill_rule","Approximate"),("options",{"preserve_collinear":True,"reverse_solution":False})):
            case=copy.deepcopy(self.case); case[field]=value
            with self.subTest(field=field), self.assertRaises(Invalid):
                validate_input(case,"sample")

    def test_missing_and_unknown_fields(self):
        for name in self.case:
            case=copy.deepcopy(self.case); del case[name]
            with self.subTest(field=name), self.assertRaises(Invalid):
                validate_input(case,"sample")
        self.case["extra"]=0
        with self.assertRaises(Invalid):
            validate_input(self.case,"sample")

    def test_noninteger_coordinate_tokens(self):
        for value in (True,1.0,1.5,"1",None,1000000001,-1000000001):
            case=copy.deepcopy(self.case); case["subject"][0][0][0]=value
            with self.subTest(value=value), self.assertRaises(Invalid):
                validate_input(case,"sample")

    def test_invalid_source_metadata(self):
        for source in ({},{"kind":"unknown"},{"kind":"upstream","file":"x","case_id":"x","sha256":"bad"}):
            case=copy.deepcopy(self.case); case["source"]=source
            with self.subTest(source=source), self.assertRaises(Invalid):
                validate_input(case,"sample")

    def test_metrics_tampering(self):
        for value in ("32.0",32,True,"032","-32"):
            result=copy.deepcopy(self.result)
            result["metrics"]["paths"][0]["area2"]=value
            with self.subTest(value=value), self.assertRaisesRegex(Invalid,"metrics"):
                validate_result(result,self.case,self.result["input_sha256"],self.lock,"sample")

    def test_false_version_is_not_integer_one(self):
        self.case["format_version"]=True
        with self.assertRaises(Invalid):
            validate_input(self.case,"sample")

    def test_duplicate_json_keys_and_nonfinite(self):
        for data in (b'{"x":1,"x":2}',b'{"x":NaN}',b'{"x":Infinity}'):
            with self.subTest(data=data), self.assertRaises(Invalid):
                decode(data)

    def test_noncanonical_encoding_and_file_size(self):
        with self.assertRaisesRegex(Invalid,"canonical"):
            decode(b'{"a":1}',strict=True)
        with self.assertRaisesRegex(Invalid,"size"):
            decode(b' '*(MAX_BYTES+1))

    def test_manifest_path_escape(self):
        with self.assertRaisesRegex(Invalid,"escapes"):
            confined(self.root,"../outside.json")

    def test_offline_catalog_needs_no_process_or_network(self):
        with mock.patch("subprocess.run",side_effect=AssertionError("process forbidden")), mock.patch("urllib.request.urlopen",side_effect=AssertionError("network forbidden")):
            _,records=read_manifest(ROOT,ROOT/"testdata/manifest.json",strict=True)
            self.assertEqual(len(records),200)

    def test_lock_identity_and_checksum_are_required(self):
        for field, value in (("commit", "0"*40), ("adapter_protocol_version", 2)):
            lock = copy.deepcopy(self.lock); lock[field] = value
            with self.subTest(field=field), self.assertRaises(Invalid):
                validate_lock(lock)
        lock = copy.deepcopy(self.lock); lock["archive"]["sha256"] = "0"*64
        with self.assertRaisesRegex(Invalid, "checksum"):
            validate_lock(lock)

    def test_result_id_and_upstream_identity_must_match(self):
        for field, value in (("case_id", "other"), ("oracle_commit", "0"*40)):
            result = copy.deepcopy(self.result); result[field] = value
            with self.subTest(field=field), self.assertRaises(Invalid):
                validate_result(result, self.case, self.result["input_sha256"], self.lock, "sample")

    def test_combined_subject_clip_vertex_budget(self):
        self.case["subject"] = [[[0,0]]*50001]
        self.case["clip"] = [[[0,0]]*50001]
        with self.assertRaisesRegex(Invalid, "combined"):
            validate_input(self.case, "sample")

    def test_unlisted_file_cannot_hide_behind_a_different_extension(self):
        self.write("testdata/upstream/inputs/unlisted.JSON", self.case)
        with self.assertRaisesRegex(Invalid, "unlisted"):
            self.check()

    def test_failed_batch_keeps_entire_baseline(self):
        second=copy.deepcopy(self.case); second["case_id"]="sample2"
        self.write("testdata/upstream/inputs/sample2.json",second)
        self.write("testdata/upstream/expected/sample2.json",self.result)
        self.manifest["cases"].append({"case_id":"sample2","input":"testdata/upstream/inputs/sample2.json","expected":"testdata/upstream/expected/sample2.json","status":"reference_only"})
        self.save_manifest()
        before={p.name:p.read_bytes() for p in (self.root/"testdata/upstream/expected").glob("*")}
        script='import json,sys; q=json.load(sys.stdin); sys.exit(2) if q["case_id"]=="sample2" else None; print(json.dumps({"format_version":1,"case_id":q["case_id"],"adapter_protocol_version":1,"oracle_commit":"'+self.lock['commit']+'","status":"success","paths":[],"tree":{"children":[]}}))'
        with self.assertRaisesRegex(Invalid,"sample2"):
            runner.generate(self.root,self.root/"testdata/manifest.json","write",[sys.executable,"-c",script])
        after={p.name:p.read_bytes() for p in (self.root/"testdata/upstream/expected").glob("*")}
        self.assertEqual(before,after)

    def test_report_failure_does_not_publish_baseline(self):
        baseline = (self.root/"testdata/upstream/expected/sample.json").read_bytes()
        script = 'import json; print(json.dumps({"format_version":1,"case_id":"sample","adapter_protocol_version":1,"oracle_commit":"' + self.lock['commit'] + '","status":"success","paths":[],"tree":{"children":[]}}))'
        original = Path.write_bytes
        def write(path, data):
            if path.name == "generation-report.json":
                raise OSError("Simulated report write failure")
            return original(path, data)
        with mock.patch.object(Path, "write_bytes", write), self.assertRaisesRegex(OSError, "report"):
            runner.generate(self.root, self.root/"testdata/manifest.json", "write", [sys.executable,"-c",script])
        self.assertEqual((self.root/"testdata/upstream/expected/sample.json").read_bytes(), baseline)

class ProcessAndSourceTests(unittest.TestCase):
    def test_nonzero_process_is_tool_failure_even_with_success_empty_stdout(self):
        script='import sys; print(\'{"status":"success","paths":[],"tree":{"children":[]}}\'); sys.exit(2)'
        with self.assertRaisesRegex(Invalid,"exited 2"):
            runner.invoke_oracle([sys.executable,"-c",script],b'{}',"failure",2)

    def test_timeout_is_tool_failure(self):
        with self.assertRaisesRegex(Invalid,"timed out"):
            runner.invoke_oracle([sys.executable,"-c","import time; time.sleep(2)"],b'{}',"slow",0.03)

    def test_success_exit_with_error_envelope_is_tool_failure(self):
        with self.assertRaisesRegex(Invalid,"tool failure"):
            runner.invoke_oracle([sys.executable,"-c",'print(\'{"status":"error","paths":[],"tree":{"children":[]}}\')'],b'{}',"error",2)

    def test_malformed_stdout_is_tool_failure(self):
        with self.assertRaises(Invalid):
            runner.invoke_oracle([sys.executable,"-c",'print("not JSON")'],b'{}',"malformed",2)

    def test_verified_source_detects_edits_and_extra_files(self):
        with tempfile.TemporaryDirectory() as temp:
            directory=Path(temp); archive=directory/"source.tar.gz"; dest=directory/"upstream"
            with tarfile.open(archive,"w:gz") as tar:
                item=tarfile.TarInfo("fixed/src.cpp"); data=b"original"; item.size=len(data)
                tar.addfile(item,io.BytesIO(data))
            builder.verify_source(archive,dest,"fixed")
            (dest/"src.cpp").write_bytes(b"modified")
            with self.assertRaisesRegex(Invalid,"modified"):
                builder.verify_source(archive,dest,"fixed")
            (dest/"src.cpp").write_bytes(b"original"); (dest/"extra.cpp").write_bytes(b"extra")
            with self.assertRaisesRegex(Invalid,"changed"):
                builder.verify_source(archive,dest,"fixed")

    def test_bad_cached_checksum_is_rejected_without_network_fallback(self):
        with tempfile.TemporaryDirectory() as temp:
            path=Path(temp)/"cached"; path.write_bytes(b"corrupt")
            with mock.patch("urllib.request.urlopen",side_effect=AssertionError("network forbidden")), self.assertRaisesRegex(Invalid,"checksum"):
                builder.fetch("https://invalid.example/",path,"0"*64)

if __name__ == "__main__":
    unittest.main()
