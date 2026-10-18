import copy
import json
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock
import compare as comparator
from compare import Invalid,load
from run_report import ROOT,evaluate,selected_records
from evidence import internal_evidence,tree_evidence
from generate_boolean import generated,runner

class TreeReportTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        _,cls.selected=selected_records(ROOT/'testdata/manifest.json')
        cls.good=[{'case_id':e['case_id'],'input_sha256':digest,'status':'success','paths':expected['paths'],'tree_result':{'status':'success','tree':expected['tree']}} for e,c,digest,expected in cls.selected]
    def changed(self):
        values=copy.deepcopy(self.good)
        node=next(v for v in values if v['case_id']=='island_union_evenodd')
        return values,node['tree_result']['tree']
    def assert_tree_difference(self,values):
        report=evaluate(ROOT/'testdata/manifest.json',values)
        self.assertEqual((report['paths']['passed'],report['tree']['passed'],report['differences']),(152,151,1))
    def test_flat_identical_but_parentage_changed(self):
        values,tree=self.changed();outer=tree['children'][0];hole=outer['children'].pop();tree['children'].append(hole)
        self.assert_tree_difference(values)
    def test_hole_lifted_to_root_rejected(self):
        values,tree=self.changed();tree['children'].append(tree['children'][0]['children'].pop())
        self.assert_tree_difference(values)
    def test_island_lifted_to_root_rejected(self):
        values,tree=self.changed();tree['children'].append(tree['children'][0]['children'][0]['children'].pop())
        self.assert_tree_difference(values)
    def test_parent_child_reversal_rejected(self):
        values,tree=self.changed();outer=tree['children'][0];hole=outer['children'].pop();hole['children'].append(outer);tree['children']=[hole]
        self.assert_tree_difference(values)
    def test_duplicate_node_rejected(self):
        values,tree=self.changed();tree['children'].append(copy.deepcopy(tree['children'][0]))
        self.assert_tree_difference(values)
    def test_missing_node_rejected(self):
        values,tree=self.changed();tree['children'][0]['children'][0]['children'].clear()
        self.assert_tree_difference(values)
    def test_extra_node_rejected(self):
        values,tree=self.changed();tree['children'].append({'path':[[100,100],[110,100],[110,110]],'children':[]})
        self.assert_tree_difference(values)
    def test_only_sibling_order_is_ignored(self):
        values=copy.deepcopy(self.good);node=next(v for v in values if v['case_id']=='disjoint_union_evenodd');node['tree_result']['tree']['children'].reverse()
        self.assertEqual(evaluate(ROOT/'testdata/manifest.json',values)['passed'],152)
    def test_tree_execution_failure_not_hidden_by_flat_success(self):
        values=copy.deepcopy(self.good);values[0]['tree_result']={'status':'error','error':'Tree resource exhausted'}
        r=evaluate(ROOT/'testdata/manifest.json',values)
        self.assertEqual((r['paths']['passed'],r['tree']['execution_errors'],r['execution_errors']),(152,1,1))
    def test_missing_tree_result_is_rejected(self):
        values=copy.deepcopy(self.good);values[0].pop('tree_result')
        with self.assertRaises(Invalid):evaluate(ROOT/'testdata/manifest.json',values)
    def test_legacy_flat_logs_do_not_establish_tree_execution(self):
        with tempfile.TemporaryDirectory() as tmp:
            directory=Path(tmp)
            for target in ('native','js'):(directory/('internal-'+target+'.log')).write_text('Total tests: 48, passed: 48, failed: 0.',encoding='utf-8')
            self.assertEqual(internal_evidence(directory)['native']['passed'],48)
            self.assertEqual(tree_evidence(directory)['internal']['native']['status'],'not_recorded')
    def test_renamed_flat_log_cannot_impersonate_tree_log(self):
        with tempfile.TemporaryDirectory() as tmp:
            (Path(tmp)/'internal-tree-native.log').write_text('Total tests: 48, passed: 48, failed: 0.',encoding='utf-8')
            with self.assertRaises(Invalid):tree_evidence(Path(tmp))
    def test_filtered_tree_counts_are_separate(self):
        with tempfile.TemporaryDirectory() as tmp:
            directory=Path(tmp)
            for target in ('native','js'):
                for stem,selection,count in [('tree','reference tree: *',152),('internal-tree','reference internal tree: *',48)]:
                    (directory/(stem+'-'+target+'.log')).write_text(f'Selection: {selection}\nTotal tests: {count}, passed: {count}, failed: 0.\n',encoding='utf-8')
            evidence=tree_evidence(directory)
            self.assertEqual(evidence['public']['native']['passed'],152);self.assertEqual(evidence['internal']['js']['passed'],48)
    def test_tree_generator_report_counts_agree(self):
        files=generated()
        self.assertEqual(files['conformance/tree_test.mbt'].count('test "reference tree:'),152)
        self.assertEqual(files['boolean_tree_reference_wbtest.mbt'].count('test "reference internal tree:'),48)
        self.assertEqual(evaluate(ROOT/'testdata/manifest.json',self.good)['tree']['passed'],152)
    def test_tree_winding_still_matters(self):
        values,tree=self.changed();tree['children'][0]['path'].reverse()
        self.assert_tree_difference(values)
    def test_case_level_reference_only_with_validated_capabilities_rejected(self):
        manifest=ROOT/'testdata/manifest.json';data=load(manifest,True);data['cases'][0]['status']='reference_only';real=comparator.load
        with mock.patch.object(comparator,'load',side_effect=lambda path,strict: data if path==manifest else real(path,strict)):
            with self.assertRaises(Invalid):comparator.read_manifest(ROOT,manifest)
    def test_strict_missing_tree_cli_exits_two(self):
        values=copy.deepcopy(self.good);values[0].pop('tree_result')
        with tempfile.TemporaryDirectory() as tmp:
            envelope={'args':['conformance','--strict','--report-json',str(Path(tmp)/'r.json'),'--report-md',str(Path(tmp)/'r.md')],'results':values}
            result=subprocess.run([sys.executable,str(ROOT/'tools/conformance/run_report.py')],input=json.dumps(envelope).encode(),capture_output=True,cwd=ROOT)
            self.assertEqual(result.returncode,2)
    def test_runner_executes_both_entrypoints_without_reference(self):
        text=runner(self.selected)
        self.assertEqual(text.count('@moonclip.boolean_op('),152)
        self.assertEqual(text.count('@moonclip.boolean_tree('),152)
        self.assertNotIn('to_paths',text)

    def test_malformed_tree_protocol_is_rejected_before_comparison(self):
        values,tree=self.changed();tree['children'][0]['path']=[[0,0]]
        with self.assertRaises(Invalid):evaluate(ROOT/'testdata/manifest.json',values)
