"""Integration checks: run explicitly after building; never part of offline CI."""
from pathlib import Path
import copy
import importlib.util
import json
import subprocess
import sys
import unittest
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/conformance'))
from compare import *
spec=importlib.util.spec_from_file_location('generate',ROOT/'tools/oracle/generate.py')
generate=importlib.util.module_from_spec(spec); spec.loader.exec_module(generate)
spec=importlib.util.spec_from_file_location('build',ROOT/'tools/oracle/build.py')
build=importlib.util.module_from_spec(spec); spec.loader.exec_module(build)

class AdapterTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.binary=generate.verified_binary(ROOT)
        cls.case=load(ROOT/'testdata/upstream/inputs/overlap_difference_evenodd.json',True)

    def call(self,case):
        return subprocess.run([str(self.binary)],input=canonical_bytes(case),capture_output=True,timeout=5)

    def rejected(self,case):
        result=self.call(case)
        self.assertEqual(result.returncode,2)
        self.assertEqual(decode(result.stdout)['status'],'error')
        self.assertTrue(result.stderr.startswith(b'oracle:'))

    def test_difference_keeps_subject_order(self):
        result=self.call(self.case)
        self.assertEqual(result.returncode,0)
        value=decode(result.stdout)
        validate_geometry(value)
        self.assertEqual(metrics(value)['paths'][0]['bounds'],[0,0,5,10])
        swapped=copy.deepcopy(self.case); swapped['subject'],swapped['clip']=swapped['clip'],swapped['subject']
        value=decode(self.call(swapped).stdout)
        self.assertEqual(metrics(value)['paths'][0]['bounds'],[10,0,15,10])

    def test_noninteger_coordinate_tokens_rejected(self):
        for token in (True,1.0,1.5,'1',None,1000000001,-1000000001,9223372036854775808):
            case=copy.deepcopy(self.case); case['subject'][0][0][0]=token
            with self.subTest(token=token): self.rejected(case)

    def test_unknown_operation_rule_version_rejected(self):
        for field,value in (('operation','Offset'),('fill_rule','Approximate'),('format_version',2),('format_version',True)):
            case=copy.deepcopy(self.case); case[field]=value
            with self.subTest(field=field,value=value): self.rejected(case)

    def test_missing_fields_and_wrong_types_rejected(self):
        for field in self.case:
            case=copy.deepcopy(self.case); del case[field]
            with self.subTest(field=field): self.rejected(case)
        for field,value in (('subject',True),('options',{}),('source',{}),('case_id','-bad')):
            case=copy.deepcopy(self.case); case[field]=value
            with self.subTest(field=field): self.rejected(case)

    def test_output_options_explicit_and_fixed(self):
        for option in ('preserve_collinear','reverse_solution'):
            case=copy.deepcopy(self.case); case['options'][option]=True
            self.rejected(case)
        case=copy.deepcopy(self.case); case['options']['preserve_collinear']=0
        self.rejected(case)

    def test_duplicate_json_field_rejected(self):
        text=canonical_bytes(self.case).decode().replace('"format_version": 1','"format_version": 1, "format_version": 1')
        result=subprocess.run([str(self.binary)],input=text.encode(),capture_output=True,timeout=5)
        self.assertEqual(result.returncode,2)
        self.assertIn(b'duplicate',result.stderr)

    def test_empty_result_is_a_success(self):
        case=load(ROOT/'testdata/upstream/inputs/disjoint_intersection_evenodd.json',True)
        value=decode(self.call(case).stdout)
        self.assertEqual(value['status'],'success'); self.assertEqual(value['paths'],[])
        self.assertEqual(value['tree'],{'children':[]})

    def test_independent_tree_has_hole_and_island(self):
        case=load(ROOT/'testdata/upstream/inputs/island_union_nonzero.json',True)
        value=decode(self.call(case).stdout); validate_geometry(value)
        self.assertEqual((metrics(value)['path_count'],metrics(value)['tree_depth'],metrics(value)['hole_count']),(3,3,1))

    def test_directional_fill_rules_change_actual_output(self):
        for direction in ('cw','ccw'):
            for fill in ('positive','negative'):
                case=load(ROOT/f'testdata/upstream/inputs/direction_{direction}_union_{fill}.json',True)
                value=decode(self.call(case).stdout)
                expected=1 if (direction,fill) in (('ccw','positive'),('cw','negative')) else 0
                self.assertEqual(len(value['paths']),expected)

    def test_modified_real_source_is_rejected(self):
        source=ROOT/'.tmp/oracle'/('Clipper2-'+self.case_commit())
        target=source/'CPP/Clipper2Lib/src/clipper.engine.cpp'
        saved=target.read_bytes()
        try:
            target.write_bytes(saved+b'\n// test modification\n')
            with self.assertRaisesRegex(Invalid,'modified'):
                build.verify_source(ROOT/'.tmp/oracle/clipper2.tar.gz',source,'Clipper2-'+self.case_commit())
        finally:
            target.write_bytes(saved)

    def case_commit(self):
        return load(ROOT/'tools/oracle/upstream-lock.json',True)['commit']

if __name__=='__main__': unittest.main()
