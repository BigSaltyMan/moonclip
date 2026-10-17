"""Strict, offline reference schemas and orientation-preserving comparison.
Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""
from __future__ import annotations
import argparse
import hashlib
import json
from pathlib import Path
import re
import sys

MAX_PATHS = 10000
MAX_VERTICES = 100000
MAX_DEPTH = 64
MAX_BYTES = 8 * 1024 * 1024
OPERATIONS = ("Intersection", "Union", "Difference", "Xor")
FILL_RULES = ("EvenOdd", "NonZero", "Positive", "Negative")

class Invalid(ValueError):
    pass

def require(condition, where, message):
    if not condition:
        raise Invalid(f"{where}: {message}")

def keys(value, expected, where):
    require(type(value) is dict, where, "expected object")
    require(set(value) == set(expected), where, f"expected fields {sorted(expected)}")

def integer(value, where, low=0, high=2147483647):
    require(type(value) is int and low <= value <= high, where, "integer outside allowed range")
    return value

def canonical_bytes(value):
    return (json.dumps(value, ensure_ascii=False, sort_keys=True, indent=2, allow_nan=False) + "\n").encode("utf-8")

def sha256(data):
    return hashlib.sha256(data).hexdigest()

def _pairs(pairs):
    result = {}
    for key, value in pairs:
        require(key not in result, "JSON", f"duplicate field {key}")
        result[key] = value
    return result

def decode(data, where="JSON", strict=False):
    require(len(data) <= MAX_BYTES, where, "file size limit exceeded")
    try:
        value = json.loads(data.decode("utf-8"), object_pairs_hook=_pairs,
                           parse_constant=lambda _: (_ for _ in ()).throw(Invalid("JSON: invalid numeric constant")))
    except (UnicodeError, ValueError, RecursionError) as error:
        raise Invalid(f"{where}: {error}") from error
    if strict:
        try:
            require(data == canonical_bytes(value), where, "expected canonical UTF-8, sorted keys, two-space indent and LF")
        except (ValueError, UnicodeError, TypeError) as error:
            raise Invalid(f"{where}: invalid canonical JSON: {error}") from error
    return value

def load(path, strict=False):
    require(path.is_file(), str(path), "missing file")
    require(path.stat().st_size <= MAX_BYTES, str(path), "file size limit exceeded")
    return decode(path.read_bytes(), str(path), strict)

def validate_path(path, where, output=False):
    require(type(path) is list, where, "expected path array")
    require(len(path) <= MAX_VERTICES, where, "vertex limit exceeded")
    if output:
        require(len(path) >= 3, where, "output contour needs at least three vertices")
        require(path[0] != path[-1], where, "repeated closing vertex is forbidden")
    for i, point in enumerate(path):
        require(type(point) is list and len(point) == 2, f"{where}[{i}]", "expected coordinate pair")
        for axis, coordinate in zip(("x", "y"), point):
            integer(coordinate, f"{where}[{i}].{axis}", -1000000000, 1000000000)

def validate_paths(paths, where, output=False):
    require(type(paths) is list and len(paths) <= MAX_PATHS, where, "path count limit or type error")
    total = 0
    for i, path in enumerate(paths):
        validate_path(path, f"{where}[{i}]", output)
        total += len(path)
        require(total <= MAX_VERTICES, where, "total vertex limit exceeded")
    return total

def normalize_path(path):
    """Booth's minimal cyclic rotation; no reversal or vertex deletion. O(V)."""
    points = tuple(tuple(point) for point in path)
    n = len(points)
    if not n:
        return points
    i, j, k = 0, 1, 0
    doubled = points + points
    while i < n and j < n and k < n:
        a, b = doubled[i+k], doubled[j+k]
        if a == b:
            k += 1
            continue
        if a > b:
            i += k + 1
            if i <= j:
                i = j + 1
        else:
            j += k + 1
            if j <= i:
                j = i + 1
        k = 0
    start = min(i, j)
    return points[start:] + points[:start]

def normalize_paths(paths):
    return tuple(sorted(normalize_path(path) for path in paths))

def walk_tree(tree, where="tree"):
    keys(tree, {"children"}, where)
    flattened = []
    holes = 0
    depth_seen = 0
    def visit(children, depth, label):
        nonlocal holes, depth_seen
        require(type(children) is list, label, "expected children array")
        require(depth <= MAX_DEPTH or not children, label, "tree depth limit exceeded")
        for i, node in enumerate(children):
            here = f"{label}[{i}]"
            keys(node, {"path", "children"}, here)
            validate_path(node["path"], here + ".path", True)
            flattened.append(node["path"])
            require(len(flattened) <= MAX_PATHS, here, "tree node limit exceeded")
            depth_seen = max(depth_seen, depth)
            holes += int(depth % 2 == 0)
            visit(node["children"], depth + 1, here + ".children")
    visit(tree["children"], 1, where + ".children")
    require(sum(map(len, flattened)) <= MAX_VERTICES, where, "tree vertex limit exceeded")
    return flattened, depth_seen, holes

