#!/usr/bin/env bash
set -euo pipefail
repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"
moon build --target js cmd/demo
mkdir -p demo/generated
cp _build/js/debug/build/cmd/demo/demo.js demo/generated/moonclip.js
