# Boolean compatibility

Pinned Clipper2 2.0.1, commit `21ebba05db8894f0c7217ad35ea518080f324946`; ordinary precision. Boolean/Offset/Stroke: preserve_collinear=false; MinkowskiSum: preserve_collinear=true; reverse_solution=false. Simplification has its own ordered-output contract.

Public cases: 152; both passed=152, differences=0, execution_errors=0. Reference catalog: 200.

| Native capability | Required | Executed | Passed | Differences | Execution errors |
| --- | ---: | ---: | ---: | ---: | ---: |
| paths | 152 | 152 | 152 | 0 | 0 |
| tree | 152 | 152 | 152 | 0 | 0 |

152 cases have two independently executed capabilities; this is not 304 independent cases. The executable calls boolean_op and boolean_tree separately and compiles only inputs and hashes.

Native and JS execute the same public and internal tests independently. Positive/Negative remain private; their 48 paths and 48 trees are separate whitebox evidence.

| Target | Internal paths | Public tree | Internal tree |
| --- | --- | --- | --- |
| native | 48/48 | 152/152 | 48/48 |
| js | 48/48 | 152/152 | 48/48 |

Filtered counts are read from actual logs. Tree logs require their own selection markers; old paths logs cannot establish tree execution. Internal rules each cover 24 cases.

Only cyclic ring starts and sibling order are normalized. Parentage, depth, full coordinates, vertex counts, winding and multiplicity remain significant.

| Case | Native paths | Native tree | Both |
| --- | --- | --- | --- |
| coincident_difference_evenodd | passed | passed | passed |
| coincident_difference_nonzero | passed | passed | passed |
| coincident_intersection_evenodd | passed | passed | passed |
| coincident_intersection_nonzero | passed | passed | passed |
| coincident_union_evenodd | passed | passed | passed |
| coincident_union_nonzero | passed | passed | passed |
| coincident_xor_evenodd | passed | passed | passed |
| coincident_xor_nonzero | passed | passed | passed |
| concave_difference_evenodd | passed | passed | passed |
| concave_difference_nonzero | passed | passed | passed |
| concave_intersection_evenodd | passed | passed | passed |
| concave_intersection_nonzero | passed | passed | passed |
| concave_union_evenodd | passed | passed | passed |
| concave_union_nonzero | passed | passed | passed |
| concave_xor_evenodd | passed | passed | passed |
| concave_xor_nonzero | passed | passed | passed |
| contained_difference_evenodd | passed | passed | passed |
| contained_difference_nonzero | passed | passed | passed |
| contained_intersection_evenodd | passed | passed | passed |
| contained_intersection_nonzero | passed | passed | passed |
| contained_union_evenodd | passed | passed | passed |
| contained_union_nonzero | passed | passed | passed |
| contained_xor_evenodd | passed | passed | passed |
| contained_xor_nonzero | passed | passed | passed |
| disjoint_difference_evenodd | passed | passed | passed |
| disjoint_difference_nonzero | passed | passed | passed |
| disjoint_intersection_evenodd | passed | passed | passed |
| disjoint_intersection_nonzero | passed | passed | passed |
| disjoint_union_evenodd | passed | passed | passed |
| disjoint_union_nonzero | passed | passed | passed |
| disjoint_xor_evenodd | passed | passed | passed |
| disjoint_xor_nonzero | passed | passed | passed |
| empty_both_difference_evenodd | passed | passed | passed |
| empty_both_difference_nonzero | passed | passed | passed |
| empty_both_intersection_evenodd | passed | passed | passed |
| empty_both_intersection_nonzero | passed | passed | passed |
| empty_both_union_evenodd | passed | passed | passed |
| empty_both_union_nonzero | passed | passed | passed |
| empty_both_xor_evenodd | passed | passed | passed |
| empty_both_xor_nonzero | passed | passed | passed |
| empty_clip_difference_evenodd | passed | passed | passed |
| empty_clip_difference_nonzero | passed | passed | passed |
| empty_clip_intersection_evenodd | passed | passed | passed |
| empty_clip_intersection_nonzero | passed | passed | passed |
| empty_clip_union_evenodd | passed | passed | passed |
| empty_clip_union_nonzero | passed | passed | passed |
| empty_clip_xor_evenodd | passed | passed | passed |
| empty_clip_xor_nonzero | passed | passed | passed |
| empty_subject_difference_evenodd | passed | passed | passed |
| empty_subject_difference_nonzero | passed | passed | passed |
| empty_subject_intersection_evenodd | passed | passed | passed |
| empty_subject_intersection_nonzero | passed | passed | passed |
| empty_subject_union_evenodd | passed | passed | passed |
| empty_subject_union_nonzero | passed | passed | passed |
| empty_subject_xor_evenodd | passed | passed | passed |
| empty_subject_xor_nonzero | passed | passed | passed |
| hole_difference_evenodd | passed | passed | passed |
| hole_difference_nonzero | passed | passed | passed |
| hole_intersection_evenodd | passed | passed | passed |
| hole_intersection_nonzero | passed | passed | passed |
| hole_union_evenodd | passed | passed | passed |
| hole_union_nonzero | passed | passed | passed |
| hole_xor_evenodd | passed | passed | passed |
| hole_xor_nonzero | passed | passed | passed |
| island_difference_evenodd | passed | passed | passed |
| island_difference_nonzero | passed | passed | passed |
| island_intersection_evenodd | passed | passed | passed |
| island_intersection_nonzero | passed | passed | passed |
| island_union_evenodd | passed | passed | passed |
| island_union_nonzero | passed | passed | passed |
| island_xor_evenodd | passed | passed | passed |
| island_xor_nonzero | passed | passed | passed |
| multipart_difference_evenodd | passed | passed | passed |
| multipart_difference_nonzero | passed | passed | passed |
| multipart_intersection_evenodd | passed | passed | passed |
| multipart_intersection_nonzero | passed | passed | passed |
| multipart_union_evenodd | passed | passed | passed |
| multipart_union_nonzero | passed | passed | passed |
| multipart_xor_evenodd | passed | passed | passed |
| multipart_xor_nonzero | passed | passed | passed |
| negative_collinear_difference_evenodd | passed | passed | passed |
| negative_collinear_difference_nonzero | passed | passed | passed |
| negative_collinear_intersection_evenodd | passed | passed | passed |
| negative_collinear_intersection_nonzero | passed | passed | passed |
| negative_collinear_union_evenodd | passed | passed | passed |
| negative_collinear_union_nonzero | passed | passed | passed |
| negative_collinear_xor_evenodd | passed | passed | passed |
| negative_collinear_xor_nonzero | passed | passed | passed |
| overlap_difference_evenodd | passed | passed | passed |
| overlap_difference_nonzero | passed | passed | passed |
| overlap_intersection_evenodd | passed | passed | passed |
| overlap_intersection_nonzero | passed | passed | passed |
| overlap_union_evenodd | passed | passed | passed |
| overlap_union_nonzero | passed | passed | passed |
| overlap_xor_evenodd | passed | passed | passed |
| overlap_xor_nonzero | passed | passed | passed |
| self_crossing_difference_evenodd | passed | passed | passed |
| self_crossing_difference_nonzero | passed | passed | passed |
| self_crossing_intersection_evenodd | passed | passed | passed |
| self_crossing_intersection_nonzero | passed | passed | passed |
| self_crossing_union_evenodd | passed | passed | passed |
| self_crossing_union_nonzero | passed | passed | passed |
| self_crossing_xor_evenodd | passed | passed | passed |
| self_crossing_xor_nonzero | passed | passed | passed |
| touch_edge_difference_evenodd | passed | passed | passed |
| touch_edge_difference_nonzero | passed | passed | passed |
| touch_edge_intersection_evenodd | passed | passed | passed |
| touch_edge_intersection_nonzero | passed | passed | passed |
| touch_edge_union_evenodd | passed | passed | passed |
| touch_edge_union_nonzero | passed | passed | passed |
| touch_edge_xor_evenodd | passed | passed | passed |
| touch_edge_xor_nonzero | passed | passed | passed |
| touch_vertex_difference_evenodd | passed | passed | passed |
| touch_vertex_difference_nonzero | passed | passed | passed |
| touch_vertex_intersection_evenodd | passed | passed | passed |
| touch_vertex_intersection_nonzero | passed | passed | passed |
| touch_vertex_union_evenodd | passed | passed | passed |
| touch_vertex_union_nonzero | passed | passed | passed |
| touch_vertex_xor_evenodd | passed | passed | passed |
| touch_vertex_xor_nonzero | passed | passed | passed |
| winding_cancel_touch_difference_evenodd | passed | passed | passed |
| winding_cancel_touch_difference_nonzero | passed | passed | passed |
| winding_cancel_touch_intersection_evenodd | passed | passed | passed |
| winding_cancel_touch_intersection_nonzero | passed | passed | passed |
| winding_cancel_touch_union_evenodd | passed | passed | passed |
| winding_cancel_touch_union_nonzero | passed | passed | passed |
| winding_cancel_touch_xor_evenodd | passed | passed | passed |
| winding_cancel_touch_xor_nonzero | passed | passed | passed |
| winding_nested_difference_evenodd | passed | passed | passed |
| winding_nested_difference_nonzero | passed | passed | passed |
| winding_nested_intersection_evenodd | passed | passed | passed |
| winding_nested_intersection_nonzero | passed | passed | passed |
| winding_nested_union_evenodd | passed | passed | passed |
| winding_nested_union_nonzero | passed | passed | passed |
| winding_nested_xor_evenodd | passed | passed | passed |
| winding_nested_xor_nonzero | passed | passed | passed |
| winding_overlap_difference_evenodd | passed | passed | passed |
| winding_overlap_difference_nonzero | passed | passed | passed |
| winding_overlap_intersection_evenodd | passed | passed | passed |
| winding_overlap_intersection_nonzero | passed | passed | passed |
| winding_overlap_union_evenodd | passed | passed | passed |
| winding_overlap_union_nonzero | passed | passed | passed |
| winding_overlap_xor_evenodd | passed | passed | passed |
| winding_overlap_xor_nonzero | passed | passed | passed |
| winding_reversed_difference_evenodd | passed | passed | passed |
| winding_reversed_difference_nonzero | passed | passed | passed |
| winding_reversed_intersection_evenodd | passed | passed | passed |
| winding_reversed_intersection_nonzero | passed | passed | passed |
| winding_reversed_union_evenodd | passed | passed | passed |
| winding_reversed_union_nonzero | passed | passed | passed |
| winding_reversed_xor_evenodd | passed | passed | passed |
| winding_reversed_xor_nonzero | passed | passed | passed |

# Offset compatibility

Offset public paths: 272/272; required=272, differences=0, execution_errors=0.

