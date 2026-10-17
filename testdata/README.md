# Reference and comparator data

Copyright (c) 2026 BigSaltyMan. Distributed under BSL-1.0; see the root LICENSE.

All current inputs and comparator counterexamples are constructed for MoonClip, not copied from upstream test suites. Each reference input records its intent and group in source metadata. The complete case mapping is in manifest.json; every capability status is reference_only.

upstream/inputs contains canonical UTF-8 requests. upstream/expected contains actual locked C++ oracle outputs, input SHA256, and independently computed exact metrics. No execution timestamps are stored in these files. The fixed engine and JSON parser notices are documented in tools/oracle/THIRD_PARTY_NOTICES.md.

comparator/valid contains five geometry-format fixtures. comparator/invalid contains thirteen deliberate counterexamples: they must be rejected, not repaired. These fixtures exercise the comparator and are not Clipper2 reference outputs or MoonClip compatibility passes.

See docs/reference-cases.md for the coverage matrix, execution results and commands.
