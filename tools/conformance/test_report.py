import copy
import unittest
from pathlib import Path
from compare import Invalid
from run_report import ROOT, evaluate, selected_records

class ReportTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        _,cls.chosen=selected_records(ROOT/'testdata/manifest.json')
        cls.good=[{'case_id':e['case_id'],'input_sha256':digest,'status':'success','paths':expected['paths']} for e,c,digest,expected in cls.chosen]
    def test_selection_is_exactly_sixty_evenodd_paths_not_trees(self):
        r=evaluate(ROOT/'testdata/manifest.json',self.good)
        self.assertEqual((r['required'],r['executed'],r['passed']),(60,60,60))
        self.assertEqual(r['tree'],'reference_only')
    def test_missing_result_rejected(self):
        with self.assertRaises(Invalid):evaluate(ROOT/'testdata/manifest.json',self.good[:-1])
    def test_extra_result_rejected(self):
        r=copy.deepcopy(self.good);r.append(dict(r[0],case_id='unexpected'))
        with self.assertRaises(Invalid):evaluate(ROOT/'testdata/manifest.json',r)
    def test_duplicate_result_rejected(self):
        with self.assertRaises(Invalid):evaluate(ROOT/'testdata/manifest.json',self.good+[self.good[0]])
    def test_compiled_input_hash_mismatch_rejected(self):
        r=copy.deepcopy(self.good);r[0]['input_sha256']='0'*64
        with self.assertRaises(Invalid):evaluate(ROOT/'testdata/manifest.json',r)
    def test_winding_difference_is_not_accepted(self):
        r=copy.deepcopy(self.good);i=next(i for i,v in enumerate(r) if v['paths']);r[i]['paths'][0].reverse()
        report=evaluate(ROOT/'testdata/manifest.json',r)
        self.assertEqual(report['differences'],1)
    def test_execution_error_is_not_a_legal_empty_region(self):
        r=copy.deepcopy(self.good);r[0].pop('paths');r[0].update(status='error',error='Execution failed')
        report=evaluate(ROOT/'testdata/manifest.json',r)
        self.assertEqual(report['execution_errors'],1)
        self.assertEqual(report['passed'],59)
    def test_malformed_output_is_an_execution_error(self):
        r=copy.deepcopy(self.good);r[0]['paths']=[[[0,0]]]
        with self.assertRaises(Invalid):evaluate(ROOT/'testdata/manifest.json',r)