Boolean reference cases: 200. Offset reference cases: 272. Boolean/Offset subtotal: 472. Offset has no public tree interface; hole/island composition is covered separately by functional tests.

| Target | Offset filtered paths |
| --- | --- |
| native | 272/272 |
| js | 272/272 |

| Offset case | Native paths |
| --- | --- |
| offset_acute_negative_bevel_evenodd | passed |
| offset_acute_negative_bevel_nonzero | passed |
| offset_acute_negative_miter_evenodd | passed |
| offset_acute_negative_miter_nonzero | passed |
| offset_acute_negative_round_evenodd | passed |
| offset_acute_negative_round_nonzero | passed |
| offset_acute_negative_square_evenodd | passed |
| offset_acute_negative_square_nonzero | passed |
| offset_acute_positive_bevel_evenodd | passed |
| offset_acute_positive_bevel_nonzero | passed |
| offset_acute_positive_miter_evenodd | passed |
| offset_acute_positive_miter_nonzero | passed |
| offset_acute_positive_round_evenodd | passed |
| offset_acute_positive_round_nonzero | passed |
| offset_acute_positive_square_evenodd | passed |
| offset_acute_positive_square_nonzero | passed |
| offset_arc_acute_t005_negative_round_evenodd | passed |
| offset_arc_acute_t005_negative_round_nonzero | passed |
| offset_arc_acute_t005_positive_round_evenodd | passed |
| offset_arc_acute_t005_positive_round_nonzero | passed |
| offset_arc_acute_t025_negative_round_evenodd | passed |
| offset_arc_acute_t025_negative_round_nonzero | passed |
| offset_arc_acute_t025_positive_round_evenodd | passed |
| offset_arc_acute_t025_positive_round_nonzero | passed |
| offset_arc_acute_t100_negative_round_evenodd | passed |
| offset_arc_acute_t100_negative_round_nonzero | passed |
| offset_arc_acute_t100_positive_round_evenodd | passed |
| offset_arc_acute_t100_positive_round_nonzero | passed |
| offset_arc_hole_t005_negative_round_evenodd | passed |
| offset_arc_hole_t005_negative_round_nonzero | passed |
| offset_arc_hole_t005_positive_round_evenodd | passed |
| offset_arc_hole_t005_positive_round_nonzero | passed |
| offset_arc_hole_t025_negative_round_evenodd | passed |
| offset_arc_hole_t025_negative_round_nonzero | passed |
| offset_arc_hole_t025_positive_round_evenodd | passed |
| offset_arc_hole_t025_positive_round_nonzero | passed |
| offset_arc_hole_t100_negative_round_evenodd | passed |
| offset_arc_hole_t100_negative_round_nonzero | passed |
| offset_arc_hole_t100_positive_round_evenodd | passed |
| offset_arc_hole_t100_positive_round_nonzero | passed |
| offset_arc_neck_t005_negative_round_evenodd | passed |
| offset_arc_neck_t005_negative_round_nonzero | passed |
| offset_arc_neck_t005_positive_round_evenodd | passed |
| offset_arc_neck_t005_positive_round_nonzero | passed |
| offset_arc_neck_t025_negative_round_evenodd | passed |
| offset_arc_neck_t025_negative_round_nonzero | passed |
| offset_arc_neck_t025_positive_round_evenodd | passed |
| offset_arc_neck_t025_positive_round_nonzero | passed |
| offset_arc_neck_t100_negative_round_evenodd | passed |
| offset_arc_neck_t100_negative_round_nonzero | passed |
| offset_arc_neck_t100_positive_round_evenodd | passed |
| offset_arc_neck_t100_positive_round_nonzero | passed |
| offset_arc_rectangle_t005_negative_round_evenodd | passed |
| offset_arc_rectangle_t005_negative_round_nonzero | passed |
| offset_arc_rectangle_t005_positive_round_evenodd | passed |
| offset_arc_rectangle_t005_positive_round_nonzero | passed |
| offset_arc_rectangle_t025_negative_round_evenodd | passed |
| offset_arc_rectangle_t025_negative_round_nonzero | passed |
| offset_arc_rectangle_t025_positive_round_evenodd | passed |
| offset_arc_rectangle_t025_positive_round_nonzero | passed |
| offset_arc_rectangle_t100_negative_round_evenodd | passed |
| offset_arc_rectangle_t100_negative_round_nonzero | passed |
| offset_arc_rectangle_t100_positive_round_evenodd | passed |
| offset_arc_rectangle_t100_positive_round_nonzero | passed |
| offset_collapse_beyond_bevel_evenodd | passed |
| offset_collapse_beyond_bevel_nonzero | passed |
| offset_collapse_beyond_miter_evenodd | passed |
| offset_collapse_beyond_miter_nonzero | passed |
| offset_collapse_beyond_round_evenodd | passed |
| offset_collapse_beyond_round_nonzero | passed |
| offset_collapse_beyond_square_evenodd | passed |
| offset_collapse_beyond_square_nonzero | passed |
| offset_collapse_exact_bevel_evenodd | passed |
| offset_collapse_exact_bevel_nonzero | passed |
| offset_collapse_exact_miter_evenodd | passed |
| offset_collapse_exact_miter_nonzero | passed |
| offset_collapse_exact_round_evenodd | passed |
| offset_collapse_exact_round_nonzero | passed |
| offset_collapse_exact_square_evenodd | passed |
| offset_collapse_exact_square_nonzero | passed |
| offset_concave_l_negative_bevel_evenodd | passed |
| offset_concave_l_negative_bevel_nonzero | passed |
| offset_concave_l_negative_miter_evenodd | passed |
| offset_concave_l_negative_miter_nonzero | passed |
| offset_concave_l_negative_round_evenodd | passed |
| offset_concave_l_negative_round_nonzero | passed |
| offset_concave_l_negative_square_evenodd | passed |
| offset_concave_l_negative_square_nonzero | passed |
| offset_concave_l_positive_bevel_evenodd | passed |
| offset_concave_l_positive_bevel_nonzero | passed |
| offset_concave_l_positive_miter_evenodd | passed |
| offset_concave_l_positive_miter_nonzero | passed |
| offset_concave_l_positive_round_evenodd | passed |
| offset_concave_l_positive_round_nonzero | passed |
| offset_concave_l_positive_square_evenodd | passed |
| offset_concave_l_positive_square_nonzero | passed |
| offset_hole_negative_bevel_evenodd | passed |
| offset_hole_negative_bevel_nonzero | passed |
| offset_hole_negative_miter_evenodd | passed |
| offset_hole_negative_miter_nonzero | passed |
| offset_hole_negative_round_evenodd | passed |
| offset_hole_negative_round_nonzero | passed |
| offset_hole_negative_square_evenodd | passed |
| offset_hole_negative_square_nonzero | passed |
| offset_hole_positive_bevel_evenodd | passed |
| offset_hole_positive_bevel_nonzero | passed |
| offset_hole_positive_miter_evenodd | passed |
| offset_hole_positive_miter_nonzero | passed |
| offset_hole_positive_round_evenodd | passed |
| offset_hole_positive_round_nonzero | passed |
| offset_hole_positive_square_evenodd | passed |
| offset_hole_positive_square_nonzero | passed |
| offset_island_negative_bevel_evenodd | passed |
| offset_island_negative_bevel_nonzero | passed |
| offset_island_negative_miter_evenodd | passed |
| offset_island_negative_miter_nonzero | passed |
| offset_island_negative_round_evenodd | passed |
| offset_island_negative_round_nonzero | passed |
| offset_island_negative_square_evenodd | passed |
| offset_island_negative_square_nonzero | passed |
| offset_island_positive_bevel_evenodd | passed |
| offset_island_positive_bevel_nonzero | passed |
| offset_island_positive_miter_evenodd | passed |
| offset_island_positive_miter_nonzero | passed |
| offset_island_positive_round_evenodd | passed |
| offset_island_positive_round_nonzero | passed |
| offset_island_positive_square_evenodd | passed |
| offset_island_positive_square_nonzero | passed |
| offset_miter10_negative_miter_evenodd | passed |
| offset_miter10_negative_miter_nonzero | passed |
| offset_miter10_positive_miter_evenodd | passed |
| offset_miter10_positive_miter_nonzero | passed |
| offset_miter4_negative_miter_evenodd | passed |
| offset_miter4_negative_miter_nonzero | passed |
| offset_miter4_positive_miter_evenodd | passed |
| offset_miter4_positive_miter_nonzero | passed |
| offset_mixed_overlap_negative_bevel_evenodd | passed |
| offset_mixed_overlap_negative_bevel_nonzero | passed |
| offset_mixed_overlap_negative_miter_evenodd | passed |
| offset_mixed_overlap_negative_miter_nonzero | passed |
| offset_mixed_overlap_negative_round_evenodd | passed |
| offset_mixed_overlap_negative_round_nonzero | passed |
| offset_mixed_overlap_negative_square_evenodd | passed |
| offset_mixed_overlap_negative_square_nonzero | passed |
| offset_mixed_overlap_positive_bevel_evenodd | passed |
| offset_mixed_overlap_positive_bevel_nonzero | passed |
| offset_mixed_overlap_positive_miter_evenodd | passed |
| offset_mixed_overlap_positive_miter_nonzero | passed |
| offset_mixed_overlap_positive_round_evenodd | passed |
| offset_mixed_overlap_positive_round_nonzero | passed |
| offset_mixed_overlap_positive_square_evenodd | passed |
| offset_mixed_overlap_positive_square_nonzero | passed |
| offset_multipart_negative_bevel_evenodd | passed |
| offset_multipart_negative_bevel_nonzero | passed |
| offset_multipart_negative_miter_evenodd | passed |
| offset_multipart_negative_miter_nonzero | passed |
| offset_multipart_negative_round_evenodd | passed |
| offset_multipart_negative_round_nonzero | passed |
| offset_multipart_negative_square_evenodd | passed |
| offset_multipart_negative_square_nonzero | passed |
| offset_multipart_positive_bevel_evenodd | passed |
| offset_multipart_positive_bevel_nonzero | passed |
| offset_multipart_positive_miter_evenodd | passed |
| offset_multipart_positive_miter_nonzero | passed |
| offset_multipart_positive_round_evenodd | passed |
| offset_multipart_positive_round_nonzero | passed |
| offset_multipart_positive_square_evenodd | passed |
| offset_multipart_positive_square_nonzero | passed |
| offset_neck_negative_bevel_evenodd | passed |
| offset_neck_negative_bevel_nonzero | passed |
| offset_neck_negative_miter_evenodd | passed |
| offset_neck_negative_miter_nonzero | passed |
| offset_neck_negative_round_evenodd | passed |
| offset_neck_negative_round_nonzero | passed |
| offset_neck_negative_square_evenodd | passed |
| offset_neck_negative_square_nonzero | passed |
| offset_neck_positive_bevel_evenodd | passed |
| offset_neck_positive_bevel_nonzero | passed |
| offset_neck_positive_miter_evenodd | passed |
| offset_neck_positive_miter_nonzero | passed |
| offset_neck_positive_round_evenodd | passed |
| offset_neck_positive_round_nonzero | passed |
| offset_neck_positive_square_evenodd | passed |
| offset_neck_positive_square_nonzero | passed |
| offset_overlap_negative_bevel_evenodd | passed |
| offset_overlap_negative_bevel_nonzero | passed |
| offset_overlap_negative_miter_evenodd | passed |
| offset_overlap_negative_miter_nonzero | passed |
| offset_overlap_negative_round_evenodd | passed |
| offset_overlap_negative_round_nonzero | passed |
| offset_overlap_negative_square_evenodd | passed |
| offset_overlap_negative_square_nonzero | passed |
| offset_overlap_positive_bevel_evenodd | passed |
| offset_overlap_positive_bevel_nonzero | passed |
| offset_overlap_positive_miter_evenodd | passed |
| offset_overlap_positive_miter_nonzero | passed |
| offset_overlap_positive_round_evenodd | passed |
| offset_overlap_positive_round_nonzero | passed |
| offset_overlap_positive_square_evenodd | passed |
| offset_overlap_positive_square_nonzero | passed |
| offset_rectangle_negative_bevel_evenodd | passed |
| offset_rectangle_negative_bevel_nonzero | passed |
| offset_rectangle_negative_miter_evenodd | passed |
| offset_rectangle_negative_miter_nonzero | passed |
| offset_rectangle_negative_round_evenodd | passed |
| offset_rectangle_negative_round_nonzero | passed |
| offset_rectangle_negative_square_evenodd | passed |
| offset_rectangle_negative_square_nonzero | passed |
| offset_rectangle_positive_bevel_evenodd | passed |
| offset_rectangle_positive_bevel_nonzero | passed |
| offset_rectangle_positive_miter_evenodd | passed |
| offset_rectangle_positive_miter_nonzero | passed |
| offset_rectangle_positive_round_evenodd | passed |
| offset_rectangle_positive_round_nonzero | passed |
| offset_rectangle_positive_square_evenodd | passed |
| offset_rectangle_positive_square_nonzero | passed |
| offset_self_crossing_negative_bevel_evenodd | passed |
| offset_self_crossing_negative_bevel_nonzero | passed |
| offset_self_crossing_negative_miter_evenodd | passed |
| offset_self_crossing_negative_miter_nonzero | passed |
| offset_self_crossing_negative_round_evenodd | passed |
| offset_self_crossing_negative_round_nonzero | passed |
| offset_self_crossing_negative_square_evenodd | passed |
| offset_self_crossing_negative_square_nonzero | passed |
| offset_self_crossing_positive_bevel_evenodd | passed |
| offset_self_crossing_positive_bevel_nonzero | passed |
| offset_self_crossing_positive_miter_evenodd | passed |
| offset_self_crossing_positive_miter_nonzero | passed |
| offset_self_crossing_positive_round_evenodd | passed |
| offset_self_crossing_positive_round_nonzero | passed |
| offset_self_crossing_positive_square_evenodd | passed |
| offset_self_crossing_positive_square_nonzero | passed |
| offset_small_n049_bevel_evenodd | passed |
| offset_small_n049_bevel_nonzero | passed |
| offset_small_n049_miter_evenodd | passed |
| offset_small_n049_miter_nonzero | passed |
| offset_small_n049_round_evenodd | passed |
| offset_small_n049_round_nonzero | passed |
| offset_small_n049_square_evenodd | passed |
| offset_small_n049_square_nonzero | passed |
| offset_small_n05_bevel_evenodd | passed |
| offset_small_n05_bevel_nonzero | passed |
| offset_small_n05_miter_evenodd | passed |
| offset_small_n05_miter_nonzero | passed |
| offset_small_n05_round_evenodd | passed |
| offset_small_n05_round_nonzero | passed |
| offset_small_n05_square_evenodd | passed |
| offset_small_n05_square_nonzero | passed |
| offset_small_p049_bevel_evenodd | passed |
| offset_small_p049_bevel_nonzero | passed |
| offset_small_p049_miter_evenodd | passed |
| offset_small_p049_miter_nonzero | passed |
| offset_small_p049_round_evenodd | passed |
| offset_small_p049_round_nonzero | passed |
| offset_small_p049_square_evenodd | passed |
| offset_small_p049_square_nonzero | passed |
| offset_small_p05_bevel_evenodd | passed |
| offset_small_p05_bevel_nonzero | passed |
| offset_small_p05_miter_evenodd | passed |
| offset_small_p05_miter_nonzero | passed |
| offset_small_p05_round_evenodd | passed |
| offset_small_p05_round_nonzero | passed |
| offset_small_p05_square_evenodd | passed |
| offset_small_p05_square_nonzero | passed |
| offset_small_zero_bevel_evenodd | passed |
| offset_small_zero_bevel_nonzero | passed |
| offset_small_zero_miter_evenodd | passed |
| offset_small_zero_miter_nonzero | passed |
| offset_small_zero_round_evenodd | passed |
| offset_small_zero_round_nonzero | passed |
| offset_small_zero_square_evenodd | passed |
| offset_small_zero_square_nonzero | passed |

