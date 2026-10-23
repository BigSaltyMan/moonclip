#!/usr/bin/env python3
"""Report independently executed MoonBit flat and tree capabilities."""
import argparse
import json
from pathlib import Path
import sys
from compare import Invalid, require, compare_paths, compare_tree, canonical_bytes, validate_paths, walk_tree
ROOT=Path(__file__).resolve().parents[2]

def selected_records(manifest):
    from selection import selections
    records,public,_=selections(manifest)
    return records,public

def summary(details,capability=None):
    states=[r[capability] if capability else r['status'] for r in details]
    return {'required':152,'executed':len(states),'passed':states.count('passed'),'differences':states.count('difference'),'execution_errors':states.count('execution_error')}

def evaluate(manifest,results):
    records,chosen=selected_records(manifest)
    require(type(results) is list,'actual','expected results array')
    actual={}
    for r in results:
        require(type(r) is dict and type(r.get('case_id')) is str,'actual','missing case ID')
        require(r['case_id'] not in actual,r['case_id'],'duplicate actual result')
        actual[r['case_id']]=r
    require(set(actual)=={r[0]['case_id'] for r in chosen},'actual','missing or extra case results')
    details=[]
    for entry,case,digest,expected in chosen:
        cid=entry['case_id'];r=actual[cid]
        require(r.get('input_sha256')==digest,cid,'compiled input hash differs from manifest input; regenerate runner')
        require('tree_result' in r,cid,'missing independent tree result')
        detail={'case_id':cid}
        if r.get('status')=='error':
            require(set(r)=={'case_id','input_sha256','status','error','tree_result'},cid,'invalid error result')
            detail['paths']='execution_error';detail['paths_message']=str(r['error'])
        else:
            require(set(r)=={'case_id','input_sha256','status','paths','tree_result'} and r['status']=='success',cid,'invalid success result')
            validate_paths(r['paths'],cid+'.actual',output=True)
            try:compare_paths(expected['paths'],r['paths'],cid+'.paths')
            except Invalid as error:detail['paths']='difference';detail['paths_message']=str(error)
            else:detail['paths']='passed'
        tree=r['tree_result']
        require(type(tree) is dict,cid,'invalid tree result')
        if tree.get('status')=='error':
            require(set(tree)=={'status','error'},cid,'invalid tree error')
            detail['tree']='execution_error';detail['tree_message']=str(tree['error'])
        else:
            require(set(tree)=={'status','tree'} and tree['status']=='success',cid,'missing or invalid tree geometry')
            walk_tree(tree['tree'],cid+'.actual.tree')
            try:compare_tree(expected['tree'],tree['tree'],cid+'.tree')
            except Invalid as error:detail['tree']='difference';detail['tree_message']=str(error)
            else:detail['tree']='passed'
        states=[detail['paths'],detail['tree']]
        detail['status']='execution_error' if 'execution_error' in states else 'difference' if 'difference' in states else 'passed'
        details.append(detail)
    report={'target':'native','reference_cases':len(records),'internal_fill_rules':'validate_internal','cases':details,**summary(details)}
    report['paths']=summary(details,'paths');report['tree']=summary(details,'tree')
    return report

def evaluate_offset(manifest, results):
    from compare import read_manifest
    from offset_compare import validate_offset_selections
    _, records=read_manifest(ROOT,manifest,strict=True)
    validate_offset_selections(ROOT,records)
    require(len(records)==272 and all(c['operation']=='OffsetPolygons' for _,c,_,_ in records),'offset','expected 272 offset cases')
    require(type(results) is list,'offset actual','expected results array')
    actual={}
    for result in results:
        require(type(result) is dict and type(result.get('case_id')) is str,'offset actual','missing case ID')
        cid=result['case_id'];require(cid not in actual,cid,'duplicate offset result');actual[cid]=result
    require(set(actual)=={e['case_id'] for e,_,_,_ in records},'offset actual','missing or extra offset results')
    details=[]
    for entry,case,digest,expected in records:
        cid=case['case_id'];r=actual[cid]
        require(r.get('input_sha256')==digest,cid,'compiled offset hash mismatch')
        detail={'case_id':cid}
        if r.get('status')=='error':
            require(set(r)=={'case_id','input_sha256','status','error'} and type(r['error']) is str,cid,'invalid offset error')
            detail.update(status='execution_error',message=r['error'])
        else:
            require(set(r)=={'case_id','input_sha256','status','paths'} and r['status']=='success',cid,'invalid offset success')
            validate_paths(r['paths'],cid+'.offset',output=True)
            try:compare_paths(expected['paths'],r['paths'],cid+'.offset')
            except Invalid as error:detail.update(status='difference',message=str(error))
            else:detail['status']='passed'
        details.append(detail)
    return {**summary(details),'required':272,'reference_cases':272,'capability':'public paths','cases':details}


def evaluate_stroke(manifest, results):
    from compare import read_manifest
    from stroke_compare import stroke_selection
    _, records=read_manifest(ROOT,manifest,strict=True)
    _,selected=stroke_selection(ROOT)
    require([r[0]["case_id"] for r in records]==[r[0]["case_id"] for r in selected],"stroke","manifest selection differs")
    require(len(records)==276 and all(c['operation']=='StrokePolyline' for _,c,_,_ in records),'stroke','expected 276 stroke cases')
    require(type(results) is list,'stroke actual','expected results array')
    actual={}
    for result in results:
        require(type(result) is dict and type(result.get('case_id')) is str,'stroke actual','missing case ID')
        cid=result['case_id'];require(cid not in actual,cid,'duplicate stroke result');actual[cid]=result
    require(set(actual)=={e['case_id'] for e,_,_,_ in records},'stroke actual','missing or extra stroke results')
    details=[]
    for entry,case,digest,expected in records:
        cid=case['case_id'];r=actual[cid]
        require(r.get('input_sha256')==digest,cid,'compiled stroke hash mismatch')
        detail={'case_id':cid}
        if r.get('status')=='error':
            require(set(r)=={'case_id','input_sha256','status','error'} and type(r['error']) is str,cid,'invalid stroke error')
            detail.update(status='execution_error',message=r['error'])
        else:
            require(set(r)=={'case_id','input_sha256','status','paths'} and r['status']=='success',cid,'invalid stroke success')
            validate_paths(r['paths'],cid+'.stroke',output=True)
            try:compare_paths(expected['paths'],r['paths'],cid+'.stroke')
            except Invalid as error:detail.update(status='difference',message=str(error))
            else:detail['status']='passed'
        details.append(detail)
    from collections import Counter
    coverage={field:dict(sorted(Counter(str(c[field]) for _,c,_,_ in records).items())) for field in ('join_type','cap_type','width','miter_limit','arc_tolerance')}
    return {**summary(details),'required':276,'reference_cases':276,'capability':'public paths','cases':details,'coverage':coverage}


