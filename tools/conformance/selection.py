"""Exact capability sets, selected from input fields rather than case names."""
from pathlib import Path
from compare import load, require, read_manifest
ROOT=Path(__file__).resolve().parents[2]
COUNTS={"EvenOdd":76,"NonZero":76,"Positive":24,"Negative":24}

def selections(manifest):
    _,records=read_manifest(ROOT,manifest,strict=True)
    selection=load(ROOT/'testdata/boolean-selection.json',True)
    require(set(selection)=={'format_version','total','rules'} and selection['format_version']==1 and selection['total']==200,'selection','invalid selection header')
    require(set(selection['rules'])==set(COUNTS),'selection','invalid rules')
    for fill,count in COUNTS.items():
        ids=[e['case_id'] for e,c,_,_ in records if c['fill_rule']==fill]
        kind='public' if fill in ('EvenOdd','NonZero') else 'internal'
        require(selection['rules'][fill]=={'entrypoint':kind,'expected_count':count,'case_ids':ids} and len(ids)==count,'selection','preselected '+fill+' set changed')
    baseline=load(ROOT/'testdata/evenodd-selection.json',True)
    eo=selection['rules']['EvenOdd']['case_ids']
    require(baseline['fill_rule']=='EvenOdd' and baseline['expected_count']==len(baseline['case_ids'])==60 and len(set(baseline['case_ids']))==60 and set(baseline['case_ids'])<=set(eo),'selection','original EvenOdd baseline missing')
    for entry,case,_,_ in records:
        status='validate' if case['fill_rule'] in ('EvenOdd','NonZero') else 'validate_internal'
        require(entry.get('validation')=={'paths':status,'tree':status},entry['case_id'],'wrong capability status')
    return records,[r for r in records if r[1]['fill_rule'] in ('EvenOdd','NonZero')],[r for r in records if r[1]['fill_rule'] in ('Positive','Negative')]