# Stroke compatibility

Stroke public paths: 276/276; required=276, differences=0, execution_errors=0.

Independent inputs: Boolean200 + Offset272 + Stroke276 =748. Strokes have no input fill rule or public tree interface; boolean_tree composition tests are separate evidence.

| Parameter | Actual case coverage |
| --- | --- |
| arc_tolerance | 0.0: 264, 0.05: 4, 0.25: 4, 1.0: 4 |
| cap_type | Butt: 94, Round: 94, Square: 88 |
| join_type | Bevel: 63, Miter: 81, Round: 69, Square: 63 |
| miter_limit | 10.0: 6, 2.0: 264, 4.0: 6 |
| width | 1.0: 12, 1.01: 12, 1.99: 12, 10.0: 108, 2.0: 12, 20.0: 12, 3.0: 12, 4.0: 96 |

| Target | Stroke filtered paths |
| --- | --- |
| native | 276/276 |
| js | 276/276 |

| Stroke case | Native paths |
| --- | --- |
| stroke_acute_w10_bevel_butt | passed |
| stroke_acute_w10_bevel_round | passed |
| stroke_acute_w10_bevel_square | passed |
| stroke_acute_w10_miter_butt | passed |
| stroke_acute_w10_miter_round | passed |
| stroke_acute_w10_miter_square | passed |
| stroke_acute_w10_round_butt | passed |
| stroke_acute_w10_round_round | passed |
| stroke_acute_w10_round_square | passed |
| stroke_acute_w10_square_butt | passed |
| stroke_acute_w10_square_round | passed |
| stroke_acute_w10_square_square | passed |
| stroke_acute_w4_bevel_butt | passed |
| stroke_acute_w4_bevel_round | passed |
| stroke_acute_w4_bevel_square | passed |
| stroke_acute_w4_miter_butt | passed |
| stroke_acute_w4_miter_round | passed |
| stroke_acute_w4_miter_square | passed |
| stroke_acute_w4_round_butt | passed |
| stroke_acute_w4_round_round | passed |
| stroke_acute_w4_round_square | passed |
| stroke_acute_w4_square_butt | passed |
| stroke_acute_w4_square_round | passed |
| stroke_acute_w4_square_square | passed |
| stroke_arc_acute_t005_miter_round | passed |
| stroke_arc_acute_t005_round_butt | passed |
| stroke_arc_acute_t025_miter_round | passed |
| stroke_arc_acute_t025_round_butt | passed |
| stroke_arc_acute_t100_miter_round | passed |
| stroke_arc_acute_t100_round_butt | passed |
| stroke_arc_right_angle_t005_miter_round | passed |
| stroke_arc_right_angle_t005_round_butt | passed |
| stroke_arc_right_angle_t025_miter_round | passed |
| stroke_arc_right_angle_t025_round_butt | passed |
| stroke_arc_right_angle_t100_miter_round | passed |
| stroke_arc_right_angle_t100_round_butt | passed |
| stroke_coincident_ends_w10_bevel_butt | passed |
| stroke_coincident_ends_w10_bevel_round | passed |
| stroke_coincident_ends_w10_bevel_square | passed |
| stroke_coincident_ends_w10_miter_butt | passed |
| stroke_coincident_ends_w10_miter_round | passed |
| stroke_coincident_ends_w10_miter_square | passed |
| stroke_coincident_ends_w10_round_butt | passed |
| stroke_coincident_ends_w10_round_round | passed |
| stroke_coincident_ends_w10_round_square | passed |
| stroke_coincident_ends_w10_square_butt | passed |
| stroke_coincident_ends_w10_square_round | passed |
| stroke_coincident_ends_w10_square_square | passed |
| stroke_coincident_ends_w4_bevel_butt | passed |
| stroke_coincident_ends_w4_bevel_round | passed |
| stroke_coincident_ends_w4_bevel_square | passed |
| stroke_coincident_ends_w4_miter_butt | passed |
| stroke_coincident_ends_w4_miter_round | passed |
| stroke_coincident_ends_w4_miter_square | passed |
| stroke_coincident_ends_w4_round_butt | passed |
| stroke_coincident_ends_w4_round_round | passed |
| stroke_coincident_ends_w4_round_square | passed |
| stroke_coincident_ends_w4_square_butt | passed |
| stroke_coincident_ends_w4_square_round | passed |
| stroke_coincident_ends_w4_square_square | passed |
| stroke_diagonal_w10_bevel_butt | passed |
| stroke_diagonal_w10_bevel_round | passed |
| stroke_diagonal_w10_bevel_square | passed |
| stroke_diagonal_w10_miter_butt | passed |
| stroke_diagonal_w10_miter_round | passed |
| stroke_diagonal_w10_miter_square | passed |
| stroke_diagonal_w10_round_butt | passed |
| stroke_diagonal_w10_round_round | passed |
| stroke_diagonal_w10_round_square | passed |
| stroke_diagonal_w10_square_butt | passed |
| stroke_diagonal_w10_square_round | passed |
| stroke_diagonal_w10_square_square | passed |
| stroke_diagonal_w4_bevel_butt | passed |
| stroke_diagonal_w4_bevel_round | passed |
| stroke_diagonal_w4_bevel_square | passed |
| stroke_diagonal_w4_miter_butt | passed |
| stroke_diagonal_w4_miter_round | passed |
| stroke_diagonal_w4_miter_square | passed |
| stroke_diagonal_w4_round_butt | passed |
| stroke_diagonal_w4_round_round | passed |
| stroke_diagonal_w4_round_square | passed |
| stroke_diagonal_w4_square_butt | passed |
| stroke_diagonal_w4_square_round | passed |
| stroke_diagonal_w4_square_square | passed |
| stroke_horizontal_w10_bevel_butt | passed |
| stroke_horizontal_w10_bevel_round | passed |
| stroke_horizontal_w10_bevel_square | passed |
| stroke_horizontal_w10_miter_butt | passed |
| stroke_horizontal_w10_miter_round | passed |
| stroke_horizontal_w10_miter_square | passed |
| stroke_horizontal_w10_round_butt | passed |
| stroke_horizontal_w10_round_round | passed |
| stroke_horizontal_w10_round_square | passed |
| stroke_horizontal_w10_square_butt | passed |
| stroke_horizontal_w10_square_round | passed |
| stroke_horizontal_w10_square_square | passed |
| stroke_horizontal_w4_bevel_butt | passed |
| stroke_horizontal_w4_bevel_round | passed |
| stroke_horizontal_w4_bevel_square | passed |
| stroke_horizontal_w4_miter_butt | passed |
| stroke_horizontal_w4_miter_round | passed |
| stroke_horizontal_w4_miter_square | passed |
| stroke_horizontal_w4_round_butt | passed |
| stroke_horizontal_w4_round_round | passed |
| stroke_horizontal_w4_round_square | passed |
| stroke_horizontal_w4_square_butt | passed |
| stroke_horizontal_w4_square_round | passed |
| stroke_horizontal_w4_square_square | passed |
| stroke_miter_acute_m10_miter_butt | passed |
| stroke_miter_acute_m10_miter_round | passed |
| stroke_miter_acute_m10_miter_square | passed |
| stroke_miter_acute_m4_miter_butt | passed |
| stroke_miter_acute_m4_miter_round | passed |
| stroke_miter_acute_m4_miter_square | passed |
| stroke_miter_acute_other_m10_miter_butt | passed |
| stroke_miter_acute_other_m10_miter_round | passed |
| stroke_miter_acute_other_m10_miter_square | passed |
| stroke_miter_acute_other_m4_miter_butt | passed |
| stroke_miter_acute_other_m4_miter_round | passed |
| stroke_miter_acute_other_m4_miter_square | passed |
| stroke_reversal_w10_bevel_butt | passed |
| stroke_reversal_w10_bevel_round | passed |
| stroke_reversal_w10_bevel_square | passed |
| stroke_reversal_w10_miter_butt | passed |
| stroke_reversal_w10_miter_round | passed |
| stroke_reversal_w10_miter_square | passed |
| stroke_reversal_w10_round_butt | passed |
| stroke_reversal_w10_round_round | passed |
| stroke_reversal_w10_round_square | passed |
| stroke_reversal_w10_square_butt | passed |
| stroke_reversal_w10_square_round | passed |
| stroke_reversal_w10_square_square | passed |
| stroke_reversal_w4_bevel_butt | passed |
| stroke_reversal_w4_bevel_round | passed |
| stroke_reversal_w4_bevel_square | passed |
| stroke_reversal_w4_miter_butt | passed |
| stroke_reversal_w4_miter_round | passed |
| stroke_reversal_w4_miter_square | passed |
| stroke_reversal_w4_round_butt | passed |
| stroke_reversal_w4_round_round | passed |
| stroke_reversal_w4_round_square | passed |
| stroke_reversal_w4_square_butt | passed |
| stroke_reversal_w4_square_round | passed |
| stroke_reversal_w4_square_square | passed |
| stroke_right_angle_w10_bevel_butt | passed |
| stroke_right_angle_w10_bevel_round | passed |
| stroke_right_angle_w10_bevel_square | passed |
| stroke_right_angle_w10_miter_butt | passed |
| stroke_right_angle_w10_miter_round | passed |
| stroke_right_angle_w10_miter_square | passed |
| stroke_right_angle_w10_round_butt | passed |
| stroke_right_angle_w10_round_round | passed |
| stroke_right_angle_w10_round_square | passed |
| stroke_right_angle_w10_square_butt | passed |
| stroke_right_angle_w10_square_round | passed |
| stroke_right_angle_w10_square_square | passed |
| stroke_right_angle_w4_bevel_butt | passed |
| stroke_right_angle_w4_bevel_round | passed |
| stroke_right_angle_w4_bevel_square | passed |
| stroke_right_angle_w4_miter_butt | passed |
| stroke_right_angle_w4_miter_round | passed |
| stroke_right_angle_w4_miter_square | passed |
| stroke_right_angle_w4_round_butt | passed |
| stroke_right_angle_w4_round_round | passed |
| stroke_right_angle_w4_round_square | passed |
| stroke_right_angle_w4_square_butt | passed |
| stroke_right_angle_w4_square_round | passed |
| stroke_right_angle_w4_square_square | passed |
| stroke_self_crossing_w10_bevel_butt | passed |
| stroke_self_crossing_w10_bevel_round | passed |
| stroke_self_crossing_w10_bevel_square | passed |
| stroke_self_crossing_w10_miter_butt | passed |
| stroke_self_crossing_w10_miter_round | passed |
| stroke_self_crossing_w10_miter_square | passed |
| stroke_self_crossing_w10_round_butt | passed |
| stroke_self_crossing_w10_round_round | passed |
| stroke_self_crossing_w10_round_square | passed |
| stroke_self_crossing_w10_square_butt | passed |
| stroke_self_crossing_w10_square_round | passed |
| stroke_self_crossing_w10_square_square | passed |
| stroke_self_crossing_w4_bevel_butt | passed |
| stroke_self_crossing_w4_bevel_round | passed |
| stroke_self_crossing_w4_bevel_square | passed |
| stroke_self_crossing_w4_miter_butt | passed |
| stroke_self_crossing_w4_miter_round | passed |
| stroke_self_crossing_w4_miter_square | passed |
| stroke_self_crossing_w4_round_butt | passed |
| stroke_self_crossing_w4_round_round | passed |
| stroke_self_crossing_w4_round_square | passed |
| stroke_self_crossing_w4_square_butt | passed |
| stroke_self_crossing_w4_square_round | passed |
| stroke_self_crossing_w4_square_square | passed |
| stroke_threshold_w101_bevel_butt | passed |
| stroke_threshold_w101_bevel_round | passed |
| stroke_threshold_w101_bevel_square | passed |
| stroke_threshold_w101_miter_butt | passed |
| stroke_threshold_w101_miter_round | passed |
| stroke_threshold_w101_miter_square | passed |
| stroke_threshold_w101_round_butt | passed |
| stroke_threshold_w101_round_round | passed |
| stroke_threshold_w101_round_square | passed |
| stroke_threshold_w101_square_butt | passed |
| stroke_threshold_w101_square_round | passed |
| stroke_threshold_w101_square_square | passed |
| stroke_threshold_w199_bevel_butt | passed |
| stroke_threshold_w199_bevel_round | passed |
| stroke_threshold_w199_bevel_square | passed |
| stroke_threshold_w199_miter_butt | passed |
| stroke_threshold_w199_miter_round | passed |
| stroke_threshold_w199_miter_square | passed |
| stroke_threshold_w199_round_butt | passed |
| stroke_threshold_w199_round_round | passed |
| stroke_threshold_w199_round_square | passed |
| stroke_threshold_w199_square_butt | passed |
| stroke_threshold_w199_square_round | passed |
| stroke_threshold_w199_square_square | passed |
| stroke_threshold_w1_bevel_butt | passed |
| stroke_threshold_w1_bevel_round | passed |
| stroke_threshold_w1_bevel_square | passed |
| stroke_threshold_w1_miter_butt | passed |
| stroke_threshold_w1_miter_round | passed |
| stroke_threshold_w1_miter_square | passed |
| stroke_threshold_w1_round_butt | passed |
| stroke_threshold_w1_round_round | passed |
| stroke_threshold_w1_round_square | passed |
| stroke_threshold_w1_square_butt | passed |
| stroke_threshold_w1_square_round | passed |
| stroke_threshold_w1_square_square | passed |
| stroke_threshold_w2_bevel_butt | passed |
| stroke_threshold_w2_bevel_round | passed |
| stroke_threshold_w2_bevel_square | passed |
| stroke_threshold_w2_miter_butt | passed |
| stroke_threshold_w2_miter_round | passed |
| stroke_threshold_w2_miter_square | passed |
| stroke_threshold_w2_round_butt | passed |
| stroke_threshold_w2_round_round | passed |
| stroke_threshold_w2_round_square | passed |
| stroke_threshold_w2_square_butt | passed |
| stroke_threshold_w2_square_round | passed |
| stroke_threshold_w2_square_square | passed |
| stroke_threshold_w3_bevel_butt | passed |
| stroke_threshold_w3_bevel_round | passed |
| stroke_threshold_w3_bevel_square | passed |
| stroke_threshold_w3_miter_butt | passed |
| stroke_threshold_w3_miter_round | passed |
| stroke_threshold_w3_miter_square | passed |
| stroke_threshold_w3_round_butt | passed |
| stroke_threshold_w3_round_round | passed |
| stroke_threshold_w3_round_square | passed |
| stroke_threshold_w3_square_butt | passed |
| stroke_threshold_w3_square_round | passed |
| stroke_threshold_w3_square_square | passed |
| stroke_vertical_w10_bevel_butt | passed |
| stroke_vertical_w10_bevel_round | passed |
| stroke_vertical_w10_bevel_square | passed |
| stroke_vertical_w10_miter_butt | passed |
| stroke_vertical_w10_miter_round | passed |
| stroke_vertical_w10_miter_square | passed |
| stroke_vertical_w10_round_butt | passed |
| stroke_vertical_w10_round_round | passed |
| stroke_vertical_w10_round_square | passed |
| stroke_vertical_w10_square_butt | passed |
| stroke_vertical_w10_square_round | passed |
| stroke_vertical_w10_square_square | passed |
| stroke_vertical_w4_bevel_butt | passed |
| stroke_vertical_w4_bevel_round | passed |
| stroke_vertical_w4_bevel_square | passed |
| stroke_vertical_w4_miter_butt | passed |
| stroke_vertical_w4_miter_round | passed |
| stroke_vertical_w4_miter_square | passed |
| stroke_vertical_w4_round_butt | passed |
| stroke_vertical_w4_round_round | passed |
| stroke_vertical_w4_round_square | passed |
| stroke_vertical_w4_square_butt | passed |
| stroke_vertical_w4_square_round | passed |
| stroke_vertical_w4_square_square | passed |

