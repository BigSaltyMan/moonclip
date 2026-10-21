# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""v8 open paths: exact fragment order, direction, vertex count and coordinates."""
from compare import (keys, require, integer, validate_input, validate_paths,
                     canonical_bytes, load, confined, sha256, validate_lock)

OPTIONS = dict(preserve_collinear=False, reverse_solution=False)
COUNT = 32

def validate_rectclip_input(v, where):
    keys(v, {'format_version','case_id','source','operation','options','rect','paths'}, where)
    require(type(v['format_version']) is int and v['format_version']==8 and v['operation']=='RectClipLines',where,'expected v8 RectClipLines')
    keys(v['options'], OPTIONS, where)
    require(all(type(v['options'][k]) is bool and v['options'][k]==x for k,x in OPTIONS.items()),where,'fixed options required')
    r=v['rect'];require(type(r) is list and len(r)==4,where,'expected rectangle coordinates')
    for x in r:integer(x,where+'.rect',-1000000000,1000000000)
    require(r[0]<=r[2] and r[1]<=r[3],where,'reversed rectangle')
    proxy=dict(format_version=1,case_id=v['case_id'],source=v['source'],operation='Union',fill_rule='NonZero',options=OPTIONS,subject=v['paths'],clip=[])
    validate_input(proxy,where)

def validate_rectclip_geometry(v,where='rectclip result'):
    require(type(v.get('format_version')) is int and v['format_version']==8 and v.get('operation')=='RectClipLines' and v.get('status')=='success',where,'expected successful v8 result')
    keys(v.get('options'),OPTIONS,where)
    require(all(type(v['options'][k]) is bool and v['options'][k]==x for k,x in OPTIONS.items()),where,'invalid options')
    validate_paths(v.get('paths'),where+'.paths',False)
    require('tree' not in v,where,'open results have no tree')
    for p in v['paths']:
        require(len(p)>=2 and all(a!=b for a,b in zip(p,p[1:])),where,'isolated or repeated consecutive output point')

def rectclip_metrics(v):
    return dict(path_count=len(v['paths']),vertex_count=sum(map(len,v['paths'])))

def validate_rectclip_result(v,c,d,lock,where):
    keys(v,{'format_version','adapter_protocol_version','case_id','input_sha256','oracle_commit','status','operation','options','paths','metrics'},where)
    require(type(v['adapter_protocol_version']) is int and v['adapter_protocol_version']==lock['rectclip_protocol_version'],where,'wrong adapter version')
    require(v['case_id']==c['case_id'] and v['input_sha256']==d and v['oracle_commit']==lock['commit'],where,'provenance mismatch')
    validate_rectclip_geometry(v,where)
    require(canonical_bytes(v['metrics'])==canonical_bytes(rectclip_metrics(v)),where,'metrics mismatch')

def compare_rectclip(a,b,where='rectclip'):
    validate_rectclip_geometry(a,where);validate_rectclip_geometry(b,where)
    require(a['paths']==b['paths'],where,'ordered open fragments differ')

def read_rectclip_manifest(root,manifest,require_expected=True,strict=True):
    v=load(manifest,strict);keys(v,{'format_version','kind','oracle_lock','cases'},'rectclip manifest')
    require(type(v['format_version']) is int and v['format_version']==8 and v['kind']=='rectclip','manifest','wrong catalog')
    require(v['oracle_lock']=='tools/oracle/upstream-lock.json','manifest','wrong lock')
    lock=load(root/v['oracle_lock'],strict);validate_lock(lock)
    require(type(v['cases']) is list and len(v['cases'])==COUNT,'manifest','incorrect case count')
    records=[];ids=set();listed={'inputs':set(),'expected':set()}
    for e in v['cases']:
        keys(e,{'case_id','input','expected','status','validation'},'entry');cid=e['case_id']
        require(type(cid) is str and cid not in ids,'manifest','duplicate ID');ids.add(cid)
        require(e['status']=='validate' and e['validation']=={'ordered_paths':'validate'},cid,'ordered capability required')
        for field,folder in [('input','inputs'),('expected','expected')]:
            require(e[field]==f'testdata/rectclip/{folder}/{cid}.json',cid,'noncanonical mapping')
            listed[folder].add(confined(root,e[field]))
        c=load(root/e['input'],strict);validate_rectclip_input(c,cid);require(c['case_id']==cid,cid,'ID mismatch');d=sha256((root/e['input']).read_bytes())
        expected=None
        if require_expected:
            expected=load(root/e['expected'],strict);validate_rectclip_result(expected,c,d,lock,cid)
        records.append((e,c,d,expected))
    require([e['case_id'] for e,_,_,_ in records]==sorted(ids),'manifest','unsorted cases')
    for folder,paths in listed.items():
        actual={p.resolve() for p in (root/'testdata/rectclip'/folder).rglob('*') if p.is_file()}
        require(actual==paths if folder=='inputs' or require_expected else actual<=paths,'manifest','missing/extra '+folder)
    selection=load(root/'testdata/rectclip-selection.json',strict)
    keys(selection,{'format_version','kind','expected_count','case_ids'},'selection')
    require(type(selection['format_version']) is int and selection['format_version']==8 and selection['kind']=='rectclip' and type(selection['expected_count']) is int and selection['expected_count']==COUNT and selection['case_ids']==sorted(ids),'selection','selection differs from catalog')
    return lock,records