def evaluate_composition(manifest,results):
    from composition_compare import composition_selection,validate_composition_geometry
    from compare import read_manifest,keys
    from collections import Counter
    _,records=read_manifest(ROOT,manifest,strict=True)
    _,selected=composition_selection(ROOT)
    require(records==selected,'composition','manifest differs from locked selection')
    require(type(results) is list,'composition actual','expected results array')
    actual={}
    for r in results:
        require(type(r) is dict and type(r.get('case_id')) is str,'composition actual','missing ID')
        require(r['case_id'] not in actual,r['case_id'],'duplicate composition result');actual[r['case_id']]=r
    require(set(actual)=={e['case_id'] for e,_,_,_ in records},'composition actual','missing or extra recipes')
    details=[]
    def compare_stage(detail,label,want,got,tree=False):
        try:
            compare_paths(want['paths'],got['paths'],detail['case_id']+'.'+label)
            if tree:compare_tree(want['tree'],got['tree'],detail['case_id']+'.'+label+'.tree')
        except Invalid as error:detail.update({label:'difference',label+'_message':str(error)})
        else:detail[label]='passed'
    for e,c,d,expected in records:
        r=actual[c['case_id']];cid=c['case_id']
        require(r.get('input_sha256')==d,cid,'compiled recipe hash mismatch')
        detail={'case_id':cid,'recipe':c['recipe']}
        if r.get('status')=='error':
            step=r.get('failure_step');require(type(step) is int and step in (1,2),cid,'missing/invalid failure step')
            fields={'case_id','input_sha256','status','error','failure_step'}
            if step==2:fields.add('intermediate')
            keys(r,fields,cid);require(type(r['error']) is str,cid,'invalid error')
            if step==2:
                keys(r['intermediate'],{'paths'},cid+'.intermediate');validate_paths(r['intermediate']['paths'],cid,True)
                compare_stage(detail,'intermediate',expected['intermediate'],r['intermediate'])
            else:detail['intermediate']='execution_error'
            detail.update(status='execution_error',final='execution_error' if step==2 else 'not_executed',failure_step=step,message=r['error'])
        else:
            keys(r,{'case_id','input_sha256','status','format_version','recipe','intermediate','final'},cid)
            require(r['recipe']==c['recipe'],cid,'actual recipe mismatch');validate_composition_geometry(r,cid)
            compare_stage(detail,'intermediate',expected['intermediate'],r['intermediate'])
            compare_stage(detail,'final',expected['final'],r['final'],c['recipe']=='InsetThenTree')
            detail['status']='passed' if detail['intermediate']==detail['final']=='passed' else 'difference'
        details.append(detail)
    report={**summary(details),'required':24,'reference_cases':24,'cases':details,'recipes':dict(Counter(c['recipe'] for _,c,_,_ in records))}
    for stage in ('intermediate','final'):
        skipped=sum(r[stage]=='not_executed' for r in details)
        report[stage]={**summary(details,stage),'required':24,'executed':len(details)-skipped,'not_executed':skipped}
    return report


def evaluate_decimal(manifest,results):
    from decimal_compare import decimal_selection,validate_decimal_geometry
    from compare import read_manifest,keys
    from collections import Counter
    _,records=read_manifest(ROOT,manifest,strict=True)
    _,selected=decimal_selection(ROOT)
    require(records==selected,'decimal','manifest differs from locked selection')
    require(type(results) is list,'decimal actual','expected results array')
    actual={}
    for r in results:
        require(type(r) is dict and type(r.get('case_id')) is str,'decimal actual','missing ID')
        require(r['case_id'] not in actual,r['case_id'],'duplicate decimal result');actual[r['case_id']]=r
    require(set(actual)=={e['case_id'] for e,_,_,_ in records},'decimal actual','missing or extra decimal results')
    details=[]
    for e,c,d,v in records:
        cid=c['case_id'];r=actual[cid]
        require(r.get('input_sha256')==d,cid,'compiled decimal input hash mismatch')
        detail=dict(case_id=cid,operation=c['operation'],precision=c['precision'],reference_route=c['reference_route'])
        if r.get('status')=='error':
            keys(r,{'case_id','input_sha256','status','error'},cid);require(type(r['error']) is str,cid,'invalid decimal execution error')
            detail.update(status='execution_error',grid_paths='execution_error',decoded='execution_error',message=r['error'])
        else:
            keys(r,{'case_id','input_sha256','status','format_version','operation','reference_route','precision','grid_paths','paths'},cid)
            require(type(r['format_version']) is int and r['format_version']==5 and r['status']=='success',cid,'invalid decimal success envelope')
            require(all(r[k]==c[k] for k in ('operation','precision','reference_route')),cid,'compiled decimal metadata mismatch')
            validate_paths(r['grid_paths'],cid+'.grid_paths',True)
            try:compare_paths(v['grid_paths'],r['grid_paths'],cid+'.grid_paths')
            except Invalid as error:detail.update(grid_paths='difference',grid_message=str(error))
            else:detail['grid_paths']='passed'
            try:validate_decimal_geometry(r,cid+'.decoded')
            except Invalid as error:detail.update(decoded='difference',decoded_message=str(error))
            else:detail['decoded']='passed'
            detail['status']='passed' if detail['grid_paths']==detail['decoded']=='passed' else 'difference'
        details.append(detail)
    report={**summary(details),'required':220,'reference_cases':220,'cases':details}
    report['routes']={route:{**summary([d for d in details if d['reference_route']==route]),'required':count} for route,count in [('DecimalGrid',196),('ClipperDCommonGrid',24)]}
    report['operations']={op:{'count':sum(c['operation']==op for _,c,_,_ in records),'precisions':dict(sorted(Counter(str(c['precision']) for _,c,_,_ in records if c['operation']==op).items()))} for op in ('BooleanD','OffsetD','StrokeD')}
    report['parameters']={field:dict(sorted(Counter(str(c[field]) for _,c,_,_ in records if field in c).items())) for field in ('clip_type','fill_rule','join_type','cap_type','delta','width','miter_limit','arc_tolerance')}
    report['grid_paths']={**summary(details,'grid_paths'),'required':220}
    report['decoded']={**summary(details,'decoded'),'required':220}
    return report


