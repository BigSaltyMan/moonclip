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
        print(f"Reference cases: {len(records)}; integrity only; geometry execution is checked separately by cmd/conformance")
        print("Operations: " + str(dict(sorted(Counter(c['operation'] for _, c, _, _ in records).items()))))
        if all(c['operation']=='Composition' for _,c,_,_ in records):
            print('Recipes: '+str(dict(sorted(Counter(c['recipe'] for _,c,_,_ in records).items()))))
        elif all(c['operation']=='StrokePolyline' for _,c,_,_ in records):
            for field in ('join_type','cap_type','width','miter_limit','arc_tolerance'):
                print(field+': '+str(dict(sorted(Counter(c[field] for _,c,_,_ in records).items()))))
        else:
            print("Fill rules: " + str(dict(sorted(Counter(c['fill_rule'] for _, c, _, _ in records).items()))))
    except (Invalid, OSError) as error:
        print(error, file=sys.stderr)
        return 1
    return 0

if __name__ == "__main__":
    sys.exit(main())
