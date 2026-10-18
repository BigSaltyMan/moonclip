# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Lock 276 open-route requests before executing MoonClip. No expectations."""
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/conformance'))
from compare import canonical_bytes,require
from stroke_compare import validate_stroke_input

ROUTES={
 'horizontal':[[0,0],[20,0]],'vertical':[[0,0],[0,20]],
 'diagonal':[[0,0],[30,40]],'right_angle':[[0,0],[20,0],[20,20]],
 'acute':[[0,0],[60,0],[2,10]],'reversal':[[0,0],[20,0],[0,0]],
 'self_crossing':[[-20,-20],[20,20],[-20,20],[20,-20]],
 'coincident_ends':[[0,0],[30,0],[30,30],[0,0]],
}


def main():
    entries=[]
    def add(group,path,width,join,cap,label,tol=0.0,miter=2.0):
        cid=f'stroke_{group}_{label}_{join.lower()}_{cap.lower()}'
        c={'format_version':3,'operation':'StrokePolyline','case_id':cid,'source':{'kind':'moonclip_constructed','group':group,'intent':'Open route; full width divided by two; '+label},'options':{'preserve_collinear':False,'reverse_solution':False},'path':path,'width':width,'join_type':join,'cap_type':cap,'miter_limit':miter,'arc_tolerance':tol}
        validate_stroke_input(c,cid)
        ip=f'testdata/stroke/inputs/{cid}.json';target=ROOT/ip;target.parent.mkdir(parents=True,exist_ok=True)
        encoded=canonical_bytes(c)
        if target.exists():require(target.read_bytes()==encoded,cid,'locked input differs')
        else:target.write_bytes(encoded)
        entries.append({'case_id':cid,'input':ip,'expected':f'testdata/stroke/expected/{cid}.json','status':'validate','validation':{'paths':'validate'}})
    for group,path in ROUTES.items():
        for join in ('Miter','Bevel','Square','Round'):
            for cap in ('Butt','Square','Round'):
                for width in (4.0,10.0):add(group,path,width,join,cap,'w'+str(int(width)))
    for width,label in ((1.0,'w1'),(1.01,'w101'),(1.99,'w199'),(2.0,'w2'),(3.0,'w3')):
        for join in ('Miter','Bevel','Square','Round'):
            for cap in ('Butt','Square','Round'):add('threshold',ROUTES['horizontal'],width,join,cap,label)
    for group in ('right_angle','acute'):
        path=[[x*5,y*5] for x,y in ROUTES[group]]
        for tol,label in ((0.05,'t005'),(0.25,'t025'),(1.0,'t100')):
            for join,cap in (('Round','Butt'),('Miter','Round')):add('arc_'+group,path,20.0,join,cap,label,tol=tol)
    acute2=[[0,0],[50,0],[4,-16]]
    for group,path in (('miter_acute',ROUTES['acute']),('miter_acute_other',acute2)):
        for miter in (4.0,10.0):
            for cap in ('Butt','Square','Round'):add(group,path,10.0,'Miter',cap,'m'+str(int(miter)),miter=miter)
    entries.sort(key=lambda e:e['case_id']);require(len(entries)==276 and len({e['case_id'] for e in entries})==276,'constructor','expected 276 unique cases')
    for name,value in [('stroke-manifest.json',{'format_version':3,'kind':'stroke','oracle_lock':'tools/oracle/upstream-lock.json','cases':entries}),('stroke-selection.json',{'format_version':3,'kind':'stroke','expected_count':276,'case_ids':[e['case_id'] for e in entries]})]:
        p=ROOT/'testdata'/name;encoded=canonical_bytes(value)
        if p.exists():require(p.read_bytes()==encoded,name,'locked catalog changed')
        else:p.write_bytes(encoded)
    (ROOT/'testdata/stroke/expected').mkdir(parents=True,exist_ok=True)
    print('Locked 276 stroke inputs and selection; no MoonClip execution or expectations')
if __name__=='__main__':main()
