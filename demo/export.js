// Presentation only: no Boolean, offset, stroke or simplification calculations.
export function viewFor(paths){
  const points=paths.flat();if(!points.length)return {x:-10,y:-10,w:20,h:20};
  let minX=Infinity,minY=Infinity,maxX=-Infinity,maxY=-Infinity;
  for(const [x,y] of points){minX=Math.min(minX,x);maxX=Math.max(maxX,x);minY=Math.min(minY,y);maxY=Math.max(maxY,y);}
  const pad=Math.max(maxX-minX,maxY-minY,10)*.15;
  return {x:minX-pad,y:-maxY-pad,w:Math.max(maxX-minX,1)+2*pad,h:Math.max(maxY-minY,1)+2*pad};
}
export const contourData=paths=>paths.filter(p=>p.length).map(p=>'M'+p.map(q=>q.join(',')).join('L')+'Z').join(' ');
export function resultSvg(paths){
  const v=viewFor(paths);
  return `<?xml version="1.0" encoding="UTF-8"?><svg xmlns="http://www.w3.org/2000/svg" viewBox="${v.x} ${v.y} ${v.w} ${v.h}" width="1000" height="700"><title>MoonClip geometry result</title><desc>Real MoonBit output. Mathematical coordinates, y up. NonZero fill preserves holes.</desc><rect x="${v.x}" y="${v.y}" width="${v.w}" height="${v.h}" fill="#fff"/><g transform="scale(1,-1)"><path d="${contourData(paths)}" fill="#148b7b" fill-rule="nonzero" stroke="#08695e" stroke-width="1" vector-effect="non-scaling-stroke"/></g></svg>`;
}
export function resultDocument(request,response){
  if(!response?.ok)throw new Error('No valid result to export');
  const tree=response.output==='tree';
  return {format:'MoonClipDemo',version:tree?2:1,kernel:'MoonBit',request:structuredClone(request),result:{paths:structuredClone(response.paths),mode:response.mode,precision:response.precision,...(tree?{output:'tree',tree:structuredClone(response.tree)}:{})},simplification:structuredClone(response.simplification)};
}