def normalize_tree(tree):
    def visit(node):
        return (normalize_path(node["path"]), tuple(sorted(visit(child) for child in node["children"])))
    return tuple(sorted(visit(child) for child in tree["children"]))

def validate_geometry(value, where="result"):
    require(type(value) is dict, where, "expected result object")
    require(value.get("status") == "success", where, "tool failure is not a successful geometry result")
    require("paths" in value and "tree" in value, where, "missing geometry")
    validate_paths(value["paths"], where + ".paths", True)
    flat, _, _ = walk_tree(value["tree"], where + ".tree")
    require(normalize_paths(value["paths"]) == normalize_paths(flat), where, "flat contours and tree contours differ")

def area2(path):
    return sum(a[0]*b[1] - a[1]*b[0] for a, b in zip(path, path[1:] + path[:1]))

def metrics(value):
    _, depth, holes = walk_tree(value["tree"])
    return {
        "path_count": len(value["paths"]),
        "vertex_count": sum(map(len, value["paths"])),
        "tree_depth": depth,
        "hole_count": holes,
        "paths": [{"area2": str(area2(path)), "vertices": len(path),
                   "bounds": [min(p[0] for p in path), min(p[1] for p in path),
                              max(p[0] for p in path), max(p[1] for p in path)]}
                  for path in value["paths"]],
    }

def compare(left, right, case_id="comparison"):
    validate_geometry(left, case_id + ".expected")
    validate_geometry(right, case_id + ".actual")
    require(normalize_paths(left["paths"]) == normalize_paths(right["paths"]), case_id + ".paths", "contours differ (coordinates, vertices, winding or multiplicity)")
    require(normalize_tree(left["tree"]) == normalize_tree(right["tree"]), case_id + ".tree", "parentage, depth or node contours differ")

def validate_input(value, where):
    keys(value, {"format_version", "case_id", "source", "operation", "fill_rule", "options", "subject", "clip"}, where)
    require(type(value["format_version"]) is int and value["format_version"] == 1, where, "unknown input format version")
    require(type(value["case_id"]) is str and re.fullmatch(r"[a-z0-9][a-z0-9_-]{0,100}", value["case_id"]), where, "invalid case ID")
    require(type(value["operation"]) is str and value["operation"] in OPERATIONS, where, "unknown operation")
    require(type(value["fill_rule"]) is str and value["fill_rule"] in FILL_RULES, where, "unknown fill rule")
    keys(value["options"], {"preserve_collinear", "reverse_solution"}, where + ".options")
    for option in value["options"].values():
        require(type(option) is bool and not option, where, "version 1 fixes both output options to false")
    source = value["source"]
    require(type(source) is dict and type(source.get("kind")) is str, where, "missing source kind")
    if source["kind"] == "moonclip_constructed":
        keys(source, {"kind", "intent", "group"}, where + ".source")
        require(all(type(source[k]) is str and source[k] for k in ("intent", "group")), where, "missing construction intent/group")
    elif source["kind"] == "upstream":
        keys(source, {"kind", "file", "case_id", "sha256"}, where + ".source")
        require(all(type(source[k]) is str and source[k] for k in ("file", "case_id")), where, "missing upstream source location")
        require(type(source["sha256"]) is str and re.fullmatch("[0-9a-f]{64}", source["sha256"]), where, "invalid source hash")
    elif source["kind"] == "regression":
        keys(source, {"kind", "discovery", "issue"}, where + ".source")
        require(all(type(source[k]) is str and source[k] for k in ("discovery", "issue")), where, "missing regression provenance")
    else:
        raise Invalid(f"{where}: unknown source kind")
    count = validate_paths(value["subject"], where + ".subject")
    count += validate_paths(value["clip"], where + ".clip")
    require(count <= MAX_VERTICES and len(value["subject"]) + len(value["clip"]) <= MAX_PATHS, where, "combined input budget exceeded")

def validate_result(value, case, digest, lock, where):
    keys(value, {"format_version", "case_id", "input_sha256", "oracle_commit", "adapter_protocol_version", "status", "paths", "tree", "metrics"}, where)
    require(type(value["format_version"]) is int and value["format_version"] == 1, where, "unknown result format")
    require(type(value["adapter_protocol_version"]) is int and value["adapter_protocol_version"] == lock["adapter_protocol_version"], where, "unknown adapter protocol version")
    require(value["case_id"] == case["case_id"], where, "case ID mismatch")
    require(value["input_sha256"] == digest, where, "input hash mismatch")
    require(value["oracle_commit"] == lock["commit"], where, "oracle commit mismatch")
    validate_geometry(value, where)
    # Comparing canonical bytes keeps bool/float metrics from equalling Python integers.
    try:
        require(canonical_bytes(value["metrics"]) == canonical_bytes(metrics(value)), where, "exact metrics mismatch")
    except (ValueError, UnicodeError, TypeError) as error:
        raise Invalid(f"{where}: invalid exact metrics: {error}") from error

def confined(root, name):
    require(type(name) is str and not Path(name).is_absolute(), "manifest", "expected relative file path")
    result = (root / name).resolve()
    require(result.is_relative_to(root.resolve()), "manifest", "path escapes repository")
    return result

