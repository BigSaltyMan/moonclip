# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Build once, execute bounded native cases, preserve failures as report entries."""
import argparse
from datetime import datetime, timezone
import hashlib
import json
import math
import os
from pathlib import Path
import platform
import signal
import statistics
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[1]
VERSIONS = (
    "moon 0.1.20260915 (2e1a46d 2026-09-15)",
    "moonc v0.10.13+cbb11c36f (2026-09-15)",
    "moonrun 0.1.20260915 (2e1a46d 2026-09-15)",
)


def execute(command, timeout):
    """Timeout includes process startup. Kill the process tree, not just its shell."""
    proc = subprocess.Popen(command, cwd=ROOT, stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE, text=True, encoding="utf-8",
                            errors="replace", start_new_session=os.name != "nt")
    try:
        out, err = proc.communicate(timeout=timeout)
        return proc.returncode, out, err, False
    except subprocess.TimeoutExpired:
        if os.name == "nt":
            subprocess.run(["taskkill", "/PID", str(proc.pid), "/T", "/F"],
                           stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                           timeout=10, check=False)
        else:
            os.killpg(proc.pid, signal.SIGKILL)
        out, err = proc.communicate(timeout=10)
        return proc.returncode, out, err, True


def checked(command, timeout=15):
    code, out, err, expired = execute(command, timeout)
    if expired or code:
        raise RuntimeError(f"Command failed: {command}; timeout={expired}; {err[-2000:]}")
    return out.strip()


def git(*args):
    return checked(["git", "-c", f"safe.directory={ROOT.as_posix()}", *args])


def cpu_name():
    if os.name == "nt":
        import winreg
        with winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE,
                            r"HARDWARE\DESCRIPTION\System\CentralProcessor\0") as key:
            return winreg.QueryValueEx(key, "ProcessorNameString")[0].strip()
    if Path("/proc/cpuinfo").exists():
        for line in Path("/proc/cpuinfo").read_text().splitlines():
            if line.startswith("model name"):
                return line.split(":", 1)[1].strip()
    return platform.processor() or "unavailable"


def sources():
    # Exact measured sources/configuration, including untracked benchmark code.
    files = sorted({*ROOT.glob("*.mbt"), *ROOT.glob("moon.*"),
                    *ROOT.glob("bench/*.mbt"), *ROOT.glob("bench/moon.pkg"),
                    ROOT / "scripts/bench.py", ROOT / "scripts/bench.sh"})
    digests = {p.relative_to(ROOT).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest()
               for p in files if p.is_file()}
    aggregate = hashlib.sha256(json.dumps(digests, sort_keys=True).encode()).hexdigest()
    return digests, aggregate


def validate_success(result):
    """Reject malformed units/counts/statistics before publishing a success."""
    for key in ("input_paths", "input_vertices", "output_paths", "output_vertices",
                "removed_vertices", "warmups", "samples", "batch"):
        if type(result.get(key)) is not int or result[key] < 0:
            raise ValueError(f"Invalid count: {key}")
    if result["samples"] < 1 or result["batch"] < 1:
        raise ValueError("Empty measurement")
    samples = result["sample_us_per_call"]
    if len(samples) != result["samples"] or any(
        type(x) not in (float, int) or not math.isfinite(x) or x < 0 for x in samples
    ):
        raise ValueError("Invalid microsecond samples")
    expected = {"min": min(samples), "median": statistics.median(samples), "max": max(samples)}
    if result["statistics_us"] != expected:
        raise ValueError("Statistics disagree with raw per-call samples")


def classify(meta, code, out, err, expired):
    result = dict(meta)
    if expired:
        result.update(status="timeout", statistics_us=None,
                      error={"kind": "ExternalTimeout", "stdout": out[-4000:], "stderr": err[-4000:]})
        return result
    try:
        if code:
            raise ValueError(f"Process exited {code}: {err[-4000:]}")
        payload = json.loads(out)
        if payload.get("case") != meta["case"]:
            raise ValueError("Missing or wrong case identity")
        if payload.get("status") not in ("success", "resource_rejected", "runtime_error"):
            raise ValueError("Unknown execution status")
        if payload["status"] == "success":
            validate_success(payload)
        elif payload.get("statistics_us") is not None:
            raise ValueError("Failed execution must not publish successful timings")
        result.update(payload)
    except (ValueError, KeyError, TypeError) as exc:
        result.update(status="runtime_error", statistics_us=None,
                      error={"kind": "RunnerProtocolFailure", "message": str(exc),
                             "stdout": out[-4000:], "stderr": err[-4000:]})
    return result