# Composition compatibility

Independent recipes: 24/24; required=24; differences=0; execution_errors=0. Boolean200 + Offset272 + Stroke276 + Composition24 =772 independent inputs.

Each recipe counts once. Both real intermediate and final outputs are compared. InsetThenTree includes strict parentage and winding. Public calls each own a fresh budget; resource rejection tests are MoonClip functional evidence, not Clipper2 resource compatibility.

| Recipe | Cases |
| --- | ---: |
| BooleanThenOffset | 8 |
| InsetThenTree | 8 |
| StrokeThenIntersection | 8 |

| Target | Composition filtered recipes |
| --- | --- |
| native | 24/24 |
| js | 24/24 |

| Recipe ID | Intermediate | Final | Status | Failure step |
| --- | --- | --- | --- | --- |
| composition_boolean_disjoint_in | passed | passed | passed |  |
| composition_boolean_disjoint_out | passed | passed | passed |  |
| composition_boolean_hole_in | passed | passed | passed |  |
| composition_boolean_hole_out | passed | passed | passed |  |
| composition_boolean_notch_in | passed | passed | passed |  |
| composition_boolean_notch_out | passed | passed | passed |  |
| composition_boolean_overlap_in | passed | passed | passed |  |
| composition_boolean_overlap_out | passed | passed | passed |  |
| composition_inset_channel_d2 | passed | passed | passed |  |
| composition_inset_channel_d4 | passed | passed | passed |  |
| composition_inset_hole_d2 | passed | passed | passed |  |
| composition_inset_hole_d4 | passed | passed | passed |  |
| composition_inset_island_d2 | passed | passed | passed |  |
| composition_inset_island_d4 | passed | passed | passed |  |
| composition_inset_touch_d2 | passed | passed | passed |  |
| composition_inset_touch_d4 | passed | passed | passed |  |
| composition_stroke_cap_butt | passed | passed | passed |  |
| composition_stroke_cap_round | passed | passed | passed |  |
| composition_stroke_corner_butt | passed | passed | passed |  |
| composition_stroke_corner_round | passed | passed | passed |  |
| composition_stroke_hole_butt | passed | passed | passed |  |
| composition_stroke_hole_round | passed | passed | passed |  |
| composition_stroke_straight_butt | passed | passed | passed |  |
| composition_stroke_straight_round | passed | passed | passed |  |

