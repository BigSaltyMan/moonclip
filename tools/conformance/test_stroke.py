# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Independent v3 schema, selection, report, evidence and publication routing."""
import copy
import importlib.util
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch
from contextlib import redirect_stdout
from io import StringIO
from compare import Invalid,canonical_bytes,compare,load,validate_input,validate_result,sha256
from stroke_compare import stroke_selection,validate_stroke_input
from run_report import ROOT,evaluate_stroke
from evidence import stroke_evidence

class StrokeTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.lock,cls.records=stroke_selection(ROOT)
        cls.case=next(c for _,c,_,_ in cls.records if c['case_id']=='stroke_horizontal_w4_miter_butt')
        cls.good=[{'case_id':e['case_id'],'input_sha256':d,'status':'success','paths':v['paths']} for e,c,d,v in cls.records]
    def rejected(self,field,value):
        c=copy.deepcopy(self.case);c[field]=value
        with self.assertRaises(Invalid):validate_input(c,'stroke')
    def test_selection_is_276_unique_open_routes(self):
        self.assertEqual(len(self.records),276)
        self.assertEqual(len({c['case_id'] for _,c,_,_ in self.records}),276)
        self.assertTrue(all('fill_rule' not in c for _,c,_,_ in self.records))
        selected=load(ROOT/'testdata/stroke-selection.json',True)
        with tempfile.TemporaryDirectory() as d:
            root=Path(d);(root/'testdata').mkdir()
            for mutation in ('missing','duplicate','extra','count'):
                changed=copy.deepcopy(selected)
                if mutation=='missing':changed['case_ids'].pop()
                elif mutation=='duplicate':changed['case_ids'][0]=changed['case_ids'][1]
                elif mutation=='extra':changed['case_ids'][0]='unknown'
                else:changed['expected_count']=275
                (root/'testdata/stroke-selection.json').write_bytes(canonical_bytes(changed))
                with patch('stroke_compare.read_stroke_manifest',return_value=(self.lock,self.records)):
                    with self.assertRaises(Invalid):stroke_selection(root)
    def test_operation_specific_protocol(self):
        for value in (1,2,True,3.0,'3'):self.rejected('format_version',value)
    def test_all_join_cap_combinations(self):
        self.assertEqual({(c['join_type'],c['cap_type']) for _,c,_,_ in self.records},{(j,k) for j in ('Miter','Bevel','Square','Round') for k in ('Butt','Square','Round')})
    def test_numeric_types_and_nonfinite_rejected(self):
        for field in ('width','miter_limit','arc_tolerance'):
            for value in (True,False,None,[],{},'4',float('inf'),float('nan')):self.rejected(field,value)
    def test_reference_width_contract_excludes_degenerates(self):
        for width in (-1,0,0.99):self.rejected('width',width)
        for path in ([],[[0,0]],[[0,0],[0,0]]):self.rejected('path',path)
    def test_parameter_and_coordinate_limits(self):
        self.rejected('miter_limit',1.999);self.rejected('arc_tolerance',-0.01)
        self.rejected('path',[[0,0],[1000000001,0]])
    def test_no_fill_rule_or_unknown_fields(self):
        self.rejected('fill_rule','NonZero');self.rejected('unexpected',True)
    def test_unknown_styles_rejected(self):
        self.rejected('cap_type','Joined');self.rejected('join_type','Unknown')
    def test_coincident_ends_and_nonconsecutive_duplicates_are_valid(self):
        c=copy.deepcopy(self.case);c['path']=[[0,0],[20,0],[0,0]];validate_stroke_input(c,'stroke')
    def test_missing_and_wrong_top_level_rejected(self):
        for value in (None,True,[],"invalid"):
            with self.assertRaises(Invalid):validate_stroke_input(value,'stroke')
        for field in self.case:
            c=copy.deepcopy(self.case);del c[field]
            with self.assertRaises(Invalid):validate_stroke_input(c,'stroke')
    def test_result_provenance_and_exact_metrics(self):
        e,c,d,v=self.records[0]
        validate_result(v,c,d,self.lock,c['case_id'])
        for field,value in (('adapter_protocol_version',2),('input_sha256','0'*64),('format_version',True)):
            changed=copy.deepcopy(v);changed[field]=value
            with self.assertRaises(Invalid):validate_result(changed,c,d,self.lock,'stroke')
    def test_stroke_has_no_tree_capability(self):
        self.assertTrue(all('tree' not in v for _,_,_,v in self.records))
        e,c,d,v=self.records[0];changed=copy.deepcopy(v);changed['tree']={'children':[]}
        with self.assertRaises(Invalid):validate_result(changed,c,d,self.lock,'stroke')
    def test_report_all_executed_with_parameter_coverage(self):
        r=evaluate_stroke(ROOT/'testdata/stroke-manifest.json',self.good)
        self.assertEqual((r['required'],r['executed'],r['passed'],r['differences'],r['execution_errors']),(276,276,276,0,0))
        self.assertEqual(set(r['coverage']['cap_type']),{'Butt','Square','Round'})
    def test_report_rejects_missing_duplicate_and_extra(self):
        for results in (self.good[:-1],self.good+[self.good[0]],self.good+[dict(self.good[0],case_id='extra')]):
            with self.assertRaises(Invalid):evaluate_stroke(ROOT/'testdata/stroke-manifest.json',results)
    def test_report_hash_mismatch_is_failure(self):
        results=copy.deepcopy(self.good);results[0]['input_sha256']='0'*64
        with self.assertRaises(Invalid):evaluate_stroke(ROOT/'testdata/stroke-manifest.json',results)
    def test_report_execution_error_is_not_empty_region(self):
        results=copy.deepcopy(self.good);results[0].pop('paths');results[0].update(status='error',error='Generation failed')
        self.assertEqual(evaluate_stroke(ROOT/'testdata/stroke-manifest.json',results)['execution_errors'],1)
    def test_strict_comparison_does_not_reverse_or_simplify(self):
        v=self.records[0][3];changed=copy.deepcopy(v);changed['paths'][0].reverse()
        with self.assertRaises(Invalid):compare(v,changed,'stroke')
        changed=copy.deepcopy(v);changed['format_version']=3.0
        with self.assertRaises(Invalid):compare(v,changed,'stroke')
    def test_actual_stroke_evidence_requires_276_and_selection(self):
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'stroke-native.log';p.write_text('Selection: reference stroke paths: *\nTotal tests: 276, passed: 276, failed: 0.\n',encoding='utf-8')
            self.assertEqual(stroke_evidence(Path(d))['native']['passed'],276)
            for text in ('Total tests: 276, passed: 276, failed: 0.','Selection: reference stroke paths: *\nTotal tests: 272, passed: 272, failed: 0.'):
                p.write_text(text,encoding='utf-8')
                with self.assertRaises(Invalid):stroke_evidence(Path(d))
    def test_runner_calls_real_entry_with_full_width(self):
        from generate_stroke import call,generated
        value=call(self.case)
        self.assertIn('stroke_polyline(',value);self.assertIn(',4.0,cap=',value)
        runner=generated()['cmd/conformance/stroke_cases.mbt']
        self.assertNotIn('expected/',runner);self.assertIn('actual_offset_case(',runner)
    def oracle_module(self):
        spec=importlib.util.spec_from_file_location('stroke_generation',ROOT/'tools/oracle/generate.py')
        module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module);return module
    def test_generator_explicit_category_and_unknown_rejection(self):
        g=self.oracle_module()
        for op,name in (('Union','upstream'),('OffsetPolygons','offset'),('StrokePolyline','stroke')):
            self.assertEqual(g.expected_directory([(None,{'operation':op},None,None)]),f'testdata/{name}/expected')
        for records in ([],[(None,{'operation':'Unknown'},None,None)],[(None,{'operation':'Union'},None,None),(None,{'operation':'StrokePolyline'},None,None)]):
            with self.assertRaises(Invalid):g.expected_directory(records)
    def test_stroke_write_never_publishes_into_old_expected_directories(self):
        g=self.oracle_module()
        with tempfile.TemporaryDirectory() as d:
            root=Path(d)
            for name in ('upstream','offset'):
                p=root/f'testdata/{name}/expected';p.mkdir(parents=True);(p/'sentinel').write_bytes(b'unchanged')
            cid=self.case['case_id'];ip=f'testdata/stroke/inputs/{cid}.json';target=root/ip;target.parent.mkdir(parents=True)
            target.write_bytes(canonical_bytes(self.case));digest=sha256(target.read_bytes())
            response={'format_version':3,'adapter_protocol_version':3,'case_id':cid,'oracle_commit':self.lock['commit'],'status':'success','paths':[]}
            command=[sys.executable,'-c','import sys;sys.stdin.buffer.read();print('+repr(canonical_bytes(response).decode())+')']
            with patch.object(g,'read_manifest',return_value=(self.lock,[({'input':ip},self.case,digest,None)])), redirect_stdout(StringIO()):
                self.assertEqual(g.generate(root,root/'manifest.json','write',command),1)
            self.assertTrue((root/f'testdata/stroke/expected/{cid}.json').exists())
            for name in ('upstream','offset'):self.assertEqual((root/f'testdata/{name}/expected/sentinel').read_bytes(),b'unchanged')
