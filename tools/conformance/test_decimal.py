# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Decimal schemas, exact decoded geometry, provenance, evidence and reporting."""
import copy
import importlib.util
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch
from contextlib import redirect_stdout
from io import StringIO
from collections import Counter
from compare import Invalid,canonical_bytes,compare,load,validate_input,validate_result,sha256
from decimal_compare import (decimal_selection,validate_decimal_geometry,quantized_inputs,
                             round_grid,SCALES)
from run_report import ROOT,evaluate_decimal
from evidence import decimal_evidence

class DecimalTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.lock,cls.records=decimal_selection(ROOT)
        cls.case=next(c for _,c,_,_ in cls.records if c['case_id']=='decimal_boolean_overlap_union_nonzero_p3')
        cls.good=[{k:v[k] for k in ('case_id','input_sha256','format_version','operation','reference_route','precision','status','grid_paths','paths')} for _,c,_,v in cls.records]
    def invalid(self,c):
        with self.assertRaises(Invalid):validate_input(c,'decimal')
    def test_220_unique_with_196_and_24_routes(self):
        self.assertEqual(len(self.records),220)
        self.assertEqual(Counter(c['reference_route'] for _,c,_,_ in self.records),{'DecimalGrid':196,'ClipperDCommonGrid':24})
    def test_boolean_complete_precision_operation_fill_matrix(self):
        cases=[c for _,c,_,_ in self.records if c['operation']=='BooleanD' and c['reference_route']=='DecimalGrid']
        self.assertEqual(Counter((c['clip_type'],c['fill_rule'],c['precision']) for c in cases),{(o,f,p):2 for o in ('Intersection','Union','Difference','Xor') for f in ('EvenOdd','NonZero') for p in range(7)})
    def test_offset_stroke_complete_styles_and_precision_matrix(self):
        for operation,count,fields in [('OffsetD',48,('join_type','fill_rule','precision')),('StrokeD',36,('join_type','cap_type','precision'))]:
            cases=[c for _,c,_,_ in self.records if c['operation']==operation]
            self.assertEqual(len(cases),count);self.assertEqual({c['precision'] for c in cases},{0,3,6})
            self.assertEqual({c['join_type'] for c in cases},{'Miter','Bevel','Square','Round'})
            if operation=='OffsetD':self.assertEqual(Counter((c['join_type'],c['fill_rule'],c['precision']) for c in cases),{(j,f,p):2 for j in ('Miter','Bevel','Square','Round') for f in ('EvenOdd','NonZero') for p in (0,3,6)})
            else:self.assertEqual(len({tuple(c[k] for k in fields) for c in cases}),36)
    def test_version_precision_and_unknown_grid(self):
        for field,values in [('format_version',(True,5.0,4)),('precision',(-1,7,True,3.0,'3')),('grid',('Binary','Approximate',None))]:
            for v in values:c=copy.deepcopy(self.case);c[field]=v;self.invalid(c)
    def test_missing_and_extra_fields_rejected(self):
        for k in self.case:
            c=copy.deepcopy(self.case);del c[k];self.invalid(c)
        c=copy.deepcopy(self.case);c['unexpected']=True;self.invalid(c)
    def test_unknown_route_and_nonboolean_clipperd_rejected(self):
        c=copy.deepcopy(self.case);c['reference_route']='Unspecified';self.invalid(c)
        c=copy.deepcopy(next(c for _,c,_,_ in self.records if c['operation']=='StrokeD'));c['reference_route']='ClipperDCommonGrid';self.invalid(c)
    def test_half_ties_and_immediate_neighbours(self):
        for value,expected in [(0.49999999999999994,0),(0.5,1),(0.5000000000000001,1),(-0.49999999999999994,0),(-0.5,-1),(-0.5000000000000001,-1)]:self.assertEqual(round_grid(value),expected)
    def test_coordinate_numeric_types_and_nonfinite(self):
        for v in (True,None,'1',float('inf'),float('nan')):
            c=copy.deepcopy(self.case);c['subject'][0][0][0]=v;self.invalid(c)
    def test_all_precision_bounds_reject_before_rounding(self):
        import math
        for p,scale in enumerate(SCALES):
            c=copy.deepcopy(self.case);c['precision']=p;c['subject'][0][0][0]=math.nextafter(1000000000/scale,math.inf);self.invalid(c)
    def test_merges_across_paths_and_operands_are_rejected(self):
        c=copy.deepcopy(self.case);c['subject']=[[[0,0],[1,0],[0,1]]];c['clip']=[[[0.0001,0],[2,0],[2,1]]];self.invalid(c)
        c['subject']+=c.pop('clip');c['clip']=[];self.invalid(c)
    def test_original_duplicates_allowed_but_closed_degeneracy_rejected(self):
        c=copy.deepcopy(self.case);p=c['subject'][0];p.insert(1,p[0]);p.append(p[0]);validate_input(c,'duplicates')
        c['subject']=[[[0,0],[1,0.0001],[2,0]]];self.invalid(c)
    def test_common_grid_input_is_on_binary_and_decimal_grids(self):
        c=copy.deepcopy(self.case);c['reference_route']='ClipperDCommonGrid';c['subject'][0][0][0]=0.1;self.invalid(c)
        for _,c,_,v in self.records:
            if c['reference_route']=='ClipperDCommonGrid':validate_input(c,'common');validate_decimal_geometry(v)
    def test_numeric_options_and_scaled_overflow_rejected(self):
        original=next(c for _,c,_,_ in self.records if c['operation']=='OffsetD' and c['precision']==6)
        for field,value in [('delta',True),('delta',1e308),('arc_tolerance',-1),('arc_tolerance',1e308),('miter_limit',1),('join_type','Unknown')]:
            c=copy.deepcopy(original);c[field]=value;self.invalid(c)
    def test_full_grid_orientation_and_multiplicity_comparison(self):
        v=next(v for _,c,_,v in self.records if c['case_id']==self.case['case_id'])
        for kind in ('reverse','duplicate','coordinate'):
            changed=copy.deepcopy(v)
            if kind=='reverse':changed['grid_paths'][0].reverse();changed['paths'][0].reverse()
            elif kind=='duplicate':changed['grid_paths']*=2;changed['paths']*=2
            else:
                changed['grid_paths'][0][0][0]+=1;changed['paths'][0][0][0]=changed['grid_paths'][0][0][0]/1000
            with self.assertRaises(Invalid):compare(v,changed,'decimal')
    def test_sub_half_grid_decimal_perturbation_cannot_hide(self):
        v=next(v for _,c,_,v in self.records if c['case_id']==self.case['case_id']);changed=copy.deepcopy(v);changed['paths'][0][0][0]+=0.0001
        self.assertEqual(round_grid(changed['paths'][0][0][0]*1000),changed['grid_paths'][0][0][0])
        with self.assertRaises(Invalid):compare(v,changed,'decoded')
    def test_negative_zero_output_is_rejected(self):
        v=copy.deepcopy(next(v for _,c,_,v in self.records if c['reference_route']=='ClipperDCommonGrid'))
        # A self-consistent zero coordinate still must have the positive sign bit.
        v['grid_paths'][0][0][0]=0;v['paths'][0][0][0]=-0.0
        with self.assertRaises(Invalid):validate_decimal_geometry(v)
    def test_invalid_output_numeric_types_and_nonfinite_rejected(self):
        v=next(v for _,c,_,v in self.records if c['case_id']==self.case['case_id'])
        for number in (True,'1',None,float('inf'),float('nan')):
            changed=copy.deepcopy(v);changed['paths'][0][0][0]=number
            with self.assertRaises(Invalid):validate_decimal_geometry(changed)
    def test_result_provenance_and_exact_metrics(self):
        e,c,d,v=self.records[0];validate_result(v,c,d,self.lock,'case')
        for field,value in [('input_sha256','0'*64),('adapter_protocol_version',True),('oracle_commit','0'*40),('precision',True)]:
            changed=copy.deepcopy(v);changed[field]=value
            with self.assertRaises(Invalid):validate_result(changed,c,d,self.lock,'result')
        changed=copy.deepcopy(v);changed['metrics']['grid']['path_count']=True
        with self.assertRaises(Invalid):validate_result(changed,c,d,self.lock,'metrics')
    def test_report_all_220_routes_and_operation_coverage(self):
        r=evaluate_decimal(ROOT/'testdata/decimal-manifest.json',self.good)
        self.assertEqual((r['required'],r['executed'],r['passed'],r['differences'],r['execution_errors']),(220,220,220,0,0))
        self.assertEqual(r['routes']['DecimalGrid']['passed'],196);self.assertEqual(r['routes']['ClipperDCommonGrid']['passed'],24)
        self.assertEqual(r['operations']['BooleanD']['count'],136)
        self.assertEqual(r['parameters']['clip_type'],dict.fromkeys(('Intersection','Union','Difference','Xor'),34))
        self.assertEqual(sum(r['parameters']['fill_rule'].values()),184)
    def test_report_missing_duplicate_and_extra_rejected(self):
        for results in (self.good[:-1],self.good+[self.good[0]],self.good+[dict(self.good[0],case_id='extra')]):
            with self.assertRaises(Invalid):evaluate_decimal(ROOT/'testdata/decimal-manifest.json',results)
    def test_report_stale_hash_rejected(self):
        data=copy.deepcopy(self.good);data[0]['input_sha256']='0'*64
        with self.assertRaises(Invalid):evaluate_decimal(ROOT/'testdata/decimal-manifest.json',data)
    def test_report_execution_error_is_never_empty_success(self):
        data=copy.deepcopy(self.good);original=data[0];data[0]={k:original[k] for k in ('case_id','input_sha256')};data[0].update(status='error',error='quantization failed')
        r=evaluate_decimal(ROOT/'testdata/decimal-manifest.json',data)
        self.assertEqual(r['execution_errors'],1);self.assertEqual(r['cases'][0]['grid_paths'],'execution_error')
    def test_report_decoded_error_is_independent_of_matching_grid(self):
        data=copy.deepcopy(self.good);data[0]['paths'][0][0][0]+=0.0000001
        r=evaluate_decimal(ROOT/'testdata/decimal-manifest.json',data)
        self.assertEqual(r['grid_paths']['passed'],220);self.assertEqual(r['decoded']['differences'],1);self.assertEqual(r['differences'],1)
    def test_evidence_requires_unique_marker_and_220(self):
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'decimal-native.log';valid='Selection: reference decimal paths: *\nTotal tests: 220, passed: 220, failed: 0.\n';p.write_text(valid,encoding='utf-8')
            self.assertEqual(decimal_evidence(Path(d))['native']['passed'],220)
            for text in (valid.replace('220','219'),valid+valid,valid.split('\n',1)[1]):
                p.write_text(text,encoding='utf-8')
                with self.assertRaises(Invalid):decimal_evidence(Path(d))
    def test_selection_missing_duplicate_extra_and_count_rejected(self):
        v=load(ROOT/'testdata/decimal-selection.json',True)
        with tempfile.TemporaryDirectory() as d:
            root=Path(d);(root/'testdata').mkdir()
            for kind in ('missing','duplicate','extra','count'):
                changed=copy.deepcopy(v)
                if kind=='missing':changed['case_ids'].pop()
                elif kind=='duplicate':changed['case_ids'][0]=changed['case_ids'][1]
                elif kind=='extra':changed['case_ids'][0]='extra'
                else:changed['expected_count']=221
                (root/'testdata/decimal-selection.json').write_bytes(canonical_bytes(changed))
                with patch('decimal_compare.read_decimal_manifest',return_value=(self.lock,self.records)):
                    with self.assertRaises(Invalid):decimal_selection(root)
    def test_generator_runtime_has_real_calls_not_expectations(self):
        from generate_decimal import generated
        runner=generated()['cmd/conformance/decimal_cases.mbt']
        for function in ('boolean_op_d','offset_polygons_d','stroke_polyline_d'):self.assertIn('@moonclip.'+function+'(',runner)
        self.assertNotIn('expected/',runner);self.assertNotIn('grid_paths',runner)
    def oracle_module(self):
        spec=importlib.util.spec_from_file_location('decimal_generation',ROOT/'tools/oracle/generate.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m
    def test_generation_explicit_directory_and_mixed_rejection(self):
        m=self.oracle_module();self.assertEqual(m.expected_directory([(None,c,None,None) for _,c,_,_ in self.records]),'testdata/decimal/expected')
        for ops in (['Unknown'],['BooleanD','Union'],['StrokeD','Composition']):
            with self.assertRaises(Invalid):m.expected_directory([(None,dict(operation=o),None,None) for o in ops])
    def test_decimal_publication_cannot_overwrite_old_categories(self):
        m=self.oracle_module()
        with tempfile.TemporaryDirectory() as d:
            root=Path(d)
            for name in ('upstream','offset','stroke','composition'):
                p=root/f'testdata/{name}/expected';p.mkdir(parents=True);(p/'sentinel').write_bytes(b'unchanged')
            cid=self.case['case_id'];ip=f'testdata/decimal/inputs/{cid}.json';p=root/ip;p.parent.mkdir(parents=True);p.write_bytes(canonical_bytes(self.case));digest=sha256(p.read_bytes())
            response=dict(format_version=5,adapter_protocol_version=5,case_id=cid,oracle_commit=self.lock['commit'],status='success',operation='BooleanD',precision=3,reference_route='DecimalGrid',grid_paths=[],paths=[])
            command=[sys.executable,'-c','import sys;sys.stdin.buffer.read();print('+repr(canonical_bytes(response).decode())+')']
            with patch.object(m,'read_manifest',return_value=(self.lock,[({'input':ip},self.case,digest,None)])),redirect_stdout(StringIO()):self.assertEqual(m.generate(root,root/'manifest.json','write',command),1)
            self.assertTrue((root/f'testdata/decimal/expected/{cid}.json').exists())
            for name in ('upstream','offset','stroke','composition'):self.assertEqual((root/f'testdata/{name}/expected/sentinel').read_bytes(),b'unchanged')
    def test_report_rejects_route_and_precision_mismatch(self):
        for field,value in [('reference_route','ClipperDCommonGrid'),('precision',6),('operation','OffsetD')]:
            data=copy.deepcopy(self.good);data[0][field]=value
            with self.assertRaises(Invalid):evaluate_decimal(ROOT/'testdata/decimal-manifest.json',data)
    def test_empty_strokes_are_real_reference_results(self):
        empty=[v for _,c,_,v in self.records if c['operation']=='StrokeD' and c['precision']==0]
        self.assertEqual(len(empty),12);self.assertTrue(all(v['paths']==v['grid_paths']==[] for v in empty))