# Decimal compatibility

Decimal public paths: 220/220; required=220; differences=0; execution_errors=0. Independent reference total: 772 +220 =992.

MoonClip always uses 10^precision. DecimalGrid invokes the pinned integer routes after independent std::round quantization; ClipperDCommonGrid really invokes ClipperD and verifies its raw output lies on the target grid before any integer conversion. These 24 common-grid cases do not establish general ClipperD equivalence.

Comparison checks full integer contours AND exact coordinate64 / scale decoding, finite output and positive zero; re-quantizing arbitrary decimal output is insufficient. Quantization rejection and budgets are MoonClip contract tests.

| Reference route | Required | Executed | Passed | Differences | Execution errors |
| --- | ---: | ---: | ---: | ---: | ---: |
| ClipperDCommonGrid | 24 | 24 | 24 | 0 | 0 |
| DecimalGrid | 196 | 196 | 196 | 0 | 0 |

| Operation | Cases | Precision coverage |
| --- | ---: | --- |
| BooleanD | 136 | 0: 24, 1: 16, 2: 16, 3: 24, 4: 16, 5: 16, 6: 24 |
| OffsetD | 48 | 0: 16, 3: 16, 6: 16 |
| StrokeD | 36 | 0: 12, 3: 12, 6: 12 |

| Parameter | Actual case coverage |
| --- | --- |
| arc_tolerance | 0.025: 84 |
| cap_type | Butt: 12, Round: 12, Square: 12 |
| clip_type | Difference: 34, Intersection: 34, Union: 34, Xor: 34 |
| delta | -0.2: 24, 0.2: 24 |
| fill_rule | EvenOdd: 92, NonZero: 92 |
| join_type | Bevel: 21, Miter: 21, Round: 21, Square: 21 |
| miter_limit | 2.0: 84 |
| width | 0.4: 36 |

| Target | Decimal filtered paths |
| --- | --- |
| native | 220/220 |
| js | 220/220 |

| Decimal case | Route | Precision | Grid contours | Decoded coordinates | Status |
| --- | --- | ---: | --- | --- | --- |
| decimal_boolean_hole_difference_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_hole_difference_evenodd_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_hole_difference_evenodd_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_hole_difference_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_hole_difference_evenodd_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_hole_difference_evenodd_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_hole_difference_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_boolean_hole_difference_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_hole_difference_nonzero_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_hole_difference_nonzero_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_hole_difference_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_hole_difference_nonzero_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_hole_difference_nonzero_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_hole_difference_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_boolean_hole_intersection_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_hole_intersection_evenodd_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_hole_intersection_evenodd_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_hole_intersection_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_hole_intersection_evenodd_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_hole_intersection_evenodd_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_hole_intersection_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_boolean_hole_intersection_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_hole_intersection_nonzero_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_hole_intersection_nonzero_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_hole_intersection_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_hole_intersection_nonzero_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_hole_intersection_nonzero_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_hole_intersection_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_boolean_hole_union_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_hole_union_evenodd_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_hole_union_evenodd_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_hole_union_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_hole_union_evenodd_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_hole_union_evenodd_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_hole_union_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_boolean_hole_union_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_hole_union_nonzero_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_hole_union_nonzero_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_hole_union_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_hole_union_nonzero_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_hole_union_nonzero_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_hole_union_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_boolean_hole_xor_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_hole_xor_evenodd_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_hole_xor_evenodd_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_hole_xor_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_hole_xor_evenodd_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_hole_xor_evenodd_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_hole_xor_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_boolean_hole_xor_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_hole_xor_nonzero_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_hole_xor_nonzero_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_hole_xor_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_hole_xor_nonzero_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_hole_xor_nonzero_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_hole_xor_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_boolean_overlap_difference_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_overlap_difference_evenodd_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_overlap_difference_evenodd_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_overlap_difference_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_overlap_difference_evenodd_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_overlap_difference_evenodd_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_overlap_difference_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_boolean_overlap_difference_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_overlap_difference_nonzero_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_overlap_difference_nonzero_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_overlap_difference_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_overlap_difference_nonzero_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_overlap_difference_nonzero_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_overlap_difference_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_boolean_overlap_intersection_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_overlap_intersection_evenodd_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_overlap_intersection_evenodd_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_overlap_intersection_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_overlap_intersection_evenodd_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_overlap_intersection_evenodd_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_overlap_intersection_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_boolean_overlap_intersection_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_overlap_intersection_nonzero_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_overlap_intersection_nonzero_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_overlap_intersection_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_overlap_intersection_nonzero_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_overlap_intersection_nonzero_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_overlap_intersection_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_boolean_overlap_union_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_overlap_union_evenodd_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_overlap_union_evenodd_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_overlap_union_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_overlap_union_evenodd_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_overlap_union_evenodd_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_overlap_union_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_boolean_overlap_union_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_overlap_union_nonzero_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_overlap_union_nonzero_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_overlap_union_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_overlap_union_nonzero_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_overlap_union_nonzero_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_overlap_union_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_boolean_overlap_xor_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_overlap_xor_evenodd_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_overlap_xor_evenodd_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_overlap_xor_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_overlap_xor_evenodd_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_overlap_xor_evenodd_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_overlap_xor_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_boolean_overlap_xor_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_boolean_overlap_xor_nonzero_p1 | DecimalGrid | 1 | passed | passed | passed |
| decimal_boolean_overlap_xor_nonzero_p2 | DecimalGrid | 2 | passed | passed | passed |
| decimal_boolean_overlap_xor_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_boolean_overlap_xor_nonzero_p4 | DecimalGrid | 4 | passed | passed | passed |
| decimal_boolean_overlap_xor_nonzero_p5 | DecimalGrid | 5 | passed | passed | passed |
| decimal_boolean_overlap_xor_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_clipperd_difference_evenodd_p0 | ClipperDCommonGrid | 0 | passed | passed | passed |
| decimal_clipperd_difference_evenodd_p3 | ClipperDCommonGrid | 3 | passed | passed | passed |
| decimal_clipperd_difference_evenodd_p6 | ClipperDCommonGrid | 6 | passed | passed | passed |
| decimal_clipperd_difference_nonzero_p0 | ClipperDCommonGrid | 0 | passed | passed | passed |
| decimal_clipperd_difference_nonzero_p3 | ClipperDCommonGrid | 3 | passed | passed | passed |
| decimal_clipperd_difference_nonzero_p6 | ClipperDCommonGrid | 6 | passed | passed | passed |
| decimal_clipperd_intersection_evenodd_p0 | ClipperDCommonGrid | 0 | passed | passed | passed |
| decimal_clipperd_intersection_evenodd_p3 | ClipperDCommonGrid | 3 | passed | passed | passed |
| decimal_clipperd_intersection_evenodd_p6 | ClipperDCommonGrid | 6 | passed | passed | passed |
| decimal_clipperd_intersection_nonzero_p0 | ClipperDCommonGrid | 0 | passed | passed | passed |
| decimal_clipperd_intersection_nonzero_p3 | ClipperDCommonGrid | 3 | passed | passed | passed |
| decimal_clipperd_intersection_nonzero_p6 | ClipperDCommonGrid | 6 | passed | passed | passed |
| decimal_clipperd_union_evenodd_p0 | ClipperDCommonGrid | 0 | passed | passed | passed |
| decimal_clipperd_union_evenodd_p3 | ClipperDCommonGrid | 3 | passed | passed | passed |
| decimal_clipperd_union_evenodd_p6 | ClipperDCommonGrid | 6 | passed | passed | passed |
| decimal_clipperd_union_nonzero_p0 | ClipperDCommonGrid | 0 | passed | passed | passed |
| decimal_clipperd_union_nonzero_p3 | ClipperDCommonGrid | 3 | passed | passed | passed |
| decimal_clipperd_union_nonzero_p6 | ClipperDCommonGrid | 6 | passed | passed | passed |
| decimal_clipperd_xor_evenodd_p0 | ClipperDCommonGrid | 0 | passed | passed | passed |
| decimal_clipperd_xor_evenodd_p3 | ClipperDCommonGrid | 3 | passed | passed | passed |
| decimal_clipperd_xor_evenodd_p6 | ClipperDCommonGrid | 6 | passed | passed | passed |
| decimal_clipperd_xor_nonzero_p0 | ClipperDCommonGrid | 0 | passed | passed | passed |
| decimal_clipperd_xor_nonzero_p3 | ClipperDCommonGrid | 3 | passed | passed | passed |
| decimal_clipperd_xor_nonzero_p6 | ClipperDCommonGrid | 6 | passed | passed | passed |
| decimal_offset_bevel_in_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_bevel_in_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_bevel_in_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_offset_bevel_in_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_bevel_in_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_bevel_in_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_offset_bevel_out_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_bevel_out_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_bevel_out_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_offset_bevel_out_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_bevel_out_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_bevel_out_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_offset_miter_in_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_miter_in_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_miter_in_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_offset_miter_in_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_miter_in_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_miter_in_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_offset_miter_out_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_miter_out_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_miter_out_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_offset_miter_out_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_miter_out_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_miter_out_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_offset_round_in_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_round_in_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_round_in_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_offset_round_in_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_round_in_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_round_in_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_offset_round_out_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_round_out_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_round_out_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_offset_round_out_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_round_out_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_round_out_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_offset_square_in_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_square_in_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_square_in_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_offset_square_in_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_square_in_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_square_in_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_offset_square_out_evenodd_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_square_out_evenodd_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_square_out_evenodd_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_offset_square_out_nonzero_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_offset_square_out_nonzero_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_offset_square_out_nonzero_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_stroke_bevel_butt_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_stroke_bevel_butt_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_stroke_bevel_butt_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_stroke_bevel_round_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_stroke_bevel_round_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_stroke_bevel_round_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_stroke_bevel_square_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_stroke_bevel_square_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_stroke_bevel_square_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_stroke_miter_butt_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_stroke_miter_butt_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_stroke_miter_butt_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_stroke_miter_round_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_stroke_miter_round_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_stroke_miter_round_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_stroke_miter_square_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_stroke_miter_square_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_stroke_miter_square_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_stroke_round_butt_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_stroke_round_butt_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_stroke_round_butt_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_stroke_round_round_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_stroke_round_round_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_stroke_round_round_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_stroke_round_square_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_stroke_round_square_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_stroke_round_square_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_stroke_square_butt_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_stroke_square_butt_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_stroke_square_butt_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_stroke_square_round_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_stroke_square_round_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_stroke_square_round_p6 | DecimalGrid | 6 | passed | passed | passed |
| decimal_stroke_square_square_p0 | DecimalGrid | 0 | passed | passed | passed |
| decimal_stroke_square_square_p3 | DecimalGrid | 3 | passed | passed | passed |
| decimal_stroke_square_square_p6 | DecimalGrid | 6 | passed | passed | passed |

