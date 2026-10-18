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
  { printf 'Selection: reference stroke paths: *\n'; moon test --target "$target" --filter "reference stroke paths: *"; } | tee "_build/conformance/stroke-$target.log"
  grep -Fxq 'Total tests: 276, passed: 276, failed: 0.' "_build/conformance/stroke-$target.log"
  { printf 'Selection: reference offset paths: *\n'; moon test --target "$target" --filter "reference offset paths: *"; } | tee "_build/conformance/offset-$target.log"
  grep -Fxq 'Total tests: 272, passed: 272, failed: 0.' "_build/conformance/offset-$target.log"
  moon test --target "$target" --filter "reference internal paths: *" | tee "_build/conformance/internal-$target.log"
  grep -Fxq 'Total tests: 48, passed: 48, failed: 0.' "_build/conformance/internal-$target.log"
  for kind in public internal; do
    if [[ "$kind" == public ]]; then
      selection='reference tree: *'; count=152; stem=tree
    else
      selection='reference internal tree: *'; count=48; stem=internal-tree
    fi
    { printf 'Selection: %s\n' "$selection"; moon test --target "$target" --filter "$selection"; } | tee "_build/conformance/$stem-$target.log"
    grep -Fxq "Total tests: $count, passed: $count, failed: 0." "_build/conformance/$stem-$target.log"
  done
done
printf 'Checking offline reference tools\n'
python --version
python -m unittest discover -s tools/conformance -p "test_*.py"
python scripts/check_reference.py --manifest testdata/manifest.json --strict
python tools/conformance/generate_boolean.py --check
python scripts/check_reference.py --manifest testdata/offset-manifest.json --strict
python tools/conformance/generate_offset.py --check
python scripts/check_reference.py --manifest testdata/stroke-manifest.json --strict
python tools/conformance/generate_stroke.py --check
moon run --target native cmd/conformance -- --manifest testdata/manifest.json --offset-manifest testdata/offset-manifest.json --stroke-manifest testdata/stroke-manifest.json --report-json _build/conformance/report.json --report-md docs/compatibility.md --strict
git diff --exit-code -- docs/compatibility.md
git diff --check
