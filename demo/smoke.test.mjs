import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {compute} from './generated/moonclip.js';
import {resultSvg,resultDocument,openResultSvg} from './export.js';
import {cases} from './cases.js';
const rect=(x,y,w,h)=>[[x,y],[x+w,y],[x+w,y+h],[x,y+h]];
// Complete locked minkowski_rectangle_rectangle_closed_forward contours; keep collinear vertices.
const minkowskiTreeExpected=[[[2,-1],[28,-1],[32,-1],[32,1],[32,21],[28,21],[2,21],[-2,21],[-2,19],[-2,1],[-2,-1]],[[2,19],[28,19],[28,1],[2,1]]];
const canonical=paths=>paths.map(p=>p.map((_,i)=>JSON.stringify(p.slice(i).concat(p.slice(0,i)))).sort()[0]).sort();
function run(request){return JSON.parse(compute(JSON.stringify({version:1,mode:'integer',precision:3,...request})));}
function exact(request,expected){const r=run(request);assert.equal(r.ok,true,JSON.stringify(r));assert.equal(r.kernel,'MoonBit');assert.deepEqual(canonical(r.paths),canonical(expected));return r;}

test('demo rectclip: complete ordered open bridge result',()=>{
  const r=run(cases.rectclip[0]);
  assert.equal(r.ok,true,JSON.stringify(r));assert.equal(r.kernel,'MoonBit');
  assert.equal(r.geometry,'open-paths');assert.equal(r.mode,'integer');assert.equal(r.precision,null);
  assert.deepEqual(r.paths,[[[0,5],[5,5],[10,5]]]);
  const decimal=run(cases.rectclip.find(c=>c.id==='decimal-cross'));
  assert.equal(decimal.ok,true,JSON.stringify(decimal));assert.equal(decimal.geometry,'open-paths');
  assert.equal(decimal.mode,'decimal');assert.equal(decimal.precision,2);
  assert.deepEqual(decimal.paths,[[[-1.25,.25],[.5,.25],[2.75,.25]]]);
  const integerRegion=exact({...cases.rectclip.find(c=>c.id==='integer-region'),output:'tree',params:{fill_rule:'NonZero'}},[rect(0,0,10,10)]);
  assert.equal(integerRegion.geometry,'closed-regions');assert.equal(integerRegion.mode,'integer');assert.equal(integerRegion.output,'tree');
  assert.deepEqual(integerRegion.tree,{roots:[0],nodes:[{parent:null,children:[],depth:1,is_hole:false}]});
  assert.deepEqual(canonical([integerRegion.paths[0]]),canonical([rect(0,0,10,10)]));
  const decimalRegion=exact({...cases.rectclip.find(c=>c.id==='decimal-region'),output:'tree'},[rect(-1.25,-.5,4,3),rect(0,0,1,1).reverse()]);
  assert.equal(decimalRegion.geometry,'closed-regions');assert.equal(decimalRegion.mode,'decimal');assert.equal(decimalRegion.precision,2);assert.equal(decimalRegion.output,'tree');
  assert.deepEqual(decimalRegion.tree,{roots:[0],nodes:[{parent:null,children:[1],depth:1,is_hole:false},{parent:0,children:[],depth:2,is_hole:true}]});
  assert.deepEqual(canonical([decimalRegion.paths[0]]),canonical([rect(-1.25,-.5,4,3)]));
  assert.deepEqual(canonical([decimalRegion.paths[1]]),canonical([rect(0,0,1,1).reverse()]));
});

