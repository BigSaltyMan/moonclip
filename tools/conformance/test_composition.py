# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Offline v4 schemas, stage comparison, evidence and generation isolation."""
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
from composition_compare import (composition_selection,validate_composition_geometry,
                                 stage_request,RECIPES)
from run_report import ROOT,evaluate_composition
from evidence import composition_evidence

class CompositionTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.lock,cls.records=composition_selection(ROOT)
        cls.case=next(c for _,c,_,_ in cls.records if c['case_id']=='composition_boolean_overlap_out')
        cls.good=[{k:v[k] for k in ('case_id','input_sha256','format_version','recipe','status','intermediate','final')} for _,c,d,v in cls.records]
    def invalid(self,c):
        with self.assertRaises(Invalid):validate_input(c,'composition')
    def test_24_locked_recipes_eight_each(self):
        from collections import Counter
        self.assertEqual(len(self.records),24)
        self.assertTrue(any(v['intermediate']['paths']==[] and v['final']=={'paths':[],'tree':{'children':[]}} for _,c,_,v in self.records if c['recipe']=='InsetThenTree'))
        self.assertEqual(Counter(c['recipe'] for _,c,_,_ in self.records),dict.fromkeys(RECIPES,8))
    def test_operation_version_and_top_level_types(self):
        for version in (True,4.0,3,'4'):
            c=copy.deepcopy(self.case);c['format_version']=version;self.invalid(c)
        for c in ([],None,True):
            from composition_compare import validate_composition_input
            with self.assertRaises(Invalid):validate_composition_input(c,'case')
    def test_unknown_and_missing_top_fields(self):
        for key in self.case:
            c=copy.deepcopy(self.case);del c[key];self.invalid(c)
        c=copy.deepcopy(self.case);c['unexpected']=1;self.invalid(c)
    def test_unknown_recipes_and_step_counts(self):
        for recipe in ('Pipeline',None,True,[]):
            c=copy.deepcopy(self.case);c['recipe']=recipe;self.invalid(c)
        for steps in ([],[self.case['steps'][0]],self.case['steps']*2,{},True):
            c=copy.deepcopy(self.case);c['steps']=steps;self.invalid(c)
    def test_both_step_unknown_fields_and_references_rejected(self):
        for i in (0,1):
            for key in ('ref','loop','source','expected'):
                c=copy.deepcopy(self.case);c['steps'][i][key]='previous';self.invalid(c)
        c=copy.deepcopy(self.case);c['steps'][1]['paths']=[];self.invalid(c)
    def test_fixed_operation_order(self):
        for i in (0,1):
            c=copy.deepcopy(self.case);c['steps'][i]['operation']='StrokePolyline';self.invalid(c)
    def test_public_rules_only_and_boolean_tokens_rejected(self):
        for i in (0,1):
            for rule in ('Positive','Negative',True,None):
                c=copy.deepcopy(self.case);c['steps'][i]['fill_rule']=rule;self.invalid(c)
    def test_inset_is_negative_and_tree_clip_is_empty(self):
        original=next(c for _,c,_,_ in self.records if c['recipe']=='InsetThenTree')
        for delta in (0,2,True):
            c=copy.deepcopy(original);c['steps'][0]['delta']=delta;self.invalid(c)
        c=copy.deepcopy(original);c['steps'][1]['clip']=[[[0,0]]];self.invalid(c)
    def test_numeric_and_style_validation_is_reused(self):
        for field,value in (('delta',True),('delta',float('inf')),('miter_limit',1.0),('arc_tolerance',-1),('join_type','Unknown')):
            c=copy.deepcopy(self.case);c['steps'][1][field]=value;self.invalid(c)
        c=copy.deepcopy(self.case);c['steps'][0]['subject'][0][0][0]=1000000001;self.invalid(c)
    def test_missing_intermediate_or_final_geometry_rejected(self):
        v=self.records[0][3]
        for field in ('intermediate','final'):
            c=copy.deepcopy(v);del c[field]
            with self.assertRaises(Invalid):validate_composition_geometry(c)
    def test_both_stages_compare_full_winding_and_multiplicity(self):
        v=next(v for _,c,_,v in self.records if c['case_id']==self.case['case_id'])
        for stage in ('intermediate','final'):
            for action in ('reverse','duplicate','coordinate'):
                c=copy.deepcopy(v)
                if action=='reverse':c[stage]['paths'][0].reverse()
                elif action=='duplicate':c[stage]['paths']*=2
                else:c[stage]['paths'][0][0][0]+=1
                with self.assertRaises(Invalid):compare(v,c,'composition')
    def test_strict_tree_catches_changed_parentage(self):
        v=next(v for _,c,_,v in self.records if c['case_id']=='composition_inset_hole_d2')
        c=copy.deepcopy(v);child=c['final']['tree']['children'][0]['children'].pop();c['final']['tree']['children'].append(child)
        with self.assertRaises(Invalid):compare(v,c,'tree')
    def test_provenance_and_exact_metrics(self):
        e,c,d,v=self.records[0];validate_result(v,c,d,self.lock,'case')
        for field,value in (('input_sha256','0'*64),('oracle_commit','0'*40),('adapter_protocol_version',True)):
            changed=copy.deepcopy(v);changed[field]=value
            with self.assertRaises(Invalid):validate_result(changed,c,d,self.lock,'case')
        changed=copy.deepcopy(v);changed['metrics']['intermediate']['path_count']=True
        with self.assertRaises(Invalid):validate_result(changed,c,d,self.lock,'case')
    def test_report_actual_24_both_stages(self):
        r=evaluate_composition(ROOT/'testdata/composition-manifest.json',self.good)
        self.assertEqual((r['required'],r['executed'],r['passed'],r['differences'],r['execution_errors']),(24,24,24,0,0))
        self.assertEqual(r['intermediate']['passed'],24);self.assertEqual(r['final']['passed'],24)
    def test_report_missing_duplicate_extra_ids(self):
        for data in (self.good[:-1],self.good+[self.good[0]],self.good+[dict(self.good[0],case_id='extra')]):
            with self.assertRaises(Invalid):evaluate_composition(ROOT/'testdata/composition-manifest.json',data)
    def test_report_stale_recipe_hash_rejected(self):
        data=copy.deepcopy(self.good);data[0]['input_sha256']='0'*64
        with self.assertRaises(Invalid):evaluate_composition(ROOT/'testdata/composition-manifest.json',data)
    def test_first_failure_final_not_executed(self):
        data=copy.deepcopy(self.good);r=data[0];data[0]={k:r[k] for k in ('case_id','input_sha256')};data[0].update(status='error',error='first failure',failure_step=1)
        report=evaluate_composition(ROOT/'testdata/composition-manifest.json',data)
        self.assertEqual(report['execution_errors'],1);self.assertEqual(report['cases'][0]['final'],'not_executed');self.assertEqual(report['final']['executed'],23)
        data[0]['failure_step']=True
        with self.assertRaises(Invalid):evaluate_composition(ROOT/'testdata/composition-manifest.json',data)
    def test_second_failure_preserves_compared_intermediate(self):
        data=copy.deepcopy(self.good);r=data[0];data[0]={k:r[k] for k in ('case_id','input_sha256','intermediate')};data[0].update(status='error',error='second failure',failure_step=2)
        report=evaluate_composition(ROOT/'testdata/composition-manifest.json',data)
        self.assertEqual(report['execution_errors'],1);self.assertEqual(report['cases'][0]['intermediate'],'passed');self.assertEqual(report['cases'][0]['failure_step'],2)
        del data[0]['intermediate']
        with self.assertRaises(Invalid):evaluate_composition(ROOT/'testdata/composition-manifest.json',data)
    def test_stage_differences_reported_separately(self):
        for stage in ('intermediate','final'):
            data=copy.deepcopy(self.good);data[0][stage]['paths'][0].reverse()
            r=evaluate_composition(ROOT/'testdata/composition-manifest.json',data)
            self.assertEqual(r[stage]['differences'],1);self.assertEqual(r['final' if stage=='intermediate' else 'intermediate']['differences'],0)
    def test_evidence_requires_unique_marker_and_exact_24(self):
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'composition-native.log';valid='Selection: reference composition: *\nTotal tests: 24, passed: 24, failed: 0.\n';p.write_text(valid,encoding='utf-8')
            self.assertEqual(composition_evidence(Path(d))['native']['passed'],24)
            for text in (valid.replace('Selection: reference composition: *\n',''),valid.replace('24','23'),valid+valid):
                p.write_text(text,encoding='utf-8')
                with self.assertRaises(Invalid):composition_evidence(Path(d))
    def test_runtime_uses_real_calls_and_never_links_expected(self):
        from generate_composition import generated
        runner=generated()['cmd/conformance/composition_cases.mbt']
        for function in ('boolean_op','offset_polygons','stroke_polyline','boolean_tree'):self.assertIn('@moonclip.'+function+'(',runner)
        self.assertNotIn('expected/',runner);self.assertIn('intermediate~',runner)
    def test_selection_missing_duplicate_extra_stale_count(self):
        selection=load(ROOT/'testdata/composition-selection.json',True)
        with tempfile.TemporaryDirectory() as d:
            root=Path(d);(root/'testdata').mkdir()
            for action in ('missing','duplicate','extra','count'):
                changed=copy.deepcopy(selection)
                if action=='missing':changed['case_ids'].pop()
                elif action=='duplicate':changed['case_ids'][0]=changed['case_ids'][1]
                elif action=='extra':changed['case_ids'][0]='extra'
                else:changed['expected_count']=25
                (root/'testdata/composition-selection.json').write_bytes(canonical_bytes(changed))
                with patch('composition_compare.read_composition_manifest',return_value=(self.lock,self.records)):
                    with self.assertRaises(Invalid):composition_selection(root)
    def oracle_module(self):
        spec=importlib.util.spec_from_file_location('composition_generation',ROOT/'tools/oracle/generate.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m
    def test_generation_explicit_category_and_mixed_rejection(self):
        m=self.oracle_module();self.assertEqual(m.expected_directory([(None,self.case,None,None)]),'testdata/composition/expected')
        for records in ([],[(None,dict(operation='Unknown'),None,None)],[(None,self.case,None,None),(None,dict(operation='Union'),None,None)]):
            with self.assertRaises(Invalid):m.expected_directory(records)
    def test_write_does_not_touch_other_three_categories(self):
        m=self.oracle_module()
        with tempfile.TemporaryDirectory() as d:
            root=Path(d)
            for name in ('upstream','offset','stroke'):
                p=root/f'testdata/{name}/expected';p.mkdir(parents=True);(p/'sentinel').write_bytes(b'unchanged')
            cid=self.case['case_id'];ip=f'testdata/composition/inputs/{cid}.json';target=root/ip;target.parent.mkdir(parents=True);target.write_bytes(canonical_bytes(self.case));digest=sha256(target.read_bytes())
            response=dict(format_version=4,adapter_protocol_version=4,case_id=cid,oracle_commit=self.lock['commit'],status='success',recipe=self.case['recipe'],intermediate=dict(paths=[]),final=dict(paths=[]))
            command=[sys.executable,'-c','import sys;sys.stdin.buffer.read();print('+repr(canonical_bytes(response).decode())+')']
            with patch.object(m,'read_manifest',return_value=(self.lock,[({'input':ip},self.case,digest,None)])),redirect_stdout(StringIO()):
                self.assertEqual(m.generate(root,root/'manifest.json','write',command),1)
            self.assertTrue((root/f'testdata/composition/expected/{cid}.json').exists())
            for name in ('upstream','offset','stroke'):self.assertEqual((root/f'testdata/{name}/expected/sentinel').read_bytes(),b'unchanged')