def validate_lock(lock):
    keys(lock, {"repository", "tag", "commit", "license", "adapter_protocol_version", "archive", "compile_inputs", "dependencies"}, "lock")
    require(lock["repository"] == "https://github.com/AngusJohnson/Clipper2" and lock["tag"] == "Clipper2_2.0.1" and lock["commit"] == "21ebba05db8894f0c7217ad35ea518080f324946", "lock", "unexpected fixed upstream identity")
    require(lock["license"] == "BSL-1.0" and type(lock["adapter_protocol_version"]) is int and lock["adapter_protocol_version"] == 1, "lock", "unknown license/protocol")
    keys(lock["archive"], {"url", "sha256"}, "lock.archive")
    require(lock["archive"]["url"] == "https://codeload.github.com/AngusJohnson/Clipper2/tar.gz/" + lock["commit"], "lock", "archive URL must use full commit")
    require(lock["archive"]["sha256"] == "897b7ed793b6a0565f7b1d34367f2301e08d541d82aa238b5f4042b701c811dc", "lock", "unexpected upstream archive checksum")
    require(lock["compile_inputs"] == ["CPP/Clipper2Lib/src/clipper.engine.cpp", "CPP/Clipper2Lib/include/clipper2/*.h"], "lock", "unexpected compile inputs")
    require(type(lock["dependencies"]) is list and len(lock["dependencies"]) == 1, "lock", "unexpected dependencies")
    dep = lock["dependencies"][0]
    keys(dep, {"name", "version", "url", "sha256", "license", "license_url", "license_sha256"}, "lock.dependency")
    require(dep["name"] == "nlohmann/json" and dep["version"] == "3.12.0" and dep["license"] == "MIT", "lock", "unexpected JSON dependency")
    for field in ("sha256", "license_sha256"):
        require(type(dep[field]) is str and re.fullmatch("[0-9a-f]{64}", dep[field]), "lock", "invalid dependency checksum")
    require(dep["url"] == "https://raw.githubusercontent.com/nlohmann/json/v3.12.0/single_include/nlohmann/json.hpp" and dep["license_url"] == "https://raw.githubusercontent.com/nlohmann/json/v3.12.0/LICENSE.MIT", "lock", "unexpected dependency URL")

def read_manifest(root, manifest, require_expected=True, strict=True):
    value = load(manifest, strict)
    keys(value, {"format_version", "oracle_lock", "cases"}, "manifest")
    require(type(value["format_version"]) is int and value["format_version"] == 1, "manifest", "unknown format version")
    require(value["oracle_lock"] == "tools/oracle/upstream-lock.json", "manifest", "unexpected oracle lock")
    lock = load(root / value["oracle_lock"], strict)
    validate_lock(lock)
    require(type(lock.get("adapter_protocol_version")) is int and lock["adapter_protocol_version"] == 1, "lock", "unknown adapter protocol")
    require(type(value["cases"]) is list and len(value["cases"]) <= 10000, "manifest", "case count/type error")
    require(bool(value["cases"]), "manifest", "empty case manifest")
    seen, inputs, outputs, records = set(), set(), set(), []
    for entry in value["cases"]:
        keys(entry, {"case_id", "input", "expected", "status"}, "manifest.case")
        cid = entry["case_id"]
        require(type(cid) is str and cid not in seen, "manifest", "duplicate or invalid case ID")
        seen.add(cid)
        require(entry["status"] == "reference_only", cid, "unknown or unimplemented capability status")
        require(entry["input"] == f"testdata/upstream/inputs/{cid}.json" and entry["expected"] == f"testdata/upstream/expected/{cid}.json", cid, "noncanonical case file mapping")
        ip, ep = confined(root, entry["input"]), confined(root, entry["expected"])
        inputs.add(ip); outputs.add(ep)
        case = load(ip, strict)
        validate_input(case, cid)
        require(case["case_id"] == cid, cid, "input case ID mismatch")
        digest = sha256(ip.read_bytes())
        expected = None
        if require_expected:
            expected = load(ep, strict)
            validate_result(expected, case, digest, lock, cid)
        records.append((entry, case, digest, expected))
    require({p for p in (root / "testdata/upstream/inputs").rglob("*") if p.is_file()} == inputs, "manifest", "unlisted or missing input files")
    actual_outputs = {p for p in (root / "testdata/upstream/expected").rglob("*") if p.is_file()}
    require(actual_outputs <= outputs if not require_expected else actual_outputs == outputs, "manifest", "orphan or missing expected files")
    return lock, records

def main():
    parser = argparse.ArgumentParser(description="Compare exact contours and PolyTree parentage")
    parser.add_argument("expected", type=Path)
    parser.add_argument("actual", type=Path)
    args = parser.parse_args()
    try:
        compare(load(args.expected), load(args.actual), args.actual.name)
    except (Invalid, OSError) as error:
        print(error, file=sys.stderr)
        return 1
    print("Geometry comparison passed")
    return 0

if __name__ == "__main__":
    sys.exit(main())