test('demo rectclip: open SVG and replayable v3 JSON',()=>{
  for(const input of [cases.rectclip[0],cases.rectclip.find(c=>c.id==='decimal-cross')]){
    const request=structuredClone(input),response=run(request);
    assert.equal(response.ok,true,JSON.stringify(response));
    const svg=openResultSvg(response),d=svg.match(/<path d="([^"]*)"/)[1];
    assert.equal(/[zZ]/.test(d),false);assert.match(svg,/fill="none"/);
    assert.equal(d,request.mode==='decimal'?'M-1.25,0.25L0.5,0.25L2.75,0.25':'M0,5L5,5L10,5');
    const doc=resultDocument(request,response);
    assert.equal(doc.version,3);assert.equal(doc.result.geometry,'open-paths');
    assert.equal(doc.result.mode,request.mode);assert.equal(doc.result.precision,request.mode==='decimal'?2:null);
    assert.deepEqual(doc.request,request);assert.deepEqual(doc.result.paths,response.paths);
    assert.deepEqual(run(doc.request).paths,doc.result.paths);
    assert.match(openResultSvg({...response,paths:[]}),/viewBox="-10 -10 20 20"/);
  }
  const request=structuredClone(cases.rectclip.find(c=>c.id==='decimal-region')),response=run(request),doc=resultDocument(request,response);
  assert.equal(response.ok,true,JSON.stringify(response));assert.equal(doc.version,1);
  assert.equal(doc.request.input_kind,'polygons');assert.equal(doc.request.params.fill_rule,'EvenOdd');
  assert.deepEqual(doc.request,request);assert.equal(doc.result.mode,'decimal');assert.equal(doc.result.precision,2);
  const expected=[rect(-1.25,-.5,4,3),rect(0,0,1,1).reverse()];
  assert.deepEqual(canonical(doc.result.paths),canonical(expected));assert.deepEqual(canonical(run(doc.request).paths),canonical(expected));
  const svg=resultSvg(response.paths),d=svg.match(/<path d="([^"]*)"/)[1];
  assert.equal((d.match(/Z/g)??[]).length,2);assert.match(svg,/fill-rule="nonzero"/);
  assert.ok(d.includes('0,0'));assert.ok(d.includes('-1.25,-0.5'));
  const treeRequest={...request,output:'tree'},treeResponse=run(treeRequest),treeDoc=resultDocument(treeRequest,treeResponse);
  assert.equal(treeResponse.ok,true,JSON.stringify(treeResponse));assert.equal(treeDoc.version,2);
  assert.deepEqual(treeDoc.request,treeRequest);assert.equal(treeDoc.request.output,'tree');
  assert.deepEqual(treeDoc.result.paths,treeResponse.paths);assert.deepEqual(treeDoc.result.tree,treeResponse.tree);
  assert.equal(treeDoc.result.mode,'decimal');assert.equal(treeDoc.result.precision,2);
  const replay=run(treeDoc.request);assert.deepEqual(replay.paths,treeDoc.result.paths);assert.deepEqual(replay.tree,treeDoc.result.tree);
  const treeSvg=resultSvg(treeResponse.paths),treeD=treeSvg.match(/<path d="([^"]*)"/)[1];
  assert.equal((treeD.match(/Z/g)??[]).length,2);assert.match(treeSvg,/fill-rule="nonzero"/);
  assert.deepEqual(canonical(treeDoc.result.paths),canonical(expected));
  for(const contour of treeResponse.paths)for(const [x,y] of contour)assert.ok(treeD.includes(`${x},${y}`));


});

