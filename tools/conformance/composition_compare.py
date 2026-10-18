# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Fixed two-step composition protocol v4; never a general workflow language."""
import re
from collections import Counter
from compare import (keys, require, validate_input, validate_paths, walk_tree,
                     normalize_paths, normalize_tree, canonical_bytes, load,
                     validate_lock, confined, sha256)
from offset_compare import offset_metrics
RECIPES=('BooleanThenOffset','InsetThenTree','StrokeThenIntersection')
META={'case_id','source','options'}

def stage_request(case, index, intermediate=None):
    step=dict(case['steps'][index])
    step.update({k:case[k] for k in META})
    if index==1:
        step['paths' if case['recipe']=='BooleanThenOffset' else 'subject']=[] if intermediate is None else intermediate
    return step

def validate_composition_input(value, where):
    keys(value,{'format_version','operation','recipe','case_id','source','options','steps'},where)
    require(type(value['format_version']) is int and value['format_version']==4 and value['operation']=='Composition',where,'unknown composition protocol')
    require(type(value['recipe']) is str and value['recipe'] in RECIPES,where,'unknown recipe')
    require(type(value['steps']) is list and len(value['steps'])==2 and all(type(s) is dict for s in value['steps']),where,'expected exactly two concrete steps')
    recipe=value['recipe'];first,second=value['steps']
    first_fields={'format_version','operation','subject','clip','fill_rule'} if recipe=='BooleanThenOffset' else {'format_version','operation','paths','delta','fill_rule','join_type','miter_limit','arc_tolerance'} if recipe=='InsetThenTree' else {'format_version','operation','path','width','cap_type','join_type','miter_limit','arc_tolerance'}
    second_fields={'format_version','operation','delta','fill_rule','join_type','miter_limit','arc_tolerance'} if recipe=='BooleanThenOffset' else {'format_version','operation','clip','fill_rule'}
    keys(first,first_fields,where+'.steps[0]');keys(second,second_fields,where+'.steps[1]')
    require(first['operation'] in ('Union','Difference','Intersection','Xor') if recipe=='BooleanThenOffset' else first['operation']==('OffsetPolygons' if recipe=='InsetThenTree' else 'StrokePolyline'),where,'wrong first operation')
    require(second['operation']==('OffsetPolygons' if recipe=='BooleanThenOffset' else 'Union' if recipe=='InsetThenTree' else 'Intersection'),where,'wrong second operation')
    if recipe=='InsetThenTree':
        require(type(first['delta']) in (int,float) and first['delta']<0 and second['clip']==[],where,'inset requires negative delta and tree-only Union')
    for i in range(2):
        request=stage_request(value,i)
        validate_input(request,where+f'.steps[{i}]')
        if 'fill_rule' in request:require(request['fill_rule'] in ('EvenOdd','NonZero'),where,'public fill rule required')

def validate_composition_geometry(value,where='composition result'):
    require(type(value) is dict and type(value.get('format_version')) is int and value['format_version']==4 and value.get('status')=='success',where,'expected successful v4 result')
    require(value.get('recipe') in RECIPES,where,'unknown recipe')
    keys(value.get('intermediate'),{'paths'},where+'.intermediate')
    keys(value.get('final'),{'paths','tree'} if value['recipe']=='InsetThenTree' else {'paths'},where+'.final')
    for stage in ('intermediate','final'):validate_paths(value[stage]['paths'],where+'.'+stage,True)
    if value['recipe']=='InsetThenTree':
        flattened,_,_=walk_tree(value['final']['tree'],where+'.final.tree')
        require(normalize_paths(flattened)==normalize_paths(value['final']['paths']),where,'tree/flat mismatch')

def composition_metrics(value):
    from compare import metrics
    return {'intermediate':offset_metrics(value['intermediate']), 'final':metrics(value['final']) if value['recipe']=='InsetThenTree' else offset_metrics(value['final'])}

