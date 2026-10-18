"""Write the explicitly constructed v1 coverage matrix; never generate expectations.
Run intentionally to review changes to case definitions; not called by checks.
"""
import json
from pathlib import Path
import sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools/conformance"))
from compare import canonical_bytes, OPERATIONS

def rect(x1,y1,x2,y2):
    return [[x1,y1],[x2,y1],[x2,y2],[x1,y2]]

def definitions():
    a=rect(0,0,10,10)
    return [
        ("disjoint",[a],[rect(20,0,30,10)],"Separated components and empty intersection"),
        ("overlap",[a],[rect(5,0,15,10)],"Partial overlap and asymmetric Difference"),
        ("contained",[a],[rect(2,2,8,8)],"Complete containment and a hole under Difference"),
        ("coincident",[a],[a],"Coincident contours; empty Difference and Xor"),
        ("touch_vertex",[a],[rect(10,10,20,20)],"Single shared vertex without area overlap"),
        ("touch_edge",[a],[rect(10,0,20,10)],"Shared edge and horizontal merging"),
        ("concave",[[[0,0],[12,0],[12,4],[4,4],[4,12],[0,12]]],[rect(2,2,8,8)],"Concave L against a rectangle"),
        ("multipart",[a,rect(20,0,30,10)],[rect(5,-5,25,5)],"Multiple independent input and output regions"),
        ("hole",[rect(-20,-20,20,20)],[rect(-10,-10,10,10)],"Outer contour with a hole under Difference"),
        ("island",[rect(-30,-30,30,30),list(reversed(rect(-20,-20,20,20))),rect(-10,-10,10,10)],[],"Depth-three nesting: outer, hole, island"),
        ("self_crossing",[[[-8,-8],[8,8],[-8,8],[8,-8]]],[rect(-6,-6,6,6)],"Self-intersection and split lobes"),
        ("negative_collinear",[[[-20,-10],[-10,-10],[0,-10],[0,0],[-20,0]]],[rect(-15,-15,-5,5)],"Negative coordinates, horizontal edges, removable collinear vertex"),
        ("empty_subject",[],[a],"Empty subject and operand-sensitive Difference"),
        ("empty_clip",[a],[],"Empty clip and operation-specific identity"),
        ("empty_both",[],[],"Successful empty result for both empty inputs"),
    ]

def main():
    entries=[]
    old={e["case_id"]:e for e in json.loads((ROOT/"testdata/manifest.json").read_bytes())["cases"]}
    def write(group,subject,clip,intent,op,fill):
        cid=f"{group}_{op.lower()}_{fill.lower()}"
        case={"format_version":1,"case_id":cid,"source":{"kind":"moonclip_constructed","intent":intent,"group":group},"operation":op,"fill_rule":fill,"options":{"preserve_collinear":False,"reverse_solution":False},"subject":subject,"clip":clip}
        input_name=f"testdata/upstream/inputs/{cid}.json"
        (ROOT/input_name).write_bytes(canonical_bytes(case))
        entry=dict(old.get(cid, {"case_id":cid,"input":input_name,"expected":f"testdata/upstream/expected/{cid}.json","status":"reference_only"}))
        entry["validation"]={"paths":"validate" if fill in ("EvenOdd","NonZero") else "validate_internal","tree":"reference_only"}
        entries.append(entry)
    for group,subject,clip,intent in definitions():
        for op in OPERATIONS:
            for fill in ("EvenOdd","NonZero"):
                write(group,subject,clip,intent,op,fill)
    for clockwise in (False,True):
        path=rect(-10,-10,10,10)
        if clockwise: path.reverse()
        group="direction_cw" if clockwise else "direction_ccw"
        for op in OPERATIONS:
            for fill in ("Positive","Negative"):
                write(group,[path],[],"Directional filling with explicit contour orientation",op,fill)
    overlap=[rect(0,0,12,12),rect(6,0,18,12)]
    crossing=[rect(3,-3,15,9),rect(9,6,21,15)]
    extra=[
        ("winding_overlap",overlap,crossing,"Positive double winding and both operands crossing singly and doubly covered regions"),
        ("winding_reversed",[list(reversed(p)) for p in overlap],[list(reversed(p)) for p in crossing],"All directions reversed from winding_overlap; negative winding duality"),
        ("winding_nested",[rect(-30,-30,30,30),list(reversed(rect(-20,-20,20,20))),rect(-10,-10,10,10),rect(5,-5,25,5)],[rect(-25,-15,15,15),list(reversed(rect(-15,-5,5,5)))],"Outer opposite hole island and overlapping fourth contour against a holed clip"),
        ("winding_cancel_touch",[rect(0,0,10,10),list(reversed(rect(0,0,10,10))),rect(10,0,20,10),rect(20,10,30,20)],[rect(5,-5,15,5),rect(15,5,25,15)],"Exact direction cancellation plus shared edge vertex contact and clip coverage"),
    ]
    for group,subject,clip,intent in extra:
        for op in OPERATIONS:
            for fill in ("EvenOdd","NonZero","Positive","Negative"):
                write(group,subject,clip,intent,op,fill)
    manifest={"format_version":1,"oracle_lock":"tools/oracle/upstream-lock.json","cases":sorted(entries,key=lambda e:e['case_id'])}
    (ROOT/'testdata/manifest.json').write_bytes(canonical_bytes(manifest))
    selection={"format_version":1,"total":200,"rules":{}}
    for fill,count,entrypoint in [("EvenOdd",76,"public"),("NonZero",76,"public"),("Positive",24,"internal"),("Negative",24,"internal")]:
        ids=[e["case_id"] for e in manifest["cases"] if json.loads((ROOT/e["input"]).read_bytes())["fill_rule"]==fill]
        assert len(ids)==count
        selection["rules"][fill]={"entrypoint":entrypoint,"expected_count":count,"case_ids":ids}
    (ROOT/"testdata/boolean-selection.json").write_bytes(canonical_bytes(selection))
    print(f"Constructed {len(entries)} explicit input cases; no expectations generated")

if __name__=='__main__':
    main()
