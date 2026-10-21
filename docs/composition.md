# Composition and cumulative resource protection

发布状态：本文所述新增树能力已随 **0.2.0** 发布，见[正式发布记录](release-0.2.0.md)。既有 Unreleased 标题、锚点或截图保留原验收归属，接口契约不变。

## Unreleased：Stroke trees

`stroke_tree` and `stroke_tree_d` return the final filled hierarchy of one open route. They keep full width, Butt / Square / Round caps and four joins, with no fill-rule argument. Neither entry is in published 0.1.0. The shared `stroke_compute` prepares the open route, generates both sides and caps, then uses the existing Positive Union with `tree_build`; decimal conversion runs inside that extraction callback. Failure cleans the same scan. Flat output keeps its existing extraction and shortcut fees.

For route (0,0) → (20,0), width 4 and Butt caps give [0,-2]–[20,2], depth one without a hole. For (0,0) → (30,0) → (30,30) → (0,30) → (0,0), Miter / Square at width 4 gives outer [-2,-2]–[32,32] and reversed hole [2,2]–[28,28], depths one and two. The repeated endpoint remains an open endpoint, not a switch to closed offset mode. `run_stroke_tree_example` checks these complete integer regions and the decimal hole example. A route has no input hole hierarchy to reuse; the tree describes the cleaned stroke region, and `to_paths()` drops explicit parentage.

Width below one grid unit or fewer than two prepared points produces an empty tree only after parameters, raw counts, coordinates and preparation are checked. Even an empty route consumes one input-path allowance; repeats count before preparation. The empty callback starts no scan and adds the existing four logical nodes and one work for `tree_empty`, plus four nodes and one work for decimal empty conversion. A singleton never becomes a cap-shaped area. Quantization uses open rules and scaled full width; original width .001 at Precision=3 reaches the integer width-one case.

Preparation, generation, cleanup, tree construction and decoding use the same ledger, with no refunds. Tree stages use PolyTree / DecimalOutput; other errors retain their actual phase (including EnginePrepare for scan control allocation). New 29 library tests and candidate consumers are separate from the unchanged reference catalogs and their 1384 cases / 2276 capability checks.

## Unreleased：Offset trees

`offset_tree` and `offset_tree_d` return the final offset hierarchy in one cumulative call. This differs from the historical InsetThenTree recipe below, which intentionally composes two public calls with independent ledgers. Neither new entry is in published 0.1.0. The default fill is NonZero; the caller's rule is used for shared input normalization, while final cleanup keeps the existing internal Positive rule.

For outer [0,0]–[40,40] and reversed hole [10,10]–[30,30], Miter +2 gives one root [-2,-2]–[42,42] and its reversed child [12,12]–[28,28], at depths 1 and 2. `run_offset_tree_example` asserts complete contours and hierarchy for integer and decimal units. The tree describes the final region: offsets can merge or split regions and remove holes; input order is not parentage.

For abs(grid delta)<0.5, normalization extracts the final tree directly, including decimal conversion while the scan still owns cleanup. For a normal distance with empty normalized paths, the private empty-tree constructor charges four logical nodes (two arrays, data and tree wrappers) and one work unit before allocation, without another scan. Flat output returns its existing normalized empty array with no extra fee. Decimal empty conversion adds the existing four-node, one-work charge. Ordinary generation, cleanup, tree construction and decoding all retain the same ledger, including prior usage; intermediates are never refunded. Accessor copies occur after execution and retain the established ownership contract.

The 27 new library tests and candidate consumers are separate from the unchanged eight reference catalogs. They do not enlarge the 1384-case / 2276-capability upstream compatibility claim.

## Existing internal fee table

InternalNodes counts logical allocation units: records and the container/slot charges listed below. It does not model allocator capacity, bytes, scalar temporaries or immutable Point64 objects. Fixed empty ScanState control containers are constant overhead; dynamic scratch and output storage are charged. Charges precede storage and are cumulative; releasing memory never refunds them.

| Stage | Nodes | Work |
| --- | --- | --- |
| Input preparation | normalized arrays, kept slots, vertices/chains/events | raw precheck and normalization visits |
| Geometry generation | normal slots, generated containers and sample slots | normals, corners, endpoints, attempted arc samples |
| Scan and cleanup | active edges, events, intersections, output records and temporary indices | comparisons, events, connection and repair visits |
| Ring extraction | index-array container plus every index slot | one visit per output point |
| Flat snapshot | outer container/path slots; inner containers/coordinate-reference slots | point-copy visits |
| Tree construction | bounds, nodes, child/root slots, traversal and validation storage | containment, traversal and exact winding verification |
| Production invariants | validation sets/arrays and their slots | each validation loop visit, including alias/ring traversal |