def compare_composition(left,right,where='composition'):
    validate_composition_geometry(left,where+'.expected');validate_composition_geometry(right,where+'.actual')
    require(left['recipe']==right['recipe'],where,'recipe mismatch')
    for stage in ('intermediate','final'):
        require(normalize_paths(left[stage]['paths'])==normalize_paths(right[stage]['paths']),where+'.'+stage,'full contours differ')
    if left['recipe']=='InsetThenTree':require(normalize_tree(left['final']['tree'])==normalize_tree(right['final']['tree']),where+'.final.tree','tree differs')

def validate_composition_result(value,case,digest,lock,where):
    keys(value,{'format_version','adapter_protocol_version','recipe','case_id','input_sha256','oracle_commit','status','intermediate','final','metrics'},where)
    require(type(value['adapter_protocol_version']) is int and value['adapter_protocol_version']==lock['composition_protocol_version'],where,'adapter protocol mismatch')
    require(value['case_id']==case['case_id'] and value['input_sha256']==digest and value['oracle_commit']==lock['commit'] and value['recipe']==case['recipe'],where,'provenance mismatch')
    validate_composition_geometry(value,where)
    require(canonical_bytes(value['metrics'])==canonical_bytes(composition_metrics(value)),where,'exact metrics mismatch')

def read_composition_manifest(root,manifest,require_expected=True,strict=True):
    value=load(manifest,strict);keys(value,{'format_version','kind','oracle_lock','cases'},'composition manifest')
    require(type(value['format_version']) is int and value['format_version']==4 and value['kind']=='composition','manifest','unknown composition catalog')
    require(value['oracle_lock']=='tools/oracle/upstream-lock.json','manifest','unexpected lock')
    lock=load(root/value['oracle_lock'],strict);validate_lock(lock)
    require(type(value['cases']) is list and len(value['cases'])==24,'manifest','expected 24 recipes')
    ids=set();inputs=set();outputs=set();records=[]
    for e in value['cases']:
        keys(e,{'case_id','input','expected','status','validation'},'composition entry');cid=e['case_id']
        require(type(cid) is str and re.fullmatch(r'[a-z0-9][a-z0-9_-]{0,100}',cid) and cid not in ids,'manifest','duplicate or invalid ID');ids.add(cid)
        require(e['status']=='validate' and e['validation']=={'intermediate':'validate','final':'validate'},cid,'both stages required')
        require(e['input']==f'testdata/composition/inputs/{cid}.json' and e['expected']==f'testdata/composition/expected/{cid}.json',cid,'noncanonical mapping')
        ip,ep=confined(root,e['input']),confined(root,e['expected']);inputs.add(ip);outputs.add(ep)
        c=load(ip,strict);validate_composition_input(c,cid);require(c['case_id']==cid,cid,'ID mismatch');d=sha256(ip.read_bytes());expected=None
        if require_expected:
            expected=load(ep,strict);validate_composition_result(expected,c,d,lock,cid)
        records.append((e,c,d,expected))
    require(Counter(c['recipe'] for _,c,_,_ in records)=={r:8 for r in RECIPES},'manifest','expected eight per recipe')
    for folder,listed in [('inputs',inputs),('expected',outputs)]:
        actual={p.resolve() for p in (root/'testdata/composition'/folder).rglob('*') if p.is_file()}
        require(actual==listed if folder=='inputs' or require_expected else actual<=listed,'manifest','unlisted or missing '+folder)
    return lock,records

def composition_selection(root):
    lock,records=read_composition_manifest(root,root/'testdata/composition-manifest.json')
    s=load(root/'testdata/composition-selection.json',True);keys(s,{'format_version','kind','expected_count','case_ids'},'composition selection')
    require(type(s['format_version']) is int and s['format_version']==4 and s['kind']=='composition' and type(s['expected_count']) is int and s['expected_count']==24,'selection','invalid composition selection')
    require(s['case_ids']==sorted(c['case_id'] for _,c,_,_ in records),'selection','composition selection mismatch')
    return lock,records
