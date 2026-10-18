# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Lock exactly 24 raw two-stage recipes, before running MoonClip."""
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/conformance'))
from compare import canonical_bytes,require
from composition_compare import validate_composition_input

def rect(x,y,w,h):return [[x,y],[x+w,y],[x+w,y+h],[x,y+h]]
def boolean(subject,clip,operation='Union'):return dict(format_version=1,operation=operation,subject=subject,clip=clip,fill_rule='NonZero')
def offset(paths,delta):return dict(format_version=2,operation='OffsetPolygons',paths=paths,delta=delta,fill_rule='NonZero',join_type='Miter',miter_limit=2.0,arc_tolerance=0.0)
def stroke(path,cap):return dict(format_version=3,operation='StrokePolyline',path=path,width=4.0,join_type='Miter',cap_type=cap,miter_limit=2.0,arc_tolerance=0.0)

def main():
    entries=[]
    def lock(path,value):
        p=ROOT/path;p.parent.mkdir(parents=True,exist_ok=True);b=canonical_bytes(value)
        if p.exists():require(p.read_bytes()==b,str(path),'locked data differs')
        else:p.write_bytes(b)
    def add(recipe,group,label,first,second):
        cid='composition_'+group+'_'+label
        c=dict(format_version=4,operation='Composition',recipe=recipe,case_id=cid,source=dict(kind='moonclip_constructed',group=group,intent=recipe+'; real intermediate; '+label),options=dict(preserve_collinear=False,reverse_solution=False),steps=[first,second])
        validate_composition_input(c,cid)
        ip=f'testdata/composition/inputs/{cid}.json';lock(ip,c)
        entries.append(dict(case_id=cid,input=ip,expected=f'testdata/composition/expected/{cid}.json',status='validate',validation=dict(intermediate='validate',final='validate')))
    for group,a,b,op in [('overlap',[rect(0,0,10,10)],[rect(5,0,10,10)],'Union'),('notch',[rect(0,0,40,40)],[rect(10,-5,20,20)],'Difference'),('hole',[rect(0,0,40,40)],[rect(10,10,20,20)],'Difference'),('disjoint',[rect(0,0,3,3)],[rect(20,0,10,10)],'Union')]:
        for delta in (2.0,-2.0):
            second=offset([],delta);del second['paths'];add('BooleanThenOffset','boolean_'+group,'out' if delta>0 else 'in',boolean(a,b,op),second)
    dumbbell=[[0,0],[12,0],[12,5],[24,5],[24,0],[36,0],[36,16],[24,16],[24,11],[12,11],[12,16],[0,16]]
    for group,region in [('hole',[rect(0,0,40,40),rect(8,8,24,24)[::-1]]),('channel',[dumbbell]),('touch',[rect(0,0,40,40),rect(4,8,20,24)[::-1]]),('island',[rect(0,0,80,80),rect(10,10,60,60)[::-1],rect(24,24,32,32),rect(32,32,16,16)[::-1]])]:
        for delta in (-2.0,-4.0):
            second=boolean([],[]);del second['subject'];add('InsetThenTree','inset_'+group,'d'+str(int(-delta)),offset(region,delta),second)
    for group,path,mask in [('straight',[[-10,10],[30,10]],[rect(0,0,20,20)]),('cap',[[0,10],[18,10]],[rect(0,0,20,20)]),('corner',[[0,0],[20,0],[20,20]],[[[-4,-4],[24,-4],[24,24],[16,24],[16,4],[-4,4]]]),('hole',[[-10,20],[50,20]],[rect(0,0,40,40),rect(10,10,20,20)[::-1]])]:
        for cap in ('Butt','Round'):
            second=boolean([],mask,'Intersection');del second['subject'];add('StrokeThenIntersection','stroke_'+group,cap.lower(),stroke(path,cap),second)
    entries.sort(key=lambda e:e['case_id']);require(len(entries)==24,'constructor','expected 24')
    lock('testdata/composition-manifest.json',dict(format_version=4,kind='composition',oracle_lock='tools/oracle/upstream-lock.json',cases=entries))
    lock('testdata/composition-selection.json',dict(format_version=4,kind='composition',expected_count=24,case_ids=[e['case_id'] for e in entries]))
    (ROOT/'testdata/composition/expected').mkdir(parents=True,exist_ok=True)
    print('Locked 24 composition recipes (8 each); no MoonClip execution or expectations')
if __name__=='__main__':main()
