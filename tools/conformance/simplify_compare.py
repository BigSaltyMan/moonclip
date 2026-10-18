# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""v6 ordered simplification, including degenerate paths and independent reports."""
import math
import re
from collections import Counter
from compare import (keys,require,integer,validate_input,validate_paths,canonical_bytes,
                     load,confined,sha256,validate_lock)
from decimal_compare import SCALES,round_grid
from offset_compare import finite
OPERATIONS=('Simplify64','SimplifyD')
COUNTS=('removed_vertices','removed_per_path')
INDICES=('input_degenerate_indices','degenerate_indices','collapsed_indices')
COMMON={'format_version','operation','case_id','source','options','mode','epsilon','reference_route','normalization','paths'}
NORMALIZATION='ConsecutiveDuplicatesAndClosedSeam'

def normalized(path,mode):
    result=[]
    for p in path:
        if not result or result[-1]!=p:result.append(p)
    if mode=='Closed' and len(result)>1 and result[-1]==result[0]:result.pop()
    return result

def degenerate(path,mode):
    if not path:return True
    a=path[0];b=next((p for p in path if p!=a),None)
    if b is None:return True
    if mode=='Open':return False
    return not any((b[0]-a[0])*(p[1]-a[1])-(b[1]-a[1])*(p[0]-a[0])!=0 for p in path)

def quantized(case,where='simplify'):
    if case['operation']=='Simplify64':
        validate_paths(case['paths'],where+'.paths');return case['paths']
    scale=SCALES[case['precision']];result=[];seen={};vertices=0
    require(type(case['paths']) is list and len(case['paths'])<=10000,where,'path limit/type')
    for path in case['paths']:
        require(type(path) is list,where,'expected path');vertices+=len(path)
        require(vertices<=100000,where,'raw vertex limit');out=[]
        for p in path:
            require(type(p) is list and len(p)==2,where,'expected pair');q=[]
            for v in p:
                finite(v,where);require(-1000000000/scale<=v<=1000000000/scale,where,'original coordinate range')
                s=v*scale;finite(s,where);require(-1000000000<=s<=1000000000,where,'scaled coordinate range');q.append(round_grid(s))
            key=tuple(q);require(key not in seen or seen[key]==p,where,'distinct input positions merge')
            seen[key]=p;out.append(q)
        result.append(out)
    return result

def validate_simplify_input(v,where):
    require(type(v) is dict and v.get('operation') in OPERATIONS,where,'unknown simplify operation')
    keys(v,COMMON|({'precision','grid'} if v['operation']=='SimplifyD' else set()),where)
    require(type(v['format_version']) is int and v['format_version']==6,where,'unknown simplify version')
    proxy={k:v[k] for k in ('case_id','source','options')};proxy.update(format_version=1,operation='Union',fill_rule='EvenOdd',subject=[],clip=[]);validate_input(proxy,where)
    require(v['mode'] in ('Open','Closed') and v['normalization']==NORMALIZATION,where,'unknown mode/normalization')
    finite(v['epsilon'],where);require(v['epsilon']>0,where,'reference epsilon must be positive')
    if v['operation']=='SimplifyD':
        integer(v['precision'],where,0,6);require(v['grid']=='DecimalHalfAwayFromZero' and v['reference_route']=='DecimalGrid',where,'unknown grid route')
    else:require(v['reference_route']=='Integer',where,'unknown integer route')
    scaled=v['epsilon']*(SCALES[v['precision']] if v['operation']=='SimplifyD' else 1)
    finite(scaled,where);finite(scaled*scaled,where);quantized(v,where)

def statistics(case,paths):
    raw=quantized(case);require(len(raw)==len(paths),'report','path correspondence lost')
    counts=[len(a)-len(b) for a,b in zip(raw,paths)]
    require(all(n>=0 for n in counts),'report','simplification added vertices')
    before=[i for i,p in enumerate(raw) if degenerate(normalized(p,case['mode']),case['mode'])]
    after=[i for i,p in enumerate(paths) if degenerate(p,case['mode'])]
    return dict(removed_vertices=sum(counts),removed_per_path=counts,input_degenerate_indices=before,degenerate_indices=after,collapsed_indices=[i for i in after if i not in before])

def validate_simplify_geometry(v,where='simplify result'):
    require(type(v) is dict and type(v.get('format_version')) is int and v['format_version']==6 and v.get('status')=='success',where,'expected successful v6')
    require(v.get('operation') in OPERATIONS and v.get('mode') in ('Open','Closed'),where,'unknown metadata')
    require(v.get('reference_route')==('Integer' if v['operation']=='Simplify64' else 'DecimalGrid'),where,'route mismatch')
    validate_paths(v.get('paths'),where+'.paths',False)
    if v['mode']=='Closed':
        for p in v['paths']:require(normalized(p,'Closed')==p,where,'output duplicate normalization violated')
    integer(v.get('removed_vertices'),where,0,100000)
    require(type(v.get('removed_per_path')) is list and len(v['removed_per_path'])==len(v['paths']),where,'removed count correspondence')
    for n in v['removed_per_path']:integer(n,where,0,100000)
    require(sum(v['removed_per_path'])==v['removed_vertices'],where,'inconsistent total')
    for field in INDICES:
        a=v.get(field);require(type(a) is list,where,'missing indices')
        for i in a:integer(i,where,0,len(v['paths'])-1)
        require(a==sorted(set(a)),where,'unordered/duplicate indices')
    require(v['degenerate_indices']==[i for i,p in enumerate(v['paths']) if degenerate(p,v['mode'])],where,'incorrect final degeneracy')
    require(v['collapsed_indices']==[i for i in v['degenerate_indices'] if i not in v['input_degenerate_indices']],where,'incorrect collapse report')
    if v['operation']=='SimplifyD':
        integer(v.get('precision'),where,0,6);scale=SCALES[v['precision']]
        decoded=v.get('paths_d');require(type(decoded) is list and len(decoded)==len(v['paths']),where,'decoded path count')
        for grid,path in zip(v['paths'],decoded):
            require(type(path) is list and len(path)==len(grid),where,'decoded vertex count')
            for q,p in zip(grid,path):
                require(type(p) is list and len(p)==2,where,'decoded pair')
                for n,x in zip(q,p):
                    finite(x,where);require(x==n/scale and (x!=0 or math.copysign(1,x)>0),where,'incorrect grid decoding / zero')