def evaluate_simplify(manifest,results):
    from simplify_compare import (simplify_selection,validate_simplify_geometry,statistics,COUNTS,INDICES)
    from compare import read_manifest,keys
    _,records=read_manifest(ROOT,manifest,strict=True);_,selected=simplify_selection(ROOT)
    require(records==selected,'simplify','manifest differs from locked selection')
    require(type(results) is list,'simplify actual','expected results array');actual={}
    for r in results:
        require(type(r) is dict and type(r.get('case_id')) is str,'simplify actual','missing ID')
        require(r['case_id'] not in actual,r['case_id'],'duplicate simplify result');actual[r['case_id']]=r
    require(set(actual)=={e['case_id'] for e,_,_,_ in records},'simplify actual','missing/extra results')
    details=[]
    for e,c,d,v in records:
        cid=c['case_id'];r=actual[cid];require(r.get('input_sha256')==d,cid,'compiled input hash mismatch')
        detail=dict(case_id=cid,operation=c['operation'],reference_route=c['reference_route'])
        if r.get('status')=='error':
            keys(r,{'case_id','input_sha256','status','error'},cid);require(type(r['error']) is str,cid,'invalid execution error')
            detail.update(status='execution_error',ordered_paths='execution_error',removed_counts='execution_error',degeneracy='execution_error',message=r['error'])
        else:
            keys(r,{'case_id','input_sha256','status','format_version','operation','mode','reference_route','paths',*COUNTS,*INDICES}|({'precision','paths_d'} if c['operation']=='SimplifyD' else set()),cid)
            require(r['status']=='success' and type(r['format_version']) is int and r['format_version']==6,cid,'invalid success envelope')
            require(all(r[k]==c[k] for k in ('operation','mode','reference_route')),cid,'metadata mismatch')
            if c['operation']=='SimplifyD':require(type(r['precision']) is int and r['precision']==c['precision'],cid,'precision mismatch')
            validate_paths(r['paths'],cid+'.paths',False)
            own=statistics(c,r['paths'])
            detail['ordered_paths']='passed' if r['paths']==v['paths'] else 'difference'
            for capability,fields in [('removed_counts',COUNTS),('degeneracy',INDICES)]:
                detail[capability]='passed' if all(canonical_bytes(r[k])==canonical_bytes(v[k])==canonical_bytes(own[k]) for k in fields) else 'difference'
            # Independently validate decoding and normalized geometry without allowing
            # inconsistent report values to contaminate the ordered-geometry count.
            try:validate_simplify_geometry({**r,**own},cid)
            except Invalid as error:detail.update(ordered_paths='difference',geometry_message=str(error))
            try:validate_simplify_geometry(r,cid)
            except Invalid as error:detail['contract_message']=str(error)
            detail['status']='passed' if all(detail[k]=='passed' for k in ('ordered_paths','removed_counts','degeneracy')) and 'contract_message' not in detail else 'difference'
        details.append(detail)
    report={**summary(details),'required':224,'reference_cases':224,'cases':details}
    report['routes']={route:{**summary([d for d in details if d['reference_route']==route]),'required':n} for route,n in [('Integer',80),('DecimalGrid',144)]}
    for field in ('ordered_paths','removed_counts','degeneracy'):report[field]={**summary(details,field),'required':224}
    return report


def evaluate_minkowski(manifest,results):
    from minkowski_compare import minkowski_selection,validate_minkowski_geometry,OPTIONS
    from compare import read_manifest,keys
    from collections import Counter
    _,records=read_manifest(ROOT,manifest,strict=True);_,selected=minkowski_selection(ROOT)
    require(records==selected,'minkowski','manifest differs from locked selection')
    require(type(results) is list,'minkowski actual','expected array');actual={}
    for r in results:
        require(type(r) is dict and type(r.get('case_id')) is str,'minkowski actual','missing ID')
        require(r['case_id'] not in actual,r['case_id'],'duplicate result');actual[r['case_id']]=r
    require(set(actual)=={e['case_id'] for e,_,_,_ in records},'minkowski actual','missing/extra results')
    details=[]
    for e,c,d,v in records:
        cid=c['case_id'];r=actual[cid];require(r.get('input_sha256')==d,cid,'compiled input hash mismatch');detail=dict(case_id=cid)
        if r.get('status')=='error':
            keys(r,{'case_id','input_sha256','status','error'},cid);require(type(r['error']) is str,cid,'invalid execution error')
            detail.update(status='execution_error',message=r['error'])
        else:
            keys(r,{'case_id','input_sha256','status','format_version','operation','fill_rule','options','paths'},cid)
            validate_minkowski_geometry(r,cid)
            try:compare_paths(v['paths'],r['paths'],cid)
            except Invalid as error:detail.update(status='difference',message=str(error))
            else:detail['status']='passed'
        details.append(detail)
    return {**summary(details),'required':144,'reference_cases':144,'cases':details,'fill_rule':'NonZero','options':OPTIONS,
      'coverage':{'patterns':dict(sorted(Counter(c['source']['group'].split(':')[0] for _,c,_,_ in records).items())),
                  'routes':dict(sorted(Counter(c['source']['group'].split(':')[1] for _,c,_,_ in records).items())),
                  'directions':dict(sorted(Counter(c['source']['group'].split(':')[2] for _,c,_,_ in records).items())),
                  'modes':dict(sorted(Counter('Closed' if c['path_is_closed'] else 'Open' for _,c,_,_ in records).items()))}}



