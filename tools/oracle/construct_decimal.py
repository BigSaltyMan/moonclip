# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Lock 196 decimal-grid and 24 actual ClipperD common-grid cases before MoonClip."""
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/conformance'))
from compare import canonical_bytes,require
from decimal_compare import validate_decimal_input

def rect(x,y,w,h):return [[x,y],[x+w,y],[x+w,y+h],[x,y+h]]
def main():
    entries=[]
    def lock(name,value):
        p=ROOT/name;p.parent.mkdir(parents=True,exist_ok=True);data=canonical_bytes(value)
        if p.exists():require(p.read_bytes()==data,name,'locked decimal data differs')
        else:p.write_bytes(data)
    def add(cid,operation,precision,route,**params):
        c=dict(format_version=5,operation=operation,case_id=cid,precision=precision,grid='DecimalHalfAwayFromZero',reference_route=route,source=dict(kind='moonclip_constructed',group=operation+'_'+route,intent='Fixed decimal grid; '+cid),options=dict(preserve_collinear=False,reverse_solution=False),**params)
        validate_decimal_input(c,cid)
        ip=f'testdata/decimal/inputs/{cid}.json';lock(ip,c)
        entries.append(dict(case_id=cid,input=ip,expected=f'testdata/decimal/expected/{cid}.json',status='validate',validation=dict(grid_paths='validate',paths='validate')))
    geometries=[('overlap',[rect(-10.25,-5.25,20,10)],[rect(0.25,-5.25,20,10)]),('hole',[rect(0.125,0.125,40,40),rect(10.125,10.125,20,20)[::-1]],[rect(20.125,-5.875,30,50)])]
    for group,subject,clip in geometries:
        for op in ('Intersection','Union','Difference','Xor'):
            for fill in ('EvenOdd','NonZero'):
                for precision in range(7):add(f'decimal_boolean_{group}_{op.lower()}_{fill.lower()}_p{precision}','BooleanD',precision,'DecimalGrid',subject=subject,clip=clip,clip_type=op,fill_rule=fill)
    region=[rect(-5.25,-5.25,20,20),rect(-0.25,-0.25,10,10)[::-1]]
    for join in ('Miter','Bevel','Square','Round'):
        for delta in (0.2,-0.2):
            for fill in ('EvenOdd','NonZero'):
                for precision in (0,3,6):add(f'decimal_offset_{join.lower()}_'+('out' if delta>0 else 'in')+f'_{fill.lower()}_p{precision}','OffsetD',precision,'DecimalGrid',paths=region,delta=delta,fill_rule=fill,join_type=join,miter_limit=2.0,arc_tolerance=0.025)
    for join in ('Miter','Bevel','Square','Round'):
        for cap in ('Butt','Square','Round'):
            for precision in (0,3,6):add(f'decimal_stroke_{join.lower()}_{cap.lower()}_p{precision}','StrokeD',precision,'DecimalGrid',path=[[-2.25,-1.25],[10.75,-1.25],[10.75,12.75]],width=0.4,join_type=join,cap_type=cap,miter_limit=2.0,arc_tolerance=0.025)
    for op in ('Intersection','Union','Difference','Xor'):
        for fill in ('EvenOdd','NonZero'):
            for precision in (0,3,6):add(f'decimal_clipperd_{op.lower()}_{fill.lower()}_p{precision}','BooleanD',precision,'ClipperDCommonGrid',subject=[rect(-12,-8,24,16)],clip=[rect(0,-8,24,16)],clip_type=op,fill_rule=fill)
    entries.sort(key=lambda e:e['case_id']);require(len(entries)==220,'constructor','expected 220 cases')
    lock('testdata/decimal-manifest.json',dict(format_version=5,kind='decimal',oracle_lock='tools/oracle/upstream-lock.json',cases=entries))
    lock('testdata/decimal-selection.json',dict(format_version=5,kind='decimal',expected_count=220,case_ids=[e['case_id'] for e in entries]))
    (ROOT/'testdata/decimal/expected').mkdir(parents=True,exist_ok=True)
    print('Locked 220 decimal inputs: 196 DecimalGrid +24 ClipperDCommonGrid; no MoonClip execution')
if __name__=='__main__':main()
