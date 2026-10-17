#!/usr/bin/env python3
"""Verify pinned downloads and every extracted source byte, then build the oracle."""
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tarfile
import time
import urllib.request
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools/conformance"))
from compare import Invalid, canonical_bytes, load, require, sha256, validate_lock
WORK = ROOT / ".tmp/oracle"

def fetch(url, path, digest):
    if not path.exists():
        pending = path.with_suffix(path.suffix + ".download")
        try:
            with urllib.request.urlopen(url, timeout=60) as response, pending.open("wb") as out:
                shutil.copyfileobj(response, out)
            require(sha256(pending.read_bytes()) == digest, str(path), "download checksum mismatch")
            pending.replace(path)
        finally:
            pending.unlink(missing_ok=True)
    require(sha256(path.read_bytes()) == digest, str(path), "cached download checksum mismatch; refusing fallback")

def verify_source(archive, destination, prefix):
    with tarfile.open(archive, "r:gz") as source:
        expected = {}
        for member in source.getmembers():
            require(not member.issym() and not member.islnk(), "source", "links forbidden")
            parts = Path(member.name).parts
            require(parts and parts[0] == prefix and ".." not in parts, "source", "unsafe archive member")
            if member.isfile():
                expected[Path(*parts[1:])] = source.extractfile(member).read()
        if not destination.exists():
            destination.mkdir()
            for relative, data in expected.items():
                path = destination / relative
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_bytes(data)
        actual = {p.relative_to(destination) for p in destination.rglob("*") if p.is_file()}
        require(not destination.is_symlink() and not any(p.is_symlink() for p in destination.rglob("*")), "source", "source symlinks forbidden")
        require(actual == set(expected), "source", "extracted source files changed")
        for relative, data in expected.items():
            path = destination / relative
            require(not path.is_symlink() and path.read_bytes() == data, str(relative), "extracted source modified")

def main():
    started = time.monotonic()
    require(sys.version_info >= (3, 11), "Python", "version 3.11 or newer required")
    lock = load(ROOT / "tools/oracle/upstream-lock.json", True)
    validate_lock(lock)
    WORK.mkdir(parents=True, exist_ok=True)
    upstream = lock["archive"]
    archive = WORK / "clipper2.tar.gz"
    fetch(upstream["url"], archive, upstream["sha256"])
    source = WORK / ("Clipper2-" + lock["commit"])
    verify_source(archive, source, "Clipper2-" + lock["commit"])
    dep = lock["dependencies"][0]
    fetch(dep["url"], WORK / "json.hpp", dep["sha256"])
    fetch(dep["license_url"], WORK / "json.LICENSE.MIT", dep["license_sha256"])
    build = WORK / "build"
    command = ["cmake", "-S", str(ROOT / "tools/oracle"), "-B", str(build), "-G", "Ninja",
               "-DCMAKE_BUILD_TYPE=Release", "-DCLIPPER2_SOURCE=" + source.as_posix(), "-DJSON_HEADER_DIR=" + WORK.as_posix()]
    subprocess.run(command, check=True, timeout=120)
    subprocess.run(["cmake", "--build", str(build), "--parallel", "2"], check=True, timeout=240)
    cache = (build / "CMakeCache.txt").read_text(encoding="utf-8")
    compiler = next(line.split("=", 1)[1] for line in cache.splitlines() if line.startswith("CMAKE_CXX_COMPILER:FILEPATH="))
    binary = build / ("moonclip-oracle.exe" if sys.platform == "win32" else "moonclip-oracle")
    report = {"cmake_sha256": sha256((ROOT / "tools/oracle/CMakeLists.txt").read_bytes()), "adapter_sha256": sha256((ROOT / "tools/oracle/adapter.cpp").read_bytes()), "lock_sha256": sha256((ROOT / "tools/oracle/upstream-lock.json").read_bytes()), "binary_sha256": sha256(binary.read_bytes()), "oracle_commit": lock["commit"], "archive_sha256": upstream["sha256"],
              "compiler": subprocess.check_output([compiler, "--version"], text=True).splitlines()[0],
              "cmake": subprocess.check_output(["cmake", "--version"], text=True).splitlines()[0],
              "python": sys.version.split()[0], "compile_definitions": {"CLIPPER2_HI_PRECISION": 0}, "configure_command": command, "seconds": round(time.monotonic()-started, 3)}
    (build / "environment.json").write_bytes(canonical_bytes(report))
    print(json.dumps(report, indent=2))
    return 0

if __name__ == "__main__":
    try:
        sys.exit(main())
    except (Invalid, OSError, subprocess.SubprocessError) as error:
        print(f"oracle build: {error}", file=sys.stderr)
        sys.exit(1)
