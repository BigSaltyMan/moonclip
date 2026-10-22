#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

scope=full
if [[ $# -ne 0 ]]; then
  if [[ $# -ne 2 || "$1" != --scope || ( "$2" != full && "$2" != stroke-batch && "$2" != minkowski-decimal ) ]]; then
    printf 'Usage: bash scripts/check.sh [--scope full|stroke-batch|minkowski-decimal]\n' >&2
    exit 2
  fi
  scope="$2"
fi

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
if [[ "$scope" == stroke-batch || "$scope" == minkowski-decimal ]]; then
  selection='stroke batch: *'
  if [[ "$scope" == minkowski-decimal ]]; then
    selection='decimal minkowski: *'
  fi
  mkdir -p "_build/$scope"
  for target in native js; do
    moon check --target "$target" --deny-warn
    moon test --target "$target" --filter "$selection" | tee "_build/$scope/$target.log"
    grep -Fxq 'Total tests: 3, passed: 3, failed: 0.' "_build/$scope/$target.log"
  done
  moon run --target native cmd/example
  git diff --check
  exit 0
fi
printf 'Checking native target\n'
moon check --target native --deny-warn
mkdir -p _build/conformance
moon test --target native | tee _build/conformance/all-native.log
grep -Fxq "Total tests: 2376, passed: 2376, failed: 0." _build/conformance/all-native.log
moon build --target native
moon run --target native cmd/example
printf 'Checking JS target\n'
node --version
moon check --target js --deny-warn
moon test --target js | tee _build/conformance/all-js.log
grep -Fxq "Total tests: 2376, passed: 2376, failed: 0." _build/conformance/all-js.log
moon fmt --check
mkdir -p _build/conformance
for target in native js; do
  { printf 'Selection: rect clip lines: *\n'; moon test --target "$target" --filter "rect clip lines: *"; } | tee "_build/conformance/rectclip-$target.log"
  grep -Fxq 'Total tests: 47, passed: 47, failed: 0.' "_build/conformance/rectclip-$target.log"
  { printf 'Selection: stroke tree: *\n'; moon test --target "$target" --filter "stroke tree: *"; } | tee "_build/conformance/stroke-tree-$target.log"
  grep -Fxq 'Total tests: 29, passed: 29, failed: 0.' "_build/conformance/stroke-tree-$target.log"
  { printf 'Selection: offset tree: *\n'; moon test --target "$target" --filter "offset tree: *"; } | tee "_build/conformance/offset-tree-$target.log"
  grep -Fxq 'Total tests: 27, passed: 27, failed: 0.' "_build/conformance/offset-tree-$target.log"
  { printf 'Selection: decimal tree: *\n'; moon test --target "$target" --filter "decimal tree: *"; } | tee "_build/conformance/decimal-tree-$target.log"
  # Exact nonzero count: reject silently empty selections as well as failures.
  grep -Fxq 'Total tests: 33, passed: 33, failed: 0.' "_build/conformance/decimal-tree-$target.log"
  { printf 'Selection: reference minkowski paths: *\n'; moon test --target "$target" --filter "reference minkowski paths: *"; } | tee "_build/conformance/minkowski-$target.log"
  grep -Fxq 'Total tests: 144, passed: 144, failed: 0.' "_build/conformance/minkowski-$target.log"
  { printf 'Selection: reference simplify paths: *\n'; moon test --target "$target" --filter "reference simplify paths: *"; } | tee "_build/conformance/simplify-$target.log"
  grep -Fxq 'Total tests: 224, passed: 224, failed: 0.' "_build/conformance/simplify-$target.log"
  { printf 'Selection: reference decimal paths: *\n'; moon test --target "$target" --filter "reference decimal paths: *"; } | tee "_build/conformance/decimal-$target.log"
  grep -Fxq 'Total tests: 220, passed: 220, failed: 0.' "_build/conformance/decimal-$target.log"
  { printf 'Selection: reference composition: *\n'; moon test --target "$target" --filter "reference composition: *"; } | tee "_build/conformance/composition-$target.log"
  grep -Fxq 'Total tests: 24, passed: 24, failed: 0.' "_build/conformance/composition-$target.log"
  { printf 'Selection: reference paths: *\n'; moon test --target "$target" --filter "reference paths: *"; } | tee "_build/conformance/paths-$target.log"
  grep -Fxq 'Total tests: 152, passed: 152, failed: 0.' "_build/conformance/paths-$target.log"
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
python scripts/check_reference.py --manifest testdata/composition-manifest.json --strict
python tools/conformance/generate_composition.py --check
python scripts/check_reference.py --manifest testdata/decimal-manifest.json --strict
python tools/conformance/generate_decimal.py --check
python scripts/check_reference.py --manifest testdata/simplify-manifest.json --strict
python tools/conformance/generate_simplify.py --check
python scripts/check_reference.py --manifest testdata/minkowski-manifest.json --strict
python tools/conformance/generate_minkowski.py --check
python scripts/check_reference.py --manifest testdata/random-manifest.json --strict
python tools/conformance/random_cases.py --check
python scripts/check_reference.py --manifest testdata/rectclip-manifest.json --strict
python tools/conformance/generate_rectclip.py --check
moon run --target native cmd/conformance -- --manifest testdata/manifest.json --offset-manifest testdata/offset-manifest.json --stroke-manifest testdata/stroke-manifest.json --composition-manifest testdata/composition-manifest.json --decimal-manifest testdata/decimal-manifest.json --simplify-manifest testdata/simplify-manifest.json --minkowski-manifest testdata/minkowski-manifest.json --random-manifest testdata/random-manifest.json --rectclip-manifest testdata/rectclip-manifest.json --report-json _build/conformance/report.json --report-md docs/compatibility.md --strict
git diff --exit-code -- docs/compatibility.md
git diff --check