def simplify_metrics(v):return {'path_count':len(v['paths']),'vertex_count':sum(map(len,v['paths']))}

def compare_simplify(a,b,where='simplify'):
    validate_simplify_geometry(a,where);validate_simplify_geometry(b,where)
    for k in ('operation','mode','reference_route','paths',*COUNTS,*INDICES):require(a[k]==b[k],where,'ordered geometry/report differs: '+k)
    if a['operation']=='SimplifyD':require(a['precision']==b['precision'] and a['paths_d']==b['paths_d'],where,'decimal decoding differs')

def validate_simplify_result(v,case,digest,lock,where):
    fields={'format_version','adapter_protocol_version','case_id','input_sha256','oracle_commit','status','operation','mode','reference_route','paths','metrics',*COUNTS,*INDICES}
    keys(v,fields|({'precision','paths_d'} if case['operation']=='SimplifyD' else set()),where)
    require(type(v['adapter_protocol_version']) is int and v['adapter_protocol_version']==lock['simplify_protocol_version'],where,'adapter version mismatch')
    require(v['case_id']==case['case_id'] and v['input_sha256']==digest and v['oracle_commit']==lock['commit'],where,'provenance mismatch')
    require(all(v[k]==case[k] for k in ('operation','mode','reference_route')),where,'metadata mismatch')
    if case['operation']=='SimplifyD':require(v['precision']==case['precision'],where,'precision mismatch')
    validate_simplify_geometry(v,where)
    for k,x in statistics(case,v['paths']).items():require(v[k]==x,where,'incorrect independently computed '+k)
    require(canonical_bytes(v['metrics'])==canonical_bytes(simplify_metrics(v)),where,'metrics mismatch')

def read_simplify_manifest(root,manifest,require_expected=True,strict=True):
    v=load(manifest,strict);keys(v,{'format_version','kind','oracle_lock','cases'},'simplify manifest')
    require(type(v['format_version']) is int and v['format_version']==6 and v['kind']=='simplify','manifest','unknown catalog')
    require(v['oracle_lock']=='tools/oracle/upstream-lock.json','manifest','unexpected lock');lock=load(root/v['oracle_lock'],strict);validate_lock(lock)
    require(type(v['cases']) is list and len(v['cases'])==224,'manifest','expected 224 simplify cases')
    ids=set();inputs=set();outputs=set();records=[]
    for e in v['cases']:
        keys(e,{'case_id','input','expected','status','validation'},'simplify entry');cid=e['case_id']
        require(type(cid) is str and re.fullmatch(r'[a-z0-9][a-z0-9_-]{0,100}',cid) and cid not in ids,'manifest','invalid/duplicate ID');ids.add(cid)
        require(e['status']=='validate' and e['validation']=={'ordered_paths':'validate','statistics':'validate','degeneracy':'validate'},cid,'incomplete validation')
        require(e['input']==f'testdata/simplify/inputs/{cid}.json' and e['expected']==f'testdata/simplify/expected/{cid}.json',cid,'noncanonical mapping')
        ip,ep=confined(root,e['input']),confined(root,e['expected']);inputs.add(ip);outputs.add(ep)
        c=load(ip,strict);validate_simplify_input(c,cid);require(c['case_id']==cid,cid,'ID mismatch');d=sha256(ip.read_bytes());expected=None
        if require_expected:expected=load(ep,strict);validate_simplify_result(expected,c,d,lock,cid)
        records.append((e,c,d,expected))
    require(Counter(c['operation'] for _,c,_,_ in records)=={'Simplify64':80,'SimplifyD':144},'manifest','route counts mismatch')
    for folder,listed in [('inputs',inputs),('expected',outputs)]:
        actual={p.resolve() for p in (root/'testdata/simplify'/folder).rglob('*') if p.is_file()}
        require(actual==listed if folder=='inputs' or require_expected else actual<=listed,'manifest','unlisted/missing '+folder)
    return lock,records

def simplify_selection(root):
    lock,records=read_simplify_manifest(root,root/'testdata/simplify-manifest.json')
    v=load(root/'testdata/simplify-selection.json',True);keys(v,{'format_version','kind','expected_count','case_ids'},'simplify selection')
    require(type(v['format_version']) is int and v['format_version']==6 and v['kind']=='simplify' and type(v['expected_count']) is int and v['expected_count']==224,'selection','invalid selection')
    require(v['case_ids']==sorted(c['case_id'] for _,c,_,_ in records),'selection','IDs mismatch')
    return lock,records
