# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Lock all 224 inputs before executing MoonClip simplification."""
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'tools/conformance'))
from compare import canonical_bytes,require
from simplify_compare import validate_simplify_input,NORMALIZATION
GROUPS=[
 ('dense',[[[0,0],[1,0],[2,0],[3,0],[4,0],[4,4],[0,4]]]),
 ('saw',[[[0,0],[2,1],[4,0],[6,1],[8,0],[8,8],[0,8]]]),
 ('acute',[[[0,0],[20,0],[21,10],[20,1],[0,10]]]),
 ('rectangle',[[[0,0],[5,0],[10,0],[10,5],[10,10],[5,10],[0,10],[0,5]]]),
 ('notch',[[[0,0],[12,0],[12,12],[7,12],[7,2],[5,2],[5,12],[0,12]]]),
 ('channel',[[[0,0],[10,0],[10,4],[20,4],[20,0],[30,0],[30,10],[20,10],[20,6],[10,6],[10,10],[0,10]]]),
 ('repeats',[[[0,0],[0,0],[10,0],[10,10],[0,10],[0,0],[0,0]]]),
 ('retrace',[[[0,0],[10,0],[5,0],[10,0],[0,0],[0,10]]]),
 ('bowtie',[[[0,0],[10,10],[0,10],[10,0]]]),
 ('mixed',[[],[[1,1]],[[0,0],[10,0]],[[0,0],[1,0],[2,0],[3,0]],[[0,0],[10,0],[10,10],[0,10]]])]

def main():
    entries=[]
    def lock(name,v):
        p=ROOT/name;p.parent.mkdir(parents=True,exist_ok=True);data=canonical_bytes(v)
        if p.exists():require(p.read_bytes()==data,name,'locked data differs')
        else:p.write_bytes(data)
    for decimal in (False,True):
        groups=GROUPS[:6]+GROUPS[8:] if decimal else GROUPS
        for group,paths in groups:
            for mode in ('Open','Closed'):
                for precision in ((0,3,6) if decimal else (None,)):
                    for epsilon in ((0.25,0.5,2) if decimal else (0.25,0.5,1,4)):
                        cid='simplify_'+('decimal' if decimal else 'integer')+'_'+group+'_'+mode.lower()+(f'_p{precision}' if decimal else '')+'_e'+str(epsilon).replace('.','_')
                        c=dict(format_version=6,operation='SimplifyD' if decimal else 'Simplify64',case_id=cid,source=dict(kind='moonclip_constructed',group=group,intent='Ordered local distance deletion; '+cid),options=dict(preserve_collinear=False,reverse_solution=False),mode=mode,epsilon=epsilon,reference_route='DecimalGrid' if decimal else 'Integer',normalization=NORMALIZATION,paths=paths)
                        if decimal:c.update(precision=precision,grid='DecimalHalfAwayFromZero',paths=[[[float(x)-0.25,float(y)-0.25] for x,y in p] for p in paths])
                        validate_simplify_input(c,cid);ip=f'testdata/simplify/inputs/{cid}.json';lock(ip,c)
                        entries.append(dict(case_id=cid,input=ip,expected=f'testdata/simplify/expected/{cid}.json',status='validate',validation=dict(ordered_paths='validate',statistics='validate',degeneracy='validate')))
    entries.sort(key=lambda e:e['case_id']);require(len(entries)==224,'constructor','expected 224 inputs')
    lock('testdata/simplify-manifest.json',dict(format_version=6,kind='simplify',oracle_lock='tools/oracle/upstream-lock.json',cases=entries))
    lock('testdata/simplify-selection.json',dict(format_version=6,kind='simplify',expected_count=224,case_ids=[e['case_id'] for e in entries]))
    (ROOT/'testdata/simplify/expected').mkdir(parents=True,exist_ok=True)
    print('Locked 224 simplify inputs: Integer80 + DecimalGrid144; no MoonClip execution')
if __name__=='__main__':main()
