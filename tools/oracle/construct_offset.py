# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Lock 116 explicit offset requests before executing MoonClip. Never expectations."""
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/conformance'))
from compare import canonical_bytes

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
    entries=[]
    def write(group,paths,delta,label,join,fill,miter,intent):
        cid=f'offset_{group}_{label}_{join.lower()}_{fill.lower()}'
        case={'format_version':2,'case_id':cid,'source':{'kind':'moonclip_constructed','group':group,'intent':intent},'operation':'OffsetPolygons','paths':paths,'delta':delta,'join_type':join,'miter_limit':miter,'fill_rule':fill,'options':{'preserve_collinear':False,'reverse_solution':False}}
        name=f'testdata/offset/inputs/{cid}.json'
        (ROOT/name).parent.mkdir(parents=True,exist_ok=True)
        (ROOT/name).write_bytes(canonical_bytes(case))
        entries.append({'case_id':cid,'input':name,'expected':f'testdata/offset/expected/{cid}.json','status':'validate','validation':{'paths':'validate'}})
    for group,paths,positive,negative,intent in definitions():
        for fill in ('EvenOdd','NonZero'):
            for join in ('Miter','Bevel'):
                for delta,label in ((positive,'positive'),(negative,'negative')):write(group,paths,delta,label,join,fill,2.0,intent)
    for delta,label in ((0.0,'zero'),(0.49,'p049'),(-0.49,'n049'),(0.5,'p05'),(-0.5,'n05')):
        for fill in ('EvenOdd','NonZero'):
            for join in ('Miter','Bevel'):write('small',[rect(0,0,10,10),rect(5,0,15,10)],delta,label,join,fill,2.0,'Normalize overlapping region before insignificant or threshold distance')
    acute=definitions()[6][1]
    for limit in (4.0,10.0):
        for fill in ('EvenOdd','NonZero'):
            for delta,label in ((3.0,'positive'),(-2.0,'negative')):write('miter'+str(int(limit)),acute,delta,label,'Miter',fill,limit,'Extra miter limit at the same acute geometry and distances')
    for delta,label in ((-5.0,'exact'),(-6.0,'beyond')):
        for fill in ('EvenOdd','NonZero'):
            for join in ('Miter','Bevel'):write('collapse',[rect(0,0,10,10)],delta,label,join,fill,2.0,'Contraction exactly degenerates or disappears')
    entries.sort(key=lambda e:e['case_id']);assert len(entries)==116 and len({e['case_id'] for e in entries})==116
    (ROOT/'testdata/offset/expected').mkdir(parents=True,exist_ok=True)
    (ROOT/'testdata/offset-manifest.json').write_bytes(canonical_bytes({'format_version':2,'kind':'offset','oracle_lock':'tools/oracle/upstream-lock.json','cases':entries}))
    (ROOT/'testdata/offset-selection.json').write_bytes(canonical_bytes({'format_version':2,'kind':'offset','expected_count':116,'case_ids':[e['case_id'] for e in entries]}))
    print('Locked 116 offset input IDs and definitions; no expectations generated')
if __name__=='__main__':main()
