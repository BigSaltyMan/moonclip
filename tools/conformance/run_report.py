#!/usr/bin/env python3
"""Native runner report transport: geometry is computed exclusively by MoonBit."""
import argparse
import json
from pathlib import Path
import sys
from compare import Invalid, require, read_manifest, load, sha256, compare_paths, canonical_bytes, validate_paths
ROOT=Path(__file__).resolve().parents[2]

def selected_records(manifest):
    _, records=read_manifest(ROOT,manifest,strict=True)
    selection=load(ROOT/'testdata/evenodd-selection.json',True)
    chosen=[r for r in records if r[1]['fill_rule']=='EvenOdd']
    require(selection=={'fill_rule':'EvenOdd','expected_count':60,'case_ids':[r[0]['case_id'] for r in chosen]},'selection','preselected case set changed')
    for entry,case,_,_ in records:
        require(entry.get('validation')=={'paths':'validate' if case['fill_rule']=='EvenOdd' else 'reference_only','tree':'reference_only'},entry['case_id'],'wrong capability status')
    return records,chosen

def evaluate(manifest, results):
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
        if r.get('status')=='error':
            require(set(r)=={'case_id','input_sha256','status','error'},cid,'invalid error result')
            details.append({'case_id':cid,'status':'execution_error','message':str(r['error'])});continue
        require(set(r)=={'case_id','input_sha256','status','paths'} and r['status']=='success',cid,'invalid success result')
        validate_paths(r["paths"],cid+".actual",output=True)
        try: compare_paths(expected['paths'],r['paths'],cid)
        except Invalid as error: details.append({'case_id':cid,'status':'difference','message':str(error)})
        else: details.append({'case_id':cid,'status':'passed'})
    report={'target':'native','reference_cases':len(records),'required':len(chosen),'executed':len(details),'passed':sum(r['status']=='passed' for r in details),'differences':sum(r['status']=='difference' for r in details),'execution_errors':sum(r['status']=='execution_error' for r in details),'tree':'reference_only','other_fill_rules':'reference_only','cases':details}
    return report

def markdown(report):
    lines=['# Boolean compatibility', '', 'Pinned Clipper2 2.0.1, commit `21ebba05db8894f0c7217ad35ea518080f324946`; ordinary precision, preserve_collinear=false, reverse_solution=false.', '',
      f"Native report: required={report['required']}, executed={report['executed']}, passed={report['passed']}, differences={report['differences']}, execution_errors={report['execution_errors']}. Reference catalog: {report['reference_cases']}.", '',
      'Native and JS independently execute the same 60 generated full-contour tests in moon test and CI. This native command report does not impersonate JS execution.', '',
      'All 136 tree outputs remain reference_only until Commit 8. The other 76 fill-rule cases remain reference_only. Passing flat contours does not establish PolyTree parentage.', '',
      'Only cyclic ring starts and contour ordering are normalized. Winding, all vertices and multiplicity are retained; no tolerance or automatic reversal is applied.', '',
      '| Case | Native paths | Tree |','| --- | --- | --- |']
    lines += [f"| {r['case_id']} | {r['status']} | reference_only |" for r in report['cases']]
    return '\n'.join(lines)+'\n'

def main():
    parser=argparse.ArgumentParser(description='Execute the preselected MoonClip EvenOdd contour comparison. Exit codes: 0 success/help; 1 contour differences; 2 arguments, integrity or execution errors.')
    parser.add_argument('--manifest',type=Path,default=ROOT/'testdata/manifest.json')
    parser.add_argument('--report-json',type=Path,default=ROOT/'_build/conformance/report.json')
    parser.add_argument('--report-md',type=Path,default=ROOT/'docs/compatibility.md')
    parser.add_argument('--strict',action='store_true',help='Require the exact preselected 60 IDs and complete results (also enforced by default)')
    try:
        envelope=json.load(sys.stdin)
        args=parser.parse_args(envelope['args'][1:])
        report=evaluate(args.manifest.resolve(),envelope['results'])
        args.report_json.parent.mkdir(parents=True,exist_ok=True)
        args.report_md.parent.mkdir(parents=True,exist_ok=True)
        args.report_json.write_bytes(canonical_bytes(report))
        args.report_md.write_text(markdown(report),encoding='utf-8',newline='\n')
        print(f"Native contour conformance: required={report['required']}, executed={report['executed']}, passed={report['passed']}, differences={report['differences']}, execution_errors={report['execution_errors']}; tree=reference_only")
        return 2 if report['execution_errors'] else 1 if report['differences'] else 0
    except (Invalid,OSError,ValueError,KeyError,TypeError) as error:
        print(f'Conformance error: {error}',file=sys.stderr);return 2
if __name__=='__main__':sys.exit(main())