# Simplification compatibility

Ordered simplification: 224/224; required=224; differences=0; execution_errors=0. Independent total: 992 +224 =1216.

Pinned C++ SimplifyPaths after agreed normalization; the adapter independently computes reports. DecimalGrid quantizes first and calls the integer template, not SimplifyPaths<PointD>. Zero threshold is a separate MoonClip contract. Empty and degenerate paths are successful results. No ring rotation or path sorting is permitted.

| Route / capability | Required | Executed | Passed | Differences | Execution errors |
| --- | ---: | ---: | ---: | ---: | ---: |
| DecimalGrid | 144 | 144 | 144 | 0 | 0 |
| Integer | 80 | 80 | 80 | 0 | 0 |
| ordered_paths | 224 | 224 | 224 | 0 | 0 |
| removed_counts | 224 | 224 | 224 | 0 | 0 |
| degeneracy | 224 | 224 | 224 | 0 | 0 |

| Target | Simplify filtered cases |
| --- | --- |
| native | 224/224 |
| js | 224/224 |

| Case | Ordered paths and decoding | Removed counts | Degeneracy | Status |
| --- | --- | --- | --- | --- |
| simplify_decimal_acute_closed_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_acute_closed_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_acute_closed_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_acute_closed_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_acute_closed_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_acute_closed_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_acute_closed_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_acute_closed_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_acute_closed_p6_e2 | passed | passed | passed | passed |
| simplify_decimal_acute_open_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_acute_open_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_acute_open_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_acute_open_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_acute_open_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_acute_open_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_acute_open_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_acute_open_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_acute_open_p6_e2 | passed | passed | passed | passed |
| simplify_decimal_bowtie_closed_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_bowtie_closed_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_bowtie_closed_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_bowtie_closed_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_bowtie_closed_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_bowtie_closed_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_bowtie_closed_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_bowtie_closed_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_bowtie_closed_p6_e2 | passed | passed | passed | passed |
| simplify_decimal_bowtie_open_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_bowtie_open_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_bowtie_open_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_bowtie_open_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_bowtie_open_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_bowtie_open_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_bowtie_open_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_bowtie_open_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_bowtie_open_p6_e2 | passed | passed | passed | passed |
| simplify_decimal_channel_closed_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_channel_closed_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_channel_closed_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_channel_closed_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_channel_closed_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_channel_closed_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_channel_closed_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_channel_closed_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_channel_closed_p6_e2 | passed | passed | passed | passed |
| simplify_decimal_channel_open_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_channel_open_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_channel_open_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_channel_open_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_channel_open_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_channel_open_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_channel_open_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_channel_open_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_channel_open_p6_e2 | passed | passed | passed | passed |
| simplify_decimal_dense_closed_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_dense_closed_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_dense_closed_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_dense_closed_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_dense_closed_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_dense_closed_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_dense_closed_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_dense_closed_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_dense_closed_p6_e2 | passed | passed | passed | passed |
| simplify_decimal_dense_open_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_dense_open_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_dense_open_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_dense_open_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_dense_open_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_dense_open_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_dense_open_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_dense_open_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_dense_open_p6_e2 | passed | passed | passed | passed |
| simplify_decimal_mixed_closed_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_mixed_closed_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_mixed_closed_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_mixed_closed_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_mixed_closed_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_mixed_closed_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_mixed_closed_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_mixed_closed_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_mixed_closed_p6_e2 | passed | passed | passed | passed |
| simplify_decimal_mixed_open_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_mixed_open_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_mixed_open_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_mixed_open_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_mixed_open_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_mixed_open_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_mixed_open_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_mixed_open_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_mixed_open_p6_e2 | passed | passed | passed | passed |
| simplify_decimal_notch_closed_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_notch_closed_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_notch_closed_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_notch_closed_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_notch_closed_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_notch_closed_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_notch_closed_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_notch_closed_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_notch_closed_p6_e2 | passed | passed | passed | passed |
| simplify_decimal_notch_open_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_notch_open_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_notch_open_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_notch_open_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_notch_open_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_notch_open_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_notch_open_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_notch_open_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_notch_open_p6_e2 | passed | passed | passed | passed |
| simplify_decimal_rectangle_closed_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_rectangle_closed_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_rectangle_closed_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_rectangle_closed_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_rectangle_closed_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_rectangle_closed_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_rectangle_closed_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_rectangle_closed_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_rectangle_closed_p6_e2 | passed | passed | passed | passed |
| simplify_decimal_rectangle_open_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_rectangle_open_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_rectangle_open_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_rectangle_open_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_rectangle_open_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_rectangle_open_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_rectangle_open_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_rectangle_open_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_rectangle_open_p6_e2 | passed | passed | passed | passed |
| simplify_decimal_saw_closed_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_saw_closed_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_saw_closed_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_saw_closed_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_saw_closed_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_saw_closed_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_saw_closed_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_saw_closed_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_saw_closed_p6_e2 | passed | passed | passed | passed |
| simplify_decimal_saw_open_p0_e0_25 | passed | passed | passed | passed |
| simplify_decimal_saw_open_p0_e0_5 | passed | passed | passed | passed |
| simplify_decimal_saw_open_p0_e2 | passed | passed | passed | passed |
| simplify_decimal_saw_open_p3_e0_25 | passed | passed | passed | passed |
| simplify_decimal_saw_open_p3_e0_5 | passed | passed | passed | passed |
| simplify_decimal_saw_open_p3_e2 | passed | passed | passed | passed |
| simplify_decimal_saw_open_p6_e0_25 | passed | passed | passed | passed |
| simplify_decimal_saw_open_p6_e0_5 | passed | passed | passed | passed |
| simplify_decimal_saw_open_p6_e2 | passed | passed | passed | passed |
| simplify_integer_acute_closed_e0_25 | passed | passed | passed | passed |
| simplify_integer_acute_closed_e0_5 | passed | passed | passed | passed |
| simplify_integer_acute_closed_e1 | passed | passed | passed | passed |
| simplify_integer_acute_closed_e4 | passed | passed | passed | passed |
| simplify_integer_acute_open_e0_25 | passed | passed | passed | passed |
| simplify_integer_acute_open_e0_5 | passed | passed | passed | passed |
| simplify_integer_acute_open_e1 | passed | passed | passed | passed |
| simplify_integer_acute_open_e4 | passed | passed | passed | passed |
| simplify_integer_bowtie_closed_e0_25 | passed | passed | passed | passed |
| simplify_integer_bowtie_closed_e0_5 | passed | passed | passed | passed |
| simplify_integer_bowtie_closed_e1 | passed | passed | passed | passed |
| simplify_integer_bowtie_closed_e4 | passed | passed | passed | passed |
| simplify_integer_bowtie_open_e0_25 | passed | passed | passed | passed |
| simplify_integer_bowtie_open_e0_5 | passed | passed | passed | passed |
| simplify_integer_bowtie_open_e1 | passed | passed | passed | passed |
| simplify_integer_bowtie_open_e4 | passed | passed | passed | passed |
| simplify_integer_channel_closed_e0_25 | passed | passed | passed | passed |
| simplify_integer_channel_closed_e0_5 | passed | passed | passed | passed |
| simplify_integer_channel_closed_e1 | passed | passed | passed | passed |
| simplify_integer_channel_closed_e4 | passed | passed | passed | passed |
| simplify_integer_channel_open_e0_25 | passed | passed | passed | passed |
| simplify_integer_channel_open_e0_5 | passed | passed | passed | passed |
| simplify_integer_channel_open_e1 | passed | passed | passed | passed |
| simplify_integer_channel_open_e4 | passed | passed | passed | passed |
| simplify_integer_dense_closed_e0_25 | passed | passed | passed | passed |
| simplify_integer_dense_closed_e0_5 | passed | passed | passed | passed |
| simplify_integer_dense_closed_e1 | passed | passed | passed | passed |
| simplify_integer_dense_closed_e4 | passed | passed | passed | passed |
| simplify_integer_dense_open_e0_25 | passed | passed | passed | passed |
| simplify_integer_dense_open_e0_5 | passed | passed | passed | passed |
| simplify_integer_dense_open_e1 | passed | passed | passed | passed |
| simplify_integer_dense_open_e4 | passed | passed | passed | passed |
| simplify_integer_mixed_closed_e0_25 | passed | passed | passed | passed |
| simplify_integer_mixed_closed_e0_5 | passed | passed | passed | passed |
| simplify_integer_mixed_closed_e1 | passed | passed | passed | passed |
| simplify_integer_mixed_closed_e4 | passed | passed | passed | passed |
| simplify_integer_mixed_open_e0_25 | passed | passed | passed | passed |
| simplify_integer_mixed_open_e0_5 | passed | passed | passed | passed |
| simplify_integer_mixed_open_e1 | passed | passed | passed | passed |
| simplify_integer_mixed_open_e4 | passed | passed | passed | passed |
| simplify_integer_notch_closed_e0_25 | passed | passed | passed | passed |
| simplify_integer_notch_closed_e0_5 | passed | passed | passed | passed |
| simplify_integer_notch_closed_e1 | passed | passed | passed | passed |
| simplify_integer_notch_closed_e4 | passed | passed | passed | passed |
| simplify_integer_notch_open_e0_25 | passed | passed | passed | passed |
| simplify_integer_notch_open_e0_5 | passed | passed | passed | passed |
| simplify_integer_notch_open_e1 | passed | passed | passed | passed |
| simplify_integer_notch_open_e4 | passed | passed | passed | passed |
| simplify_integer_rectangle_closed_e0_25 | passed | passed | passed | passed |
| simplify_integer_rectangle_closed_e0_5 | passed | passed | passed | passed |
| simplify_integer_rectangle_closed_e1 | passed | passed | passed | passed |
| simplify_integer_rectangle_closed_e4 | passed | passed | passed | passed |
| simplify_integer_rectangle_open_e0_25 | passed | passed | passed | passed |
| simplify_integer_rectangle_open_e0_5 | passed | passed | passed | passed |
| simplify_integer_rectangle_open_e1 | passed | passed | passed | passed |
| simplify_integer_rectangle_open_e4 | passed | passed | passed | passed |
| simplify_integer_repeats_closed_e0_25 | passed | passed | passed | passed |
| simplify_integer_repeats_closed_e0_5 | passed | passed | passed | passed |
| simplify_integer_repeats_closed_e1 | passed | passed | passed | passed |
| simplify_integer_repeats_closed_e4 | passed | passed | passed | passed |
| simplify_integer_repeats_open_e0_25 | passed | passed | passed | passed |
| simplify_integer_repeats_open_e0_5 | passed | passed | passed | passed |
| simplify_integer_repeats_open_e1 | passed | passed | passed | passed |
| simplify_integer_repeats_open_e4 | passed | passed | passed | passed |
| simplify_integer_retrace_closed_e0_25 | passed | passed | passed | passed |
| simplify_integer_retrace_closed_e0_5 | passed | passed | passed | passed |
| simplify_integer_retrace_closed_e1 | passed | passed | passed | passed |
| simplify_integer_retrace_closed_e4 | passed | passed | passed | passed |
| simplify_integer_retrace_open_e0_25 | passed | passed | passed | passed |
| simplify_integer_retrace_open_e0_5 | passed | passed | passed | passed |
| simplify_integer_retrace_open_e1 | passed | passed | passed | passed |
| simplify_integer_retrace_open_e4 | passed | passed | passed | passed |
| simplify_integer_saw_closed_e0_25 | passed | passed | passed | passed |
| simplify_integer_saw_closed_e0_5 | passed | passed | passed | passed |
| simplify_integer_saw_closed_e1 | passed | passed | passed | passed |
| simplify_integer_saw_closed_e4 | passed | passed | passed | passed |
| simplify_integer_saw_open_e0_25 | passed | passed | passed | passed |
| simplify_integer_saw_open_e0_5 | passed | passed | passed | passed |
| simplify_integer_saw_open_e1 | passed | passed | passed | passed |
| simplify_integer_saw_open_e4 | passed | passed | passed | passed |

