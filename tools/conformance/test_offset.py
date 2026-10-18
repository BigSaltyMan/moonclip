# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Offset v2 schema, strict report and actual execution evidence regressions."""
import copy
from pathlib import Path
import tempfile
import unittest
from compare import Invalid, canonical_bytes, compare, load, normalize_paths, validate_input, validate_result
from offset_compare import offset_selection, validate_offset_input
from run_report import ROOT, evaluate_offset, markdown
from evidence import offset_evidence

class OffsetTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.lock,cls.records=offset_selection(ROOT)
        cls.case=cls.records[0][1]
        cls.good=[{'case_id':e['case_id'],'input_sha256':digest,'status':'success','paths':expected['paths']} for e,c,digest,expected in cls.records]
    def reject_input(self,field,value):
        case=copy.deepcopy(self.case);case[field]=value
        with self.assertRaises(Invalid):validate_input(case,'offset')
    def test_locked_selection_is_exactly_272_unique_inputs(self):
        self.assertEqual(len(self.records),272)
        self.assertEqual(len({c['case_id'] for _,c,_,_ in self.records}),272)
    def test_old_boolean_protocol_remains_v1(self):
        c=load(ROOT/'testdata/upstream/inputs/overlap_union_evenodd.json',True)
        validate_input(c,'boolean');self.assertEqual(c['format_version'],1)
        self.assertEqual(self.lock['adapter_protocol_version'],1)
    def test_offset_version_is_operation_specific(self):
        for value in (1,True,2.0,'2',3):self.reject_input('format_version',value)
    def test_unknown_and_future_joins_rejected(self):
        for value in ('Unknown','round','square',True,None):self.reject_input('join_type',value)
    def test_invalid_numeric_tokens_rejected(self):
        for field in ('delta','miter_limit'):
            for value in (True,False,'2',None,[],{},float('nan'),float('inf'),float('-inf')):
                self.reject_input(field,value)
    def test_minimum_miter_and_finite_fractional_delta(self):
        case=copy.deepcopy(self.case);case.update(miter_limit=2,delta=-0.5)
        validate_offset_input(case,'offset')
        self.reject_input('miter_limit',1.999)
    def test_private_fill_rules_not_offset_public_capability(self):
        for value in ('Positive','Negative','Unknown',True):self.reject_input('fill_rule',value)
    def test_options_are_fixed_and_explicit(self):
        for value in ({},{'preserve_collinear':True,'reverse_solution':False},{'preserve_collinear':0,'reverse_solution':False}):self.reject_input('options',value)
    def test_offset_results_have_no_tree_or_tree_metrics(self):
        for entry,case,digest,expected in self.records:
            validate_result(expected,case,digest,self.lock,case['case_id'])
            self.assertNotIn('tree',expected);self.assertNotIn('tree_depth',expected['metrics'])
    def test_expected_hash_and_protocol_checked(self):
        _,case,digest,expected=self.records[0]
        for field,value in (('input_sha256','0'*64),('adapter_protocol_version',1),('format_version',True)):
            changed=copy.deepcopy(expected);changed[field]=value
            with self.assertRaises(Invalid):validate_result(changed,case,digest,self.lock,'offset')
    def test_metrics_are_exact_and_reject_bool_equivalence(self):
        _,case,digest,expected=self.records[0]
        changed=copy.deepcopy(expected);changed['metrics']['path_count']=True
        with self.assertRaises(Invalid):validate_result(changed,case,digest,self.lock,'offset')
    def test_report_executes_exactly_272_full_paths(self):
        report=evaluate_offset(ROOT/'testdata/offset-manifest.json',self.good)
        self.assertEqual((report['executed'],report['passed'],report['differences'],report['execution_errors']),(272,272,0,0))
    def test_report_missing_extra_and_duplicate_results_rejected(self):
        for results in (self.good[:-1],self.good+[self.good[0]],self.good+[dict(self.good[0],case_id='extra')]):
            with self.assertRaises(Invalid):evaluate_offset(ROOT/'testdata/offset-manifest.json',results)
    def test_report_input_hash_cannot_be_stale(self):
        results=copy.deepcopy(self.good);results[0]['input_sha256']='0'*64
        with self.assertRaises(Invalid):evaluate_offset(ROOT/'testdata/offset-manifest.json',results)
    def test_report_error_not_legal_empty_region(self):
        results=copy.deepcopy(self.good);results[0].pop('paths');results[0].update(status='error',error='Offset failed')
        r=evaluate_offset(ROOT/'testdata/offset-manifest.json',results)
        self.assertEqual((r['execution_errors'],r['passed']),(1,271))
    def test_report_does_not_accept_reversed_winding(self):
        results=copy.deepcopy(self.good);index=next(i for i,r in enumerate(results) if r['paths']);results[index]['paths'][0].reverse()
        self.assertEqual(evaluate_offset(ROOT/'testdata/offset-manifest.json',results)['differences'],1)
    def test_report_rejects_tree_masquerading_as_offset_capability(self):
        results=copy.deepcopy(self.good);results[0]['tree']={'children':[]}
        with self.assertRaises(Invalid):evaluate_offset(ROOT/'testdata/offset-manifest.json',results)
    def test_comparison_preserves_full_vertices(self):
        expected=next(e for _,_,_,e in self.records if e['paths'])
        actual=copy.deepcopy(expected);actual['paths'][0].insert(1,actual['paths'][0][0])
        with self.assertRaises(Invalid):compare(expected,actual,'offset')
    def test_filtered_evidence_needs_correct_selection_and_count(self):
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'offset-native.log'
            p.write_text('Selection: reference offset paths: *\nTotal tests: 272, passed: 272, failed: 0.\n',encoding='utf-8')
            self.assertEqual(offset_evidence(Path(d))['native']['passed'],272)
            for text in ('Total tests: 272, passed: 272, failed: 0.','Selection: reference offset paths: *\nTotal tests: 271, passed: 271, failed: 0.'):
                p.write_text(text,encoding='utf-8')
                with self.assertRaises(Invalid):offset_evidence(Path(d))
    def test_old_boolean_logs_cannot_establish_offset_execution(self):
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'offset-js.log';p.write_text('Selection: reference tree: *\nTotal tests: 272, passed: 272, failed: 0.\n',encoding='utf-8')
            with self.assertRaises(Invalid):offset_evidence(Path(d))

    def test_optional_arc_tolerance_preserves_old_request(self):
        case=copy.deepcopy(self.case);case.pop('arc_tolerance',None)
        validate_offset_input(case,'offset')
        case['arc_tolerance']=0.0;validate_offset_input(case,'offset')

    def test_all_four_joins_are_accepted(self):
        for join in ('Miter','Bevel','Square','Round'):
            case=copy.deepcopy(self.case);case['join_type']=join;validate_offset_input(case,'offset')

    def test_arc_tolerance_rejects_invalid_types_and_values(self):
        for malformed in (None,True,False,[],"invalid"):
            with self.assertRaises(Invalid):validate_offset_input(malformed,'offset')
        for value in (True,False,'0.25',None,[],{},-0.01,float('nan'),float('inf'),float('-inf')):
            self.reject_input('arc_tolerance',value)

    def test_arc_tolerance_accepts_zero_tiny_and_large(self):
        for value in (0,-0.0,1e-20,1e-12,0.05,0.25,1.0,1e300):
            case=copy.deepcopy(self.case);case['arc_tolerance']=value;validate_offset_input(case,'offset')

    def test_new_protocol_field_does_not_allow_unknown_fields(self):
        case=copy.deepcopy(self.case);case['arc_tolerance']=0.25;case['arctolerance']=0.25
        with self.assertRaises(Invalid):validate_offset_input(case,'offset')

    def test_retained_and_join_batches_are_disjoint_and_complete(self):
        old=load(ROOT/'testdata/offset-selection.json',True)
        new=load(ROOT/'testdata/offset-join-selection.json',True)
        self.assertEqual((len(old['case_ids']),len(new['case_ids'])),(116,156))
        self.assertFalse(set(old['case_ids'])&set(new['case_ids']))
        self.assertEqual(set(old['case_ids'])|set(new['case_ids']),{c['case_id'] for _,c,_,_ in self.records})
        records={c['case_id']:c for _,c,_,_ in self.records}
        self.assertTrue(all('arc_tolerance' not in records[cid] for cid in old['case_ids']))

    def test_selection_reader_rejects_overlap_duplicates_and_incomplete_union(self):
        from offset_compare import validate_offset_selections
        old=load(ROOT/'testdata/offset-selection.json',True);new=load(ROOT/'testdata/offset-join-selection.json',True)
        with tempfile.TemporaryDirectory() as d:
            root=Path(d);(root/'testdata').mkdir()
            (root/'testdata/offset-selection.json').write_bytes(canonical_bytes(old))
            for mutation in ('overlap','duplicate','missing','count'):
                changed=copy.deepcopy(new)
                if mutation=='overlap':changed['case_ids'][0]=old['case_ids'][0];changed['case_ids'].sort()
                elif mutation=='duplicate':changed['case_ids'][0]=changed['case_ids'][1]
                elif mutation=='missing':changed['case_ids'][0]='nonexistent';changed['case_ids'].sort()
                else:changed['expected_count']=155
                (root/'testdata/offset-join-selection.json').write_bytes(canonical_bytes(changed))
                with self.assertRaises(Invalid):validate_offset_selections(root,self.records)

    def test_tolerance_generator_forwards_exact_input_and_default(self):
        from generate_offset import call
        case=copy.deepcopy(self.case);case['arc_tolerance']=0.25
        self.assertIn('arc_tolerance=0.25',call(case))
        case.pop('arc_tolerance');self.assertIn('arc_tolerance=0.0',call(case))

    def test_explicit_tolerance_matrix_is_locked_48_cases(self):
        records=[c for _,c,_,_ in self.records if 'arc_tolerance' in c]
        self.assertEqual(len(records),48)
        self.assertEqual({c['arc_tolerance'] for c in records},{0.05,0.25,1.0})
        self.assertEqual({c['delta'] for c in records},{-10.0,10.0})
        self.assertEqual({c['source']['group'] for c in records},{'arc_rectangle','arc_acute','arc_hole','arc_neck'})

    def test_strict_round_comparison_does_not_merge_nearby_grid_points(self):
        e=next(e for _,c,_,e in self.records if c['join_type']=='Round' and e['paths'])
        actual=copy.deepcopy(e);actual['paths'][0][0][0]+=1
        with self.assertRaises(Invalid):compare(e,actual,'round')
