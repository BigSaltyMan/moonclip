# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Audit a real moon package ZIP and run consumers outside the checkout. No publish."""
import argparse
from datetime import datetime, timezone
import hashlib
import json
import os
import platform
from pathlib import Path, PurePosixPath
import re
import shutil
import subprocess
import sys
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parents[1]
MODULE = "BigSaltyMan/moonclip"
VERSION = "0.3.1"
EXPECTED = {
    "name": MODULE, "version": VERSION, "readme": "README.md", "license": "BSL-1.0",
    "repository": "https://github.com/BigSaltyMan/moonclip",
}
TOOLCHAIN = (
    "moon 0.1.20260915 (2e1a46d 2026-09-15)",
    "moonc v0.10.13+cbb11c36f (2026-09-15)",
    "moonrun 0.1.20260915 (2e1a46d 2026-09-15)",
)
SUCCESS = "MoonClip candidate consumer OK: Boolean PolyTree Offset Stroke Decimal Simplify Minkowski errors"
TREE_APIS = (
    "boolean_tree", "boolean_tree_d", "offset_tree", "offset_tree_d",
    "stroke_tree", "stroke_tree_d",
)
INCREMENTAL_APIS = {
    "rectclip": ("rect_clip_lines_d", "rect_clip_polygons_tree_d"),
    "batch_stroke_query": (
        "stroke_polylines_tree_d", "PolyTreeD::locate_many", "PolyTree64::locate",
    ),
    "minkowski_tree": ("minkowski_sum_tree_d",),
}


def require(condition, message):
    if not condition:
        raise ValueError(message)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def command(args, cwd=ROOT, timeout=180):
    result = subprocess.run(args, cwd=cwd, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            text=True, encoding="utf-8", errors="replace", timeout=timeout)
    require(result.returncode == 0,
            f"Command failed ({result.returncode}): {args}\n{result.stdout[-4000:]}\n{result.stderr[-4000:]}")
    return result.stdout + result.stderr


def git(*args):
    return command(["git", "-c", f"safe.directory={ROOT.as_posix()}", *args], timeout=20).strip()


def consumer_tree_apis(output):
    """Validate actual execution markers from one target, without shared state."""
    lines = output.splitlines()
    require(lines.count(SUCCESS) == 1, "Missing or duplicate consumer success marker")
    markers = [line for line in lines if line.startswith("TREE_API_OK")]
    expected = [f"TREE_API_OK {api}" for api in TREE_APIS]
    require(len(markers) == len(expected) and set(markers) == set(expected),
            "Missing, duplicate or unknown tree API execution marker: " + repr(markers))
    require(lines.count("RECTCLIP_API_OK rect_clip_lines") == 1,
            "Missing or duplicate rectangle line API execution marker")
    return list(TREE_APIS)


def consumer_incremental_apis(output):
    """Three completed flows, each backed by explicit consumer calls/assertions."""
    markers = [line for line in output.splitlines() if line.startswith("INCREMENTAL_API_OK")]
    expected = [f"INCREMENTAL_API_OK {flow}" for flow in INCREMENTAL_APIS]
    require(len(markers) == len(expected) and set(markers) == set(expected),
            "Missing, duplicate or unknown incremental API execution marker: " + repr(markers))
    return {flow: dict(status="success", marker=f"INCREMENTAL_API_OK {flow}",
                       apis_checked=list(apis)) for flow, apis in INCREMENTAL_APIS.items()}


def run_consumer(target, consumer, report_dir):
    output = command(["moon", "run", "--target", target, "."], cwd=consumer)
    (report_dir / f"consumer-{target}.log").write_text(output, encoding="utf-8")
    checked = consumer_tree_apis(output)
    incremental = consumer_incremental_apis(output)
    return dict(status="success", marker=SUCCESS, tree_apis_checked=checked, rectclip_api_checked=True,
                incremental_flows=incremental,
                incremental_apis_checked=[api for apis in INCREMENTAL_APIS.values() for api in apis],
                log=f"consumer-{target}.log")


def snapshot_report(source):
    return dict(schema_version=1, status="running", module=MODULE, version=VERSION,
                metadata_version=VERSION, publication_status="unpublished-release-candidate",
                recorded_at_utc=datetime.now(timezone.utc).isoformat(),
                platform=dict(system=platform.system(), machine=platform.machine()),
                source=source, consumers={}, commands=[])


