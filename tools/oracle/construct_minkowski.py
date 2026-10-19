# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Lock 4 patterns x9 routes x2 modes x2 real route directions, before MoonClip."""
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'tools/conformance'))
from compare import canonical_bytes,require
from minkowski_compare import validate_minkowski_input,OPTIONS
PATTERNS={
 'rectangle':[[-2,-1],[2,-1],[2,1],[-2,1]],
 'circle':[[3,0],[2,2],[0,3],[-2,2],[-3,0],[-2,-2],[0,-3],[2,-2]],
 'concave':[[0,0],[4,0],[4,1],[1,1],[1,4],[0,4]],
 'offcenter':[[2,1],[6,1],[5,4],[2,3]]}
ROUTES={
 'long_horizontal':[[0,0],[30,0]],'short_horizontal':[[0,0],[1,0]],
 'diagonal':[[-10,-5],[20,15]],'right_angle':[[0,0],[20,0],[20,20]],
 'acute':[[0,0],[25,0],[4,6]],'retrace':[[0,0],[20,0],[5,0],[5,20]],
 'selfcross':[[0,0],[20,20],[0,20],[20,0],[30,10]],
 'rectangle':[[0,0],[30,0],[30,20],[0,20]],
 'repeats':[[0,0],[0,0],[20,0],[20,20],[0,0]]}

def main():
    entries=[]
    def lock(name,v):
        p=ROOT/name;p.parent.mkdir(parents=True,exist_ok=True);data=canonical_bytes(v)
        if p.exists():require(p.read_bytes()==data,name,'locked Minkowski data differs')
        else:p.write_bytes(data)
    for pattern,p in PATTERNS.items():
        for route,r in ROUTES.items():
            require(r!=r[::-1],route,'direction must be distinct')
            for closed in (False,True):
                for direction in ('forward','reverse'):
                    cid='minkowski_'+pattern+'_'+route+('_closed_' if closed else '_open_')+direction
                    c=dict(format_version=7,operation='MinkowskiSum',case_id=cid,source=dict(kind='moonclip_constructed',group=pattern+':'+route+':'+direction,intent='Fixed connection quadrilaterals; no complete endpoint patterns'),options=OPTIONS,pattern=p,path=r if direction=='forward' else r[::-1],path_is_closed=closed)
                    validate_minkowski_input(c,cid);ip=f'testdata/minkowski/inputs/{cid}.json';lock(ip,c)
                    entries.append(dict(case_id=cid,input=ip,expected=f'testdata/minkowski/expected/{cid}.json',status='validate',validation=dict(paths='validate')))
    entries.sort(key=lambda e:e['case_id']);require(len(entries)==144,'constructor','144 inputs required')
    lock('testdata/minkowski-manifest.json',dict(format_version=7,kind='minkowski',oracle_lock='tools/oracle/upstream-lock.json',cases=entries))
    lock('testdata/minkowski-selection.json',dict(format_version=7,kind='minkowski',expected_count=144,case_ids=[e['case_id'] for e in entries]))
    (ROOT/'testdata/minkowski/expected').mkdir(parents=True,exist_ok=True)
    print('Locked 144 Minkowski inputs; no MoonClip execution')
if __name__=='__main__':main()
