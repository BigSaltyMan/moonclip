# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Decimal v5: exact grid contours AND exact prescribed floating-point decoding."""
import math
import re
from collections import Counter
from compare import (keys,require,integer,validate_input,validate_paths,normalize_paths,
                     load,validate_lock,confined,sha256,canonical_bytes)
from offset_compare import finite,offset_metrics
OPERATIONS=('BooleanD','OffsetD','StrokeD')
ROUTES=('DecimalGrid','ClipperDCommonGrid')
SCALES=(1,10,100,1000,10000,100000,1000000)
COMMON={'format_version','operation','case_id','source','options','precision','grid','reference_route'}

def round_grid(value):
    whole=math.floor(value) if value>=0 else math.ceil(value)
    return whole+(1 if value-whole>=0.5 else 0) if value>=0 else whole-(1 if whole-value>=0.5 else 0)

def quantized_inputs(case,where):
    scale=SCALES[case['precision']]
    groups=[case['subject'],case['clip']] if case['operation']=='BooleanD' else [case['paths'],[]] if case['operation']=='OffsetD' else [[case['path']],[]]
    require(all(type(g) is list for g in groups),where,'expected path arrays')
    require(sum(map(len,groups))<=10000,where,'input path limit')
    seen={};vertices=0;result=[[],[]]
    for gi,group in enumerate(groups):
        for path in group:
            require(type(path) is list,where,'expected path array')
            vertices+=len(path);require(vertices<=100000,where,'raw vertex limit')
            output=[]
            for point in path:
                require(type(point) is list and len(point)==2,where,'expected decimal pair')
                q=[]
                for v in point:
                    finite(v,where)
                    require(-1000000000/scale<=v<=1000000000/scale,where,'original coordinate outside precision range')
                    scaled=v*scale;finite(scaled,where)
                    require(-1000000000<=scaled<=1000000000,where,'scaled coordinate range')
                    q.append(round_grid(scaled))
                    if case['reference_route']=='ClipperDCommonGrid':
                        binary=1<<scale.bit_length()
                        require(v*scale==round_grid(v*scale) and v*binary==round_grid(v*binary),where,'input is not on both grids')
                key=tuple(q)
                require(key not in seen or seen[key]==point,where,'distinct input positions merge')
                seen.setdefault(key,point);output.append(q)
            if output and case['operation']!='StrokeD':
                a=output[0];b=next((p for p in output if p!=a),a)
                require(any((b[0]-a[0])*(p[1]-a[1])-(b[1]-a[1])*(p[0]-a[0])!=0 for p in output),where,'quantized closed input is degenerate')
            result[gi].append(output)
    return result

def validate_decimal_input(value,where):
    require(type(value) is dict and type(value.get('operation')) is str and value['operation'] in OPERATIONS,where,'unknown decimal operation')
    operation=value['operation']
    fields=COMMON|({'subject','clip','clip_type','fill_rule'} if operation=='BooleanD' else {'paths','delta','fill_rule','join_type','miter_limit','arc_tolerance'} if operation=='OffsetD' else {'path','width','cap_type','join_type','miter_limit','arc_tolerance'})
    keys(value,fields,where)
    require(type(value['format_version']) is int and value['format_version']==5,where,'unknown decimal version')
    integer(value['precision'],where+'.precision',0,6)
    require(value['grid']=='DecimalHalfAwayFromZero' and type(value['reference_route']) is str and value['reference_route'] in ROUTES,where,'unknown grid/reference route')
    require(value['reference_route']=='DecimalGrid' or operation=='BooleanD',where,'ClipperD route is Boolean only')
    proxy={k:value[k] for k in ('case_id','source','options')}
    proxy.update(format_version=1,operation=value.get('clip_type','Union'),fill_rule=value.get('fill_rule','NonZero'),subject=[],clip=[])
    validate_input(proxy,where)
    if operation!='StrokeD':require(value['fill_rule'] in ('EvenOdd','NonZero'),where,'public fill rule required')
    if operation!='BooleanD':
        require(type(value['join_type']) is str and value['join_type'] in ('Miter','Bevel','Square','Round'),where,'unknown join')
        for k in ('miter_limit','arc_tolerance','delta' if operation=='OffsetD' else 'width'):finite(value[k],where+'.'+k)
        require(value['miter_limit']>=2 and value['arc_tolerance']>=0,where,'invalid options')
        if operation=='StrokeD':require(value['width']>=0 and value['cap_type'] in ('Butt','Square','Round'),where,'invalid stroke parameters')
        for k in ('arc_tolerance','delta' if operation=='OffsetD' else 'width'):finite(value[k]*SCALES[value['precision']],where+'.scaled '+k)
    quantized_inputs(value,where)

