import copy
import json
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from run_report import ROOT, selected_records

class CliTests(unittest.TestCase):
    def native(self,*args):
        return subprocess.run(['moon','run','--target','native','cmd/conformance','--',*args],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.PIPE,timeout=90)
    def test_native_help_exit_zero(self):
        result=self.native('--help');self.assertEqual(result.returncode,0,result.stderr);self.assertIn(b'Exit codes',result.stdout)
    def test_native_unknown_argument_exit_two(self):
        self.assertEqual(self.native('--unknown').returncode,2)
    def test_native_missing_manifest_exit_two(self):
        self.assertEqual(self.native('--manifest','.tmp/missing-manifest.json').returncode,2)
    def report(self,error):
        _,chosen=selected_records(ROOT/'testdata/manifest.json')
        actual=[{'case_id':e['case_id'],'input_sha256':digest,'status':'success','paths':copy.deepcopy(expected['paths']),'tree_result':{'status':'success','tree':copy.deepcopy(expected['tree'])}} for e,c,digest,expected in chosen]
        if error:
            actual[0].pop('paths');actual[0].update(status='error',error='failure')
        else:
            i=next(i for i,v in enumerate(actual) if v['paths']);actual[i]['paths'][0].reverse()
        with tempfile.TemporaryDirectory() as temp:
            args=['conformance','--strict','--report-json',str(Path(temp)/'result.json'),'--report-md',str(Path(temp)/'result.md')]
            return subprocess.run([sys.executable,str(ROOT/'tools/conformance/run_report.py')],input=json.dumps({'args':args,'results':actual}).encode(),cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.PIPE,timeout=30)
    def test_contour_difference_exit_one(self):self.assertEqual(self.report(False).returncode,1)
    def test_execution_error_exit_two(self):self.assertEqual(self.report(True).returncode,2)