def metadata(text):
    fields = dict(re.findall(r'^([a-z_]+)\s*=\s*"([^"\n]+)"\s*$', text, re.M))
    for key, value in EXPECTED.items():
        require(fields.get(key) == value, f"Wrong module metadata: {key}")
    require("description" in fields and all(term in fields["description"]
            for term in ("decimal", "Boolean", "PolyTree", "offset", "stroke", "Minkowski")),
            "Incomplete public capability description")
    return fields


def distribution_files():
    # Independent of the ignore implementation: an exact intended distribution.
    runtime = {p.name for p in ROOT.glob("*.mbt")
               if not p.name.endswith(("_test.mbt", "_wbtest.mbt"))}
    return runtime | {
        "moon.mod", "moon.pkg", "pkg.generated.mbti", ".moonignore", "README.md", "LICENSE", "CHANGELOG.md",
        "cmd/example/main.mbt", "cmd/example/moon.pkg", "cmd/example/pkg.generated.mbti",
    } | {p.relative_to(ROOT).as_posix() for p in (ROOT / "docs").glob("*.md")}


def audit(archive, expected):
    records = []
    payload = {}
    with zipfile.ZipFile(archive) as z:
        for entry in z.infolist():
            name = entry.filename
            path = PurePosixPath(name)
            require("\\" not in name and not path.is_absolute() and ".." not in path.parts
                    and ":" not in name, f"Unsafe archive path: {name}")
            require(not ((entry.external_attr >> 16) & 0o170000) == 0o120000,
                    f"Symlink not allowed: {name}")
            if entry.is_dir():
                continue
            require(name not in payload, f"Duplicate archive member: {name}")
            require(name in expected, f"Unexpected distribution file: {name}")
            require(entry.file_size <= 2_000_000, f"Unexpectedly large file: {name}")
            data = z.read(entry)
            require(data == (ROOT / name).read_bytes(), f"Packager changed source bytes: {name}")
            # The candidate is text-only. Disallow machine-specific source/config paths.
            text = data.decode("utf-8")
            require(str(ROOT).lower() not in text.lower() and ROOT.as_posix().lower() not in text.lower(),
                    f"Checkout path leaked into {name}")
            require(not re.search(r"[A-Za-z]:[/\\]Users[/\\][^/\\\s]+", text, re.I),
                    f"Machine user path leaked into {name}")
            payload[name] = data
            records.append(dict(path=name, size=len(data), sha256=sha(data)))
    require(set(payload) == expected,
            "Missing distribution files: " + ", ".join(sorted(expected - set(payload))))
    metadata(payload["moon.mod"].decode())
    interface = payload["pkg.generated.mbti"].decode()
    for apis in INCREMENTAL_APIS.values():
        for api in apis:
            require(f"pub fn {api}(" in interface, f"Missing incremental public interface: {api}")
    license_text = payload["LICENSE"].decode()
    for term in ("Boost Software License - Version 1.0", "Angus Johnson 2010-2025", "BigSaltyMan", "THE SOFTWARE IS PROVIDED"):
        require(term in license_text, f"Missing license / copyright: {term}")
    upstream = payload["docs/upstream.md"].decode()
    for term in ("Clipper2_2.0.1", "21ebba05db8894f0c7217ad35ea518080f324946", "BSL-1.0"):
        require(term in upstream, f"Missing standalone provenance: {term}")
    # Every relative Markdown link must resolve inside the actual ZIP.
    for name, data in payload.items():
        if not name.endswith(".md"):
            continue
        for target in re.findall(r'\]\(([^)]+)\)', data.decode()):
            if "://" in target or target.startswith("#"):
                continue
            target = target.split("#", 1)[0]
            resolved = os.path.normpath(str(PurePosixPath(name).parent / target)).replace("\\", "/")
            require(resolved in payload, f"Broken package documentation link: {name} -> {target}")
    return sorted(records, key=lambda r: r["path"]), payload


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--report", type=Path, default=Path("_build/release-0.3.1/report.json"))
    args = parser.parse_args()
    report_path = (ROOT / args.report).resolve()
    report_path.parent.mkdir(parents=True, exist_ok=True)
    report = snapshot_report(dict(commit=git("rev-parse", "HEAD"),
                                  worktree_dirty=bool(git("status", "--porcelain", "--untracked-files=normal"))))
    try:
        version = command(["moon", "version", "--all"])
        require(all(v in version for v in TOOLCHAIN), "Use the fixed MoonBit toolchain")
        report["toolchain"] = version
        metadata((ROOT / "moon.mod").read_text(encoding="utf-8"))
        expected = distribution_files()
        # A fresh directory outside the repository avoids inherited _build ignores.
        with tempfile.TemporaryDirectory(prefix="moonclip-release-") as temporary:
            work = Path(temporary).resolve()
            require(work.parent == Path(tempfile.gettempdir()).resolve()
                    and work.name.startswith("moonclip-release-")
                    and not work.is_relative_to(ROOT), "Unsafe temporary directory")
            source = work / "source"
            source.mkdir()
            source_files = git("ls-files", "--cached", "--others", "--exclude-standard", "-z").split("\0")
            for name in source_files:
                if not name:
                    continue
                src = (ROOT / name).resolve()
                require(src.is_relative_to(ROOT) and src.is_file() and not (ROOT / name).is_symlink(),
                        f"Unsafe / missing source snapshot file: {name}")
                dest = source / name
                dest.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(src, dest)
            report["commands"].append("moon package (external full source snapshot)")
            package_log = command(["moon", "package"], cwd=source)
            (report_path.parent / "package.log").write_text(package_log, encoding="utf-8")
            archives = list((source / "_build/publish").glob("*.zip"))
            require(len(archives) == 1, "Expected exactly one official package ZIP")
            archive = report_path.parent / f"moonclip-{VERSION}.zip"
            shutil.copy2(archives[0], archive)
            files, payload = audit(archive, expected)
            report["archive"] = dict(path=str(archive), sha256=sha(archive.read_bytes()),
                                     size=archive.stat().st_size, file_count=len(files), files=files,
                                     payload_sha256=sha(json.dumps(files, sort_keys=True).encode()))
            print(f"Unpublished release candidate: {MODULE}; metadata_version={VERSION}; files={len(files)}; bytes={archive.stat().st_size}; SHA256={report['archive']['sha256']}", flush=True)
            for record in files:
                print(f"  {record['path']}  {record['size']} bytes  {record['sha256']}")
            workspace = work / "consumer-workspace"
            library = workspace / "library"
            library.mkdir(parents=True)
            # Extract only already audited members; no development checkout dependency.
            for name, data in payload.items():
                dest = library / name
                dest.parent.mkdir(parents=True, exist_ok=True)
                dest.write_bytes(data)
            consumer = workspace / "consumer"
            shutil.copytree(ROOT / "tools/release-consumer", consumer,
                            ignore=shutil.ignore_patterns("_build", ".mooncakes", "moon.work", "moon.work.json"))
            (workspace / "moon.work").write_text('members = [ "library", "consumer" ]\n', encoding="utf-8")
            consumer_metadata = (consumer / "moon.mod").read_text(encoding="utf-8")
            require(f'"{MODULE}@{VERSION}"' in consumer_metadata,
                    "External consumer must declare the exact candidate dependency version")
            report["consumer_dependency"] = dict(method="moon.work members", library="audited ZIP extraction",
                                                 declared_module=MODULE, declared_version=VERSION,
                                                 development_checkout_dependency=False,
                                                 external_workspace=True)
            for target in ("native", "js"):
                report["commands"].append(f"moon run --target {target} . (external consumer)")
                try:
                    report["consumers"][target] = run_consumer(target, consumer, report_path.parent)
                    require(all((library / name).read_bytes() == data for name, data in payload.items()),
                            f"Consumer {target} compilation modified candidate payload")
                    report["consumers"][target]["extracted_library_unchanged"] = True
                except (OSError, ValueError, subprocess.SubprocessError) as exc:
                    report["consumers"][target] = dict(status="failure", error=str(exc))
                    raise
                print(f"External candidate consumer {target}: success", flush=True)
                print(f"Tree APIs checked {target}: " + ", ".join(report["consumers"][target]["tree_apis_checked"]), flush=True)
                print(f"Incremental APIs checked {target}: " + ", ".join(report["consumers"][target]["incremental_apis_checked"]), flush=True)
            # Confirm compilation did not change the extracted library source/interface.
            require(all((library / name).read_bytes() == data for name, data in payload.items()),
                    "Consumer compilation modified candidate payload")
            report["extracted_library_unchanged_after_compilation"] = True
        report["status"] = "success"
    except (OSError, ValueError, subprocess.SubprocessError, zipfile.BadZipFile) as exc:
        report["status"] = "failure"
        report["error"] = str(exc)
        print(f"Release candidate check failed: {exc}", file=sys.stderr)
    report_path.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"Release candidate report: {report_path}")
    return 0 if report["status"] == "success" else 1


if __name__ == "__main__":
    sys.exit(main())