def validate_decimal_geometry(value,where='decimal result'):
    require(type(value) is dict and type(value.get('format_version')) is int and value['format_version']==5 and value.get('status')=='success',where,'expected successful v5 geometry')
    integer(value.get('precision'),where+'.precision',0,6)
    require(value.get('reference_route') in ROUTES and value.get('operation') in OPERATIONS,where,'unknown route/operation')
    require(value['reference_route']=='DecimalGrid' or value['operation']=='BooleanD',where,'invalid route for operation')
    validate_paths(value.get('grid_paths'),where+'.grid_paths',True)
    paths=value.get('paths');require(type(paths) is list and len(paths)==len(value['grid_paths']),where,'decimal path count mismatch')
    scale=SCALES[value['precision']]
    for pi,(grid,path) in enumerate(zip(value['grid_paths'],paths)):
        require(type(path) is list and len(path)==len(grid),where,'decimal vertex count mismatch')
        for gi,point in zip(grid,path):
            require(type(point) is list and len(point)==2,where,'expected output decimal pair')
            for integer_coordinate,coordinate in zip(gi,point):
                finite(coordinate,where)
                require(coordinate==integer_coordinate/scale,where,'decimal output differs from grid / scale')
                require(coordinate!=0 or math.copysign(1.0,coordinate)>0,where,'negative zero output forbidden')

def decimal_metrics(value):return {'grid':offset_metrics({'paths':value['grid_paths']})}

def compare_decimal(left,right,where='decimal'):
    validate_decimal_geometry(left,where+'.expected');validate_decimal_geometry(right,where+'.actual')
    for field in ('precision','operation','reference_route'):require(left[field]==right[field],where,'decimal metadata mismatch')
    require(normalize_paths(left['grid_paths'])==normalize_paths(right['grid_paths']),where,'full grid contours differ')

def validate_decimal_result(value,case,digest,lock,where):
    keys(value,{'format_version','adapter_protocol_version','case_id','input_sha256','oracle_commit','status','operation','reference_route','precision','grid_paths','paths','metrics'},where)
    require(type(value['adapter_protocol_version']) is int and value['adapter_protocol_version']==lock['decimal_protocol_version'],where,'decimal adapter version mismatch')
    require(value['case_id']==case['case_id'] and value['input_sha256']==digest and value['oracle_commit']==lock['commit'],where,'decimal provenance mismatch')
    require(all(value[k]==case[k] for k in ('precision','reference_route','operation')),where,'decimal case metadata mismatch')
    validate_decimal_geometry(value,where)
    require(canonical_bytes(value['metrics'])==canonical_bytes(decimal_metrics(value)),where,'exact grid metrics mismatch')

def read_decimal_manifest(root,manifest,require_expected=True,strict=True):
    v=load(manifest,strict);keys(v,{'format_version','kind','oracle_lock','cases'},'decimal manifest')
    require(type(v['format_version']) is int and v['format_version']==5 and v['kind']=='decimal','manifest','unknown decimal catalog')
    require(v['oracle_lock']=='tools/oracle/upstream-lock.json','manifest','unexpected lock')
    lock=load(root/v['oracle_lock'],strict);validate_lock(lock)
    require(type(v['cases']) is list and len(v['cases'])==220,'manifest','expected 220 decimal cases')
    ids=set();inputs=set();outputs=set();records=[]
    for e in v['cases']:
        keys(e,{'case_id','input','expected','status','validation'},'decimal entry');cid=e['case_id']
        require(type(cid) is str and re.fullmatch(r'[a-z0-9][a-z0-9_-]{0,100}',cid) and cid not in ids,'manifest','invalid/duplicate decimal ID');ids.add(cid)
        require(e['status']=='validate' and e['validation']=={'grid_paths':'validate','paths':'validate'},cid,'both grid and decimal geometry required')
        require(e['input']==f'testdata/decimal/inputs/{cid}.json' and e['expected']==f'testdata/decimal/expected/{cid}.json',cid,'noncanonical mapping')
        ip,ep=confined(root,e['input']),confined(root,e['expected']);inputs.add(ip);outputs.add(ep)
        c=load(ip,strict);validate_decimal_input(c,cid);require(c['case_id']==cid,cid,'ID mismatch');d=sha256(ip.read_bytes());expected=None
        if require_expected:expected=load(ep,strict);validate_decimal_result(expected,c,d,lock,cid)
        records.append((e,c,d,expected))
    require(Counter(c['reference_route'] for _,c,_,_ in records)=={'DecimalGrid':196,'ClipperDCommonGrid':24},'manifest','route count mismatch')
    require(Counter(c['operation'] for _,c,_,_ in records)=={'BooleanD':136,'OffsetD':48,'StrokeD':36},'manifest','operation count mismatch')
    for folder,listed in [('inputs',inputs),('expected',outputs)]:
        actual={p.resolve() for p in (root/'testdata/decimal'/folder).rglob('*') if p.is_file()}
        require(actual==listed if folder=='inputs' or require_expected else actual<=listed,'manifest','unlisted/missing decimal '+folder)
    return lock,records

def decimal_selection(root):
    lock,records=read_decimal_manifest(root,root/'testdata/decimal-manifest.json')
    v=load(root/'testdata/decimal-selection.json',True);keys(v,{'format_version','kind','expected_count','case_ids'},'decimal selection')
    require(type(v['format_version']) is int and v['format_version']==5 and v['kind']=='decimal' and type(v['expected_count']) is int and v['expected_count']==220,'selection','invalid decimal selection')
    require(v['case_ids']==sorted(c['case_id'] for _,c,_,_ in records),'selection','decimal IDs mismatch')
    return lock,records