def evaluate_rectclip(manifest,results):
    from rectclip_compare import read_rectclip_manifest,validate_rectclip_geometry,OPTIONS,COUNT
    from compare import keys
    _,records=read_rectclip_manifest(ROOT,manifest,strict=True)
    require(type(results) is list,'rectclip actual','expected results array')
    actual={}
    for r in results:
        require(type(r) is dict and type(r.get('case_id')) is str,'rectclip actual','missing ID')
        require(r['case_id'] not in actual,r['case_id'],'duplicate result');actual[r['case_id']]=r
    require(set(actual)=={e['case_id'] for e,_,_,_ in records},'rectclip actual','missing/extra results')
    details=[]
    for e,c,d,v in records:
        cid=c['case_id'];r=actual[cid];require(r.get('input_sha256')==d,cid,'compiled input hash mismatch')
        detail=dict(case_id=cid)
        if r.get('status')=='error':
            keys(r,{'case_id','input_sha256','status','error'},cid)
            require(type(r['error']) is str,cid,'invalid execution error')
            detail.update(status='execution_error',message=r['error'])
        else:
            keys(r,{'case_id','input_sha256','status','paths'},cid)
            validate_rectclip_geometry(dict(r,format_version=8,operation='RectClipLines',options=OPTIONS),cid)
            detail['status']='passed' if r['paths']==v['paths'] else 'difference'
        details.append(detail)
    return {**summary(details),'required':COUNT,'reference_cases':COUNT,'cases':details,'capability':'ordered open fragments'}


def rectclip_markdown(result):
    return ['','# Rectangle open-line clipping compatibility','',
        f"Ordered open fragments: {result['passed']}/{result['executed']}; required={result['required']}; differences={result['differences']}; execution_errors={result['execution_errors']}.",'',
        'Pinned C++ RectClipLines64, CLIPPER2_HI_PRECISION=0. Fragment order, travel direction, every vertex and coordinate are compared exactly. No ring rotation, reversal, sorting, epsilon or forced boundary snapping. Boundary inclusion depends on traversal history.','',
        '| Case | Ordered open paths |','| --- | --- |',
        *[f"| {r['case_id']} | {r['status']} |" for r in result['cases']]]


def coverage_matrix(include_random=True):
    """Counts catalog cases once; capability selections and field incidence are separate."""
    from collections import Counter
    from compare import read_manifest
    catalogs=[('boolean','manifest'),('offset','offset-manifest'),('stroke','stroke-manifest'),
              ('composition','composition-manifest'),('decimal','decimal-manifest'),
              ('simplify','simplify-manifest'),('minkowski','minkowski-manifest')]
    if include_random:catalogs.append(('random','random-manifest'))
    catalogs.append(('rectclip','rectclip-manifest'))
    fields=('operation','clip_type','fill_rule','join_type','cap_type','precision','reference_route','mode','epsilon','path_is_closed','preserve_collinear','reverse_solution')
    rows=[];all_ids=set()
    for name,stem in catalogs:
        _,records=read_manifest(ROOT,ROOT/('testdata/'+stem+'.json'),strict=True)
        capabilities=Counter();coverage={field:Counter() for field in fields}
        for e,c,_,_ in records:
            require(e['case_id'] not in all_ids,'matrix','duplicate case across catalogs');all_ids.add(e['case_id'])
            for capability,status in e.get('validation',{}).items():capabilities[capability+':'+status]+=1
            parts=[c]+c.get('steps',[])
            for field in fields:
                values=set()
                for part in parts:
                    source=part.get('options',{}) if field in ('preserve_collinear','reverse_solution') else part
                    if field in source:values.add(__import__('json').dumps(source[field],sort_keys=True))
                for value in values:coverage[field][value]+=1
        rows.append(dict(catalog=name,cases=len(records),capability_checks=sum(capabilities.values()),
                         capabilities=dict(sorted(capabilities.items())),
                         fields={k:dict(sorted(v.items())) for k,v in coverage.items() if v},
                         absent_fields=[k for k,v in coverage.items() if not v]))
    return dict(cases=len(all_ids),capability_checks=sum(r['capability_checks'] for r in rows),catalogs=rows,
        limitations=['Manifest selections are coverage, not fresh execution evidence.',
          'Random v1 adds only public flat Boolean: three small configurations, four operations, two fill rules; no random trees, decimal, offset, stroke, simplification or Minkowski coverage.',
          'Positive/Negative Boolean remain internal; no arbitrary-region open-path Boolean, MinkowskiDiff, decimal Minkowski or multi-pattern holes API. Decimal Boolean trees and integer/decimal offset or stroke trees are not validated by these catalogs. Rectclip checks ordered integer open fragments, not filled contours or trees.',
          'Simplification checks ordered vertices, statistics and degeneracy; it is not a general topology-preservation proof.',
          'Individual field coverage does not imply the full Cartesian product is covered. Missing fields below mean absent/not applicable, not passed.'])


def random_execution_evidence(directory):
    import re
    result={}
    for target in ('native','js'):
        path=directory/('random-'+target+'.log');full=False
        if not path.exists():path=directory/('all-'+target+'.log');full=True
        if not path.exists():result[target]={'status':'not_recorded'};continue
        totals=re.findall(r'Total tests: (\d+), passed: (\d+), failed: (\d+)\.',path.read_text(encoding='utf-8-sig'))
        count=2397 if full else 24
        require(totals==[(str(count),str(count),'0')],str(path),'unexpected random/full execution count')
        result[target]=dict(status='passed',executed=24,passed=24,source='full' if full else 'random-only')
    return result


