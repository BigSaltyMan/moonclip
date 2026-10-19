import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {compute} from './generated/moonclip.js';
import {resultSvg,resultDocument} from './export.js';
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
