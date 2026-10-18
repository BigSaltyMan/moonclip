# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Strict offset protocol v2. Boolean v1 schemas and data remain independent."""
import math
import re
from compare import (keys, require, validate_paths, validate_input, area2, canonical_bytes,
                     load, validate_lock, confined, sha256)


def finite(value, where):
    require(type(value) in (int, float), where, "expected finite number")
    try:
        require(math.isfinite(value), where, "expected finite number")
    except OverflowError:
        require(False, where, "number out of range")


def validate_offset_input(value, where):
    keys(value, {"format_version", "case_id", "source", "operation", "fill_rule", "options",
                 "paths", "delta", "join_type", "miter_limit"}, where)
    require(type(value["format_version"]) is int and value["format_version"] == 2, where, "unknown offset protocol")
    require(value["operation"] == "OffsetPolygons", where, "unknown offset operation")
    # Reuse v1 provenance and fixed output options validation without changing v1.
    proxy = {k:value[k] for k in ("case_id", "source", "fill_rule", "options")}
    proxy.update(format_version=1, operation="Union", subject=value["paths"], clip=[])
    validate_input(proxy, where)
    require(value["fill_rule"] in ("EvenOdd", "NonZero"), where, "unsupported offset fill rule")
    require(type(value["join_type"]) is str and value["join_type"] in ("Miter", "Bevel"), where, "unknown offset join")
    finite(value["delta"], where + ".delta")
    finite(value["miter_limit"], where + ".miter_limit")
    require(value["miter_limit"] >= 2, where, "miter limit must be at least 2")


def validate_offset_geometry(value, where="offset result"):
    require(value.get("status") == "success", where, "offset execution failed")
    require("tree" not in value, where, "offset v2 has no tree capability")
    validate_paths(value.get("paths"), where + ".paths", True)


def offset_metrics(value):
    return {"path_count":len(value["paths"]), "vertex_count":sum(map(len,value["paths"])),
            "paths":[{"area2":str(area2(p)), "vertices":len(p),
                      "bounds":[min(q[0] for q in p),min(q[1] for q in p),max(q[0] for q in p),max(q[1] for q in p)]}
                     for p in value["paths"]]}


def validate_offset_result(value, case, digest, lock, where):
    keys(value, {"format_version","adapter_protocol_version","case_id","input_sha256",
                 "oracle_commit","status","paths","metrics"}, where)
    require(type(value["format_version"]) is int and value["format_version"] == 2, where, "unknown offset result format")
    require(type(value["adapter_protocol_version"]) is int and value["adapter_protocol_version"] == lock["offset_protocol_version"], where, "unknown offset adapter protocol")
    require(value["case_id"] == case["case_id"] and value["input_sha256"] == digest, where, "offset ID/hash mismatch")
    require(value["oracle_commit"] == lock["commit"], where, "offset oracle commit mismatch")
    validate_offset_geometry(value, where)
    require(canonical_bytes(value["metrics"]) == canonical_bytes(offset_metrics(value)), where, "exact offset metrics mismatch")


def read_offset_manifest(root, manifest, require_expected=True, strict=True):
    value = load(manifest, strict)
    keys(value,{"format_version","kind","oracle_lock","cases"},"offset manifest")
    require(type(value["format_version"]) is int and value["format_version"]==2 and value["kind"]=="offset", "offset manifest", "unknown format")
    require(value["oracle_lock"] == "tools/oracle/upstream-lock.json", "offset manifest", "unexpected lock")
    lock=load(root/value["oracle_lock"],strict);validate_lock(lock)
    require(type(value["cases"]) is list and 0<len(value["cases"])<=10000,"offset manifest","invalid case count")
    ids, inputs, outputs, records=set(),set(),set(),[]
    for entry in value["cases"]:
        keys(entry,{"case_id","input","expected","status","validation"},"offset case")
        cid=entry["case_id"]
        require(type(cid) is str and re.fullmatch(r"[a-z0-9][a-z0-9_-]{0,100}",cid) and cid not in ids,"offset manifest","duplicate/invalid ID")
        ids.add(cid)
        require(entry["status"]=="validate" and entry["validation"]=={"paths":"validate"},cid,"offset supports public paths only")
        require(entry["input"]==f"testdata/offset/inputs/{cid}.json" and entry["expected"]==f"testdata/offset/expected/{cid}.json",cid,"noncanonical offset mapping")
        ip,ep=confined(root,entry["input"]),confined(root,entry["expected"])
        inputs.add(ip);outputs.add(ep)
        case=load(ip,strict);validate_offset_input(case,cid)
        require(case["case_id"]==cid,cid,"offset ID mismatch")
        digest=sha256(ip.read_bytes());expected=None
        if require_expected:
            expected=load(ep,strict);validate_offset_result(expected,case,digest,lock,cid)
        records.append((entry,case,digest,expected))
    require({p for p in (root/"testdata/offset/inputs").rglob("*") if p.is_file()}==inputs,"offset manifest","unlisted or missing inputs")
    actual={p for p in (root/"testdata/offset/expected").rglob("*") if p.is_file()}
    require(actual==outputs if require_expected else actual<=outputs,"offset manifest","unlisted or missing expectations")
    return lock,records


def offset_selection(root):
    lock,records=read_offset_manifest(root,root/"testdata/offset-manifest.json")
    selected=load(root/"testdata/offset-selection.json",True)
    keys(selected,{"format_version","kind","expected_count","case_ids"},"offset selection")
    require(type(selected["format_version"]) is int and selected["format_version"]==2 and selected["kind"]=="offset","offset selection","invalid format")
    require(type(selected["expected_count"]) is int and selected["expected_count"]==116,"offset selection","expected 116")
    require(selected["case_ids"]==sorted(r[1]["case_id"] for r in records) and len(records)==116,"offset selection","selection mismatch")
    return lock,records
