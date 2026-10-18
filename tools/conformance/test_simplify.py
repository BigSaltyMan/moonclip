# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Strict ordered protocol, independent statistics, evidence and report regressions."""
import copy
import importlib.util
import math
from pathlib import Path
import tempfile
import unittest
from compare import Invalid,canonical_bytes,load,validate_input,validate_result,compare
from simplify_compare import *
from run_report import ROOT,evaluate_simplify
from evidence import simplify_evidence

class SimplifyTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.lock,cls.records=simplify_selection(ROOT)
        cls.case=copy.deepcopy(next(c for _,c,_,_ in cls.records if c['operation']=='Simplify64'))
        cls.decimal=copy.deepcopy(next(c for _,c,_,_ in cls.records if c['operation']=='SimplifyD'))
        cls.good=[{k:v for k,v in expected.items() if k not in ('oracle_commit','adapter_protocol_version','metrics')} for _,_,_,expected in cls.records]
    def invalid(self,c):
        with self.assertRaises(Invalid):validate_input(c,'simplify')
    def report(self,data=None):return evaluate_simplify(ROOT/'testdata/simplify-manifest.json',self.good if data is None else data)
    def test_224_routes_modes_groups(self):
        self.assertEqual(len(self.records),224)
        for op,count,groups in [('Simplify64',80,10),('SimplifyD',144,8)]:
            selected=[c for _,c,_,_ in self.records if c['operation']==op]
            self.assertEqual(len(selected),count);self.assertEqual(len({c['source']['group'] for c in selected}),groups)
            self.assertEqual({c['mode'] for c in selected},{'Open','Closed'})
    def test_full_integer_matrix(self):
        from collections import Counter
        self.assertEqual(Counter((c['mode'],c['epsilon']) for _,c,_,_ in self.records if c['operation']=='Simplify64'),{(m,e):10 for m in ('Open','Closed') for e in (.25,.5,1,4)})
    def test_full_decimal_matrix(self):
        from collections import Counter
        self.assertEqual(Counter((c['mode'],c['precision'],c['epsilon']) for _,c,_,_ in self.records if c['operation']=='SimplifyD'),{(m,p,e):8 for m in ('Open','Closed') for p in (0,3,6) for e in (.25,.5,2)})
    def test_missing_extra_fields(self):
        for original in (self.case,self.decimal):
            for field in original:
                c=copy.deepcopy(original);del c[field];self.invalid(c)
            c=copy.deepcopy(original);c['extra']=0;self.invalid(c)
    def test_invalid_version_mode_route_normalization(self):
        for field,values in [('format_version',(True,6.0,5)),('mode',('Ring','open',None)),('reference_route',('ClipperDCommonGrid','DecimalGrid',None)),('normalization',('Automatic',None))]:
            for value in values:c=copy.deepcopy(self.case);c[field]=value;self.invalid(c)
    def test_epsilon_positive_finite_and_square(self):
        for e in (0,-0.0,-1,True,'1',float('nan'),float('inf'),1e308):
            c=copy.deepcopy(self.case);c['epsilon']=e;self.invalid(c)
    def test_decimal_precision_scaling_overflow(self):
        for p in (-1,7,True,3.0):c=copy.deepcopy(self.decimal);c['precision']=p;self.invalid(c)
        c=copy.deepcopy(self.decimal);c.update(precision=6,epsilon=1e150);self.invalid(c)
    def test_grid_coordinate_type_and_range(self):
        for x in (True,1.0,'1',1000000001,-1000000001,-9223372036854775808):
            c=copy.deepcopy(self.case);c['paths']=[[[x,0]]];self.invalid(c)
    def test_decimal_range_and_merge(self):
        c=copy.deepcopy(self.decimal);c.update(precision=3,paths=[[[0,0],[.0001,0]]]);self.invalid(c)
        for x in (math.inf,math.nan,1000.0001):c.update(precision=6,paths=[[[x,0]]]);self.invalid(c)
    def test_raw_budgets_include_duplicates_empties(self):
        c=copy.deepcopy(self.case);c['paths']=[[]]*10001;self.invalid(c)
        c['paths']=[[[0,0]]*100001];self.invalid(c)
    def test_closed_existing_degeneracy_allowed(self):
        for original in (self.case,self.decimal):
            c=copy.deepcopy(original);c.update(paths=[[],[[0,0]],[[0,0],[1,0],[2,0]]],mode='Closed');validate_input(c,'degenerate')
    def test_open_normalization_retains_return_endpoint(self):
        p=[[0,0],[0,0],[2,0],[0,0]]
        self.assertEqual(normalized(p,'Open'),[[0,0],[2,0],[0,0]])
        self.assertEqual(normalized(p,'Closed'),[[0,0],[2,0]])
    def test_bowtie_not_classified_by_signed_area(self):
        self.assertFalse(degenerate([[0,0],[10,10],[0,10],[10,0]],'Closed'))
        self.assertTrue(degenerate([[0,0],[1,0],[2,0]],'Closed'))
    def test_stats_independently_count_raw_points(self):
        c=copy.deepcopy(self.case);c.update(paths=[[],[[0,0],[0,0],[10,0],[0,10],[0,0]]],mode='Closed')
        self.assertEqual(statistics(c,[[],[[0,0],[10,0],[0,10]]]),dict(removed_vertices=2,removed_per_path=[0,2],input_degenerate_indices=[0],degenerate_indices=[0],collapsed_indices=[]))
    def test_order_comparator_rejects_rotation_reverse_and_path_swap(self):
        v=next(v for _,c,_,v in self.records if c['source']['group']=='rectangle' and c['mode']=='Closed')
        for transform in (lambda p:p[1:]+p[:1],lambda p:p[::-1]):
            r=copy.deepcopy(v);r['paths'][0]=transform(r['paths'][0])
            with self.assertRaises(Invalid):compare(v,r)
        v=next(v for _,c,_,v in self.records if c['source']['group']=='mixed' and c['operation']=='Simplify64')
        r=copy.deepcopy(v);r['paths'][0],r['paths'][1]=r['paths'][1],r['paths'][0]
        with self.assertRaises(Invalid):compare(v,r)
    def test_degenerate_output_accepted(self):
        self.assertTrue(any(len(p)<3 for _,_,_,v in self.records for p in v['paths']))
        for _,_,_,v in self.records:validate_simplify_geometry(v)
    def test_metadata_and_provenance_rejected(self):
        _,c,d,v=self.records[0]
        for k,x in [('input_sha256','0'*64),('oracle_commit','bad'),('adapter_protocol_version',True),('precision',True),('mode','Closed' if c['mode']=='Open' else 'Open')]:
            r=copy.deepcopy(v);r[k]=x
            with self.assertRaises(Invalid):validate_result(r,c,d,self.lock,'bad')
    def test_bad_totals_and_bool_counts_rejected(self):
        _,c,d,v=self.records[0]
        for field,value in [('removed_vertices',v['removed_vertices']+1),('removed_vertices',True),('removed_per_path',[True])]:
            r=copy.deepcopy(v);r[field]=value
            with self.assertRaises(Invalid):validate_result(r,c,d,self.lock,'bad')
    def test_wrong_missing_unordered_degeneracy_rejected(self):
        _,c,d,v=next(r for r in self.records if len(r[3]['degenerate_indices'])>1)
        for field,value in [('degenerate_indices',[]),('input_degenerate_indices',[0,0]),('collapsed_indices',[999]),('degenerate_indices',v['degenerate_indices'][::-1])]:
            r=copy.deepcopy(v);r[field]=value
            with self.assertRaises(Invalid):validate_result(r,c,d,self.lock,'bad')
    def test_decimal_decoded_small_drift_and_negative_zero_rejected(self):
        v=next(v for _,c,_,v in self.records if c['operation']=='SimplifyD' and v['paths'] and v['paths'][0])
        r=copy.deepcopy(v);r['paths_d'][0][0][0]+=1e-10
        with self.assertRaises(Invalid):validate_simplify_geometry(r)
        r=copy.deepcopy(v);r['paths'][0][0][0]=0;r['paths_d'][0][0][0]=-0.0
        with self.assertRaises(Invalid):validate_simplify_geometry(r)
    def test_report_all_routes_and_capabilities(self):
        r=self.report();self.assertEqual((r['executed'],r['passed'],r['differences'],r['execution_errors']),(224,224,0,0))
        self.assertEqual({k:v['passed'] for k,v in r['routes'].items()},{'Integer':80,'DecimalGrid':144})
        for k in ('ordered_paths','removed_counts','degeneracy'):self.assertEqual(r[k]['passed'],224)
    def test_report_missing_duplicate_extra_hash_rejected(self):
        for data in (self.good[:-1],self.good+[self.good[0]],self.good+[dict(case_id='extra')]):
            with self.assertRaises(Invalid):self.report(data)
        data=copy.deepcopy(self.good);data[0]['input_sha256']='0'*64
        with self.assertRaises(Invalid):self.report(data)
    def test_report_ordered_geometry_difference(self):
        data=copy.deepcopy(self.good);i=next(i for i,r in enumerate(data) if r['operation']=='Simplify64' and len(r['paths'][0])>=3)
        p=data[i]['paths'][0];data[i]['paths'][0]=p[1:]+p[:1]
        r=self.report(data);self.assertEqual(r['ordered_paths']['differences'],1);self.assertEqual(r['removed_counts']['differences'],0);self.assertEqual(r['execution_errors'],0)
    def test_report_removed_count_difference(self):
        data=copy.deepcopy(self.good);data[0]['removed_per_path'][0]+=1;data[0]['removed_vertices']+=1
        r=self.report(data);self.assertEqual(r['removed_counts']['differences'],1);self.assertEqual(r['ordered_paths']['differences'],0);self.assertEqual(r['execution_errors'],0)
    def test_report_degeneracy_difference(self):
        data=copy.deepcopy(self.good);i=next(i for i,r in enumerate(data) if r['degenerate_indices']);data[i]['degenerate_indices']=[]
        r=self.report(data);self.assertEqual(r['degeneracy']['differences'],1);self.assertEqual(r['ordered_paths']['differences'],0);self.assertEqual(r['execution_errors'],0)
    def test_report_execution_error_is_separate(self):
        data=copy.deepcopy(self.good);data[0]={k:data[0][k] for k in ('case_id','input_sha256')};data[0].update(status='error',error='budget exhausted')
        r=self.report(data);self.assertEqual((r['execution_errors'],r['differences']),(1,0))
    def test_report_rejects_metadata_and_success_extras(self):
        for k,v in [('mode','Unknown'),('format_version',True),('unexpected',0)]:
            data=copy.deepcopy(self.good);data[0][k]=v
            with self.assertRaises(Invalid):self.report(data)
    def test_evidence_exact_marker_counts(self):
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory);self.assertEqual(simplify_evidence(root)['native']['status'],'not_recorded')
            p=root/'simplify-native.log';p.write_text('Selection: reference simplify paths: *\nTotal tests: 224, passed: 224, failed: 0.\n')
            self.assertEqual(simplify_evidence(root)['native']['passed'],224)
            for text in ('Total tests: 224, passed: 224, failed: 0.\n','Selection: reference simplify paths: *\nTotal tests: 220, passed: 220, failed: 0.\n','Selection: reference simplify paths: *\nTotal tests: 224, passed: 223, failed: 1.\n'):
                p.write_text(text)
                with self.assertRaises(Invalid):simplify_evidence(root)
    def test_generated_runner_links_only_inputs(self):
        from generate_simplify import generated
        r=generated()['cmd/conformance/simplify_cases.mbt'];self.assertIn('@moonclip.simplify_paths(',r);self.assertIn('@moonclip.simplify_paths_d(',r)
        for field in ('expected/','removed_vertices','degenerate_indices'):self.assertNotIn(field,r)
    def test_generation_routes_and_mixed_rejection(self):
        spec=importlib.util.spec_from_file_location('simplify_generate',ROOT/'tools/oracle/generate.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
        self.assertEqual(m.expected_directory(self.records),'testdata/simplify/expected')
        for op in ('Union','OffsetPolygons','StrokeD','Composition'):
            with self.assertRaises(Invalid):m.expected_directory([self.records[0],(None,dict(operation=op),None,None)])
    def test_manifest_and_selection_unlisted_or_missing_files(self):
        from unittest.mock import patch
        import simplify_compare as module
        original=module.load
        def changed(path,strict=True):
            v=original(path,strict)
            if str(path).endswith('simplify-selection.json'):v['case_ids']=v['case_ids'][:-1]
            return v
        with patch.object(module,'load',side_effect=changed):
            with self.assertRaises(Invalid):module.simplify_selection(ROOT)
