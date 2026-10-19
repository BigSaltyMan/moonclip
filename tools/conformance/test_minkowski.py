# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Complete Minkowski contours, strict provenance, settings and separate evidence."""
import copy
import importlib.util
from pathlib import Path
import tempfile
import unittest
from collections import Counter
from compare import Invalid,load,validate_input,validate_result,canonical_bytes,compare
from minkowski_compare import *
from run_report import ROOT,evaluate_minkowski,markdown
from evidence import minkowski_evidence

class MinkowskiTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.lock,cls.records=minkowski_selection(ROOT)
        cls.case=copy.deepcopy(cls.records[0][1])
        cls.good=[{k:v for k,v in expected.items() if k not in ('oracle_commit','adapter_protocol_version','metrics')} for _,_,_,expected in cls.records]
    def invalid(self,c):
        with self.assertRaises(Invalid):validate_input(c,'minkowski')
    def report(self,data=None):return evaluate_minkowski(ROOT/'testdata/minkowski-manifest.json',self.good if data is None else data)
    def test_144_complete_matrix(self):
        self.assertEqual(len(self.records),144)
        self.assertEqual(Counter((c['source']['group'].split(':')[0],c['source']['group'].split(':')[1],c['path_is_closed'],c['source']['group'].split(':')[2]) for _,c,_,_ in self.records),{(p,r,m,d):1 for p in PATTERNS for r in ROUTES for m in (False,True) for d in ('forward','reverse')})
    def test_directions_are_real_distinct_inputs(self):
        indexed={(c['source']['group'],c['path_is_closed']):c for _,c,_,_ in self.records}
        for _,c,_,_ in self.records:
            p,r,d=c['source']['group'].split(':')
            other=indexed[(p+':'+r+':'+('reverse' if d=='forward' else 'forward'),c['path_is_closed'])]
            self.assertEqual(c['path'],other['path'][::-1]);self.assertNotEqual(c['path'],other['path'])
    def test_missing_extra_fields(self):
        for k in self.case:
            c=copy.deepcopy(self.case);del c[k];self.invalid(c)
        c=copy.deepcopy(self.case);c['epsilon']=1;self.invalid(c)
    def test_operation_version_mode_exact_types(self):
        for k,values in [('operation',('MinkowskiDiff','StrokePolyline',None)),('format_version',(True,7.0,6)),('path_is_closed',(0,1,'true',None))]:
            for x in values:c=copy.deepcopy(self.case);c[k]=x;self.invalid(c)
    def test_output_options_explicit_true_false(self):
        for options in ({},{'preserve_collinear':False,'reverse_solution':False},{'preserve_collinear':1,'reverse_solution':False},{'preserve_collinear':True,'reverse_solution':True}):
            c=copy.deepcopy(self.case);c['options']=options;self.invalid(c)
    def test_source_and_id_contract(self):
        for k,x in [('case_id','-bad'),('source',{}),('source',dict(kind='moonclip_constructed',group='',intent='test'))]:
            c=copy.deepcopy(self.case);c[k]=x;self.invalid(c)
    def test_raw_coordinate_tokens_range(self):
        for x in (True,1.0,'1',None,1000000001,-1000000001,-9223372036854775808):
            c=copy.deepcopy(self.case);c['pattern']=[[x,0]];self.invalid(c)
    def test_combined_raw_budget_before_dedup(self):
        c=copy.deepcopy(self.case);c['pattern']=[[0,0]]*60000;c['path']=[[0,0]]*40001;self.invalid(c)
    def test_generation_products_and_int_representation(self):
        for m,n in [(2147483647,2),(1,600000000)]:
            with self.assertRaises(Invalid):generation_size(m,n,True)
        self.assertEqual(generation_size(0,2147483647,False)[:3],(0,0,0))
    def test_generation_conservative_limit_before_translation(self):
        c=copy.deepcopy(self.case);c['pattern']=[[0,0]]*1000;c['path']=[[0,0]]*1000;self.invalid(c)
    def test_generated_coordinate_range(self):
        for x in (1000000000,-1000000000):
            c=copy.deepcopy(self.case);c['pattern']=[[1 if x>0 else -1,0]];c['path']=[[x,0]];self.invalid(c)
    def test_empty_still_checks_other_operand(self):
        c=copy.deepcopy(self.case);c['pattern']=[];c['path']=[[1000000001,0]];self.invalid(c)
        c['path']=[];validate_input(c,'both empty')
    def test_short_route_is_not_filled_endpoint_pattern(self):
        e=next(v for _,c,_,v in self.records if c['source']['group']=='rectangle:short_horizontal:forward' and not c['path_is_closed'])
        self.assertEqual(len(e['paths']),2)
    def test_closed_route_has_opposite_winding_hole(self):
        from compare import area2
        e=next(v for _,c,_,v in self.records if c['source']['group']=='rectangle:rectangle:forward' and c['path_is_closed'])
        self.assertEqual(len(e['paths']),2);self.assertEqual(sorted(1 if area2(p)>0 else -1 for p in e['paths']),[-1,1])
    def test_full_collinear_vertices_cannot_be_removed(self):
        _,c,d,v=next(r for r in self.records if r[1]['source']['group']=='rectangle:right_angle:forward' and not r[1]['path_is_closed'])
        r=copy.deepcopy(v);p=r['paths'][0]
        for i in range(len(p)):
            a,b,z=p[i-1],p[i],p[(i+1)%len(p)]
            if (b[0]-a[0])*(z[1]-b[1])==(b[1]-a[1])*(z[0]-b[0]):p.pop(i);break
        else:self.fail('reference must contain a collinear vertex')
        with self.assertRaises(Invalid):compare(v,r)
    def test_rotations_allowed_reversal_multiplicity_rejected(self):
        v=next(v for _,_,_,v in self.records if len(v['paths'])==1)
        r=copy.deepcopy(v);p=r['paths'][0];r['paths'][0]=p[1:]+p[:1];compare(v,r)
        r['paths'][0]=r['paths'][0][::-1]
        with self.assertRaises(Invalid):compare(v,r)
        r=copy.deepcopy(v);r['paths'].append(r['paths'][0])
        with self.assertRaises(Invalid):compare(v,r)
    def test_provenance_metrics_and_settings_rejected(self):
        _,c,d,v=self.records[0]
        for k,x in [('input_sha256','0'*64),('oracle_commit','bad'),('adapter_protocol_version',True),('metrics',{}),('fill_rule','EvenOdd'),('options',dict(preserve_collinear=False,reverse_solution=False))]:
            r=copy.deepcopy(v);r[k]=x
            with self.assertRaises(Invalid):validate_result(r,c,d,self.lock,'result')
    def test_report_144_coverage_settings(self):
        r=self.report();self.assertEqual((r['executed'],r['passed'],r['differences'],r['execution_errors']),(144,144,0,0))
        self.assertEqual(r['options'],OPTIONS);self.assertEqual(r['fill_rule'],'NonZero')
        self.assertEqual(r['coverage']['patterns'],{p:36 for p in PATTERNS});self.assertEqual(r['coverage']['routes'],{p:16 for p in ROUTES})
        self.assertEqual(r['coverage']['modes'],{'Open':72,'Closed':72});self.assertEqual(r['coverage']['directions'],{'forward':72,'reverse':72})
    def test_report_missing_duplicate_extra_hash(self):
        for data in (self.good[:-1],self.good+[self.good[0]],self.good+[dict(case_id='extra')]):
            with self.assertRaises(Invalid):self.report(data)
        r=copy.deepcopy(self.good);r[0]['input_sha256']='0'*64
        with self.assertRaises(Invalid):self.report(r)
    def test_report_geometry_difference_separate_error(self):
        r=copy.deepcopy(self.good);r[0]['paths']=[]
        result=self.report(r);self.assertEqual((result['differences'],result['execution_errors']),(1,0))
        r=copy.deepcopy(self.good);r[0]={k:r[0][k] for k in ('case_id','input_sha256')};r[0].update(status='error',error='budget exhausted')
        result=self.report(r);self.assertEqual((result['differences'],result['execution_errors']),(0,1))
    def test_report_rejects_missing_settings_and_wrong_types(self):
        for k,x in [('format_version',True),('operation','Union'),('options',dict(preserve_collinear=1,reverse_solution=False))]:
            r=copy.deepcopy(self.good);r[0][k]=x
            with self.assertRaises(Invalid):self.report(r)
    def test_independent_evidence_marker_count(self):
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory);self.assertEqual(minkowski_evidence(root)['native']['status'],'not_recorded')
            p=root/'minkowski-native.log';p.write_text('Selection: reference minkowski paths: *\nTotal tests: 144, passed: 144, failed: 0.\n')
            self.assertEqual(minkowski_evidence(root)['native']['passed'],144)
            for text in ('Total tests: 144, passed: 144, failed: 0.\n','Selection: reference minkowski paths: *\nTotal tests: 224, passed: 224, failed: 0.\n'):
                p.write_text(text)
                with self.assertRaises(Invalid):minkowski_evidence(root)
    def test_runner_inputs_hashes_only(self):
        from generate_minkowski import generated
        r=generated()['cmd/conformance/minkowski_cases.mbt'];self.assertEqual(r.count('@moonclip.minkowski_sum('),144)
        self.assertNotIn('expected/',r);self.assertNotIn('canonical_paths',r)
    def test_seventh_generation_directory_rejects_mixtures(self):
        spec=importlib.util.spec_from_file_location('minkowski_generation',ROOT/'tools/oracle/generate.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
        self.assertEqual(m.expected_directory(self.records),'testdata/minkowski/expected')
        for op in ('Union','OffsetPolygons','StrokePolyline','Composition','BooleanD','Simplify64'):
            with self.assertRaises(Invalid):m.expected_directory([self.records[0],(None,dict(operation=op),None,None)])
