#!/usr/bin/env python3
"""Offline integrity checking; never invokes the oracle or the network."""
import argparse
from collections import Counter
from pathlib import Path
import sys
ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools/conformance"))
from compare import Invalid, read_manifest

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, default=ROOT / "testdata/manifest.json")
    parser.add_argument("--strict", action="store_true")
    args = parser.parse_args()
    try:
        _, records = read_manifest(ROOT, args.manifest.resolve(), strict=args.strict)
        print(f"Reference cases: {len(records)} (reference_only); MoonClip boolean compatibility: not run")
        print("Operations: " + str(dict(sorted(Counter(c['operation'] for _, c, _, _ in records).items()))))
        print("Fill rules: " + str(dict(sorted(Counter(c['fill_rule'] for _, c, _, _ in records).items()))))
    except (Invalid, OSError) as error:
        print(error, file=sys.stderr)
        return 1
    return 0

if __name__ == "__main__":
    sys.exit(main())
