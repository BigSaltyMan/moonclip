# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Generate directed open-path tests and an inputs/hashes-only actual runner."""
import argparse
from rectclip_compare import read_rectclip_manifest
from generate_boolean import paths,formatted
from selection import ROOT

def invocation(c):
    a,b,z,d=c['rect']
    return '@moonclip.rect_clip_lines({min_x:'+str(a)+'L,min_y:'+str(b)+'L,max_x:'+str(z)+'L,max_y:'+str(d)+'L},'+paths(c['paths'])+')'

def generated():
    _,records=read_rectclip_manifest(ROOT,ROOT/'testdata/rectclip-manifest.json')
    tests=['// Generated from fixed C++ RectClipLines64; exact ordered open outputs.']
    runner=['// Generated inputs and hashes only; NO expected output linked.','///|','fn run_rectclip_cases() -> Array[Json] { [']
    for _,c,d,v in records:
        tests+=['///|','// Input SHA256: '+d,'test "rect clip lines: reference '+c['case_id']+'" {','assert_eq('+invocation(c)+',Ok('+paths(v['paths'])+'))','}']
        runner+=['actual_offset_case("'+c['case_id']+'","'+d+'",'+invocation(c)+'),']
    return {'conformance/rectclip_test.mbt':'\n'.join(tests)+'\n','cmd/conformance/rectclip_cases.mbt':'\n'.join(runner+[']','}'])+'\n'}

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');a=p.parse_args()
    for name,text in generated().items():
        data=formatted(text);target=ROOT/name
        if a.check:
            if target.read_bytes()!=data:raise SystemExit('Stale generated rectclip data: '+name)
        else:target.write_bytes(data)
    print('Rectclip ordered tests/runner: '+('check passed' if a.check else 'generated'))
