# Boolean compatibility

Pinned Clipper2 2.0.1, commit `21ebba05db8894f0c7217ad35ea518080f324946`; ordinary precision, preserve_collinear=false, reverse_solution=false.

Native report: required=60, executed=60, passed=60, differences=0, execution_errors=0. Reference catalog: 136.

Native and JS independently execute the same 60 generated full-contour tests in moon test and CI. This native command report does not impersonate JS execution.

All 136 tree outputs remain reference_only until Commit 8. The other 76 fill-rule cases remain reference_only. Passing flat contours does not establish PolyTree parentage.

Only cyclic ring starts and contour ordering are normalized. Winding, all vertices and multiplicity are retained; no tolerance or automatic reversal is applied.

| Case | Native paths | Tree |
| --- | --- | --- |
| coincident_difference_evenodd | passed | reference_only |
| coincident_intersection_evenodd | passed | reference_only |
| coincident_union_evenodd | passed | reference_only |
| coincident_xor_evenodd | passed | reference_only |
| concave_difference_evenodd | passed | reference_only |
| concave_intersection_evenodd | passed | reference_only |
| concave_union_evenodd | passed | reference_only |
| concave_xor_evenodd | passed | reference_only |
| contained_difference_evenodd | passed | reference_only |
| contained_intersection_evenodd | passed | reference_only |
| contained_union_evenodd | passed | reference_only |
| contained_xor_evenodd | passed | reference_only |
| disjoint_difference_evenodd | passed | reference_only |
| disjoint_intersection_evenodd | passed | reference_only |
| disjoint_union_evenodd | passed | reference_only |
| disjoint_xor_evenodd | passed | reference_only |
| empty_both_difference_evenodd | passed | reference_only |
| empty_both_intersection_evenodd | passed | reference_only |
| empty_both_union_evenodd | passed | reference_only |
| empty_both_xor_evenodd | passed | reference_only |
| empty_clip_difference_evenodd | passed | reference_only |
| empty_clip_intersection_evenodd | passed | reference_only |
| empty_clip_union_evenodd | passed | reference_only |
| empty_clip_xor_evenodd | passed | reference_only |
| empty_subject_difference_evenodd | passed | reference_only |
| empty_subject_intersection_evenodd | passed | reference_only |
| empty_subject_union_evenodd | passed | reference_only |
| empty_subject_xor_evenodd | passed | reference_only |
| hole_difference_evenodd | passed | reference_only |
| hole_intersection_evenodd | passed | reference_only |
| hole_union_evenodd | passed | reference_only |
| hole_xor_evenodd | passed | reference_only |
| island_difference_evenodd | passed | reference_only |
| island_intersection_evenodd | passed | reference_only |
| island_union_evenodd | passed | reference_only |
| island_xor_evenodd | passed | reference_only |
| multipart_difference_evenodd | passed | reference_only |
| multipart_intersection_evenodd | passed | reference_only |
| multipart_union_evenodd | passed | reference_only |
| multipart_xor_evenodd | passed | reference_only |
| negative_collinear_difference_evenodd | passed | reference_only |
| negative_collinear_intersection_evenodd | passed | reference_only |
| negative_collinear_union_evenodd | passed | reference_only |
| negative_collinear_xor_evenodd | passed | reference_only |
| overlap_difference_evenodd | passed | reference_only |
| overlap_intersection_evenodd | passed | reference_only |
| overlap_union_evenodd | passed | reference_only |
| overlap_xor_evenodd | passed | reference_only |
| self_crossing_difference_evenodd | passed | reference_only |
| self_crossing_intersection_evenodd | passed | reference_only |
| self_crossing_union_evenodd | passed | reference_only |
| self_crossing_xor_evenodd | passed | reference_only |
| touch_edge_difference_evenodd | passed | reference_only |
| touch_edge_intersection_evenodd | passed | reference_only |
| touch_edge_union_evenodd | passed | reference_only |
| touch_edge_xor_evenodd | passed | reference_only |
| touch_vertex_difference_evenodd | passed | reference_only |
| touch_vertex_intersection_evenodd | passed | reference_only |
| touch_vertex_union_evenodd | passed | reference_only |
| touch_vertex_xor_evenodd | passed | reference_only |
