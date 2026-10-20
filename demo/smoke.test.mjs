import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {compute} from './generated/moonclip.js';
import {resultSvg,resultDocument} from './export.js';
import {cases} from './cases.js';
const rect=(x,y,w,h)=>[[x,y],[x+w,y],[x+w,y+h],[x,y+h]];
const canonical=paths=>paths.map(p=>p.map((_,i)=>JSON.stringify(p.slice(i).concat(p.slice(0,i)))).sort()[0]).sort();
function run(request){return JSON.parse(compute(JSON.stringify({version:1,mode:'integer',precision:3,...request})));}
function exact(request,expected){const r=run(request);assert.equal(r.ok,true,JSON.stringify(r));assert.equal(r.kernel,'MoonBit');assert.deepEqual(canonical(r.paths),canonical(expected));return r;}
test('Boolean calls MoonBit and returns exact Intersection',()=>{
  const request={scene:'boolean',subject:[rect(0,0,10,10)],clip:[rect(5,5,10,10)],params:{operation:'Intersection',fill_rule:'EvenOdd'}};
  const r=exact(request,[rect(5,5,5,5)]);const doc=resultDocument(request,r);assert.deepEqual(doc.request,request);assert.deepEqual(doc.result.paths,r.paths);assert.match(resultSvg(r.paths),/viewBox=/);assert.throws(()=>resultDocument(request,{ok:false}));
});
test('Offset preserves a genuine hole with NonZero',()=>exact({scene:'offset',subject:[rect(-10,-10,20,20),rect(-5,-5,10,10).reverse()],params:{delta:2,join:'Miter',fill_rule:'NonZero'}},[rect(-12,-12,24,24),rect(-3,-3,6,6).reverse()]));
test('Stroke receives full width and Butt caps',()=>exact({scene:'stroke',path:[[0,0],[10,0]],params:{width:4,cap:'Butt',join:'Miter'}},[rect(0,-2,10,4)]));
test('Minkowski uses fixed integer reference including short-route gap',async()=>{
  const c=JSON.parse(await readFile(new URL('../testdata/minkowski/inputs/minkowski_rectangle_short_horizontal_open_forward.json',import.meta.url)));
  const v=JSON.parse(await readFile(new URL('../testdata/minkowski/expected/minkowski_rectangle_short_horizontal_open_forward.json',import.meta.url)));
  exact({scene:'minkowski',pattern:c.pattern,path:c.path,params:{path_is_closed:c.path_is_closed}},v.paths);
});
test('Decimal Boolean, Offset and Stroke call their decimal APIs',()=>{
  exact({scene:'boolean',mode:'decimal',precision:2,subject:[rect(.25,.25,10,10)],clip:[rect(5.25,5.25,10,10)],params:{operation:'Intersection'}},[rect(5.25,5.25,5,5)]);
  exact({scene:'offset',mode:'decimal',precision:2,subject:[rect(-10.25,-10.25,20.5,20.5)],params:{delta:2.5,join:'Miter'}},[rect(-12.75,-12.75,25.5,25.5)]);
  exact({scene:'stroke',mode:'decimal',precision:2,path:[[.25,.25],[10.25,.25]],params:{width:4.5,cap:'Butt'}},[rect(.25,-2,10,4.5)]);
});
test('Explicit simplification reports deletions and stops at degeneracy',()=>{
  const r=exact({scene:'stroke',path:[[0,0],[3,0],[7,0],[10,0]],params:{width:4},simplify:{enabled:true,epsilon:.25}},[rect(0,-2,10,4)]);assert.equal(r.simplification.removed_vertices,2);
  const bad=run({scene:'offset',subject:[[[1,1]]],params:{delta:2},simplify:{enabled:true,epsilon:.25}});assert.equal(bad.ok,false);assert.equal(bad.error.kind,'DegenerateAfterSimplification');assert.deepEqual(bad.simplification.input_degenerate_indices,[0]);assert.equal(bad.paths,undefined);
});
test('Structured errors preserve location and reject decimal sweep',()=>{
  const r=run({scene:'boolean',subject:[[[1000000001,0],[0,10],[0,0]]],clip:[]});assert.equal(r.ok,false);assert.equal(r.error.kind,'CoordinateOutOfRange');assert.equal(r.error.path_index,0);assert.equal(r.error.vertex_index,0);assert.equal(r.error.value,1000000001);
  assert.equal(run({scene:'minkowski',mode:'decimal',path:[],pattern:[]}).error.stage,'BridgeInput');
  assert.equal(run({scene:'offset',subject:[rect(0,0,10,10)],params:{delta:2,miter_limit:1}}).ok,false);
  assert.equal(JSON.parse(compute('{')).error.kind,'InvalidJSON');
});