def evaluate_random(manifest,results):
    from compare import read_manifest,keys
    _,records=read_manifest(ROOT,manifest,strict=True)
    require(len(records)==24 and all(e['validation']=={'paths':'validate'} for e,_,_,_ in records),'random','expected24 flat cases')
    require(type(results) is list,'random','expected result array');actual={}
    for r in results:
        require(type(r) is dict and type(r.get('case_id')) is str and r['case_id'] not in actual,'random','missing/duplicate ID')
        actual[r['case_id']]=r
    require(set(actual)=={e['case_id'] for e,_,_,_ in records},'random','missing/extra results')
    details=[]
    for e,c,d,v in records:
        r=actual[e['case_id']];require(r.get('input_sha256')==d,e['case_id'],'compiled hash mismatch')
        detail=dict(case_id=e['case_id'],seed=e['seed'],configuration=e['configuration'],input_sha256=d)
        if r.get('status')=='error':
            keys(r,{'case_id','input_sha256','status','error'},'random error')
            require(type(r['error']) is str,'random','invalid error');detail.update(status='execution_error',message=r['error'])
        else:
            keys(r,{'case_id','input_sha256','status','paths'},'random success');require(r['status']=='success','random','invalid status')
            validate_paths(r['paths'],'random output',output=True)
            try:compare_paths(v['paths'],r['paths'],e['case_id'])
            except Invalid as error:detail.update(status='difference',message=str(error))
            else:detail['status']='passed'
        details.append(detail)
    return {**summary(details),'required':24,'reference_cases':24,'cases':details}


def matrix_markdown(matrix):
    lines=['','# Manifest coverage matrix','',f"Unique catalog cases: {matrix['cases']}; selected capability checks: {matrix['capability_checks']}. A case with flat/tree or intermediate/final results is counted once as a case.",'',
           'Each field value counts distinct cases containing that value (including composition steps). Counts across capabilities or fields must not be added as independent cases.','',
           '| Catalog | Cases | Selected checks | Capability selections |','| --- | ---: | ---: | --- |']
    for row in matrix['catalogs']:
        lines.append(f"| {row['catalog']} | {row['cases']} | {row['capability_checks']} | "+', '.join(k+'='+str(v) for k,v in sorted(row['capabilities'].items()))+' |')
    for row in matrix['catalogs']:
        lines+=['',"## "+row['catalog']+' field coverage','','| Field | Case incidence |','| --- | --- |']
        for field,values in sorted(row['fields'].items()):lines.append('| '+field+' | '+', '.join(k+': '+str(v) for k,v in values.items())+' |')
        lines+=['','Absent / not applicable fields: '+', '.join(row['absent_fields'])+'.']
    lines+=['','## Limits of this evidence','']+['- '+item for item in matrix['limitations']]
    return lines


def random_markdown(result,evidence):
    lines=['','# Fixed-seed random Boolean flat compatibility','',f"Random cases: {result['passed']}/24; differences={result['differences']}; execution_errors={result['execution_errors']}. Reference total: 1360 + 24 = 1384.",'',
           'Seed 20261019; xorshift32-small-polygons-v1. Three configurations x four operations x two fill rules. Inputs, order and hashes are locked; no random tree capability is claimed.','',
           '| Target | Actual random tests |','| --- | --- |']
    for target in ('native','js'):
        e=evidence.get(target,{})
        lines.append('| '+target+' | '+('24/24' if e.get('status')=='passed' else 'not recorded')+' |')
    lines+=['','| Case | Configuration | Native flat result |','| --- | --- | --- |']
    lines += ['| '+r['case_id']+' | '+r['configuration']+' | '+r['status']+' |' for r in result['cases']]
    return lines


