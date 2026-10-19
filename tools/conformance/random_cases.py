# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Locked, small v1 Boolean cases. Construction is independent of library output."""
import argparse
from pathlib import Path
from compare import (canonical_bytes, load, keys, require, validate_input,
                     validate_result, validate_lock, sha256, confined)

ROOT = Path(__file__).resolve().parents[2]
SEED = 20261019
ALGORITHM = 'xorshift32-small-polygons-v1'
CONFIGURATIONS = ('rectangle', 'orthogonal_concave', 'small_convex')
OPERATIONS = ('Intersection', 'Union', 'Difference', 'Xor')
RULES = ('EvenOdd', 'NonZero')


def cases(seed=SEED):
    require(type(seed) is int and 0 < seed < 2**32, 'seed', 'expected nonzero uint32')
    state = seed

    def draw(low, high):
        nonlocal state
        state ^= (state << 13) & 0xffffffff
        state ^= state >> 17
        state ^= (state << 5) & 0xffffffff
        state &= 0xffffffff
        return low + state % (high - low + 1)

    result = []
    for configuration in CONFIGURATIONS:
        x, y, w, h = draw(-20, -5), draw(-20, -5), draw(12, 22), draw(12, 22)
        if configuration == 'rectangle':
            ring = [[x,y],[x+w,y],[x+w,y+h],[x,y+h]]
        elif configuration == 'orthogonal_concave':
            ring = [[x,y],[x+w,y],[x+w,y+h//3],[x+w//3,y+h//3],[x+w//3,y+h],[x,y+h]]
        else:
            ring = [[x,y+h//2],[x+w//3,y],[x+w,y+h//3],[x+3*w//4,y+h],[x+w//4,y+h]]
        cx, cy = x+draw(3,7), y+draw(2,6)
        clip = [[cx,cy],[cx+w,cy],[cx+w,cy+h],[cx,cy+h]]
        for operation in OPERATIONS:
            for rule in RULES:
                cid = f'random_{configuration}_{operation.lower()}_{rule.lower()}'
                result.append(dict(format_version=1, case_id=cid,
                    source=dict(kind='moonclip_constructed', group=f'random:{ALGORITHM}:{configuration}',
                                intent=f'Locked seed {seed}; small public Boolean flat regression'),
                    operation=operation, fill_rule=rule,
                    options=dict(preserve_collinear=False,reverse_solution=False), subject=[ring],clip=[clip]))
    return result


def documents(seed=SEED):
    inputs = cases(seed)
    entries = [dict(case_id=c['case_id'], input=f"testdata/random/inputs/{c['case_id']}.json",
                    expected=f"testdata/random/expected/{c['case_id']}.json",status='validate',
                    validation={'paths':'validate'}, seed=seed,
                    configuration=c['source']['group'].split(':')[-1],
                    input_sha256=sha256(canonical_bytes(c))) for c in inputs]
    manifest = dict(format_version=1,kind='random',oracle_lock='tools/oracle/upstream-lock.json',
                    seed=seed,algorithm=ALGORITHM,cases=entries)
    selection = dict(format_version=1,kind='random',expected_count=24,
                     case_ids=[c['case_id'] for c in inputs])
    files = {'testdata/random-manifest.json':canonical_bytes(manifest),
             'testdata/random-selection.json':canonical_bytes(selection)}
    files.update({e['input']:canonical_bytes(c) for e,c in zip(entries,inputs)})
    return files


def read_random_manifest(root, manifest, require_expected=True, strict=True):
    v=load(manifest,strict)
    keys(v,{'format_version','kind','oracle_lock','seed','algorithm','cases'},'random manifest')
    require(canonical_bytes(v)==documents()['testdata/random-manifest.json'],'random','locked manifest changed')
    require((root/'testdata/random-selection.json').read_bytes()==
            documents()['testdata/random-selection.json'],'random','selection must contain exactly the ordered 24 cases')
    lock=load(root/v['oracle_lock'],strict);validate_lock(lock)
    records=[]
    for e in v['cases']:
        ip,ep=confined(root,e['input']),confined(root,e['expected'])
        raw=ip.read_bytes();require(raw==documents()[e['input']],'random','locked input bytes changed')
        c=load(ip,strict);validate_input(c,e['case_id']);d=sha256(raw)
        require(d==e['input_sha256'],'random','input hash mismatch')
        expected=load(ep,strict) if require_expected else None
        if require_expected:validate_result(expected,c,d,lock,e['case_id'])
        records.append((e,c,d,expected))
    for folder in ('inputs','expected'):
        actual={p.resolve() for p in (root/'testdata/random'/folder).rglob('*') if p.is_file()}
        listed={confined(root,e['input' if folder=='inputs' else 'expected']) for e in v['cases']}
        require(actual==listed if folder=='inputs' or require_expected else actual<=listed,'random','missing or extra '+folder)
    return lock,records


def generated():
    from generate_boolean import paths,call,formatted
    _,records=read_random_manifest(ROOT,ROOT/'testdata/random-manifest.json')
    tests=['// Generated locked random v1 flat contours; do not edit.']
    runner=['// Generated inputs and hashes only; no expected geometry.','///|',
            'fn run_random_cases() -> Array[Json] { [']
    for e,c,d,v in records:
        tests+=['///|','// Seed: '+str(e['seed'])+'; input SHA256: '+d,
                'test "reference random paths: '+c['case_id']+'" {',
                'assert_eq('+call(c)+'.map(canonical_paths), Ok(canonical_paths('+paths(v['paths'])+')))','}']
        runner+=['actual_offset_case("'+c['case_id']+'","'+d+'",'+call(c)+'),']
    return {'conformance/random_test.mbt':formatted('\n'.join(tests)+'\n'),
            'cmd/conformance/random_cases.mbt':formatted('\n'.join(runner+[']','}'])+'\n')}


def main():
    p=argparse.ArgumentParser(description=__doc__)
    m=p.add_mutually_exclusive_group(required=True)
    m.add_argument('--construct',action='store_true');m.add_argument('--generate',action='store_true');m.add_argument('--check',action='store_true')
    args=p.parse_args()
    files=documents() if args.construct else {**documents(),**generated()}
    for name,data in files.items():
        path=ROOT/name
        if args.check or (args.construct and path.exists()):
            require(path.read_bytes()==data,name,'locked/generated bytes changed')
        else:path.parent.mkdir(parents=True,exist_ok=True);path.write_bytes(data)
    print('Random v1: 24 ordered cases; seed='+str(SEED)+'; '+ALGORITHM+'; '+('checked' if args.check else 'written'))

if __name__=='__main__':main()
