# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""v7 fixed Minkowski Sum, complete contours including collinear vertices."""
import re
from collections import Counter
from compare import (keys,require,integer,validate_input,validate_paths,compare_paths,
                     canonical_bytes,load,confined,sha256,validate_lock)
from offset_compare import offset_metrics
OPTIONS=dict(preserve_collinear=True,reverse_solution=False)
FIELDS={'format_version','case_id','source','operation','options','pattern','path','path_is_closed'}
PATTERNS=('rectangle','circle','concave','offcenter')
ROUTES=('long_horizontal','short_horizontal','diagonal','right_angle','acute','retrace','selfcross','rectangle','repeats')

def generation_size(m,n,closed):
    require(type(m) is int and type(n) is int and m>=0 and n>=0,'size','invalid dimensions')
    if m==0 or n==0:return (0,0,0,2,0)
    edges=n if closed else n-1
    # Python integers cannot overflow; the limits mirror the pure checked MoonBit helper.
    p=m*n;q=m*edges;slots=4*q
    nodes=2+2*n+2*p+6*q;work=n+p+2*q
    require(max(p,q,slots,nodes,work)<=2147483647,'size','Int representation exceeded')
    return p,q,slots,nodes,work

def validate_minkowski_input(v,where):
    keys(v,FIELDS,where)
    require(type(v['format_version']) is int and v['format_version']==7 and v['operation']=='MinkowskiSum',where,'unknown Minkowski protocol/operation')
    require(type(v['path_is_closed']) is bool,where,'path_is_closed must be boolean')
    keys(v['options'],OPTIONS,where+'.options')
    require(all(type(v['options'][k]) is bool and v['options'][k]==x for k,x in OPTIONS.items()),where,'fixed output settings required')
    proxy={k:v[k] for k in ('case_id','source')};proxy.update(format_version=1,operation='Union',fill_rule='NonZero',options=dict(preserve_collinear=False,reverse_solution=False),subject=[v['pattern'],v['path']],clip=[])
    validate_input(proxy,where)
    p,q,slots,nodes,work=generation_size(len(v['pattern']),len(v['path']),v['path_is_closed'])
    require(nodes<=500000 and work<=5000000,where,'conservative generation budget exceeded')
    for a in v['path']:
        for b in v['pattern']:
            require(all(-1000000000<=x+y<=1000000000 for x,y in zip(a,b)),where,'translated coordinate outside range')

def validate_minkowski_geometry(v,where='minkowski result'):
    require(type(v) is dict and type(v.get('format_version')) is int and v['format_version']==7 and v.get('status')=='success',where,'expected successful v7 result')
    require(v.get('operation')=='MinkowskiSum' and v.get('fill_rule')=='NonZero',where,'fixed operation/fill required')
    keys(v.get('options'),OPTIONS,where)
    require(all(type(v['options'][k]) is bool and v['options'][k]==x for k,x in OPTIONS.items()),where,'fixed output options required')
    validate_paths(v.get('paths'),where+'.paths',True)
    require('tree' not in v,where,'no Minkowski tree capability')

def validate_minkowski_result(v,c,d,lock,where):
    keys(v,{'format_version','adapter_protocol_version','case_id','input_sha256','oracle_commit','status','operation','fill_rule','options','paths','metrics'},where)
    require(type(v['adapter_protocol_version']) is int and v['adapter_protocol_version']==lock['minkowski_protocol_version'],where,'adapter protocol mismatch')
    require(v['case_id']==c['case_id'] and v['input_sha256']==d and v['oracle_commit']==lock['commit'],where,'provenance mismatch')
    validate_minkowski_geometry(v,where)
    require(canonical_bytes(v['metrics'])==canonical_bytes(offset_metrics(v)),where,'exact metrics mismatch')

def compare_minkowski(a,b,where='minkowski'):
    validate_minkowski_geometry(a,where);validate_minkowski_geometry(b,where)
    compare_paths(a['paths'],b['paths'],where) # rotations and siblings only; no deletion/reversal

def read_minkowski_manifest(root,manifest,require_expected=True,strict=True):
    v=load(manifest,strict);keys(v,{'format_version','kind','oracle_lock','cases'},'minkowski manifest')
    require(type(v['format_version']) is int and v['format_version']==7 and v['kind']=='minkowski','manifest','unknown catalog')
    require(v['oracle_lock']=='tools/oracle/upstream-lock.json','manifest','unexpected lock');lock=load(root/v['oracle_lock'],strict);validate_lock(lock)
    require(type(v['cases']) is list and len(v['cases'])==144,'manifest','expected 144 Minkowski cases')
    records=[];ids=set();inputs=set();outputs=set()
    for e in v['cases']:
        keys(e,{'case_id','input','expected','status','validation'},'entry');cid=e['case_id']
        require(type(cid) is str and re.fullmatch(r'[a-z0-9][a-z0-9_-]{0,100}',cid) and cid not in ids,'manifest','invalid/duplicate ID');ids.add(cid)
        require(e['status']=='validate' and e['validation']=={'paths':'validate'},cid,'complete paths required')
        require(e['input']==f'testdata/minkowski/inputs/{cid}.json' and e['expected']==f'testdata/minkowski/expected/{cid}.json',cid,'noncanonical mapping')
        ip,ep=confined(root,e['input']),confined(root,e['expected']);inputs.add(ip);outputs.add(ep)
        c=load(ip,strict);validate_minkowski_input(c,cid);require(c['case_id']==cid,cid,'ID mismatch');d=sha256(ip.read_bytes());expected=None
        if require_expected:expected=load(ep,strict);validate_minkowski_result(expected,c,d,lock,cid)
        records.append((e,c,d,expected))
    expected={(p,r,m,d) for p in PATTERNS for r in ROUTES for m in (False,True) for d in ('forward','reverse')}
    actual=[(*c['source']['group'].split(':'),c['path_is_closed']) for _,c,_,_ in records]
    require(len(set(actual))==144 and {(p,r,m,d) for p,r,d,m in actual}==expected,'manifest','incomplete pattern/route/mode/direction matrix')
    for folder,listed in [('inputs',inputs),('expected',outputs)]:
        actual={p.resolve() for p in (root/'testdata/minkowski'/folder).rglob('*') if p.is_file()}
        require(actual==listed if folder=='inputs' or require_expected else actual<=listed,'manifest','unlisted/missing '+folder)
    return lock,records

def minkowski_selection(root):
    lock,records=read_minkowski_manifest(root,root/'testdata/minkowski-manifest.json')
    v=load(root/'testdata/minkowski-selection.json',True);keys(v,{'format_version','kind','expected_count','case_ids'},'selection')
    require(type(v['format_version']) is int and v['format_version']==7 and v['kind']=='minkowski' and type(v['expected_count']) is int and v['expected_count']==144,'selection','invalid selection')
    require(v['case_ids']==sorted(c['case_id'] for _,c,_,_ in records),'selection','IDs mismatch')
    return lock,records
