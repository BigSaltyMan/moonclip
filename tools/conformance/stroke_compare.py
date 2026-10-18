# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Stroke protocol v3: one open route, full width, no fill rule or tree."""
import re
from compare import keys, require, load, validate_lock, confined, sha256, canonical_bytes
from offset_compare import finite, validate_offset_input, offset_metrics


def validate_stroke_input(value, where):
    keys(value,{"format_version","operation","case_id","source","options","path","width","join_type","cap_type","miter_limit","arc_tolerance"},where)
    require(type(value['format_version']) is int and value['format_version']==3 and value['operation']=='StrokePolyline',where,'unknown stroke protocol/operation')
    finite(value['width'],where+'.width')
    require(value['width']>=1,where,'reference strokes require full width at least 1')
    require(type(value['cap_type']) is str and value['cap_type'] in ('Butt','Square','Round'),where,'unknown cap')
    proxy={k:value[k] for k in ('case_id','source','options','join_type','miter_limit','arc_tolerance')}
    proxy.update(format_version=2,operation='OffsetPolygons',paths=[value['path']],delta=value['width']/2,fill_rule='NonZero')
    validate_offset_input(proxy,where)
    require(any(a!=b for a,b in zip(value['path'],value['path'][1:])),where,'reference stroke requires an effective segment')


def validate_stroke_geometry(value, where='stroke result'):
    require(type(value) is dict and type(value.get('format_version')) is int and value['format_version']==3,where,'unknown stroke geometry version')
    require(value.get('status')=='success' and 'tree' not in value,where,'expected successful stroke paths only')
    from compare import validate_paths
    validate_paths(value.get('paths'),where+'.paths',True)


def validate_stroke_result(value, case, digest, lock, where):
    keys(value,{'format_version','adapter_protocol_version','case_id','input_sha256','oracle_commit','status','paths','metrics'},where)
    require(type(value['format_version']) is int and value['format_version']==3,where,'unknown stroke result format')
    require(type(value['adapter_protocol_version']) is int and value['adapter_protocol_version']==lock['stroke_protocol_version'],where,'unknown stroke adapter version')
    require(value['case_id']==case['case_id'] and value['input_sha256']==digest and value['oracle_commit']==lock['commit'],where,'stroke provenance mismatch')
    validate_stroke_geometry(value,where)
    require(canonical_bytes(value['metrics'])==canonical_bytes(offset_metrics(value)),where,'exact stroke metrics mismatch')


def read_stroke_manifest(root, manifest, require_expected=True, strict=True):
    value=load(manifest,strict)
    keys(value,{'format_version','kind','oracle_lock','cases'},'stroke manifest')
    require(type(value['format_version']) is int and value['format_version']==3 and value['kind']=='stroke','stroke manifest','unknown format')
    require(value['oracle_lock']=='tools/oracle/upstream-lock.json','stroke manifest','unexpected lock')
    lock=load(root/value['oracle_lock'],strict);validate_lock(lock)
    require(type(value['cases']) is list and 0<len(value['cases'])<=10000,'stroke manifest','invalid cases')
    ids,inputs,outputs,records=set(),set(),set(),[]
    for e in value['cases']:
        keys(e,{'case_id','input','expected','status','validation'},'stroke case')
        cid=e['case_id']
        require(type(cid) is str and re.fullmatch(r'[a-z0-9][a-z0-9_-]{0,100}',cid) and cid not in ids,'stroke manifest','duplicate/invalid ID')
        ids.add(cid)
        require(e['status']=='validate' and e['validation']=={'paths':'validate'},cid,'stroke supports public paths only')
        require(e['input']==f'testdata/stroke/inputs/{cid}.json' and e['expected']==f'testdata/stroke/expected/{cid}.json',cid,'noncanonical mapping')
        ip,ep=confined(root,e['input']),confined(root,e['expected']);inputs.add(ip);outputs.add(ep)
        case=load(ip,strict);validate_stroke_input(case,cid)
        require(case['case_id']==cid,cid,'stroke ID mismatch')
        digest=sha256(ip.read_bytes());expected=None
        if require_expected:
            expected=load(ep,strict);validate_stroke_result(expected,case,digest,lock,cid)
        records.append((e,case,digest,expected))
    require({p for p in (root/'testdata/stroke/inputs').rglob('*') if p.is_file()}==inputs,'stroke manifest','unlisted or missing inputs')
    actual={p for p in (root/'testdata/stroke/expected').rglob('*') if p.is_file()}
    require(actual==outputs if require_expected else actual<=outputs,'stroke manifest','unlisted or missing expectations')
    return lock,records


def stroke_selection(root):
    lock,records=read_stroke_manifest(root,root/'testdata/stroke-manifest.json')
    s=load(root/'testdata/stroke-selection.json',True)
    keys(s,{'format_version','kind','expected_count','case_ids'},'stroke selection')
    require(type(s['format_version']) is int and s['format_version']==3 and s['kind']=='stroke','stroke selection','unknown format')
    require(type(s['expected_count']) is int and s['expected_count']==276,'stroke selection','expected 276')
    require(s['case_ids']==sorted({c['case_id'] for _,c,_,_ in records}) and len(records)==276,'stroke selection','selection mismatch')
    return lock,records