def positive_seconds(text):
    value = float(text)
    if not math.isfinite(value) or not 0 < value <= 300:
        raise argparse.ArgumentTypeError("seconds must be finite, >0 and <=300")
    return value


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--target", choices=["native"], default="native")
    parser.add_argument("--report", type=Path, default=Path("_build/bench/report.json"))
    parser.add_argument("--timeout", type=positive_seconds, default=15.0,
                        help="seconds per case process (default: 15)")
    parser.add_argument("--suite-timeout", type=positive_seconds, default=90.0,
                        help="seconds for all cases after build (default: 90)")
    parser.add_argument("--case", action="append", dest="cases", help="select a case ID; repeatable")
    parser.add_argument("--smoke", action="store_true", help="one tiny Boolean, 1 warmup/sample/call")
    args = parser.parse_args()
    report_path = (ROOT / args.report).resolve()
    report_path.parent.mkdir(parents=True, exist_ok=True)
    version = checked(["moon", "version", "--all"])
    if not all(v in version for v in VERSIONS):
        parser.error("Use the pinned toolchain documented in docs/toolchain.md")
    digests, fingerprint = sources()
    report = {
        "schema_version": 1, "case_algorithm": "small-deterministic-v1",
        "recorded_at_utc": datetime.now(timezone.utc).isoformat(),
        "environment": {"target": "native", "profile": "release", "os": platform.platform(),
                        "cpu": cpu_name(), "architecture": platform.machine() or f"{64 if sys.maxsize > 2**32 else 32}-bit process",
                        "toolchain": version, "python": platform.python_version(),
                        "clock": "core/bench monotonic microseconds (QPC on Windows; CLOCK_MONOTONIC on Linux)",
                        "memory": {"status": "not_measured", "bytes": None}},
        "source": {"commit": git("rev-parse", "HEAD"),
                   "worktree_dirty": bool(git("status", "--porcelain", "--untracked-files=normal")),
                   "files_sha256": digests, "fingerprint": fingerprint},
        "limits": {"build_timeout_seconds": 120, "case_timeout_seconds": args.timeout,
                   "suite_timeout_seconds": args.suite_timeout},
        "build": {"command": ["moon", "build", "--target", "native", "--release", "--deny-warn", "bench"]},
        "smoke_only": args.smoke, "results": [],
    }
    code, out, err, expired = execute(report["build"]["command"], 120)
    log_path = report_path.with_suffix(".build.log")
    log_path.write_text(out + err, encoding="utf-8")
    report["build"].update(status="timeout" if expired else "success" if code == 0 else "runtime_error",
                           exit_code=code, log=str(log_path))
    if report["build"]["status"] == "success":
        executable = ROOT / "_build/native/release/build/bench/bench.exe"
        if not executable.is_file():
            raise RuntimeError(f"Missing native executable: {executable}")
        report["build"]["executable_sha256"] = hashlib.sha256(executable.read_bytes()).hexdigest()
        catalog = json.loads(checked([str(executable), "--list"]))
        ids = [c["case"] for c in catalog]
        if len(ids) != 11 or len(set(ids)) != len(ids):
            raise RuntimeError("Expected 11 unique benchmark cases")
        selected = ["boolean_1"] if args.smoke else args.cases or ids
        if len(set(selected)) != len(selected) or set(selected) - set(ids):
            parser.error("Case selection has duplicates or unknown IDs: " + ", ".join(ids))
        deadline = time.monotonic() + args.suite_timeout
        for meta in catalog:
            if meta["case"] not in selected:
                continue
            remaining = deadline - time.monotonic()
            if remaining <= 0:
                result = dict(meta, status="timeout", statistics_us=None,
                              error={"kind": "SuiteDeadline", "message": "Not started: suite deadline exhausted"})
            else:
                command = [str(executable), meta["case"]] + (["--smoke"] if args.smoke else [])
                result = classify(meta, *execute(command, min(args.timeout, remaining)))
            # Preserve the requested schedule even when no samples complete.
            result["requested_schedule"] = dict(warmups=1 if args.smoke else 2,
                                                 samples=1 if args.smoke else 5,
                                                 batch=1 if args.smoke else meta["batch"])
            report["results"].append(result)
            stats = result.get("statistics_us")
            print(f"{result['case']}: {result['status']}" +
                  (f" median={stats['median']:.3f} us/call" if stats else ""), flush=True)
    report_path.write_text(json.dumps(report, ensure_ascii=False, indent=2, allow_nan=False) + "\n", encoding="utf-8")
    print(f"Report: {report_path}")
    # Stress budget refusal/timeout is evidence, never successful timing.
    bad = report["build"]["status"] != "success" or any(
        r["status"] == "runtime_error" or (not r["stress"] and r["status"] != "success")
        for r in report["results"])
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
