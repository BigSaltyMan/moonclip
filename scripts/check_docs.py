#!/usr/bin/env python3
"""Check local inline-link targets in the Commit 52 document set.

This intentionally handles the repository's conventional Markdown links only.
It does not fetch URLs, validate heading anchors, or recurse into linked files.
"""

from pathlib import Path
import re
from urllib.parse import unquote, urlsplit


ROOT = Path(__file__).resolve().parents[1]
DOCUMENTS = (
    "README.md",
    "CHANGELOG.md",
    "docs/scope.md",
    "docs/upgrade-incremental.md",
    "docs/acceptance-incremental.md",
    "docs/demo.md",
    "docs/decimal.md",
    "docs/rectclip.md",
    "docs/minkowski.md",
    "docs/polytree-query.md",
    "docs/release-0.3.0.md",
    "docs/release-0.3.1.md",
    "docs/composition.md",
    "docs/release-checklist.md",
    "docs/numerics.md",
    "docs/related-work.md",
    "docs/upstream.md",
    "docs/upgrade-trees.md",
)
LINK = re.compile(r"!?\[[^\]\n]*\]\(\s*(?:<([^>\n]+)>|([^\s)]+))(?:\s+[\"'][^\n]*?[\"'])?\s*\)")


def main():
    checked = 0
    missing = []
    for name in DOCUMENTS:
        document = ROOT / name
        fence = None
        for number, line in enumerate(document.read_text(encoding="utf-8").splitlines(), 1):
            marker = re.match(r"^\s*(`{3,}|~{3,})", line)
            if marker:
                token = marker.group(1)
                if fence is None:
                    fence = token
                elif token[0] == fence[0] and len(token) >= len(fence):
                    fence = None
                continue
            if fence is not None:
                continue
            for match in LINK.finditer(line):
                target = match.group(1) or match.group(2)
                parsed = urlsplit(target)
                if parsed.scheme or parsed.netloc or not parsed.path:
                    continue
                # urlsplit removes the fragment before percent decoding the path.
                path = document.parent / unquote(parsed.path)
                checked += 1
                if not path.exists():
                    missing.append(f"{name}:{number}: missing local target: {target}")
    if missing:
        print("\n".join(missing))
        return 1
    print(f"Docs check passed: {len(DOCUMENTS)} documents, {checked} local link/image targets exist.")
    print("Heading anchors and external URLs are not checked; anchors require manual spot checks.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
