import copy
import tempfile
import unittest
from pathlib import Path
from unittest import mock
from compare import Invalid, load, sha256
import selection
from selection import ROOT, selections
from generate_boolean import generated, runner, call, formatted
from run_report import evaluate
from evidence import internal_evidence

class SelectionTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.records,cls.public,cls.internal=selections(ROOT/'testdata/manifest.json')
        cls.good=[{'case_id':e['case_id'],'input_sha256':digest,'status':'success','paths':expected['paths']} for e,c,digest,expected in cls.public]
    def changed_selection(self,change):
        data=load(ROOT/'testdata/boolean-selection.json',True);change(data)
        real=selection.load
        with mock.patch.object(selection,'load',side_effect=lambda path,strict: data if path.name=='boolean-selection.json' else real(path,strict)):
            with self.assertRaises(Invalid):selections(ROOT/'testdata/manifest.json')
    def test_selection_counts_and_entrypoints(self):
        self.assertEqual((len(self.records),len(self.public),len(self.internal)),(200,152,48))
        self.assertEqual({rule:sum(c['fill_rule']==rule for _,c,_,_ in self.records) for rule in selection.COUNTS},selection.COUNTS)
    def test_original_evenodd_baseline_is_subset(self):
        baseline=load(ROOT/'testdata/evenodd-selection.json',True)
        self.assertEqual(len(baseline['case_ids']),60)
        self.assertTrue(set(baseline['case_ids'])<={e['case_id'] for e,c,_,_ in self.public if c['fill_rule']=='EvenOdd'})
    def test_negative_group_name_does_not_select_private_rule(self):
        selected=[c['fill_rule'] for e,c,_,_ in self.public if e['case_id'].startswith('negative_collinear_')]
        self.assertEqual(sorted(selected),['EvenOdd']*4+['NonZero']*4)
    def test_missing_selected_id_rejected(self):
        self.changed_selection(lambda d:d['rules']['NonZero']['case_ids'].pop())
    def test_duplicate_selected_id_rejected(self):
        self.changed_selection(lambda d:d['rules']['Positive']['case_ids'].append(d['rules']['Positive']['case_ids'][0]))
    def test_extra_selected_id_rejected(self):
        self.changed_selection(lambda d:d['rules']['EvenOdd']['case_ids'].append('extra'))
    def test_internal_cannot_be_labeled_public(self):
        self.changed_selection(lambda d:d['rules']['Positive'].update(entrypoint='public'))
    def test_unknown_rule_rejected(self):
        self.changed_selection(lambda d:d['rules'].update(Unknown={}))
    def test_unknown_selection_header_rejected(self):
        self.changed_selection(lambda d:d.update(total=201))
    def test_internal_case_in_public_actual_results_rejected(self):
        e,c,digest,expected=self.internal[0]
        extra={'case_id':e['case_id'],'input_sha256':digest,'status':'success','paths':expected['paths']}
        with self.assertRaises(Invalid):evaluate(ROOT/'testdata/manifest.json',self.good+[extra])
    def test_evenodd_substitution_is_detected_for_nonzero(self):
        values=copy.deepcopy(self.good)
        by_id={e['case_id']:expected for e,c,digest,expected in self.records}
        cid='winding_overlap_union_nonzero'
        result=next(r for r in values if r['case_id']==cid)
        result['paths']=by_id['winding_overlap_union_evenodd']['paths']
        report=evaluate(ROOT/'testdata/manifest.json',values)
        self.assertEqual((report['required'],report['differences'],report['passed']),(152,1,151))
    def test_generator_explicitly_passes_all_public_rules(self):
        files=generated();text=files['conformance/cases_test.mbt']
        self.assertEqual(text.count('fill_rule=@moonclip.NonZero'),76)
        self.assertEqual(text.count('fill_rule=@moonclip.EvenOdd'),76)
        self.assertEqual(files['boolean_reference_wbtest.mbt'].count('test "reference internal paths:'),48)
    def test_native_runner_has_no_reference_geometry_dependency(self):
        changed=[(e,c,digest,{'paths':'poison: expected geometry must never be read'}) for e,c,digest,_ in self.public]
        self.assertEqual(runner(changed),runner(self.public))
        self.assertNotIn('canonical_paths',runner(self.public))
        self.assertNotIn('Positive',runner(self.public))
        self.assertNotIn('Negative',runner(self.public))
    def test_generated_hashes_and_files_match_current_input(self):
        for e,c,digest,_ in self.records:self.assertEqual(digest,sha256((ROOT/e['input']).read_bytes()))
        for name,text in generated().items():self.assertEqual(formatted(text),(ROOT/name).read_bytes(),name)
    def test_absent_internal_execution_is_not_counted_as_passed(self):
        with tempfile.TemporaryDirectory() as temp:
            self.assertEqual(internal_evidence(Path(temp)),{'native':{'status':'not_recorded'},'js':{'status':'not_recorded'}})
    def test_zero_or_failed_internal_execution_rejected(self):
        with tempfile.TemporaryDirectory() as temp:
            p=Path(temp)/'internal-native.log'
            for summary in ('Total tests: 0, passed: 0, failed: 0.','Total tests: 48, passed: 47, failed: 1.','Total tests: 47, passed: 47, failed: 0.'):
                p.write_text(summary,encoding='utf-8')
                with self.assertRaises(Invalid):internal_evidence(Path(temp))
    def test_successful_internal_execution_is_recorded_per_target(self):
        with tempfile.TemporaryDirectory() as temp:
            for target in ('native','js'):(Path(temp)/('internal-'+target+'.log')).write_text('Total tests: 48, passed: 48, failed: 0.',encoding='utf-8')
            evidence=internal_evidence(Path(temp))
            for target in ('native','js'):self.assertEqual((evidence[target]['executed'],evidence[target]['passed'],evidence[target]['failed']),(48,48,0))