// Compare each contour without reversing winding or discarding vertices, then
// check the relationships independently of the bridge's node ordering.
function chain(request,expected){
  const r=exact({...request,output:'tree'},expected);
  assert.equal(r.output,'tree');assert.equal(r.tree.nodes.length,r.paths.length);
  const visited=new Set();let indices=r.tree.roots;let parent=null;
  for(let depth=1;depth<=expected.length;depth++){
    assert.equal(indices.length,1);const i=indices[0];assert.equal(visited.has(i),false);visited.add(i);
    const n=r.tree.nodes[i];assert.deepEqual(canonical([r.paths[i]]),canonical([expected[depth-1]]));
    assert.equal(n.parent,parent);assert.equal(n.depth,depth);assert.equal(n.is_hole,depth%2===0);parent=i;indices=n.children;
  }
  assert.deepEqual(indices,[]);assert.equal(visited.size,r.paths.length);return r;
}
for(const mode of ['integer','decimal']){
  test(`Tree Boolean ${mode}: outer, hole and island with exact winding`,()=>{
    const shift=mode==='decimal'?.125:0;
    chain({scene:'boolean',mode,precision:3,subject:[rect(shift,shift,60,60),rect(10+shift,10+shift,40,40).reverse(),rect(20+shift,20+shift,20,20)],clip:[],params:{operation:'Union',fill_rule:'NonZero'}},[rect(shift,shift,60,60),rect(10+shift,10+shift,40,40).reverse(),rect(20+shift,20+shift,20,20)]);
  });
  test(`Tree Offset ${mode}: preserved and disappearing hole`,()=>{
    const shift=mode==='decimal'?.25:0;
    const request={scene:'offset',mode,precision:2,subject:[rect(shift,shift,40,40),rect(10+shift,10+shift,20,20).reverse()],params:{delta:2,fill_rule:'NonZero',join:'Miter'}};
    chain(request,[rect(shift-2,shift-2,44,44),rect(shift+12,shift+12,16,16).reverse()]);
    chain({...request,params:{...request.params,delta:10}},[rect(shift-10,shift-10,60,60)]);
  });
  test(`Tree Stroke ${mode}: returning open route encloses a real hole`,()=>{
    const shift=mode==='decimal'?.125:0;
    chain({scene:'stroke',mode,precision:3,path:[[0,0],[30,0],[30,30],[0,30],[0,0]].map(p=>p.map(x=>x+shift)),params:{width:4,cap:'Square',join:'Miter'}},[rect(shift-2,shift-2,34,34),rect(shift+2,shift+2,26,26).reverse()]);
  });
}
test('Tree empty regions and stroke shortcuts have no indices in all six branches',()=>{
  for(const mode of ['integer','decimal'])for(const request of [
    {scene:'boolean',subject:[],clip:[]},
    {scene:'offset',subject:[],params:{delta:2}},
    {scene:'stroke',path:[],params:{width:4}},
    {scene:'stroke',path:[[0,0]],params:{width:4}},
    {scene:'stroke',path:[[0,0],[10,0]],params:{width:0}},
  ]){const r=exact({...request,mode,output:'tree'},[]);assert.deepEqual(r.tree,{roots:[],nodes:[]});}
  chain({scene:'stroke',mode:'decimal',precision:3,path:[[0,0],[.01,0]],params:{width:.002}},[rect(0,-.001,.01,.002)]);
});
test('Tree forest indices stay aligned across siblings and multiple nesting levels',()=>{
  const nested=Array.from({length:12},(_,i)=>{const p=rect(i,i,40-2*i,40-2*i);return i%2?p.reverse():p;});
  const detached=rect(60,0,10,10),expected=[...nested,detached];
  const r=exact({scene:'boolean',output:'tree',subject:expected,clip:[],params:{operation:'Union',fill_rule:'NonZero'}},expected);
  assert.equal(r.tree.roots.length,2);assert.equal(r.tree.nodes.length,13);
  const seen=new Set(),queue=r.tree.roots.map(i=>({i,parent:null,depth:1}));
  for(let cursor=0;cursor<queue.length;cursor++){
    const {i,parent,depth}=queue[cursor];assert.equal(seen.has(i),false);seen.add(i);
    const n=r.tree.nodes[i];assert.equal(n.parent,parent);assert.equal(n.depth,depth);assert.equal(n.is_hole,depth%2===0);
    const outer=r.paths[i].some(([x])=>x>=60);assert.deepEqual(canonical([r.paths[i]]),canonical([outer?detached:nested[depth-1]]));
    for(const child of n.children)queue.push({i:child,parent:i,depth:depth+1});
  }
  assert.equal(seen.size,13);
});
test('Output selection defaults to the unchanged v1 flat document and rejects invalid modes',()=>{
  const request={scene:'boolean',subject:[rect(0,0,10,10)],params:{operation:'Union'}};
  const implicit=run(request),explicit=run({...request,output:'paths'});
  assert.deepEqual(implicit,explicit);assert.equal(implicit.tree,undefined);assert.equal(resultDocument(request,implicit).version,1);
  assert.deepEqual(Object.keys(resultDocument(request,implicit).result),['paths','mode','precision']);
  for(const output of ['unknown',null,2]){const r=run({...request,output});assert.equal(r.ok,false);assert.equal(r.error.stage,'BridgeInput');assert.equal(r.tree,undefined);assert.equal(r.paths,undefined);}
  assert.equal(run({scene:'minkowski',output:'tree'}).error.stage,'BridgeInput');
});
test('Tree explicit simplification uses Closed regions and Open routes, aborting degeneracy',()=>{
  for(const mode of ['integer','decimal']){
    const s={mode,output:'tree',simplify:{enabled:true,epsilon:.25}};
    const b=chain({...s,scene:'boolean',subject:[[[0,0],[5,0],[10,0],[10,10],[0,10]]],clip:[],params:{operation:'Union'}},[rect(0,0,10,10)]);assert.equal(b.simplification.removed_vertices,1);
    const o=chain({...s,scene:'offset',subject:[[[0,0],[5,0],[10,0],[10,10],[0,10]]],params:{delta:2}},[rect(-2,-2,14,14)]);assert.equal(o.simplification.removed_vertices,1);
    const r=chain({...s,scene:'stroke',path:[[0,0],[3,0],[7,0],[10,0]],params:{width:4}},[rect(0,-2,10,4)]);assert.equal(r.simplification.removed_vertices,2);
    const bad=run({...s,scene:'offset',subject:[[[1,1]]],params:{delta:2}});assert.equal(bad.error.kind,'DegenerateAfterSimplification');assert.deepEqual(bad.simplification.input_degenerate_indices,[0]);assert.equal(bad.paths,undefined);assert.equal(bad.tree,undefined);
  }
});
test('Tree core failures retain the actual stage and location without partial results',()=>{
  const r=run({scene:'stroke',output:'tree',path:[[0,0],[1000000001,0]],params:{width:4}});
  assert.equal(r.ok,false);assert.equal(r.error.kind,'CoordinateOutOfRange');assert.equal(r.error.stage,'StrokeGenerate');assert.equal(r.error.path_index,0);assert.equal(r.error.vertex_index,1);assert.equal(r.paths,undefined);assert.equal(r.tree,undefined);
  const d=run({scene:'stroke',mode:'decimal',output:'tree',precision:0,path:[[0,0],[.1,0]],params:{width:0}});assert.equal(d.error.kind,'QuantizationFailure');assert.equal(d.tree,undefined);
});
test('Tree v2 exports replay v1 requests and deeply isolate all data',()=>{
  const request={...structuredClone(cases.boolean.find(c=>c.output==='tree')),simplify:{enabled:true,epsilon:.25}};
  const response=run(request),before=structuredClone(response);const doc=resultDocument(request,response);
  assert.equal(doc.version,2);assert.equal(doc.request.version,1);assert.equal(doc.result.output,'tree');assert.deepEqual(run(doc.request),response);
  doc.request.subject[0][0][0]=999;doc.request.params.operation='Xor';doc.result.paths[0][0][0]=999;doc.result.tree.roots.push(999);doc.result.tree.nodes[0].children.push(999);doc.simplification.removed_per_path.push(999);
  assert.deepEqual(response,before);assert.notEqual(request.subject[0][0][0],999);assert.equal(request.params.operation,'Union');
  const fresh=resultDocument(request,response);request.subject[0][0][0]=888;response.tree.nodes[0].children.push(888);response.paths[0][0][0]=888;response.simplification.removed_per_path.push(888);
  assert.notEqual(fresh.request.subject[0][0][0],888);assert.deepEqual(fresh.result.paths,before.paths);assert.deepEqual(fresh.result.tree,before.tree);assert.deepEqual(fresh.simplification,before.simplification);
});
test('Tree SVG uses one NonZero compound result path and contains no viewer selection',()=>{
  const r=run(cases.boolean.find(c=>c.output==='tree')),svg=resultSvg(r.paths);
  assert.equal((svg.match(/<path /g)??[]).length,1);assert.equal((svg.match(/<path d="([^"]*)"/)[1].match(/Z/g)??[]).length,3);assert.match(svg,/fill-rule="nonzero"/);assert.match(svg,/scale\(1,-1\)/);assert.doesNotMatch(svg,/data-selected|tree-node|input-a|script/);
});
