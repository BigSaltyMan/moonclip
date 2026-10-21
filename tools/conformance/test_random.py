# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Small C16 tooling checks. Injected faults below are not library defects."""
import copy
import importlib.util
import sys
from pathlib import Path
import tempfile
import unittest
from compare import Invalid, canonical_bytes, load
from random_cases import ROOT,SEED,cases,documents,read_random_manifest,generated
from run_report import evaluate_random,coverage_matrix,random_execution_evidence,matrix_markdown
from reduce_failure import reduce_case,observe,size


class RandomTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        _,cls.records=read_random_manifest(ROOT,ROOT/'testdata/random-manifest.json')
        cls.good=[dict(case_id=c['case_id'],input_sha256=d,status='success',paths=v['paths']) for _,c,d,v in cls.records]

    def test_seed_bytes_and_locked_order(self):
        self.assertEqual(documents(),documents(SEED))
        self.assertNotEqual(canonical_bytes(cases()),canonical_bytes(cases(SEED+1)))
        for name,data in documents().items():self.assertEqual((ROOT/name).read_bytes(),data)

    def test_selection_exact_24_flat_capabilities(self):
        selected=load(ROOT/'testdata/random-selection.json')
        self.assertEqual(selected['case_ids'],[e['case_id'] for e,_,_,_ in self.records])
        self.assertEqual(len(set(selected['case_ids'])),24)
        self.assertTrue(all(e['validation']=={'paths':'validate'} for e,_,_,_ in self.records))

    def test_report_exact_results_and_bad_identity(self):
        report=evaluate_random(ROOT/'testdata/random-manifest.json',self.good)
        self.assertEqual((report['passed'],report['differences'],report['execution_errors']),(24,0,0))
        bad_hash=copy.deepcopy(self.good);bad_hash[0]['input_sha256']='0'*64
        for values in (self.good[:-1],self.good+[self.good[0]],self.good+[dict(case_id='extra')],bad_hash):
            with self.assertRaises(Invalid):evaluate_random(ROOT/'testdata/random-manifest.json',values)

    def test_report_difference_and_execution_error_are_distinct(self):
        values=copy.deepcopy(self.good);i=next(i for i,r in enumerate(values) if r['paths']);values[i]['paths']=[]
        self.assertEqual(evaluate_random(ROOT/'testdata/random-manifest.json',values)['differences'],1)
        values[i]={k:values[i][k] for k in ('case_id','input_sha256')};values[i].update(status='error',error='test injected error')
        self.assertEqual(evaluate_random(ROOT/'testdata/random-manifest.json',values)['execution_errors'],1)

    def test_matrix_unique_cases_and_capability_checks(self):
        result=coverage_matrix();self.assertEqual(result['cases'],1416)
        self.assertEqual(sum(r['cases'] for r in result['catalogs']),1416)
        self.assertEqual(matrix_markdown(result),matrix_markdown(__import__('json').loads(canonical_bytes(result))))
        boolean=result['catalogs'][0];self.assertEqual((boolean['cases'],boolean['capability_checks']),(200,400))
        by={c['catalog']:c for c in result['catalogs']}
        self.assertEqual(by['random']['capability_checks'],24)
        self.assertEqual(by['rectclip']['capability_checks'],32)
        self.assertEqual(by['minkowski']['fields']['preserve_collinear'],{'true':144})
        self.assertEqual(set(result['catalogs'][4]['fields']['precision']),{str(i) for i in range(7)})

    def test_generator_publication_isolated_and_mixtures_rejected(self):
        spec=importlib.util.spec_from_file_location('random_generator',ROOT/'tools/oracle/generate.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
        self.assertEqual(m.expected_directory(self.records),'testdata/random/expected')
        old=dict(self.records[0][0],expected='testdata/upstream/expected/old.json')
        with self.assertRaises(Invalid):m.expected_directory([self.records[0],(old,self.records[0][1],None,None)])

    def test_runner_inputs_only_and_exact_generated_tests(self):
        files=generated();runner=files['cmd/conformance/random_cases.mbt'].decode()
        self.assertEqual(runner.count('@moonclip.boolean_op('),24)
        self.assertNotIn('expected/',runner);self.assertNotIn('boolean_tree',runner)
        self.assertEqual(files['conformance/random_test.mbt'].count(b'test "reference random paths:'),24)

    def test_js_evidence_cannot_come_from_native_log(self):
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory);(root/'random-native.log').write_text('Total tests: 24, passed: 24, failed: 0.\n')
            e=random_execution_evidence(root);self.assertEqual(e['native']['passed'],24);self.assertEqual(e['js']['status'],'not_recorded')
            # A stale full-suite count must not establish JS execution evidence.
            (root/'all-js.log').write_text('Total tests: 2323, passed: 2323, failed: 0.\n')
            with self.assertRaises(Invalid):random_execution_evidence(root)
            (root/'all-js.log').write_text('Total tests: 2370, passed: 2370, failed: 0.\n')
            self.assertEqual(random_execution_evidence(root)['js']['passed'],24)

    def test_reducer_keeps_category_and_attempt_cap(self):
        original=copy.deepcopy(self.records[0][1]);seen=[]
        def injected(c):
            seen.append(copy.deepcopy(c))
            # Explicit tool-test fault; a zero/empty candidate changes category.
            category='difference' if c['subject'] and c['clip'] else 'moonclip_error:InvalidInput'
            return dict(category=category,oracle={'test_double':True},moonclip={'test_double':True})
        with tempfile.TemporaryDirectory() as directory:
            path=reduce_case(original,injected,7,Path(directory),label='tool_test_injected_fault')
            metadata=load(path/'metadata.json');reduced=load(path/'reduced.json')
            self.assertEqual(metadata['failure_category'],'difference');self.assertLessEqual(metadata['attempts'],7)
            self.assertEqual(len(seen),metadata['attempts']+1)
            self.assertTrue(all(c['operation']==original['operation'] and c['fill_rule']==original['fill_rule'] for c in seen))
            self.assertEqual(load(path/'reduced-results.json')['category'],'difference')
            self.assertLess(size(reduced),size(original));self.assertFalse(metadata['globally_minimal'])
            self.assertTrue(any(not h['accepted'] for h in metadata['history']))

    def test_reducer_match_creates_no_files_and_zero_limit_archives(self):
        with tempfile.TemporaryDirectory() as directory:
            output=Path(directory)/'not-created'
            self.assertIsNone(reduce_case(self.records[0][1],lambda c:dict(category='match'),output=output))
            self.assertFalse(output.exists())
            path=reduce_case(self.records[0][1],lambda c:dict(category='difference'),0,output,label='tool_test_injected_fault')
            self.assertEqual(load(path/'metadata.json')['stop_reason'],'attempt_limit')

    def test_real_process_transport_and_class_preservation(self):
        with tempfile.TemporaryDirectory() as directory:
            script=Path(directory)/'fault.py'
            script.write_text('import json,sys\nc=json.load(sys.stdin)\nprint(json.dumps({"status":"success","paths":[]}) if sys.argv[1]=="oracle" else json.dumps({"status":"error","error":"injected tool fault","error_kind":"InvalidInput"}))\n')
            result=observe(self.records[0][1],[sys.executable,str(script),'oracle'],[sys.executable,str(script),'moonclip'])
            self.assertEqual(result['category'],'moonclip_error:InvalidInput')
            path=reduce_case(self.records[0][1],lambda c:result,40,Path(directory)/'archive',label='tool_test_injected_fault')
            self.assertEqual(load(path/'metadata.json')['stop_reason'],'unsupported_failure_class')
            self.assertEqual(load(path/'metadata.json')['attempts'],0)

    def test_timeout_is_not_a_geometry_difference(self):
        with tempfile.TemporaryDirectory() as directory:
            script=Path(directory)/'slow.py';script.write_text('import time;time.sleep(2)\n')
            result=observe(self.records[0][1],[sys.executable,str(script)],[sys.executable,str(script)],.05)
            self.assertEqual(result['category'],'oracle_timeout')
            self.assertEqual(result['moonclip']['transport'],'timeout')