Commit 12 adds previously uncharged normalized-copy, normal-array/container, ring-index and snapshot storage and meters production invariant validation. Defaults remain 500,000 internal nodes and 5,000,000 work units. Point64 values are immutable and reused; storing a reference costs one slot, not another point object. Tree accessor copies occur after execution and retain no ledger.

Both charges must be nonnegative. Check both remaining capacities before changing either counter. Preflight consumes nothing. Failure retains the first error; cleanup needs no remaining budget. Internal child calls use the passed ledger's limits and counters.


## Three real flows

1. **BooleanThenOffset:** NonZero Union of rectangles [0,0]–[10,10] and [5,0]–[15,10] returns [0,0]–[15,10]. Feed that actual array to Miter +2: [-2,-2]–[17,12]. Boolean defaults to EvenOdd while Offset defaults to NonZero, so these examples state the fill rule explicitly.
2. **InsetThenTree:** outer [0,0]–[40,40] and reversed hole [10,10]–[30,30], Miter -2, produce outer [2,2]–[38,38] and hole [8,8]–[32,32]. Pass the actual inset to boolean_tree NonZero Union: one depth-1 root and one depth-2 hole. Narrow bridges can break, holes can reach exterior, and disappearing regions continue as an empty tree.
3. **StrokeThenIntersection:** route (-10,10) → (30,10), full width 4, Butt caps, then NonZero Intersection with [0,0]–[20,20], yields [0,8]–[20,12]. Round caps, corners, self-crossings, concave/hole masks and disjoint output have separate regressions.

The executable [example](../cmd/example/main.mbt) checks every Result and full expected contours. A failure stops execution. It never substitutes empty paths or the original inputs. `Ok([])` is a valid region, distinct from Err; the next stage still runs. Offset expansion followed by contraction is generally not reversible.

## Call boundaries and ownership

Each public call starts a fresh ledger. Within Offset or Stroke, input preparation, generation, internal Boolean cleanup and extraction share one ledger. There is no public session, pipeline DSL or cross-call total budget. Passing a ledger internally never substitutes the child function's limits or resets prior usage.

An array returned by stage 1 is raw input to the next public call. It is checked again against that call's coordinates and Limits, before normalization; errors identify its path/vertex indices. Internally generated inputs have no fictional raw indices and preserve OffsetGenerate/OffsetCleanup or StrokeGenerate/StrokeCleanup context. Specific scan, output and PolyTree stages remain specific.

Result arrays own both levels of storage even with aliased input paths. Modifying an intermediate cannot change earlier source arrays or other calls. `PolyTree64::to_paths()` and node `contour()` return independent arrays; accessors do not retain a live operation budget. Cleanup always works after failure and never restores a failed scan state.

ArcTolerance, full stroke width, offset rounding away from zero and scan projection rounding are unchanged; see [numerics](numerics.md). Public Limits fields/defaults and root interface are unchanged.

## Evidence boundaries

60 functional cases: 18 public flows (six each), 24 cumulative budget checks, 10 structured errors/numeric boundaries, 8 isolation/retry checks. Exact-budget tests first measure fixed cases, rerun exact limits, then one less with the expected failure stage. Snapshot tests run a real completed scan under the measured reduced allowance.

Protocol v4 locks 24 recipes before MoonClip execution, eight per flow. The pinned C++ engine executes step 1 and feeds its freshly computed paths to step 2, including empty paths. Both stages' full integer contours are compared; tree recipes also compare parentage. Expected contours are linked only into tests, while the command runner contains raw inputs/parameters/hashes. Missing, duplicate, extra and stale-hash cases fail integrity checks; execution errors retain the failed step.

Each recipe counts once: 748 old inputs plus 24 =772. Native and JS each run 1414 library cases; 24 recipe filters per target require their own selection marker. 179 offline tool tests and 51 real adapter tests are separate. Local execution, Linux ordinary CI, and Linux independent C++ rebuild are separate evidence. Resource rejection tests establish MoonClip's own protection, not Clipper2 budget parity.

The v4 hole reference uses outer [0,0]–[40,40] and reversed [8,8]–[32,32]: inset -4 collapses the entire region, then the real second call returns an empty tree. This case covers empty intermediate propagation; the manual [10,10]–[30,30] example remains separate.
