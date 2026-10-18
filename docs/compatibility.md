# Boolean compatibility

Pinned Clipper2 2.0.1, commit `21ebba05db8894f0c7217ad35ea518080f324946`; ordinary precision, preserve_collinear=false, reverse_solution=false.

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
| join_type | Bevel: 63, Miter: 81, Round: 69, Square: 63 |
| cap_type | Butt: 94, Round: 94, Square: 88 |
| width | 1.0: 12, 1.01: 12, 1.99: 12, 10.0: 108, 2.0: 12, 20.0: 12, 3.0: 12, 4.0: 96 |
| miter_limit | 10.0: 6, 2.0: 264, 4.0: 6 |
| arc_tolerance | 0.0: 264, 0.05: 4, 0.25: 4, 1.0: 4 |

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
| DecimalGrid | 196 | 196 | 196 | 0 | 0 |
| ClipperDCommonGrid | 24 | 24 | 24 | 0 | 0 |

| Operation | Cases | Precision coverage |
| --- | ---: | --- |
| BooleanD | 136 | 0: 24, 1: 16, 2: 16, 3: 24, 4: 16, 5: 16, 6: 24 |
| OffsetD | 48 | 0: 16, 3: 16, 6: 16 |
| StrokeD | 36 | 0: 12, 3: 12, 6: 12 |

| Parameter | Actual case coverage |
| --- | --- |
| clip_type | Difference: 34, Intersection: 34, Union: 34, Xor: 34 |
| fill_rule | EvenOdd: 92, NonZero: 92 |
| join_type | Bevel: 21, Miter: 21, Round: 21, Square: 21 |
| cap_type | Butt: 12, Round: 12, Square: 12 |
| delta | -0.2: 24, 0.2: 24 |
| width | 0.4: 36 |
| miter_limit | 2.0: 84 |
| arc_tolerance | 0.025: 84 |

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
