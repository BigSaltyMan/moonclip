# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Generate fixed public calls; runtime contains inputs, parameters and hashes only."""
import argparse
from composition_compare import composition_selection,stage_request
from generate_boolean import paths,formatted,call as boolean_call,tree_value
from generate_stroke import call as stroke_call
from selection import ROOT

def invocation(c,index):
    r=stage_request(c,index)
    op=r['operation']
    if op=='StrokePolyline':return stroke_call(r)
    if op=='OffsetPolygons':
        source=paths(r['paths']) if index==0 else 'intermediate'
        return '@moonclip.offset_polygons('+source+','+repr(float(r['delta']))+',fill_rule=@moonclip.'+r['fill_rule']+',options=@moonclip.OffsetOptions::new(join=@moonclip.JoinType::'+r['join_type']+',miter_limit='+repr(float(r['miter_limit']))+',arc_tolerance='+repr(float(r['arc_tolerance']))+'))'
    if index==0:return boolean_call(r)
    function='boolean_tree' if c['recipe']=='InsetThenTree' else 'boolean_op'
    return '@moonclip.'+function+'(intermediate,'+paths(r['clip'])+',@moonclip.'+op+',fill_rule=@moonclip.'+r['fill_rule']+')'

def generated():
    _,records=composition_selection(ROOT)
    tests=['// Generated composition references; both real stages must pass.']
    runner=['// Generated inputs/parameters/hashes only; NO expected contours.']
    for i,(e,c,d,expected) in enumerate(records):
        first,second=invocation(c,0),invocation(c,1);cid=c['case_id']
        tests+=['///|','// Full recipe SHA256: '+d,'test "reference composition: '+cid+'" {','guard '+first+' is Ok(intermediate) else { fail("step 1 failed") }','assert_eq(canonical_paths(intermediate),canonical_paths('+paths(expected['intermediate']['paths'])+'))']
        if c['recipe']=='InsetThenTree':
            value='['+','.join(tree_value(n) for n in expected['final']['tree']['children'])+']'
            tests+=['guard '+second+' is Ok(final) else { fail("step 2 failed") }','assert_eq(reference_tree(final),ref_sort('+value+'))','assert_eq(canonical_paths(final.to_paths()),canonical_paths('+paths(expected['final']['paths'])+'))']
        else:tests+=['assert_eq('+second+'.map(canonical_paths),Ok(canonical_paths('+paths(expected['final']['paths'])+')))']
        tests+=['}']
        runner+=['///|','fn composition_case_'+str(i)+'() -> Json {','let id="'+cid+'"','let digest="'+d+'"','let intermediate = match '+first+' { Ok(value)=>value\n Err(e)=>return composition_failure(id,digest,1,e) }','let final = match '+second+' { Ok(value)=>value\n Err(e)=>return composition_failure(id,digest,2,e,intermediate~) }','composition_success(id,digest,"'+c['recipe']+'",intermediate,'+('final.to_paths(),tree=actual_tree(final)' if c['recipe']=='InsetThenTree' else 'final')+')','}']
    runner+=['///|','fn run_composition_cases() -> Array[Json] { ['+','.join('composition_case_'+str(i)+'()' for i in range(len(records)))+'] }']
    return {'conformance/composition_test.mbt':'\n'.join(tests).replace('final','outcome')+'\n','cmd/conformance/composition_cases.mbt':'\n'.join(runner).replace('final','outcome')+'\n'}

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');args=p.parse_args()
    for name,text in generated().items():
        data=formatted(text);target=ROOT/name
        if args.check:
            if target.read_bytes()!=data:raise SystemExit('Stale generated composition: '+name)
        else:target.write_bytes(data)
    print('Composition selection: 24 public recipes; '+('check passed' if args.check else 'generated'))
