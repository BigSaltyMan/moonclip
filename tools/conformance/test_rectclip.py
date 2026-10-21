# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
import copy
import unittest
from pathlib import Path
from compare import Invalid,canonical_bytes,compare,read_manifest,validate_input
from rectclip_compare import COUNT
from run_report import evaluate_rectclip
from generate_rectclip import generated
ROOT=Path(__file__).resolve().parents[2]

class RectclipTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        _,cls.records=read_manifest(ROOT,ROOT/'testdata/rectclip-manifest.json',strict=True)
        cls.good=[dict(case_id=c['case_id'],input_sha256=d,status='success',paths=v['paths']) for _,c,d,v in cls.records]

    def test_rectclip_catalog_and_generated_inputs_only(self):
        self.assertEqual(len(self.records),COUNT)
        runner=generated()['cmd/conformance/rectclip_cases.mbt']
        self.assertEqual(runner.count('@moonclip.rect_clip_lines('),COUNT)
        self.assertNotIn('expected/',runner)

    def test_rectclip_order_direction_and_vertices_are_not_normalized(self):
        v=next(v for _,c,_,v in self.records if c['source']['group']=='reentry')
        for transform in [lambda p:p[::-1],lambda p:[p[0][::-1],*p[1:]],lambda p:[p[0][1:]+p[0][:1],*p[1:]],lambda p:[p[0][::2],*p[1:]]]:
            r=copy.deepcopy(v);r['paths']=transform(r['paths'])
            with self.assertRaises(Invalid):compare(v,r)

    def test_rectclip_input_tokens_and_window_validation(self):
        c=copy.deepcopy(self.records[0][1])
        for value in [True,0.5,'1',1000000001,-9223372036854775808]:
            r=copy.deepcopy(c);r['rect'][0]=value
            with self.assertRaises(Invalid):validate_input(r,'injected invalid input')
        for value in [True,8.0,7]:
            r=copy.deepcopy(c);r['format_version']=value
            with self.assertRaises(Invalid):validate_input(r,'injected invalid version')
        r=copy.deepcopy(c);r['rect']=[10,0,0,10]
        with self.assertRaises(Invalid):validate_input(r,'reversed')

    def test_rectclip_report_actual_success(self):
        r=evaluate_rectclip(ROOT/'testdata/rectclip-manifest.json',self.good)
        self.assertEqual((r['passed'],r['differences'],r['execution_errors']),(COUNT,0,0))

    def test_rectclip_missing_extra_duplicate_and_stale_hash_rejected(self):
        for bad in [self.good[:-1],self.good+[self.good[0]],self.good+[dict(case_id='extra',status='error',error='x')]]:
            with self.assertRaises(Invalid):evaluate_rectclip(ROOT/'testdata/rectclip-manifest.json',bad)
        bad=copy.deepcopy(self.good);bad[0]['input_sha256']='0'*64
        with self.assertRaises(Invalid):evaluate_rectclip(ROOT/'testdata/rectclip-manifest.json',bad)

    def test_rectclip_difference_and_execution_error_are_separate(self):
        bad=copy.deepcopy(self.good);i=next(i for i,v in enumerate(bad) if v['paths'])
        bad[i]['paths'][0].reverse()
        self.assertEqual(evaluate_rectclip(ROOT/'testdata/rectclip-manifest.json',bad)['differences'],1)
        bad[i]={k:bad[i][k] for k in ['case_id','input_sha256']};bad[i].update(status='error',error='injected')
        self.assertEqual(evaluate_rectclip(ROOT/'testdata/rectclip-manifest.json',bad)['execution_errors'],1)

    def test_rectclip_boundary_history_is_not_uniform(self):
        by={c['source']['group']:v['paths'] for _,c,_,v in self.records}
        self.assertEqual(by['outside_edge'],[[[5,0],[5,5]]])
        self.assertEqual(by['inside_edge'],[[[5,5],[5,0],[9,0]]])
        self.assertEqual(by['left_edge'],[[[0,1],[0,5],[0,9]]])
        self.assertEqual(by['tangent'],[])

    def test_rectclip_old_reference_directory_not_selected(self):
        import importlib.util
        spec=importlib.util.spec_from_file_location('rectclip_generation',ROOT/'tools/oracle/generate.py')
        m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
        self.assertEqual(m.expected_directory(self.records),'testdata/rectclip/expected')

if __name__=='__main__':unittest.main()