# Minkowski Sum compatibility

MinkowskiSum public paths: 144/144; required=144; differences=0; execution_errors=0. Seven-catalog baseline subtotal: 1216 +144 =1360; random additions are counted separately.

Real pinned MinkowskiSum, internal NonZero, preserve_collinear=true, reverse_solution=false. Complete contours preserve collinear vertices, winding and multiplicity; only sibling order and cyclic starts are normalized. No endpoint pattern fill, no automatic input normalization, and closed routes may retain holes.

| Coverage | Cases |
| --- | --- |
| directions | forward: 72, reverse: 72 |
| modes | Closed: 72, Open: 72 |
| patterns | circle: 36, concave: 36, offcenter: 36, rectangle: 36 |
| routes | acute: 16, diagonal: 16, long_horizontal: 16, rectangle: 16, repeats: 16, retrace: 16, right_angle: 16, selfcross: 16, short_horizontal: 16 |

| Target | Minkowski filtered paths |
| --- | --- |
| native | 144/144 |
| js | 144/144 |

| Minkowski case | Native complete contours |
| --- | --- |
| minkowski_circle_acute_closed_forward | passed |
| minkowski_circle_acute_closed_reverse | passed |
| minkowski_circle_acute_open_forward | passed |
| minkowski_circle_acute_open_reverse | passed |
| minkowski_circle_diagonal_closed_forward | passed |
| minkowski_circle_diagonal_closed_reverse | passed |
| minkowski_circle_diagonal_open_forward | passed |
| minkowski_circle_diagonal_open_reverse | passed |
| minkowski_circle_long_horizontal_closed_forward | passed |
| minkowski_circle_long_horizontal_closed_reverse | passed |
| minkowski_circle_long_horizontal_open_forward | passed |
| minkowski_circle_long_horizontal_open_reverse | passed |
| minkowski_circle_rectangle_closed_forward | passed |
| minkowski_circle_rectangle_closed_reverse | passed |
| minkowski_circle_rectangle_open_forward | passed |
| minkowski_circle_rectangle_open_reverse | passed |
| minkowski_circle_repeats_closed_forward | passed |
| minkowski_circle_repeats_closed_reverse | passed |
| minkowski_circle_repeats_open_forward | passed |
| minkowski_circle_repeats_open_reverse | passed |
| minkowski_circle_retrace_closed_forward | passed |
| minkowski_circle_retrace_closed_reverse | passed |
| minkowski_circle_retrace_open_forward | passed |
| minkowski_circle_retrace_open_reverse | passed |
| minkowski_circle_right_angle_closed_forward | passed |
| minkowski_circle_right_angle_closed_reverse | passed |
| minkowski_circle_right_angle_open_forward | passed |
| minkowski_circle_right_angle_open_reverse | passed |
| minkowski_circle_selfcross_closed_forward | passed |
| minkowski_circle_selfcross_closed_reverse | passed |
| minkowski_circle_selfcross_open_forward | passed |
| minkowski_circle_selfcross_open_reverse | passed |
| minkowski_circle_short_horizontal_closed_forward | passed |
| minkowski_circle_short_horizontal_closed_reverse | passed |
| minkowski_circle_short_horizontal_open_forward | passed |
| minkowski_circle_short_horizontal_open_reverse | passed |
| minkowski_concave_acute_closed_forward | passed |
| minkowski_concave_acute_closed_reverse | passed |
| minkowski_concave_acute_open_forward | passed |
| minkowski_concave_acute_open_reverse | passed |
| minkowski_concave_diagonal_closed_forward | passed |
| minkowski_concave_diagonal_closed_reverse | passed |
| minkowski_concave_diagonal_open_forward | passed |
| minkowski_concave_diagonal_open_reverse | passed |
| minkowski_concave_long_horizontal_closed_forward | passed |
| minkowski_concave_long_horizontal_closed_reverse | passed |
| minkowski_concave_long_horizontal_open_forward | passed |
| minkowski_concave_long_horizontal_open_reverse | passed |
| minkowski_concave_rectangle_closed_forward | passed |
| minkowski_concave_rectangle_closed_reverse | passed |
| minkowski_concave_rectangle_open_forward | passed |
| minkowski_concave_rectangle_open_reverse | passed |
| minkowski_concave_repeats_closed_forward | passed |
| minkowski_concave_repeats_closed_reverse | passed |
| minkowski_concave_repeats_open_forward | passed |
| minkowski_concave_repeats_open_reverse | passed |
| minkowski_concave_retrace_closed_forward | passed |
| minkowski_concave_retrace_closed_reverse | passed |
| minkowski_concave_retrace_open_forward | passed |
| minkowski_concave_retrace_open_reverse | passed |
| minkowski_concave_right_angle_closed_forward | passed |
| minkowski_concave_right_angle_closed_reverse | passed |
| minkowski_concave_right_angle_open_forward | passed |
| minkowski_concave_right_angle_open_reverse | passed |
| minkowski_concave_selfcross_closed_forward | passed |
| minkowski_concave_selfcross_closed_reverse | passed |
| minkowski_concave_selfcross_open_forward | passed |
| minkowski_concave_selfcross_open_reverse | passed |
| minkowski_concave_short_horizontal_closed_forward | passed |
| minkowski_concave_short_horizontal_closed_reverse | passed |
| minkowski_concave_short_horizontal_open_forward | passed |
| minkowski_concave_short_horizontal_open_reverse | passed |
| minkowski_offcenter_acute_closed_forward | passed |
| minkowski_offcenter_acute_closed_reverse | passed |
| minkowski_offcenter_acute_open_forward | passed |
| minkowski_offcenter_acute_open_reverse | passed |
| minkowski_offcenter_diagonal_closed_forward | passed |
| minkowski_offcenter_diagonal_closed_reverse | passed |
| minkowski_offcenter_diagonal_open_forward | passed |
| minkowski_offcenter_diagonal_open_reverse | passed |
| minkowski_offcenter_long_horizontal_closed_forward | passed |
| minkowski_offcenter_long_horizontal_closed_reverse | passed |
| minkowski_offcenter_long_horizontal_open_forward | passed |
| minkowski_offcenter_long_horizontal_open_reverse | passed |
| minkowski_offcenter_rectangle_closed_forward | passed |
| minkowski_offcenter_rectangle_closed_reverse | passed |
| minkowski_offcenter_rectangle_open_forward | passed |
| minkowski_offcenter_rectangle_open_reverse | passed |
| minkowski_offcenter_repeats_closed_forward | passed |
| minkowski_offcenter_repeats_closed_reverse | passed |
| minkowski_offcenter_repeats_open_forward | passed |
| minkowski_offcenter_repeats_open_reverse | passed |
| minkowski_offcenter_retrace_closed_forward | passed |
| minkowski_offcenter_retrace_closed_reverse | passed |
| minkowski_offcenter_retrace_open_forward | passed |
| minkowski_offcenter_retrace_open_reverse | passed |
| minkowski_offcenter_right_angle_closed_forward | passed |
| minkowski_offcenter_right_angle_closed_reverse | passed |
| minkowski_offcenter_right_angle_open_forward | passed |
| minkowski_offcenter_right_angle_open_reverse | passed |
| minkowski_offcenter_selfcross_closed_forward | passed |
| minkowski_offcenter_selfcross_closed_reverse | passed |
| minkowski_offcenter_selfcross_open_forward | passed |
| minkowski_offcenter_selfcross_open_reverse | passed |
| minkowski_offcenter_short_horizontal_closed_forward | passed |
| minkowski_offcenter_short_horizontal_closed_reverse | passed |
| minkowski_offcenter_short_horizontal_open_forward | passed |
| minkowski_offcenter_short_horizontal_open_reverse | passed |
| minkowski_rectangle_acute_closed_forward | passed |
| minkowski_rectangle_acute_closed_reverse | passed |
| minkowski_rectangle_acute_open_forward | passed |
| minkowski_rectangle_acute_open_reverse | passed |
| minkowski_rectangle_diagonal_closed_forward | passed |
| minkowski_rectangle_diagonal_closed_reverse | passed |
| minkowski_rectangle_diagonal_open_forward | passed |
| minkowski_rectangle_diagonal_open_reverse | passed |
| minkowski_rectangle_long_horizontal_closed_forward | passed |
| minkowski_rectangle_long_horizontal_closed_reverse | passed |
| minkowski_rectangle_long_horizontal_open_forward | passed |
| minkowski_rectangle_long_horizontal_open_reverse | passed |
| minkowski_rectangle_rectangle_closed_forward | passed |
| minkowski_rectangle_rectangle_closed_reverse | passed |
| minkowski_rectangle_rectangle_open_forward | passed |
| minkowski_rectangle_rectangle_open_reverse | passed |
| minkowski_rectangle_repeats_closed_forward | passed |
| minkowski_rectangle_repeats_closed_reverse | passed |
| minkowski_rectangle_repeats_open_forward | passed |
| minkowski_rectangle_repeats_open_reverse | passed |
| minkowski_rectangle_retrace_closed_forward | passed |
| minkowski_rectangle_retrace_closed_reverse | passed |
| minkowski_rectangle_retrace_open_forward | passed |
| minkowski_rectangle_retrace_open_reverse | passed |
| minkowski_rectangle_right_angle_closed_forward | passed |
| minkowski_rectangle_right_angle_closed_reverse | passed |
| minkowski_rectangle_right_angle_open_forward | passed |
| minkowski_rectangle_right_angle_open_reverse | passed |
| minkowski_rectangle_selfcross_closed_forward | passed |
| minkowski_rectangle_selfcross_closed_reverse | passed |
| minkowski_rectangle_selfcross_open_forward | passed |
| minkowski_rectangle_selfcross_open_reverse | passed |
| minkowski_rectangle_short_horizontal_closed_forward | passed |
| minkowski_rectangle_short_horizontal_closed_reverse | passed |
| minkowski_rectangle_short_horizontal_open_forward | passed |
| minkowski_rectangle_short_horizontal_open_reverse | passed |