def markdown(report):
    lines=['# Boolean compatibility','','Pinned Clipper2 2.0.1, commit `21ebba05db8894f0c7217ad35ea518080f324946`; ordinary precision. Boolean/Offset/Stroke: preserve_collinear=false; MinkowskiSum: preserve_collinear=true; reverse_solution=false. Simplification has its own ordered-output contract.','',
      f"Public cases: {report['required']}; both passed={report['passed']}, differences={report['differences']}, execution_errors={report['execution_errors']}. Reference catalog: {report['reference_cases']}.",'',
      '| Native capability | Required | Executed | Passed | Differences | Execution errors |','| --- | ---: | ---: | ---: | ---: | ---: |']
    for capability in ('paths','tree'):
        r=report[capability];lines.append(f"| {capability} | {r['required']} | {r['executed']} | {r['passed']} | {r['differences']} | {r['execution_errors']} |")
    lines+=['','152 cases have two independently executed capabilities; this is not 304 independent cases. The executable calls boolean_op and boolean_tree separately and compiles only inputs and hashes.','','Native and JS execute the same public and internal tests independently. Positive/Negative remain private; their 48 paths and 48 trees are separate whitebox evidence.','','| Target | Internal paths | Public tree | Internal tree |','| --- | --- | --- | --- |']
    for target in ('native','js'):
        entries=[report.get('internal',{}).get(target,{}),report.get('tree_evidence',{}).get('public',{}).get(target,{}),report.get('tree_evidence',{}).get('internal',{}).get(target,{})]
        values=[str(e['passed'])+'/'+str(e['executed']) if e.get('status')=='passed' else 'not recorded' for e in entries]
        lines.append('| '+target+' | '+' | '.join(values)+' |')
    lines+=['','Filtered counts are read from actual logs. Tree logs require their own selection markers; old paths logs cannot establish tree execution. Internal rules each cover 24 cases.','','Only cyclic ring starts and sibling order are normalized. Parentage, depth, full coordinates, vertex counts, winding and multiplicity remain significant.','','| Case | Native paths | Native tree | Both |','| --- | --- | --- | --- |']
    lines += [f"| {r['case_id']} | {r['paths']} | {r['tree']} | {r['status']} |" for r in report['cases']]
    if 'offset' in report:
        r=report['offset']
        lines+=['','# Offset compatibility','',f"Offset public paths: {r['passed']}/{r['executed']}; required={r['required']}, differences={r['differences']}, execution_errors={r['execution_errors']}.",'',
          'Boolean reference cases: 200. Offset reference cases: 272. Boolean/Offset subtotal: 472. This offset catalog checks flat output; the newer direct tree interfaces have separate targeted tests and consumer checks.','',
          '| Target | Offset filtered paths |','| --- | --- |']
        for target in ('native','js'):
            e=report.get('offset_evidence',{}).get(target,{})
            value=str(e['passed'])+'/'+str(e['executed']) if e.get('status')=='passed' else 'not recorded'
            lines.append('| '+target+' | '+value+' |')
        lines+=['','| Offset case | Native paths |','| --- | --- |']
        lines += [f"| {c['case_id']} | {c['status']} |" for c in r['cases']]
    if 'stroke' in report:
        r=report['stroke']
        lines+=['','# Stroke compatibility','',f"Stroke public paths: {r['passed']}/{r['executed']}; required={r['required']}, differences={r['differences']}, execution_errors={r['execution_errors']}.",'',
          'Independent inputs: Boolean200 + Offset272 + Stroke276 =748. Strokes have no input fill rule or public tree interface; boolean_tree composition tests are separate evidence.','',
          '| Parameter | Actual case coverage |','| --- | --- |']
        lines += ['| '+field+' | '+', '.join(k+': '+str(v) for k,v in values.items())+' |' for field,values in sorted(r['coverage'].items())]
        lines+=['','| Target | Stroke filtered paths |','| --- | --- |']
        for target in ('native','js'):
            e=report.get('stroke_evidence',{}).get(target,{})
            value=str(e['passed'])+'/'+str(e['executed']) if e.get('status')=='passed' else 'not recorded'
            lines.append('| '+target+' | '+value+' |')
        lines+=['','| Stroke case | Native paths |','| --- | --- |']
        lines += [f"| {c['case_id']} | {c['status']} |" for c in r['cases']]
    if 'composition' in report:
        r=report['composition']
        lines+=['','# Composition compatibility','',f"Independent recipes: {r['passed']}/{r['executed']}; required=24; differences={r['differences']}; execution_errors={r['execution_errors']}. Boolean200 + Offset272 + Stroke276 + Composition24 =772 independent inputs.",'',
          'Each recipe counts once. Both real intermediate and final outputs are compared. InsetThenTree includes strict parentage and winding. Public calls each own a fresh budget; resource rejection tests are MoonClip functional evidence, not Clipper2 resource compatibility.','',
          '| Recipe | Cases |','| --- | ---: |']
        lines += [f"| {name} | {count} |" for name,count in sorted(r['recipes'].items())]
        lines+=['','| Target | Composition filtered recipes |','| --- | --- |']
        for target in ('native','js'):
            e=report.get('composition_evidence',{}).get(target,{})
            value=str(e['passed'])+'/'+str(e['executed']) if e.get('status')=='passed' else 'not recorded'
            lines.append('| '+target+' | '+value+' |')
        lines+=['','| Recipe ID | Intermediate | Final | Status | Failure step |','| --- | --- | --- | --- | --- |']
        lines += [f"| {c['case_id']} | {c['intermediate']} | {c['final']} | {c['status']} | {c.get('failure_step','')} |" for c in r['cases']]
    if 'decimal' in report:
        r=report['decimal']
        lines+=['','# Decimal compatibility','',f"Decimal public paths: {r['passed']}/{r['executed']}; required=220; differences={r['differences']}; execution_errors={r['execution_errors']}. Independent reference total: 772 +220 =992.",'',
          'MoonClip always uses 10^precision. DecimalGrid invokes the pinned integer routes after independent std::round quantization; ClipperDCommonGrid really invokes ClipperD and verifies its raw output lies on the target grid before any integer conversion. These 24 common-grid cases do not establish general ClipperD equivalence.','',
          'Comparison checks full integer contours AND exact coordinate64 / scale decoding, finite output and positive zero; re-quantizing arbitrary decimal output is insufficient. Quantization rejection and budgets are MoonClip contract tests.','',
          '| Reference route | Required | Executed | Passed | Differences | Execution errors |','| --- | ---: | ---: | ---: | ---: | ---: |']
        for route,v in sorted(r['routes'].items()):lines.append(f"| {route} | {v['required']} | {v['executed']} | {v['passed']} | {v['differences']} | {v['execution_errors']} |")
        lines+=['','| Operation | Cases | Precision coverage |','| --- | ---: | --- |']
        for op,v in sorted(r['operations'].items()):lines.append('| '+op+' | '+str(v['count'])+' | '+', '.join(k+': '+str(n) for k,n in v['precisions'].items())+' |')
        lines+=['','| Parameter | Actual case coverage |','| --- | --- |']
        lines += ['| '+field+' | '+', '.join(k+': '+str(n) for k,n in counts.items())+' |' for field,counts in sorted(r['parameters'].items())]
        lines+=['','| Target | Decimal filtered paths |','| --- | --- |']
        for target in ('native','js'):
            e=report.get('decimal_evidence',{}).get(target,{})
            value=str(e['passed'])+'/'+str(e['executed']) if e.get('status')=='passed' else 'not recorded'
            lines.append('| '+target+' | '+value+' |')
        lines+=['','| Decimal case | Route | Precision | Grid contours | Decoded coordinates | Status |','| --- | --- | ---: | --- | --- | --- |']
        lines += [f"| {c['case_id']} | {c['reference_route']} | {c['precision']} | {c['grid_paths']} | {c['decoded']} | {c['status']} |" for c in r['cases']]
    if 'simplify' in report:
        r=report['simplify']
        lines+=['','# Simplification compatibility','',f"Ordered simplification: {r['passed']}/{r['executed']}; required=224; differences={r['differences']}; execution_errors={r['execution_errors']}. Independent total: 992 +224 =1216.",'',
          'Pinned C++ SimplifyPaths after agreed normalization; the adapter independently computes reports. DecimalGrid quantizes first and calls the integer template, not SimplifyPaths<PointD>. Zero threshold is a separate MoonClip contract. Empty and degenerate paths are successful results. No ring rotation or path sorting is permitted.','',
          '| Route / capability | Required | Executed | Passed | Differences | Execution errors |','| --- | ---: | ---: | ---: | ---: | ---: |']
        for name,v in [*sorted(r['routes'].items()),*((k,r[k]) for k in ('ordered_paths','removed_counts','degeneracy'))]:lines.append(f"| {name} | {v['required']} | {v['executed']} | {v['passed']} | {v['differences']} | {v['execution_errors']} |")
        lines+=['','| Target | Simplify filtered cases |','| --- | --- |']
        for target in ('native','js'):
            e=report.get('simplify_evidence',{}).get(target,{})
            value=str(e['passed'])+'/'+str(e['executed']) if e.get('status')=='passed' else 'not recorded'
            lines.append('| '+target+' | '+value+' |')
        lines+=['','| Case | Ordered paths and decoding | Removed counts | Degeneracy | Status |','| --- | --- | --- | --- | --- |']
        lines += [f"| {c['case_id']} | {c['ordered_paths']} | {c['removed_counts']} | {c['degeneracy']} | {c['status']} |" for c in r['cases']]
    if 'minkowski' in report:
        r=report['minkowski']
        lines+=['','# Minkowski Sum compatibility','',f"MinkowskiSum public paths: {r['passed']}/{r['executed']}; required=144; differences={r['differences']}; execution_errors={r['execution_errors']}. Seven-catalog baseline subtotal: 1216 +144 =1360; random additions are counted separately.",'',
          'Real pinned MinkowskiSum, internal NonZero, preserve_collinear=true, reverse_solution=false. Complete contours preserve collinear vertices, winding and multiplicity; only sibling order and cyclic starts are normalized. No endpoint pattern fill, no automatic input normalization, and closed routes may retain holes.','',
          '| Coverage | Cases |','| --- | --- |']
        for field,values in sorted(r['coverage'].items()):lines.append('| '+field+' | '+', '.join(k+': '+str(v) for k,v in values.items())+' |')
        lines+=['','| Target | Minkowski filtered paths |','| --- | --- |']
        for target in ('native','js'):
            e=report.get('minkowski_evidence',{}).get(target,{})
            value=str(e['passed'])+'/'+str(e['executed']) if e.get('status')=='passed' else 'not recorded'
            lines.append('| '+target+' | '+value+' |')
        lines+=['','| Minkowski case | Native complete contours |','| --- | --- |']
        lines += [f"| {c['case_id']} | {c['status']} |" for c in r['cases']]
    if 'coverage_matrix' in report:lines+=matrix_markdown(report['coverage_matrix'])
    if 'random' in report:lines+=random_markdown(report['random'],report.get('random_evidence',{}))
    if 'rectclip' in report:lines+=rectclip_markdown(report['rectclip'])
    return '\n'.join(lines)+'\n'

