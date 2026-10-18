# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Append 156 locked offset requests before executing MoonClip. Never expectations."""
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/conformance'))
from compare import canonical_bytes, load, require, validate_input

def rect(a,b,c,d):return [[a,b],[c,b],[c,d],[a,d]]

def definitions():
    return [
      ('rectangle',[rect(0,0,10,10)],2.0,-2.0,'Basic positive and negative rectangle'),
      ('concave_l',[[[0,0],[40,0],[40,10],[10,10],[10,40],[0,40]]],4.0,-4.0,'Concave corner cleanup'),
      ('multipart',[rect(0,0,10,10),rect(14,0,24,10)],3.0,-2.0,'Expansion merges a four-unit gap'),
      ('hole',[rect(-30,-30,30,30),list(reversed(rect(-10,-10,10,10)))],12.0,-4.0,'Positive distance closes the hole; negative expands it'),
      ('island',[rect(-40,-40,40,40),list(reversed(rect(-25,-25,25,25))),rect(-10,-10,10,10)],4.0,-4.0,'Outer hole island orientation'),
      ('neck',[[[0,0],[20,0],[20,8],[30,8],[30,0],[50,0],[50,20],[30,20],[30,12],[20,12],[20,20],[0,20]]],3.0,-3.0,'Four-unit bridge splits under contraction'),
      ('acute',[[[0,0],[60,0],[2,10]]],3.0,-2.0,'Acute triangle tests miter to square fallback'),
      ('overlap',[rect(0,0,20,20),rect(10,0,30,20)],3.0,-3.0,'Same-direction inputs normalized together'),
      ('mixed_overlap',[rect(0,0,20,20),list(reversed(rect(10,0,30,20)))],3.0,-3.0,'Opposite winding cancels overlap before offset'),
      ('self_crossing',[[[-20,-20],[20,20],[-20,20],[20,-20]]],3.0,-3.0,'Zero-area bowtie must normalize into filled lobes'),
    ]

def main():
    old_selection=load(ROOT/'testdata/offset-selection.json',True)
    manifest=load(ROOT/'testdata/offset-manifest.json',True)
    old_ids=set(old_selection['case_ids'])
    require(len(old_ids)==116,'constructor','expected locked 116-case baseline')
    old_entries=[e for e in manifest['cases'] if e['case_id'] in old_ids]
    require(len(old_entries)==116,'constructor','missing old entry')
    for e in old_entries:
        case=load(ROOT/e['input'],True);validate_input(case,e['case_id'])
        require('arc_tolerance' not in case and case['join_type'] in ('Miter','Bevel'),e['case_id'],'old baseline changed')
    entries=[]
    def write(group,paths,delta,label,join,fill,intent,tolerance=None):
        cid=f'offset_{group}_{label}_{join.lower()}_{fill.lower()}'
        case={'format_version':2,'case_id':cid,'source':{'kind':'moonclip_constructed','group':group,'intent':intent},'operation':'OffsetPolygons','paths':paths,'delta':delta,'join_type':join,'miter_limit':2.0,'fill_rule':fill,'options':{'preserve_collinear':False,'reverse_solution':False}}
        if tolerance is not None:case['arc_tolerance']=tolerance
        validate_input(case,cid)
        name=f'testdata/offset/inputs/{cid}.json';target=ROOT/name
        encoded=canonical_bytes(case)
        if target.exists():require(target.read_bytes()==encoded,cid,'locked definition differs')
        else:target.write_bytes(encoded)
        entries.append({'case_id':cid,'input':name,'expected':f'testdata/offset/expected/{cid}.json','status':'validate','validation':{'paths':'validate'}})
    for group,paths,positive,negative,intent in definitions():
        for fill in ('EvenOdd','NonZero'):
            for join in ('Square','Round'):
                for delta,label in ((positive,'positive'),(negative,'negative')):write(group,paths,delta,label,join,fill,intent)
    for delta,label in ((0.0,'zero'),(0.49,'p049'),(-0.49,'n049'),(0.5,'p05'),(-0.5,'n05')):
        for fill in ('EvenOdd','NonZero'):
            for join in ('Square','Round'):write('small',[rect(0,0,10,10),rect(5,0,15,10)],delta,label,join,fill,'Normalize overlapping region before insignificant or threshold distance')
    for delta,label in ((-5.0,'exact'),(-6.0,'beyond')):
        for fill in ('EvenOdd','NonZero'):
            for join in ('Square','Round'):write('collapse',[rect(0,0,10,10)],delta,label,join,fill,'Contraction exactly degenerates or disappears')
    for group,paths,_,_,_ in definitions():
        if group not in ('rectangle','acute','hole','neck'):continue
        scaled=[[[x*5,y*5] for x,y in p] for p in paths]
        for tolerance,label in ((0.05,'t005'),(0.25,'t025'),(1.0,'t100')):
            for fill in ('EvenOdd','NonZero'):
                for delta,sign in ((10.0,'positive'),(-10.0,'negative')):
                    write('arc_'+group,scaled,delta,label+'_'+sign,'Round',fill,'Scale 5, signed radius 10, explicit tolerance; neck contraction splits the twenty-unit bridge',tolerance)
    entries.sort(key=lambda e:e['case_id'])
    require(len(entries)==156 and len({e['case_id'] for e in entries})==156,'constructor','expected 156 unique new cases')
    require(not old_ids&{e['case_id'] for e in entries},'constructor','new/old overlap')
    combined=sorted(old_entries+entries,key=lambda e:e['case_id'])
    (ROOT/'testdata/offset-manifest.json').write_bytes(canonical_bytes({'format_version':2,'kind':'offset','oracle_lock':'tools/oracle/upstream-lock.json','cases':combined}))
    selection=canonical_bytes({'format_version':2,'kind':'offset','expected_count':156,'case_ids':[e['case_id'] for e in entries]})
    target=ROOT/'testdata/offset-join-selection.json'
    if target.exists():require(target.read_bytes()==selection,'constructor','new selection changed')
    else:target.write_bytes(selection)
    print('Locked 156 new offset inputs; reused 116 baseline records without rewriting inputs or selection; no expectations generated')
if __name__=='__main__':main()