# Manifest coverage matrix

Unique catalog cases: 1384; selected capability checks: 2276. A case with flat/tree or intermediate/final results is counted once as a case.

Each field value counts distinct cases containing that value (including composition steps). Counts across capabilities or fields must not be added as independent cases.

| Catalog | Cases | Selected checks | Capability selections |
| --- | ---: | ---: | --- |
| boolean | 200 | 400 | paths:validate=152, paths:validate_internal=48, tree:validate=152, tree:validate_internal=48 |
| offset | 272 | 272 | paths:validate=272 |
| stroke | 276 | 276 | paths:validate=276 |
| composition | 24 | 48 | final:validate=24, intermediate:validate=24 |
| decimal | 220 | 440 | grid_paths:validate=220, paths:validate=220 |
| simplify | 224 | 672 | degeneracy:validate=224, ordered_paths:validate=224, statistics:validate=224 |
| minkowski | 144 | 144 | paths:validate=144 |
| random | 24 | 24 | paths:validate=24 |

## boolean field coverage

| Field | Case incidence |
| --- | --- |
| fill_rule | "EvenOdd": 76, "Negative": 24, "NonZero": 76, "Positive": 24 |
| operation | "Difference": 50, "Intersection": 50, "Union": 50, "Xor": 50 |
| preserve_collinear | false: 200 |
| reverse_solution | false: 200 |

Absent / not applicable fields: clip_type, join_type, cap_type, precision, reference_route, mode, epsilon, path_is_closed.

## offset field coverage

| Field | Case incidence |
| --- | --- |
| fill_rule | "EvenOdd": 136, "NonZero": 136 |
| join_type | "Bevel": 54, "Miter": 62, "Round": 102, "Square": 54 |
| operation | "OffsetPolygons": 272 |
| preserve_collinear | false: 272 |
| reverse_solution | false: 272 |

Absent / not applicable fields: clip_type, cap_type, precision, reference_route, mode, epsilon, path_is_closed.

## stroke field coverage

| Field | Case incidence |
| --- | --- |
| cap_type | "Butt": 94, "Round": 94, "Square": 88 |
| join_type | "Bevel": 63, "Miter": 81, "Round": 69, "Square": 63 |
| operation | "StrokePolyline": 276 |
| preserve_collinear | false: 276 |
| reverse_solution | false: 276 |

Absent / not applicable fields: clip_type, fill_rule, precision, reference_route, mode, epsilon, path_is_closed.

## composition field coverage

| Field | Case incidence |
| --- | --- |
| cap_type | "Butt": 4, "Round": 4 |
| fill_rule | "NonZero": 24 |
| join_type | "Miter": 24 |
| operation | "Composition": 24, "Difference": 4, "Intersection": 8, "OffsetPolygons": 16, "StrokePolyline": 8, "Union": 12 |
| preserve_collinear | false: 24 |
| reverse_solution | false: 24 |

Absent / not applicable fields: clip_type, precision, reference_route, mode, epsilon, path_is_closed.

## decimal field coverage

| Field | Case incidence |
| --- | --- |
| cap_type | "Butt": 12, "Round": 12, "Square": 12 |
| clip_type | "Difference": 34, "Intersection": 34, "Union": 34, "Xor": 34 |
| fill_rule | "EvenOdd": 92, "NonZero": 92 |
| join_type | "Bevel": 21, "Miter": 21, "Round": 21, "Square": 21 |
| operation | "BooleanD": 136, "OffsetD": 48, "StrokeD": 36 |
| precision | 0: 52, 1: 16, 2: 16, 3: 52, 4: 16, 5: 16, 6: 52 |
| preserve_collinear | false: 220 |
| reference_route | "ClipperDCommonGrid": 24, "DecimalGrid": 196 |
| reverse_solution | false: 220 |

Absent / not applicable fields: mode, epsilon, path_is_closed.

## simplify field coverage

| Field | Case incidence |
| --- | --- |
| epsilon | 0.25: 68, 0.5: 68, 1: 20, 2: 48, 4: 20 |
| mode | "Closed": 112, "Open": 112 |
| operation | "Simplify64": 80, "SimplifyD": 144 |
| precision | 0: 48, 3: 48, 6: 48 |
| preserve_collinear | false: 224 |
| reference_route | "DecimalGrid": 144, "Integer": 80 |
| reverse_solution | false: 224 |

Absent / not applicable fields: clip_type, fill_rule, join_type, cap_type, path_is_closed.

## minkowski field coverage

| Field | Case incidence |
| --- | --- |
| operation | "MinkowskiSum": 144 |
| path_is_closed | false: 72, true: 72 |
| preserve_collinear | true: 144 |
| reverse_solution | false: 144 |

Absent / not applicable fields: clip_type, fill_rule, join_type, cap_type, precision, reference_route, mode, epsilon.

## random field coverage

| Field | Case incidence |
| --- | --- |
| fill_rule | "EvenOdd": 12, "NonZero": 12 |
| operation | "Difference": 6, "Intersection": 6, "Union": 6, "Xor": 6 |
| preserve_collinear | false: 24 |
| reverse_solution | false: 24 |

Absent / not applicable fields: clip_type, join_type, cap_type, precision, reference_route, mode, epsilon, path_is_closed.

## Limits of this evidence

- Manifest selections are coverage, not fresh execution evidence.
- Random v1 adds only public flat Boolean: three small configurations, four operations, two fill rules; no random trees, decimal, offset, stroke, simplification or Minkowski coverage.
- Positive/Negative Boolean remain internal; no open-path Boolean, MinkowskiDiff, decimal Minkowski or multi-pattern holes API. Unreleased decimal Boolean trees and integer/decimal offset trees are not validated by these catalogs.
- Simplification checks ordered vertices, statistics and degeneracy; it is not a general topology-preservation proof.
- Individual field coverage does not imply the full Cartesian product is covered. Missing fields below mean absent/not applicable, not passed.

# Fixed-seed random Boolean flat compatibility

Random cases: 24/24; differences=0; execution_errors=0. Reference total: 1360 + 24 = 1384.

Seed 20261019; xorshift32-small-polygons-v1. Three configurations x four operations x two fill rules. Inputs, order and hashes are locked; no random tree capability is claimed.

| Target | Actual random tests |
| --- | --- |
| native | 24/24 |
| js | 24/24 |

| Case | Configuration | Native flat result |
| --- | --- | --- |
| random_rectangle_intersection_evenodd | rectangle | passed |
| random_rectangle_intersection_nonzero | rectangle | passed |
| random_rectangle_union_evenodd | rectangle | passed |
| random_rectangle_union_nonzero | rectangle | passed |
| random_rectangle_difference_evenodd | rectangle | passed |
| random_rectangle_difference_nonzero | rectangle | passed |
| random_rectangle_xor_evenodd | rectangle | passed |
| random_rectangle_xor_nonzero | rectangle | passed |
| random_orthogonal_concave_intersection_evenodd | orthogonal_concave | passed |
| random_orthogonal_concave_intersection_nonzero | orthogonal_concave | passed |
| random_orthogonal_concave_union_evenodd | orthogonal_concave | passed |
| random_orthogonal_concave_union_nonzero | orthogonal_concave | passed |
| random_orthogonal_concave_difference_evenodd | orthogonal_concave | passed |
| random_orthogonal_concave_difference_nonzero | orthogonal_concave | passed |
| random_orthogonal_concave_xor_evenodd | orthogonal_concave | passed |
| random_orthogonal_concave_xor_nonzero | orthogonal_concave | passed |
| random_small_convex_intersection_evenodd | small_convex | passed |
| random_small_convex_intersection_nonzero | small_convex | passed |
| random_small_convex_union_evenodd | small_convex | passed |
| random_small_convex_union_nonzero | small_convex | passed |
| random_small_convex_difference_evenodd | small_convex | passed |
| random_small_convex_difference_nonzero | small_convex | passed |
| random_small_convex_xor_evenodd | small_convex | passed |
| random_small_convex_xor_nonzero | small_convex | passed |
