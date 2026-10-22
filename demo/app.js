import {cases,patterns} from './cases.js';
import {viewFor,contourData,openPathData,resultSvg,openResultSvg,resultDocument} from './export.js';
const $=id=>document.getElementById(id);
const titles={boolean:'区域布尔',offset:'带孔偏移',stroke:'路线加宽',minkowski:'图案扫掠',rectclip:'窗口裁剪','stroke-batch':'批量加宽'};
let scene='boolean',input=null,valid=null,requestId=0,view=null,ready=false,selectedNode=null;
const worker=new Worker(new URL('./worker.js',import.meta.url),{type:'module'});
worker.onerror=e=>{requestId++;showError({kind:'WorkerError',stage:'BrowserBridge',message:e.message});};
worker.onmessage=({data})=>{
  if(data.ready){ready=true;calculate();return;}
  if(data.id!==requestId)return;
  $('compute').disabled=false;
  const r=data.response;showReport(r.simplification);
  if(!r.ok){showError(r.error,r.simplification);return;}
  valid={request:structuredClone(input),response:r};
  $('status').textContent='计算完成';const units=input.mode==='decimal'?'小数 Precision '+input.precision:'整数';$('result-detail').textContent=scene==='rectclip'?`${units} · 开放折线 · 窗口裁剪`:scene==='stroke-batch'?`${units} · 批量加宽 · 完整宽度 ${input.params.width} · ${input.params.cap} / ${input.params.join} · 重叠区域统一合并`:scene==='minkowski'?`${units} · 图案扫掠 · NonZero · 保留共线点`:scene==='stroke'?`${units} · 完整宽度 ${input.params.width} · ${input.params.cap} / ${input.params.join}`:scene==='offset'?`${units} · 偏移 ${input.params.delta} · ${input.params.join} / ${input.params.fill_rule}`:`${units} · ${input.params.operation} / ${input.params.fill_rule}`;
  $('contours').textContent=r.paths.length;$('vertices').textContent=r.paths.reduce((n,p)=>n+p.length,0);$('elapsed').textContent=data.elapsed.toFixed(2);$('removed').textContent=['rectclip','stroke-batch'].includes(scene)?input.paths.length:(r.simplification?.removed_vertices??0);
  $('error').hidden=true;$('export-svg').disabled=false;$('export-json').disabled=false;
  renderTree();renderQuery();fit();
};
function clearQuery(){$('query-result').hidden=true;$('query-status').textContent='';$('query-hits').textContent='';}
function renderQuery(){
  clearQuery();const q=valid?.response.query;if(!q)return;
  const names={Outside:'外部',Inside:'区域内部',InHole:'孔洞内部',OnBoundary:'边界'};
  $('query-result').hidden=false;$('query-status').textContent=`${names[q.status]} · 点 (${q.point.join(', ')})`;
  $('query-hits').textContent=q.node_indices.length?q.node_indices.map(i=>{const n=valid.response.tree.nodes[i];return `#${i} · 深度 ${n.depth} · ${n.is_hole?'孔洞':'填充节点'}`;}).join('；'):'没有命中节点';
}
function clearTree(){selectedNode=null;$('tree-panel').hidden=true;$('tree-list').replaceChildren();$('tree-summary').textContent='';$('selection-detail').textContent='点击节点，定位对应轮廓。';$('clear-selection').disabled=true;}
function selectNode(index){selectedNode=index;for(const b of $('tree-list').querySelectorAll('[data-node-index]'))b.setAttribute('aria-pressed',String(Number(b.dataset.nodeIndex)===index));$('clear-selection').disabled=index===null;$('selection-detail').textContent=index===null?'点击节点，定位对应轮廓。':`已选择 #${index} · ${valid.response.tree.nodes[index].is_hole?'孔洞':'外轮廓'} · 仅高亮边界`;draw();}
function renderTree(){
  clearTree();const tree=valid?.response.tree;if(!tree)return;
  $('tree-panel').hidden=false;
  let maxDepth=0;for(const n of tree.nodes)maxDepth=Math.max(maxDepth,n.depth);
  $('tree-summary').textContent=`${tree.roots.length} 个根 · ${tree.nodes.length} 个轮廓 · 最大深度 ${maxDepth}`;
  if(!tree.nodes.length){$('tree-list').textContent='空区域，没有可选择的轮廓。';return;}
  const queue=tree.roots.map(index=>({index,container:$('tree-list')}));
  for(let cursor=0;cursor<queue.length;cursor++){
    const {index,container}=queue[cursor],node=tree.nodes[index];
    const button=document.createElement('button');button.type='button';button.className='tree-node';button.dataset.nodeIndex=index;button.setAttribute('aria-pressed','false');button.textContent=`#${index} · 深度 ${node.depth} · ${node.is_hole?'孔洞':'外轮廓'} · ${valid.response.paths[index].length} 点`;button.onclick=event=>{event.preventDefault();event.stopPropagation();selectNode(index);};
    let childContainer;
    if(node.children.length){const details=document.createElement('details');details.open=true;const summary=document.createElement('summary');summary.append(button);childContainer=document.createElement('div');childContainer.className='tree-children';details.append(summary,childContainer);container.append(details);}
    else container.append(button);
    for(const child of node.children)queue.push({index:child,container:childContainer});
  }
}
function showReport(report){$('simplification').hidden=!report;if(report)$('simplification-data').textContent=JSON.stringify(report,null,2);}
function invalidate(){requestId++;valid=null;clearTree();clearQuery();$('export-svg').disabled=true;$('export-json').disabled=true;$('status').textContent='输入已更新 · 待计算';$('result-detail').textContent='当前没有有效结果，计算后才可导出';for(const id of ['contours','vertices','elapsed','removed'])$(id).textContent='—';$('error').hidden=true;showReport(null);$('compute').disabled=false;draw();}
function showError(error,report){valid=null;clearTree();clearQuery();$('export-svg').disabled=true;$('export-json').disabled=true;$('compute').disabled=false;$('status').textContent='计算未完成';$('result-detail').textContent='检查错误信息，修正后重新计算';$('error').hidden=false;$('error').textContent=JSON.stringify(error,null,2);showReport(report);for(const id of ['contours','vertices','elapsed'])$(id).textContent='—';$('removed').textContent=report?.removed_vertices??'—';draw();}
function numeric(id){const value=$(id).value.trim();if(value==='')throw new Error('参数不能为空: '+id);const n=Number(value);if(!Number.isFinite(n))throw new Error('参数必须是有限数值: '+id);return n;}
function readRequest(){
  if(scene==='stroke-batch')return {version:1,scene,mode:$('mode').value,precision:numeric('precision'),output:'paths',paths:JSON.parse($('input-a').value),params:{width:numeric('width'),cap:$('cap').value,join:$('join').value,miter_limit:numeric('miter-limit'),arc_tolerance:numeric('arc-tolerance')},simplify:{enabled:false}};
  if(scene==='rectclip')return {version:1,scene,mode:$('mode').value,precision:numeric('precision'),output:'paths',paths:JSON.parse($('input-a').value),rect:{min_x:numeric('min-x'),min_y:numeric('min-y'),max_x:numeric('max-x'),max_y:numeric('max-y')},simplify:{enabled:false}};
  const r={version:1,scene,output:$('output').value,mode:$('mode').value,precision:numeric('precision'),params:{operation:$('operation').value,fill_rule:$('fill-rule').value,delta:numeric('delta'),width:numeric('width'),join:$('join').value,cap:$('cap').value,miter_limit:numeric('miter-limit'),arc_tolerance:numeric('arc-tolerance'),path_is_closed:$('closed').checked},simplify:{enabled:$('simplify').checked,epsilon:numeric('epsilon')}};
  if(scene==='boolean'&&r.mode==='integer'&&r.output==='tree'&&$('query-enabled').checked)r.query={point:[numeric('query-x'),numeric('query-y')]};
  const a=JSON.parse($('input-a').value);
  if(scene==='boolean'){r.subject=a;r.clip=JSON.parse($('input-b').value);}
  else if(scene==='offset')r.subject=a;
  else {r.path=a;if(scene==='minkowski')r.pattern=JSON.parse($('input-b').value);}
  return r;
}
function calculate(){
  invalidate();
  try{input=readRequest();if(!ready){$('status').textContent='加载 MoonBit 核心…';return;}$('compute').disabled=true;$('status').textContent='MoonBit 正在计算…';worker.postMessage({id:requestId,request:input});}
  catch(error){showError({kind:'InvalidInput',stage:'Editor',message:String(error.message)});}
}
function setVisibility(){
  const querySupported=scene==='boolean'&&$('mode').value==='integer'&&$('output').value==='tree';
  $('query-controls').hidden=!querySupported;if(!querySupported)$('query-enabled').checked=false;
  $('query-fields').hidden=!$('query-enabled').checked;
  document.querySelectorAll('[data-for]').forEach(el=>{el.hidden=!el.dataset.for.split(' ').includes(scene);});
  $('route-tabs').hidden=!['stroke','minkowski','rectclip','stroke-batch'].includes(scene);
  $('rectclip-tab').classList.toggle('selected',scene==='rectclip');$('batch-tab').classList.toggle('selected',scene==='stroke-batch');
  $('coordinate-controls').hidden=false;$('output-controls').hidden=['rectclip','stroke-batch'].includes(scene);
  $('contours-label').textContent=scene==='rectclip'?'输出片段':'结果轮廓';$('removed-label').textContent=['rectclip','stroke-batch'].includes(scene)?'输入路线':'简化删点';
  $('stroke-tab').classList.toggle('selected',scene==='stroke');$('sweep-tab').classList.toggle('selected',scene==='minkowski');
  $('scene-title').textContent=titles[scene];
  $('output').disabled=scene==='minkowski';if(scene==='minkowski')$('output').value='paths';
  $('mode').disabled=false;if(scene==='minkowski')$('simplify').checked=false;
  $('precision').disabled=$('mode').value==='integer';$('simplify-control').hidden=['minkowski','rectclip','stroke-batch'].includes(scene);
  if(['rectclip','stroke-batch'].includes(scene)){$('output').value='paths';$('simplify').checked=false;$('closed').checked=false;}
  $('mode-badge').textContent=scene==='rectclip'?($('mode').value==='decimal'?'小数 · 开放折线':'整数 · 开放折线'):$('mode').value==='decimal'?'小数':'整数';
  $('mode-note').textContent=scene==='stroke-batch'?'整批共享样式，重叠区域统一合并。小数模式使用共同精度网格，宽度和圆弧容差采用原始坐标单位。输入路线独立开放，输出为闭合区域。':scene==='rectclip'?'输入与输出均为开放路线；窗口以虚线标示。小数按共同精度网格计算；有面积窗口可能因精度过粗而塌缩报错，与原始空窗口不同。':scene==='minkowski'?'图案与路线单位相同；小数由 MoonBit 公共入口量化。Precision 影响细节，合并可能报错；图案不自动居中，不额外补满端点。':$('mode').value==='decimal'?'Precision 0—6；距离与 epsilon 使用原始小数单位。':'整数坐标 ±10⁹；距离与宽度使用相同单位。';
  $('input-a-label').textContent=['rectclip','stroke-batch'].includes(scene)?'开放路线集合 · Paths':scene==='boolean'?'操作数 A · Paths':scene==='offset'?'区域与孔洞 · Paths':'开放/闭合路线 · Path';
  $('editor-b').hidden=scene!=='boolean'&&scene!=='minkowski';$('input-b-label').textContent=scene==='minkowski'?'图案 · Path（相对锚点）':'操作数 B · Paths';
  $('epsilon-row').hidden=!$('simplify').checked;
}
function loadCase(){
  const c=structuredClone(cases[scene].find(c=>c.id===$('case').value)??cases[scene][0]);
  $('output').value=c.output??'paths';$('mode').value=c.mode;$('precision').value=String(c.precision??3);$('simplify').checked=false;$('epsilon').value=.5;
  $('query-enabled').checked=false;$('query-x').value=String(c.query?.point?.[0]??6);$('query-y').value=String(c.query?.point?.[1]??6);
  const p=c.params??{};
  if(scene==='rectclip')for(const [id,key] of [['min-x','min_x'],['min-y','min_y'],['max-x','max_x'],['max-y','max_y']])$(id).value=String(c.rect[key]);
  for(const [id,key,fallback] of [['operation','operation','Intersection'],['fill-rule','fill_rule','EvenOdd'],['delta','delta',5],['width','width',12],['join','join','Miter'],['cap','cap','Butt'],['miter-limit','miter_limit',2],['arc-tolerance','arc_tolerance',.25]])$(id).value=p[key]??fallback;
  $('closed').checked=p.path_is_closed??false;$('input-a').value=JSON.stringify(c.paths??c.subject??c.path,null,2);$('input-b').value=JSON.stringify(c.clip??c.pattern??[],null,2);
  if(scene==='minkowski')$('pattern-select').value=c.id==='decimal-grid'?'custom':'rectangle';
  input=c;setVisibility();view=null;invalidate();fit();if(ready)calculate();
}
function switchScene(next){scene=next;document.querySelectorAll('[data-scene]').forEach(b=>b.classList.toggle('active',b.dataset.scene===(['stroke','minkowski','rectclip','stroke-batch'].includes(scene)?'route':scene)));$('case').replaceChildren(...cases[scene].map(c=>new Option(c.label,c.id)));loadCase();}
function inputLayers(){
  let r;try{r=readRequest();}catch{return [];}
  const safe=layers=>layers.filter(l=>Array.isArray(l.paths)&&l.paths.every(p=>Array.isArray(p)&&p.every(q=>Array.isArray(q)&&q.length===2&&q.every(Number.isFinite))));
  if(scene==='stroke-batch')return safe([{name:'独立输入路线',paths:r.paths,color:'#b9782e',closed:false}]);
  if(scene==='rectclip')return safe([{name:'输入路线',paths:r.paths,color:'#b9782e',closed:false},{name:'裁剪窗口',paths:[[[r.rect.min_x,r.rect.min_y],[r.rect.max_x,r.rect.min_y],[r.rect.max_x,r.rect.max_y],[r.rect.min_x,r.rect.max_y]]],color:'#8265a6',closed:true,window:true}]);
  if(scene==='boolean')return safe([{name:'操作数 A',paths:r.subject,color:'#3972bd',closed:true},{name:'操作数 B',paths:r.clip,color:'#bd792d',closed:true}]);
  if(scene==='offset')return safe([{name:'输入区域 / 孔洞',paths:r.subject,color:'#3972bd',closed:true}]);
  const layers=[{name:'路线',paths:[r.path],color:'#b9782e',closed:scene==='minkowski'&&r.params.path_is_closed}];
  if(scene==='minkowski')layers.push({name:'图案 / 局部原点',paths:[r.pattern],color:'#8265a6',closed:true});
  return safe(layers);
}
function fit(){const layers=inputLayers();view=viewFor([...layers.flatMap(l=>l.paths),...(valid?.response.paths??[]),...(valid?.response.query?[[valid.response.query.point]]:[])]);draw();}
function zoom(factor){if(!view)return;view={x:view.x+view.w*(1-factor)/2,y:view.y+view.h*(1-factor)/2,w:view.w*factor,h:view.h*factor};draw();}
function draw(){
  const svg=$('drawing');const layers=inputLayers();if(!view)view=viewFor(layers.flatMap(l=>l.paths));
  if(![view.x,view.y,view.w,view.h].every(Number.isFinite))return;
  svg.setAttribute('viewBox',`${view.x} ${view.y} ${view.w} ${view.h}`);
  const objects=[];
  objects.push(`<g stroke="#b2c3b5" stroke-width=".6" vector-effect="non-scaling-stroke"><path d="M${view.x},0h${view.w}M0,${view.y}v${view.h}" vector-effect="non-scaling-stroke"/></g>`);
  if($('show-result').checked&&valid&&valid.response.geometry!=='open-paths')objects.push(`<path d="${contourData(valid.response.paths)}" fill="#30a18e" fill-opacity=".32" fill-rule="nonzero" stroke="#087f72" stroke-width="1.7" vector-effect="non-scaling-stroke"/>`);
  if($('show-input').checked){
    for(const l of layers){if(!Array.isArray(l.paths)||!l.paths.every(p=>Array.isArray(p)&&p.every(q=>Array.isArray(q)&&q.length===2&&q.every(Number.isFinite))))continue;
      const d=l.closed?contourData(l.paths):openPathData(l.paths);
      objects.push(`<path d="${d}" fill="${l.closed&&!l.window?l.color:'none'}" fill-opacity=".055" fill-rule="${$('fill-rule').value==='EvenOdd'?'evenodd':'nonzero'}" stroke="${l.color}" stroke-width="1.4" stroke-dasharray="${l.closed?'4 3':'none'}" vector-effect="non-scaling-stroke"/>`);
      const radius=view.w/500;
      for(const p of l.paths)for(const [x,y] of p)objects.push(`<circle cx="${x}" cy="${y}" r="${radius}" fill="white" stroke="${l.color}" stroke-width="1" vector-effect="non-scaling-stroke"/>`);
    }
    if(scene==='minkowski')objects.push(`<path d="M${-view.w/60},0h${view.w/30}M0,${-view.w/60}v${view.w/30}" stroke="#8265a6" stroke-width="2" vector-effect="non-scaling-stroke"/>`);
  }
  if($('show-result').checked&&valid?.response.geometry==='open-paths')objects.push(`<path d="${openPathData(valid.response.paths)}" fill="none" stroke="#087f72" stroke-width="3" vector-effect="non-scaling-stroke"/>`);
  if($('show-result').checked&&valid&&selectedNode!==null)objects.push(`<path data-selected-contour="${selectedNode}" d="${contourData([valid.response.paths[selectedNode]])}" fill="none" stroke="#d65a25" stroke-width="4" vector-effect="non-scaling-stroke"/>`);
  const query=valid?.response.query;
  if(query){
    if($('show-result').checked)for(const i of query.node_indices)objects.push(`<path data-query-node="${i}" d="${contourData([valid.response.paths[i]])}" fill="none" stroke="#9b3ca6" stroke-width="3" stroke-dasharray="6 3" vector-effect="non-scaling-stroke"/>`);
    const [x,y]=query.point;objects.push(`<circle data-query-point="true" cx="${x}" cy="${y}" r="${view.w/120}" fill="#ae2471" stroke="white" stroke-width="1.5" vector-effect="non-scaling-stroke"/>`);
  }
  svg.innerHTML=`<g transform="scale(1,-1)">${objects.join('')}</g>`;
  $('legend').replaceChildren(...[...layers,{name:'MoonBit 结果',color:'#087f72'}].map(l=>{const span=document.createElement('span');const i=document.createElement('i');i.style.background=l.color;span.append(i,document.createTextNode(l.name));return span;}));
  $('view-label').textContent=`x: ${view.x.toFixed(1)} … ${(view.x+view.w).toFixed(1)} · y 向上`;
}
function download(type){if(!valid)return;const name=`moonclip-${valid.request.scene}`;const body=type==='svg'?(valid.response.geometry==='open-paths'?openResultSvg(valid.response):resultSvg(valid.response.paths)):JSON.stringify(resultDocument(valid.request,valid.response),null,2);const blob=new Blob([body],{type:type==='svg'?'image/svg+xml':'application/json'});const url=URL.createObjectURL(blob);const a=document.createElement('a');a.href=url;a.download=name+'.'+type;a.click();setTimeout(()=>URL.revokeObjectURL(url),1000);}
document.querySelectorAll('[data-scene]').forEach(b=>b.onclick=()=>switchScene(b.dataset.scene==='route'?'stroke':b.dataset.scene));
$('batch-tab').onclick=()=>switchScene('stroke-batch');
$('rectclip-tab').onclick=()=>switchScene('rectclip');
$('stroke-tab').onclick=()=>switchScene('stroke');$('sweep-tab').onclick=()=>switchScene('minkowski');
$('pattern-select').replaceChildren(new Option('案例／自定义图案','custom'),...Object.entries(patterns).map(([id,p])=>new Option(p.label,id)));
$('pattern-select').onchange=()=>{if($('pattern-select').value==='custom')return;$('input-b').value=JSON.stringify(patterns[$('pattern-select').value].points,null,2);invalidate();fit();calculate();};
$('output').onchange=()=>{setVisibility();calculate();};$('clear-selection').onclick=()=>selectNode(null);
$('case').onchange=loadCase;$('compute').onclick=calculate;
for(const id of ['mode','precision','operation','fill-rule','delta','width','join','cap','miter-limit','arc-tolerance','closed','simplify','epsilon','input-a','input-b','min-x','min-y','max-x','max-y','query-enabled','query-x','query-y'])$(id).addEventListener('input',()=>{if(id==='input-b'&&scene==='minkowski')$('pattern-select').value='custom';invalidate();setVisibility();draw();});
for(const id of ['show-input','show-result'])$(id).onchange=draw;
$('zoom-in').onclick=()=>zoom(.8);$('zoom-out').onclick=()=>zoom(1.25);$('fit').onclick=fit;
$('drawing').addEventListener('wheel',e=>{e.preventDefault();zoom(e.deltaY>0?1.12:1/1.12);},{passive:false});
let dragging=null;$('drawing').addEventListener('pointerdown',e=>{dragging={x:e.clientX,y:e.clientY,v:{...view}};e.currentTarget.setPointerCapture(e.pointerId);});
$('drawing').addEventListener('pointermove',e=>{if(!dragging)return;const box=$('drawing').getBoundingClientRect();view={...dragging.v,x:dragging.v.x-(e.clientX-dragging.x)*dragging.v.w/box.width,y:dragging.v.y-(e.clientY-dragging.y)*dragging.v.h/box.height};draw();});
$('drawing').addEventListener('pointerup',()=>{dragging=null;});$('drawing').addEventListener('pointercancel',()=>{dragging=null;});
$('export-svg').onclick=()=>download('svg');$('export-json').onclick=()=>download('json');
switchScene('boolean');
