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