def main():
    parser=argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,description='Execute independent MoonClip paths and tree comparisons. Exit codes: 0 success/help; 1 differences; 2 arguments, integrity or execution errors.')
    parser.add_argument('--random-only',action='store_true',help='Execute/report only the24 new inputs locally; no old geometry execution')
    parser.add_argument('--rectclip-only',action='store_true',help='Execute/report only the new rectangle line inputs')
    parser.add_argument('--rectclip-manifest',type=Path)
    parser.add_argument('--random-manifest',type=Path)
    parser.add_argument('--manifest',type=Path,default=ROOT/'testdata/manifest.json')
    parser.add_argument('--offset-manifest',type=Path,help='Include independently executed offset protocol v2 cases')
    parser.add_argument('--stroke-manifest',type=Path,help='Include independent open stroke protocol v3 cases')
    parser.add_argument('--composition-manifest',type=Path,help='Include fixed two-step protocol v4 recipes')
    parser.add_argument('--minkowski-manifest',type=Path,help='Include 144 fixed MinkowskiSum complete contours')
    parser.add_argument('--simplify-manifest',type=Path,help='Include 80 integer and 144 decimal-grid ordered simplify inputs')
    parser.add_argument('--decimal-manifest',type=Path,help='Include 196 decimal-grid and 24 actual ClipperD common-grid inputs')
    parser.add_argument('--report-json',type=Path,default=ROOT/'_build/conformance/report.json')
    parser.add_argument('--report-md',type=Path,default=ROOT/'docs/compatibility.md')
    parser.add_argument('--strict',action='store_true',help='Require exactly 152 public cases with independent paths and tree results (also enforced by default)')
    try:
        envelope=json.load(sys.stdin);args=parser.parse_args(envelope['args'][1:])
        if args.rectclip_only:
            require(args.rectclip_manifest is not None,'rectclip','--rectclip-manifest required')
            result=evaluate_rectclip(args.rectclip_manifest.resolve(),envelope.get('rectclip_results'))
            report=dict(rectclip=result)
            args.report_json.parent.mkdir(parents=True,exist_ok=True);args.report_md.parent.mkdir(parents=True,exist_ok=True)
            args.report_json.write_bytes(canonical_bytes(report));args.report_md.write_text('\n'.join(rectclip_markdown(result))+'\n',encoding='utf-8',newline='\n')
            print(f"Native rectclip conformance: ordered_paths={result['passed']}/{result['required']}, differences={result['differences']}, execution_errors={result['execution_errors']}")
            return 2 if result['execution_errors'] else 1 if result['differences'] else 0
        if args.random_only:
            require(args.random_manifest is not None,'random','--random-manifest required')
            result=evaluate_random(args.random_manifest.resolve(),envelope.get('random_results'))
            report=dict(random=result,random_evidence=random_execution_evidence(ROOT/'_build/conformance'),coverage_matrix=coverage_matrix())
            args.report_json.parent.mkdir(parents=True,exist_ok=True)
            args.report_json.write_bytes(canonical_bytes(report))
            args.report_md.parent.mkdir(parents=True,exist_ok=True)
            args.report_md.write_text('\n'.join(matrix_markdown(report['coverage_matrix'])+random_markdown(result,report['random_evidence']))+'\n',encoding='utf-8',newline='\n')
            print(f"Native random conformance: paths={result['passed']}/24, differences={result['differences']}, execution_errors={result['execution_errors']}")
            return 2 if result['execution_errors'] else 1 if result['differences'] else 0
        report=evaluate(args.manifest.resolve(),envelope['results'])
        if args.rectclip_manifest:
            report['rectclip']=evaluate_rectclip(args.rectclip_manifest.resolve(),envelope.get('rectclip_results'))
        report['coverage_matrix']=coverage_matrix(bool(args.random_manifest))
        if args.random_manifest:
            report['random']=evaluate_random(args.random_manifest.resolve(),envelope.get('random_results'))
            report['random_evidence']=random_execution_evidence(ROOT/'_build/conformance')
        from evidence import internal_evidence,tree_evidence,offset_evidence,stroke_evidence,composition_evidence,decimal_evidence
        if args.offset_manifest:
            report['offset']=evaluate_offset(args.offset_manifest.resolve(),envelope.get('offset_results'))
            report['offset_evidence']=offset_evidence(ROOT/'_build/conformance')
        if args.stroke_manifest:
            report['stroke']=evaluate_stroke(args.stroke_manifest.resolve(),envelope.get('stroke_results'))
            report['stroke_evidence']=stroke_evidence(ROOT/'_build/conformance')
        if args.composition_manifest:
            report['composition']=evaluate_composition(args.composition_manifest.resolve(),envelope.get('composition_results'))
            report['composition_evidence']=composition_evidence(ROOT/'_build/conformance')
        if args.minkowski_manifest:
            from evidence import minkowski_evidence
            report['minkowski']=evaluate_minkowski(args.minkowski_manifest.resolve(),envelope.get('minkowski_results'))
            report['minkowski_evidence']=minkowski_evidence(ROOT/'_build/conformance')
        if args.simplify_manifest:
            from evidence import simplify_evidence
            report['simplify']=evaluate_simplify(args.simplify_manifest.resolve(),envelope.get('simplify_results'))
            report['simplify_evidence']=simplify_evidence(ROOT/'_build/conformance')
        if args.decimal_manifest:
            report['decimal']=evaluate_decimal(args.decimal_manifest.resolve(),envelope.get('decimal_results'))
            report['decimal_evidence']=decimal_evidence(ROOT/'_build/conformance')
        report['internal']=internal_evidence(ROOT/'_build/conformance')
        report['tree_evidence']=tree_evidence(ROOT/'_build/conformance')
        args.report_json.parent.mkdir(parents=True,exist_ok=True);args.report_md.parent.mkdir(parents=True,exist_ok=True)
        args.report_json.write_bytes(canonical_bytes(report));args.report_md.write_text(markdown(report),encoding='utf-8',newline='\n')
        print(f"Native conformance: cases={report['required']}, paths={report['paths']['passed']}/{report['paths']['executed']}, tree={report['tree']['passed']}/{report['tree']['executed']}, both={report['passed']}, differences={report['differences']}, execution_errors={report['execution_errors']}")
        offset=report.get('offset',{})
        if offset:
            print(f"Native offset conformance: cases=272, paths={offset['passed']}/{offset['executed']}, differences={offset['differences']}, execution_errors={offset['execution_errors']}")
        stroke=report.get('stroke',{})
        if stroke:
            print(f"Native stroke conformance: cases=276, paths={stroke['passed']}/{stroke['executed']}, differences={stroke['differences']}, execution_errors={stroke['execution_errors']}")
        composition=report.get('composition',{})
        if composition:
            print(f"Native composition conformance: recipes=24, intermediate={composition['intermediate']['passed']}/24, final={composition['final']['passed']}/24, both={composition['passed']}, differences={composition['differences']}, execution_errors={composition['execution_errors']}")
        decimal=report.get('decimal',{})
        if decimal:
            print(f"Native decimal conformance: cases=220, DecimalGrid={decimal['routes']['DecimalGrid']['passed']}/196, ClipperDCommonGrid={decimal['routes']['ClipperDCommonGrid']['passed']}/24, grid={decimal['grid_paths']['passed']}/220, decoded={decimal['decoded']['passed']}/220, differences={decimal['differences']}, execution_errors={decimal['execution_errors']}")
        simplify=report.get('simplify',{})
        if simplify:
            print(f"Native simplify conformance: cases=224, Integer={simplify['routes']['Integer']['passed']}/80, DecimalGrid={simplify['routes']['DecimalGrid']['passed']}/144, ordered_paths={simplify['ordered_paths']['passed']}/224, removed_counts={simplify['removed_counts']['passed']}/224, degeneracy={simplify['degeneracy']['passed']}/224, differences={simplify['differences']}, execution_errors={simplify['execution_errors']}")
        minkowski=report.get('minkowski',{})
        if minkowski:
            print(f"Native minkowski conformance: cases=144, paths={minkowski['passed']}/144, NonZero, preserve_collinear=true, differences={minkowski['differences']}, execution_errors={minkowski['execution_errors']}")
        random=report.get('random',{})
        if random:print(f"Native random conformance: paths={random['passed']}/24, differences={random['differences']}, execution_errors={random['execution_errors']}")
        rectclip=report.get('rectclip',{})
        if rectclip:print(f"Native rectclip conformance: ordered_paths={rectclip['passed']}/{rectclip['required']}, differences={rectclip['differences']}, execution_errors={rectclip['execution_errors']}")
        return 2 if any(r.get('execution_errors') for r in (report,offset,stroke,composition,decimal,simplify,minkowski,random,rectclip)) else 1 if any(r.get('differences') for r in (report,offset,stroke,composition,decimal,simplify,minkowski,random,rectclip)) else 0
    except (Invalid,OSError,ValueError,KeyError,TypeError) as error:
        print(f'Conformance error: {error}',file=sys.stderr);return 2
if __name__=='__main__':sys.exit(main())