test('demo rectclip: invalid requests cannot export a result',()=>{
  const request=cases.rectclip[0],decimal=cases.rectclip.find(c=>c.id==='decimal-cross');
  const reversed=run({...request,rect:{...request.rect,min_x:11}});
  assert.equal(reversed.ok,false);assert.equal(reversed.error.stage,'RectClipParameters');
  const collapsed=run({...decimal,input_kind:'polygons',output:'tree',precision:0,rect:{min_x:.1,min_y:0,max_x:.2,max_y:1}});
  assert.equal(collapsed.ok,false);assert.equal(collapsed.error.kind,'QuantizationFailure');assert.equal(collapsed.error.stage,'DecimalQuantize');
  assert.equal(Object.hasOwn(request,'input_kind'),false);
  const legacy=run({...request,output:undefined});assert.equal(legacy.geometry,'open-paths');assert.equal(legacy.output,'paths');assert.equal(legacy.tree,undefined);assert.deepEqual(legacy.paths,[[[0,5],[5,5],[10,5]]]);
  for(const bad of [reversed,collapsed,
    run({...request,input_kind:'unknown'}),run({...request,input_kind:'polygons',output:'unknown'}),
    run({...request,input_kind:'polygons',mode:'decimal',output:'tree',query:{point:[1,1]}}),run({...cases.rectclip.find(c=>c.id==='integer-region'),params:{fill_rule:'invalid'}}),
    run({...request,mode:'unknown'}),run({...decimal,precision:7}),
    run({...request,paths:[[[0.5,5],[5,5]]]}),
    run({...request,rect:{...request.rect,min_x:.5}}),
    run({...request,output:'tree'}),run({...request,simplify:{enabled:true}}),
  ]){
    assert.equal(bad.ok,false);assert.equal(bad.paths,undefined);assert.equal(bad.tree,undefined);assert.throws(()=>resultDocument(request,bad));assert.throws(()=>openResultSvg(bad));
  }
});
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
test('demo decimal minkowski: structured errors preserve locations',()=>{
  const r=run({scene:'boolean',subject:[[[1000000001,0],[0,10],[0,0]]],clip:[]});assert.equal(r.ok,false);assert.equal(r.error.kind,'CoordinateOutOfRange');assert.equal(r.error.path_index,0);assert.equal(r.error.vertex_index,0);assert.equal(r.error.value,1000000001);
  const collision=run({scene:'minkowski',mode:'decimal',precision:2,output:'tree',pattern:[[0.001,0]],path:[[0.002,0]],params:{path_is_closed:false}});
  assert.equal(collision.ok,false);assert.equal(collision.error.kind,'QuantizationFailure');
  assert.equal(collision.error.stage,'DecimalQuantize');assert.equal(collision.error.path_index,1);assert.equal(collision.error.vertex_index,0);
  assert.deepEqual(collision.error.related,{stage:'DecimalQuantize',path_index:0,vertex_index:0});
  assert.equal(run({scene:'offset',subject:[rect(0,0,10,10)],params:{delta:2,miter_limit:1}}).ok,false);
  assert.equal(JSON.parse(compute('{')).error.kind,'InvalidJSON');
  const request=cases.minkowski.find(c=>c.id==='decimal-grid');
  const legacy=run({...request,output:undefined});assert.equal(legacy.ok,true);assert.equal(legacy.output,'paths');assert.equal(legacy.tree,undefined);assert.equal(resultDocument(request,legacy).version,1);
  for(const bad of [collision,run({...request,output:'unknown'}),run({...request,output:'tree',simplify:{enabled:true}}),run({...request,mode:'decimal',output:'tree',query:{point:[0,0]}})]){
    assert.equal(bad.ok,false);assert.equal(bad.paths,undefined);assert.equal(bad.tree,undefined);assert.throws(()=>resultDocument(request,bad));
  }

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


test('demo decimal minkowski: complete decimal sweep result',()=>{
  const request=cases.minkowski.find(c=>c.id==='decimal-grid');
  const r=exact(request,[rect(-1,-.25,2,.5)]);
  assert.equal(r.mode,'decimal');assert.equal(r.precision,2);assert.equal(r.output,'paths');assert.equal(r.geometry,undefined);
  for(const id of ['tree-rectangle','tree-rectangle-d']){
    const input=cases.minkowski.find(c=>c.id===id),scale=input.mode==='decimal'?4:1;
    const expected=minkowskiTreeExpected.map(p=>p.map(([x,y])=>[x/scale,y/scale]));
    const tree=chain(input,expected);assert.equal(tree.mode,input.mode);assert.equal(tree.precision,input.mode==='decimal'?2:null);
    assert.deepEqual(tree.paths.map(p=>p.length),[11,4]);assert.equal(tree.query,undefined);
  }

});

test('demo decimal minkowski: closed area export and request replay',()=>{
  const request=structuredClone(cases.minkowski.find(c=>c.id==='decimal-grid')),r=run(request);
  const doc=resultDocument(request,r),svg=resultSvg(r.paths);
  assert.equal(doc.version,1);assert.deepEqual(doc.request,request);
  assert.deepEqual(doc.request.pattern,[[0,-.25],[0,.25]]);assert.deepEqual(doc.request.path,[[-1,0],[1,0]]);
  assert.equal(doc.request.precision,2);assert.equal(doc.request.params.path_is_closed,false);
  assert.equal(doc.result.mode,'decimal');assert.equal(doc.result.precision,2);
  assert.deepEqual(canonical(doc.result.paths),canonical([rect(-1,-.25,2,.5)]));
  assert.deepEqual(run(doc.request).paths,r.paths);
  assert.match(svg,/[zZ]" fill=/);assert.match(svg,/fill-rule="nonzero"/);
  assert.match(svg,/-0\.25/);assert.match(svg,/,0\.25/);
  const treeRequest=structuredClone(cases.minkowski.find(c=>c.id==='tree-rectangle-d')),tree=run(treeRequest);
  const treeDoc=resultDocument(treeRequest,tree),treeSvg=resultSvg(tree.paths);
  assert.equal(tree.ok,true,JSON.stringify(tree));assert.equal(treeDoc.version,2);assert.equal(treeDoc.result.output,'tree');
  assert.deepEqual(treeDoc.request,treeRequest);assert.equal(treeDoc.result.mode,'decimal');assert.equal(treeDoc.result.precision,2);
  assert.deepEqual(treeDoc.result.tree,tree.tree);assert.deepEqual(treeDoc.result.paths,tree.paths);
  const replay=run(treeDoc.request);assert.deepEqual(replay.paths,treeDoc.result.paths);assert.deepEqual(replay.tree,treeDoc.result.tree);
  const expected=minkowskiTreeExpected.map(p=>p.map(([x,y])=>[x/4,y/4]));assert.deepEqual(canonical(treeDoc.result.paths),canonical(expected));
  const d=treeSvg.match(/<path d="([^"]*)"/)[1];assert.equal(d,tree.paths.map(p=>'M'+p.map(q=>q.join(',')).join('L')+'Z').join(' '));
  assert.equal((d.match(/Z/g)||[]).length,2);assert.match(treeSvg,/fill-rule="nonzero"/);assert.deepEqual(tree.paths.map(p=>p.length),[11,4]);

});


test('demo stroke batch: complete merged rectangle',()=>{
  const r=exact(cases['stroke-batch'][0],[rect(0,-1,15,2)]);
  assert.equal(r.mode,'integer');assert.equal(r.precision,null);assert.equal(r.output,'paths');assert.equal(r.geometry,undefined);
  const decimal=exact(cases['stroke-batch'].find(c=>c.id==='decimal-overlap'),[rect(-1.25,.25,3,.5)]);
  assert.equal(decimal.mode,'decimal');assert.equal(decimal.precision,2);assert.equal(decimal.output,'paths');assert.equal(decimal.geometry,undefined);
  assert.equal(r.tree,undefined);assert.equal(run({...cases['stroke-batch'][0],output:undefined}).output,'paths');
  for(const [id,outer,hole] of [
    ['batch-tree-frame',rect(-1,-1,12,12),rect(1,1,8,8).reverse()],
    ['batch-tree-frame-d',rect(-.25,-.25,3,3),rect(.25,.25,2,2).reverse()],
  ]){
    const input=cases['stroke-batch'].find(c=>c.id===id),tree=exact(input,[outer,hole]);
    assert.equal(tree.output,'tree');assert.equal(tree.mode,input.mode);assert.equal(tree.precision,input.mode==='decimal'?2:null);
    assert.deepEqual(tree.tree,{roots:[0],nodes:[{parent:null,children:[1],depth:1,is_hole:false},{parent:0,children:[],depth:2,is_hole:true}]});
    assert.deepEqual(canonical([tree.paths[0]]),canonical([outer]));assert.deepEqual(canonical([tree.paths[1]]),canonical([hole]));
    assert.equal(tree.query,undefined);
  }
});

test('demo stroke batch: subsequent route error and unsupported requests',()=>{
  const request=cases['stroke-batch'][0],decimal=cases['stroke-batch'].find(c=>c.id==='decimal-overlap');
  const later=run({...request,paths:[request.paths[0],[[5,0],[1000000001,0]]]});
  assert.equal(later.ok,false);assert.equal(later.error.kind,'CoordinateOutOfRange');
  assert.equal(later.error.stage,'StrokeGenerate');assert.equal(later.error.path_index,1);assert.equal(later.error.vertex_index,1);
  const collision=run({...decimal,output:'tree',paths:[[[.001,0],[1,0]],[[.002,0],[2,0]]]});
  assert.equal(collision.ok,false);assert.equal(collision.error.kind,'QuantizationFailure');assert.equal(collision.error.stage,'DecimalQuantize');
  assert.equal(collision.error.path_index,1);assert.equal(collision.error.vertex_index,0);
  assert.equal(collision.error.related.path_index,0);assert.equal(collision.error.related.vertex_index,0);
  for(const bad of [later,collision,run({...request,mode:'unknown'}),run({...request,paths:decimal.paths}),run({...request,output:'unknown'}),run({...request,simplify:{enabled:true}})]){
    assert.equal(bad.ok,false);assert.equal(bad.tree,undefined);assert.equal(bad.paths,undefined);assert.throws(()=>resultDocument(request,bad));
  }
});

test('demo stroke batch: closed region export and replay',()=>{
  for(const input of [cases['stroke-batch'][0],cases['stroke-batch'].find(c=>c.id==='decimal-overlap')]){
    const request=structuredClone(input),r=run(request),doc=resultDocument(request,r);
    assert.equal(r.ok,true,JSON.stringify(r));assert.equal(doc.version,1);assert.deepEqual(doc.request,request);
    assert.deepEqual(doc.request.paths,input.paths);assert.deepEqual(doc.request.params,input.params);
    assert.equal(doc.result.mode,input.mode);assert.equal(doc.result.precision,input.mode==='decimal'?2:null);
    const expected=input.mode==='decimal'?rect(-1.25,.25,3,.5):rect(0,-1,15,2);
    assert.deepEqual(canonical(doc.result.paths),canonical([expected]));assert.deepEqual(run(doc.request).paths,r.paths);
    const svg=resultSvg(r.paths);assert.match(svg,/[zZ]" fill=/);assert.match(svg,/fill-rule="nonzero"/);
    if(input.mode==='decimal')for(const [x,y] of expected)assert.ok(svg.includes(`${x},${y}`));
  }
  const request=structuredClone(cases['stroke-batch'].find(c=>c.id==='batch-tree-frame-d'));
  const response=run(request),doc=resultDocument(request,response);
  assert.equal(response.ok,true,JSON.stringify(response));assert.equal(doc.version,2);assert.equal(doc.result.output,'tree');
  assert.deepEqual(doc.request,request);assert.deepEqual(doc.request.paths,request.paths);assert.deepEqual(doc.request.params,request.params);
  assert.equal(doc.result.mode,'decimal');assert.equal(doc.result.precision,2);
  assert.deepEqual(doc.result.paths,response.paths);assert.deepEqual(doc.result.tree,response.tree);
  const replay=run(doc.request);assert.deepEqual(replay.paths,doc.result.paths);assert.deepEqual(replay.tree,doc.result.tree);
  const svg=resultSvg(response.paths);assert.match(svg,/fill-rule="nonzero"/);
  assert.equal((svg.match(/<path d="([^"]*)"/)[1].match(/Z/g)||[]).length,2);
  for(const contour of response.paths)for(const [x,y] of contour)assert.ok(svg.includes(`${x},${y}`));

});

test('demo tree locate: public batch and window routes locate the final integer region',()=>{
  const minkowski=cases.minkowski.find(c=>c.id==='tree-rectangle');
  const batch=cases['stroke-batch'].find(c=>c.id==='batch-tree-frame');
  const region=cases.rectclip.find(c=>c.id==='integer-region');
  const notch=[[0,0],[5,0],[5,3],[3,3],[3,7],[5,7],[5,10],[0,10]];
  for(const [request,point,status,contour] of [
    [minkowski,[5,5],'InHole',minkowskiTreeExpected[1]],
    [batch,[5,5],'InHole',rect(1,1,8,8).reverse()],
    [{...region,output:'tree',rect:{...region.rect,max_x:5}},[4,5],'Outside',null],
  ]){
    const r=run({...request,query:{point}});assert.equal(r.ok,true,JSON.stringify(r));
    assert.deepEqual(r.query.point,point);assert.equal(r.query.status,status);assert.equal(r.query.node_indices.length,contour?1:0);
    if(contour){const i=r.query.node_indices[0];assert.deepEqual(canonical([r.paths[i]]),canonical([contour]));assert.equal(r.tree.nodes[i].depth,2);assert.equal(r.tree.nodes[i].is_hole,true);}
    else {assert.deepEqual(canonical(r.paths),canonical([notch]));assert.deepEqual(r.tree,{roots:[0],nodes:[{parent:null,children:[],depth:1,is_hole:false}]});}
  }
});

test('demo tree locate: all touching boundaries and complete query errors',()=>{
  const request={scene:'boolean',mode:'integer',output:'tree',subject:[rect(0,0,10,10),rect(10,10,10,10)],clip:[],params:{operation:'Union'},query:{point:[10,10]}};
  const r=run(request);assert.equal(r.ok,true);assert.equal(r.query.status,'OnBoundary');assert.equal(new Set(r.query.node_indices).size,2);
  assert.deepEqual(canonical(r.query.node_indices.map(i=>r.paths[i])),canonical(request.subject));
  for(const i of r.query.node_indices){assert.equal(r.tree.nodes[i].depth,1);assert.equal(r.tree.nodes[i].is_hole,false);}
  const outside=run({...request,query:{point:[1000000001,0]}});
  assert.equal(outside.ok,false);assert.equal(outside.error.kind,'CoordinateOutOfRange');assert.equal(outside.error.stage,'PolyTreeQuery');
  assert.equal(outside.error.path_index,null);assert.equal(outside.paths,undefined);
  for(const invalid of [{...request,mode:'decimal'},{...request,output:'paths'}, {...cases.rectclip[0],output:'tree',query:{point:[5,5]}}, {...request,query:{point:[.5,0]}},{...request,scene:'unknown'},{...request,query:{point:[0]}}]){
    const bad=run(invalid);assert.equal(bad.ok,false);assert.equal(bad.error.stage,'BridgeInput');assert.equal(bad.paths,undefined);assert.equal(bad.tree,undefined);assert.throws(()=>resultDocument(invalid,bad));
  }
});

test('demo tree locate: v2 JSON query replay and absent-query compatibility',()=>{
  const request={...structuredClone(cases['stroke-batch'].find(c=>c.id==='batch-tree-frame')),query:{point:[5,5]}},r=run(request),doc=resultDocument(request,r);
  assert.equal(doc.version,2);assert.equal(doc.request.scene,'stroke-batch');assert.deepEqual(doc.request.paths,request.paths);assert.deepEqual(doc.request.query,{point:[5,5]});assert.deepEqual(doc.result.query,r.query);
  const replay=run(doc.request);assert.equal(replay.ok,true);assert.equal(replay.query.status,'InHole');
  const hits=response=>response.query.node_indices.map(i=>({contour:response.paths[i],depth:response.tree.nodes[i].depth,is_hole:response.tree.nodes[i].is_hole}));
  assert.deepEqual(hits(replay),hits(r));assert.deepEqual(canonical([hits(replay)[0].contour]),canonical([rect(1,1,8,8).reverse()]));assert.equal(hits(replay)[0].depth,2);
  delete request.query;const plain=run(request),plainDoc=resultDocument(request,plain);
  assert.equal(plain.ok,true);assert.equal(Object.hasOwn(plain,'query'),false);assert.equal(Object.hasOwn(plainDoc.result,'query'),false);
  assert.deepEqual(Object.keys(plainDoc.result),['paths','mode','precision','output','tree']);
});
