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

    def offset_case(self, name='offset_rectangle_positive_miter_nonzero'):
        return load(ROOT/f'testdata/offset/inputs/{name}.json',True)

    def test_offset_full_rectangle_both_signs(self):
        for sign in ('positive','negative'):
            case=self.offset_case('offset_rectangle_'+sign+'_miter_nonzero')
            result=self.call(case);self.assertEqual(result.returncode,0)
            value=decode(result.stdout);validate_geometry(value)
            expected=load(ROOT/f"testdata/offset/expected/{case['case_id']}.json",True)
            self.assertEqual(normalize_paths(value['paths']),normalize_paths(expected['paths']))
            self.assertNotIn('tree',value)

    def test_offset_numeric_tokens_rejected(self):
        for field in ('delta','miter_limit'):
            for token in (True,False,'2',None,[],{}):
                case=self.offset_case();case[field]=token
                with self.subTest(field=field,token=token):self.rejected(case)
        for token in ('NaN','Infinity','-Infinity','1e400'):
            text=canonical_bytes(self.offset_case()).decode().replace('"delta": 2.0','"delta": '+token)
            result=subprocess.run([str(self.binary)],input=text.encode(),capture_output=True,timeout=5)
            self.assertEqual(result.returncode,2)

    def test_offset_unknown_join_rule_and_protocol_rejected(self):
        for field,value in (('join_type','Round'),('join_type','Unknown'),('join_type',True),('fill_rule','Positive'),('format_version',1),('format_version',True),('miter_limit',1.999)):
            case=self.offset_case();case[field]=value;self.rejected(case)

    def test_offset_zero_is_union_normalization(self):
        case=self.offset_case();case['delta']=0.0;case['paths']*=2
        result=decode(self.call(case).stdout)
        self.assertEqual(normalize_paths(result['paths']),normalize_paths(case['paths'][:1]))
        case['fill_rule']='EvenOdd'
        self.assertEqual(decode(self.call(case).stdout)['paths'],[])

    def test_offset_holes_and_islands_full_geometry(self):
        for group in ('hole','island'):
            for sign in ('positive','negative'):
                case=self.offset_case('offset_'+group+'_'+sign+'_miter_nonzero')
                result=self.call(case);self.assertEqual(result.returncode,0)
                expected=load(ROOT/f"testdata/offset/expected/{case['case_id']}.json",True)
                self.assertEqual(normalize_paths(decode(result.stdout)['paths']),normalize_paths(expected['paths']))

    def test_offset_square_fallback_differs_from_bevel(self):
        m=self.offset_case('offset_acute_positive_miter_nonzero')
        b=self.offset_case('offset_acute_positive_bevel_nonzero')
        self.assertNotEqual(normalize_paths(decode(self.call(m).stdout)['paths']),normalize_paths(decode(self.call(b).stdout)['paths']))
        expected=normalize_paths(decode(self.call(b).stdout)['paths'])
        b['miter_limit']=1e300
        self.assertEqual(normalize_paths(decode(self.call(b).stdout)['paths']),expected)

    def test_offset_collapse_empty_and_degenerate_inputs(self):
        case=self.offset_case();case['delta']=-6
        self.assertEqual(decode(self.call(case).stdout)['paths'],[])
        case['paths']=[[],[[0,0]],[[0,0],[10,10]]];case['delta']=4
        self.assertEqual(decode(self.call(case).stdout)['paths'],[])

    def test_offset_generated_coordinates_and_huge_delta_rejected(self):
        case=self.offset_case();case['paths']=[[[999999990,0],[1000000000,0],[1000000000,10],[999999990,10]]]
        self.rejected(case)
        case=self.offset_case();case['delta']=1e300;self.rejected(case)

    def test_offset_missing_fields_and_fixed_options_rejected(self):
        original=self.offset_case()
        for field in original:
            case=copy.deepcopy(original);del case[field];self.rejected(case)
        case=copy.deepcopy(original);case['options']['reverse_solution']=True;self.rejected(case)

    def test_offset_empty_still_checks_parameters(self):
        case=self.offset_case();case['paths']=[]
        self.assertEqual(decode(self.call(case).stdout)['paths'],[])
        case['miter_limit']=1;self.rejected(case)

    def case_commit(self):
        return load(ROOT/'tools/oracle/upstream-lock.json',True)['commit']

if __name__=='__main__': unittest.main()
