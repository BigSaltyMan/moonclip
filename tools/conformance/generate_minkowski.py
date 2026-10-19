# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""144 complete-contour tests and an inputs/hashes-only runtime."""
import argparse
from minkowski_compare import minkowski_selection
from generate_boolean import paths,formatted
from selection import ROOT

def invocation(c):return '@moonclip.minkowski_sum('+paths([c['pattern']])[1:-1]+','+paths([c['path']])[1:-1]+','+str(c['path_is_closed']).lower()+')'

def generated():
    _,records=minkowski_selection(ROOT)
    tests=['// Generated fixed C++ MinkowskiSum geometry; preserve all collinear vertices.']
    runner=['// Generated inputs and hashes only; NO expected geometry.','///|','fn run_minkowski_cases() -> Array[Json] { [']
    for _,c,d,v in records:
        tests+=['///|','// Input SHA256: '+d,'test "reference minkowski paths: '+c['case_id']+'" {','assert_eq('+invocation(c)+'.map(canonical_paths),Ok(canonical_paths('+paths(v['paths'])+')))','}']
        runner+=['actual_minkowski_case("'+c['case_id']+'","'+d+'",'+invocation(c)+'),']
    return {'conformance/minkowski_test.mbt':'\n'.join(tests)+'\n','cmd/conformance/minkowski_cases.mbt':'\n'.join(runner+[']','}'])+'\n'}
if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');args=p.parse_args()
    for name,text in generated().items():
        data=formatted(text);target=ROOT/name
        if args.check:
            if target.read_bytes()!=data:raise SystemExit('Stale generated Minkowski data: '+name)
        else:target.write_bytes(data)
    print('Minkowski selection: 144 public paths, NonZero, preserve_collinear=true; '+('check passed' if args.check else 'generated'))
