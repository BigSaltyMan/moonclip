# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Small runner-contract checks; these are not geometry regression cases."""
import json
import sys
import unittest

from bench import classify, execute, validate_success


class BenchRunnerTests(unittest.TestCase):
    def test_statistics_and_units(self):
        value = dict(input_paths=2, input_vertices=8, output_paths=1,
                     output_vertices=4, removed_vertices=0, warmups=2, samples=5,
                     batch=5, sample_us_per_call=[1.5, 2.0, 1.0, 4.0, 2.5],
                     statistics_us=dict(min=1.0, median=2.0, max=4.0))
        validate_success(value)
        value["statistics_us"]["median"] = 10.0  # batch-total masquerading as per-call
        with self.assertRaises(ValueError):
            validate_success(value)

    def test_resource_refusal_retains_stage_and_no_timings(self):
        payload = dict(case="stress", status="resource_rejected", statistics_us=None,
                       error=dict(kind="ResourceLimitExceeded", stage="OffsetGenerate",
                                  resource="InternalNodes", limit=500000))
        result = classify(dict(case="stress"), 0, json.dumps(payload), "", False)
        self.assertEqual(result["error"], payload["error"])
        self.assertIsNone(result["statistics_us"])
        payload["statistics_us"] = dict(median=1)
        self.assertEqual(classify(dict(case="stress"), 0, json.dumps(payload), "", False)["status"],
                         "runtime_error")

    def test_wrong_case_and_crash_are_runtime_errors(self):
        for code, out in [(2, ""), (0, "not JSON"),
                          (0, '{"case":"other","status":"success"}')]:
            result = classify(dict(case="wanted"), code, out, "diagnostic", False)
            self.assertEqual(result["status"], "runtime_error")
            self.assertIsNone(result["statistics_us"])

    def test_actual_external_timeout_is_distinct(self):
        execution = execute([sys.executable, "-c", "import time; time.sleep(2)"], 0.05)
        self.assertTrue(execution[3])
        result = classify(dict(case="probe"), *execution)
        self.assertEqual(result["status"], "timeout")
        self.assertEqual(result["error"]["kind"], "ExternalTimeout")
        self.assertIsNone(result["statistics_us"])


if __name__ == "__main__":
    unittest.main()
