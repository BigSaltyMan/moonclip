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
    _, records=read_manifest(ROOT,manifest,strict=True)
    require(len(records)==116 and all(c['operation']=='OffsetPolygons' for _,c,_,_ in records),'offset','expected 116 offset cases')
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
    return {**summary(details),'required':116,'reference_cases':116,'capability':'public paths','cases':details}


def markdown(report):
    lines=['# Boolean compatibility','','Pinned Clipper2 2.0.1, commit `21ebba05db8894f0c7217ad35ea518080f324946`; ordinary precision, preserve_collinear=false, reverse_solution=false.','',
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
          'Boolean reference cases: 200. Offset reference cases: 116. Total independent reference inputs: 316. Offset has no public tree interface; hole/island composition is covered separately by functional tests.','',
          '| Target | Offset filtered paths |','| --- | --- |']
        for target in ('native','js'):
            e=report.get('offset_evidence',{}).get(target,{})
            value=str(e['passed'])+'/'+str(e['executed']) if e.get('status')=='passed' else 'not recorded'
            lines.append('| '+target+' | '+value+' |')
        lines+=['','| Offset case | Native paths |','| --- | --- |']
        lines += [f"| {c['case_id']} | {c['status']} |" for c in r['cases']]
    return '\n'.join(lines)+'\n'

def main():
    parser=argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,description='Execute independent MoonClip paths and tree comparisons. Exit codes: 0 success/help; 1 differences; 2 arguments, integrity or execution errors.')
    parser.add_argument('--manifest',type=Path,default=ROOT/'testdata/manifest.json')
    parser.add_argument('--offset-manifest',type=Path,help='Include independently executed offset protocol v2 cases')
    parser.add_argument('--report-json',type=Path,default=ROOT/'_build/conformance/report.json')
    parser.add_argument('--report-md',type=Path,default=ROOT/'docs/compatibility.md')
    parser.add_argument('--strict',action='store_true',help='Require exactly 152 public cases with independent paths and tree results (also enforced by default)')
    try:
        envelope=json.load(sys.stdin);args=parser.parse_args(envelope['args'][1:])
        report=evaluate(args.manifest.resolve(),envelope['results'])
        from evidence import internal_evidence,tree_evidence,offset_evidence
        if args.offset_manifest:
            report['offset']=evaluate_offset(args.offset_manifest.resolve(),envelope.get('offset_results'))
            report['offset_evidence']=offset_evidence(ROOT/'_build/conformance')
        report['internal']=internal_evidence(ROOT/'_build/conformance')
        report['tree_evidence']=tree_evidence(ROOT/'_build/conformance')
        args.report_json.parent.mkdir(parents=True,exist_ok=True);args.report_md.parent.mkdir(parents=True,exist_ok=True)
        args.report_json.write_bytes(canonical_bytes(report));args.report_md.write_text(markdown(report),encoding='utf-8',newline='\n')
        print(f"Native conformance: cases={report['required']}, paths={report['paths']['passed']}/{report['paths']['executed']}, tree={report['tree']['passed']}/{report['tree']['executed']}, both={report['passed']}, differences={report['differences']}, execution_errors={report['execution_errors']}")
        offset=report.get('offset',{})
        if offset:
            print(f"Native offset conformance: cases=116, paths={offset['passed']}/{offset['executed']}, differences={offset['differences']}, execution_errors={offset['execution_errors']}")
        return 2 if report['execution_errors'] or offset.get('execution_errors') else 1 if report['differences'] or offset.get('differences') else 0
    except (Invalid,OSError,ValueError,KeyError,TypeError) as error:
        print(f'Conformance error: {error}',file=sys.stderr);return 2
if __name__=='__main__':sys.exit(main())
