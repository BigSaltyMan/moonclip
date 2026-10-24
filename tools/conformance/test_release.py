# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Execution-marker checks only; real ZIP consumers run in check_release.py."""
import importlib.util
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

spec = importlib.util.spec_from_file_location(
    "moonclip_check_release", Path(__file__).resolve().parents[2] / "scripts/check_release.py")
release = importlib.util.module_from_spec(spec)
spec.loader.exec_module(release)


def complete():
    return "\n".join([
        *(f"TREE_API_OK {api}" for api in release.TREE_APIS),
        "RECTCLIP_API_OK rect_clip_lines",
        *(f"INCREMENTAL_API_OK {flow}" for flow in release.INCREMENTAL_APIS),
        release.SUCCESS,
    ]) + "\n"


class ReleaseTreeMarkers(unittest.TestCase):
    def test_rectclip_marker_is_required_separately_from_six_trees(self):
        for output in (complete().replace('RECTCLIP_API_OK rect_clip_lines\n',''),complete()+'RECTCLIP_API_OK rect_clip_lines\n'):
            with self.assertRaises(ValueError):release.consumer_tree_apis(output)
        self.assertEqual(len(release.TREE_APIS),6)
    def test_complete_markers_and_overall_success(self):
        self.assertEqual(release.consumer_tree_apis(complete()), list(release.TREE_APIS))
        self.assertEqual(release.consumer_tree_apis("\n".join(reversed(complete().splitlines()))),
                         list(release.TREE_APIS))
        flows = release.consumer_incremental_apis(complete())
        self.assertEqual(list(flows), list(release.INCREMENTAL_APIS))
        for flow, apis in release.INCREMENTAL_APIS.items():
            self.assertEqual(flows[flow], dict(status="success", marker=f"INCREMENTAL_API_OK {flow}",
                                              apis_checked=list(apis)))
        for output in (complete().replace(release.SUCCESS, ""), complete() + release.SUCCESS + "\n"):
            with self.subTest(output=output), self.assertRaises(ValueError):
                release.consumer_tree_apis(output)

    def test_missing_tree_marker(self):
        for api in release.TREE_APIS:
            with self.subTest(api=api), self.assertRaises(ValueError):
                release.consumer_tree_apis(complete().replace(f"TREE_API_OK {api}\n", ""))

    def test_duplicate_tree_marker(self):
        for api in release.TREE_APIS:
            with self.subTest(api=api), self.assertRaises(ValueError):
                release.consumer_tree_apis(complete() + f"TREE_API_OK {api}\n")

    def test_unknown_or_malformed_tree_marker(self):
        for marker in ("TREE_API_OK future_tree", "TREE_API_OK", "TREE_API_OK  boolean_tree"):
            with self.subTest(marker=marker), self.assertRaises(ValueError):
                release.consumer_tree_apis(complete().replace("TREE_API_OK boolean_tree\n", marker + "\n"))

    def test_missing_incremental_marker(self):
        for flow in release.INCREMENTAL_APIS:
            with self.subTest(flow=flow), self.assertRaises(ValueError):
                release.consumer_incremental_apis(complete().replace(f"INCREMENTAL_API_OK {flow}\n", ""))

    def test_duplicate_incremental_marker(self):
        for flow in release.INCREMENTAL_APIS:
            with self.subTest(flow=flow), self.assertRaises(ValueError):
                release.consumer_incremental_apis(complete() + f"INCREMENTAL_API_OK {flow}\n")

    def test_unknown_or_malformed_incremental_marker(self):
        for marker in ("INCREMENTAL_API_OK future_api", "INCREMENTAL_API_OK", "INCREMENTAL_API_OK  rectclip"):
            with self.subTest(marker=marker), self.assertRaises(ValueError):
                release.consumer_incremental_apis(complete().replace("INCREMENTAL_API_OK rectclip\n", marker + "\n"))

    def test_release_candidate_report_fields(self):
        source = dict(commit="f" * 40, worktree_dirty=True)
        report = release.snapshot_report(source)
        self.assertEqual(report["metadata_version"], "0.3.1")
        self.assertEqual(report["version"], report["metadata_version"])
        self.assertEqual(report["publication_status"], "unpublished-release-candidate")
        self.assertEqual(report["source"], source)
        self.assertEqual(report["consumers"], {})
        self.assertEqual(set(report["platform"]), {"system", "machine"})

    def test_native_result_cannot_replace_js_execution(self):
        for omitted in ("TREE_API_OK boolean_tree_d", "INCREMENTAL_API_OK batch_stroke_query"):
            bad_js = complete().replace(omitted + "\n", "")
            with self.subTest(omitted=omitted), tempfile.TemporaryDirectory() as temporary, patch.object(
                    release, "command", side_effect=[complete(), bad_js]) as command:
                directory = Path(temporary)
                native = release.run_consumer("native", directory, directory)
                self.assertEqual(native["tree_apis_checked"], list(release.TREE_APIS))
                self.assertEqual(native["incremental_flows"], release.consumer_incremental_apis(complete()))
                self.assertEqual(native["incremental_apis_checked"], [
                    "rect_clip_lines_d", "rect_clip_polygons_tree_d", "stroke_polylines_tree_d",
                    "PolyTreeD::locate_many", "PolyTree64::locate", "minkowski_sum_tree_d",
                ])
                self.assertEqual(native["log"], "consumer-native.log")
                with self.assertRaises(ValueError):
                    release.run_consumer("js", directory, directory)
                self.assertEqual([c.args[0][3] for c in command.call_args_list], ["native", "js"])
                self.assertEqual((directory / "consumer-js.log").read_text(), bad_js)


if __name__ == "__main__":
    unittest.main()
