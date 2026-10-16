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
moon check --target native --deny-warn
moon test --target native
moon build --target native
moon run --target native cmd/example
moon fmt --check
git diff --check
