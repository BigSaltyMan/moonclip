#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

versions="$(moon version --all)"
printf '%s\n' "$versions"
grep -Fq 'moon 0.1.20260915 (2e1a46d 2026-09-15)' <<< "$versions"
grep -Fq 'moonc v0.10.13+cbb11c36f (2026-09-15)' <<< "$versions"
grep -Fq 'moonrun 0.1.20260915 (2e1a46d 2026-09-15)' <<< "$versions"

moon fmt --check
moon info --target native
git diff --exit-code -- '*.mbti'
untracked_interfaces="$(git ls-files --others --exclude-standard -- '*.mbti')"
if [[ -n "$untracked_interfaces" ]]; then
  printf 'Untracked public interfaces; review and stage them:\n%s\n' "$untracked_interfaces" >&2
  exit 1
fi
printf 'Checking native target\n'
moon check --target native --deny-warn
moon test --target native
moon build --target native
moon run --target native cmd/example
printf 'Checking JS target\n'
node --version
moon check --target js --deny-warn
moon test --target js
moon fmt --check
mkdir -p _build/conformance
for target in native js; do
  moon test --target "$target" --filter "reference internal paths: *" | tee "_build/conformance/internal-$target.log"
  grep -Fxq 'Total tests: 48, passed: 48, failed: 0.' "_build/conformance/internal-$target.log"
done
printf 'Checking offline reference tools\n'
python --version
python -m unittest discover -s tools/conformance -p "test_*.py"
python scripts/check_reference.py --manifest testdata/manifest.json --strict
python tools/conformance/generate_boolean.py --check
moon run --target native cmd/conformance -- --manifest testdata/manifest.json --report-json _build/conformance/report.json --report-md docs/compatibility.md --strict
git diff --exit-code -- docs/compatibility.md
git diff --check
