// Inputs and parameters only. Geometry always comes from MoonBit.
const rect=(x,y,w,h)=>[[x,y],[x+w,y],[x+w,y+h],[x,y+h]];
export const patterns={
  rectangle:{label:'居中矩形',points:rect(-5,-4,10,8)},
  circle:{label:'整数近圆',points:[[6,0],[4,4],[0,6],[-4,4],[-6,0],[-4,-4],[0,-6],[4,-4]]},
  concave:{label:'凹 L 图案',points:[[0,0],[8,0],[8,3],[3,3],[3,8],[0,8]]},
  offcenter:{label:'偏置图案',points:[[3,2],[11,2],[9,8],[3,6]]},
};
const base={version:1,mode:'integer',precision:3,simplify:{enabled:false,epsilon:.5}};
export const cases={
  // Legacy cases intentionally omit operation; loading them defaults to Intersection.
  lineclip:[
    {id:'hole-route',label:'整数路线 · 穿过带孔区域',version:1,scene:'lineclip',mode:'integer',output:'paths',paths:[[[-2,5],[2,5],[5,5],[12,5]]],clip:[rect(0,0,10,10),rect(3,3,4,4)],params:{fill_rule:'EvenOdd'},simplify:{enabled:false}},
    {id:'hole-route-d',label:'小数路线 · 带孔区域 / Precision 2',version:1,scene:'lineclip',mode:'decimal',precision:2,output:'paths',paths:[[[-.2,.5],[.2,.5],[.5,.5],[1.2,.5]]],clip:[rect(0,0,1,1),rect(.3,.3,.4,.4)],params:{fill_rule:'EvenOdd'},simplify:{enabled:false}},
  ],
  'stroke-batch':[
    {id:'overlap-lines',label:'两条直线 · 重叠合并',version:1,scene:'stroke-batch',mode:'integer',output:'paths',paths:[[[0,0],[10,0]],[[5,0],[15,0]]],params:{width:2,cap:'Butt',join:'Miter',miter_limit:2,arc_tolerance:0},simplify:{enabled:false}},
    {id:'two-turns',label:'两条转角路线 · 共享样式',version:1,scene:'stroke-batch',mode:'integer',output:'paths',paths:[[[0,0],[10,0],[10,10]],[[5,-5],[5,5],[15,5]]],params:{width:2,cap:'Butt',join:'Miter',miter_limit:2,arc_tolerance:0},simplify:{enabled:false}},
    {id:'decimal-overlap',label:'小数路线 · 重叠合并',version:1,scene:'stroke-batch',mode:'decimal',precision:2,output:'paths',paths:[[[-1.25,.5],[.75,.5]],[[-.25,.5],[1.75,.5]]],params:{width:.5,cap:'Butt',join:'Miter',miter_limit:2,arc_tolerance:0},simplify:{enabled:false}},
    {id:'batch-tree-frame',label:'整数方框 · 合并孔洞层级',version:1,scene:'stroke-batch',mode:'integer',output:'tree',paths:[[[0,0],[10,0]],[[10,0],[10,10]],[[10,10],[0,10]],[[0,10],[0,0]]],params:{width:2,cap:'Square',join:'Miter',miter_limit:2,arc_tolerance:0},simplify:{enabled:false}},
    {id:'batch-tree-frame-d',label:'小数方框 · 合并孔洞层级',version:1,scene:'stroke-batch',mode:'decimal',precision:2,output:'tree',paths:[[[0,0],[2.5,0]],[[2.5,0],[2.5,2.5]],[[2.5,2.5],[0,2.5]],[[0,2.5],[0,0]]],params:{width:.5,cap:'Square',join:'Miter',miter_limit:2,arc_tolerance:0},simplify:{enabled:false}},
  ],
  rectclip:[
    {id:'cross',label:'穿过窗口 · 保留中间顶点',version:1,scene:'rectclip',mode:'integer',output:'paths',rect:{min_x:0,min_y:0,max_x:10,max_y:10},paths:[[[-10,5],[5,5],[20,5]]],simplify:{enabled:false}},
    {id:'reentry',label:'先出后入 · 两个片段',version:1,scene:'rectclip',mode:'integer',output:'paths',rect:{min_x:0,min_y:0,max_x:10,max_y:10},paths:[[[2,2],[12,2],[12,8],[2,8]]],simplify:{enabled:false}},
    {id:'decimal-cross',label:'小数窗口 · 保留三点片段',version:1,scene:'rectclip',mode:'decimal',precision:2,output:'paths',rect:{min_x:-1.25,min_y:-.5,max_x:2.75,max_y:2.5},paths:[[[-2,.25],[.5,.25],[3,.25]]],simplify:{enabled:false}},
    {id:'integer-region',label:'整数区域 · 同向内轮廓',version:1,scene:'rectclip',input_kind:'polygons',mode:'integer',output:'paths',rect:{min_x:0,min_y:0,max_x:10,max_y:10},paths:[rect(-2,-2,14,14),rect(3,3,4,4)],params:{fill_rule:'EvenOdd'},simplify:{enabled:false}},
    {id:'decimal-region',label:'小数区域 · 窗口与孔洞',version:1,scene:'rectclip',input_kind:'polygons',mode:'decimal',precision:2,output:'paths',rect:{min_x:-1.25,min_y:-.5,max_x:2.75,max_y:2.5},paths:[rect(-2,-1,6,5),rect(0,0,1,1)],params:{fill_rule:'EvenOdd'},simplify:{enabled:false}},
  ],
  boolean:[
    {id:'overlap',label:'交叠矩形 · 负坐标',...base,scene:'boolean',subject:[rect(-48,-28,62,52)],clip:[rect(-10,-8,60,48)],params:{operation:'Intersection',fill_rule:'EvenOdd'}},
    {id:'hole',label:'孔洞与交叠区域',...base,scene:'boolean',subject:[rect(-50,-32,100,64),[[-18,-14],[-18,14],[18,14],[18,-14]]],clip:[rect(-8,-40,32,80)],params:{operation:'Difference',fill_rule:'NonZero'}},
    {id:'tree-island',label:'层级查看 · 外轮廓 / 孔洞 / 岛',...base,scene:'boolean',output:'tree',subject:[rect(0,0,60,60),rect(10,10,40,40).reverse(),rect(20,20,20,20)],clip:[],params:{operation:'Union',fill_rule:'NonZero'}},
    {id:'locate-nesting',label:'点定位 · 外轮廓 / 孔洞 / 岛',...base,scene:'boolean',output:'tree',subject:[rect(0,0,20,20),rect(4,4,12,12).reverse(),rect(8,8,4,4)],clip:[],params:{operation:'Union',fill_rule:'NonZero'},query:{point:[6,6]}},
  ],
  offset:[
    {id:'courtyard',label:'带孔矩形 · 内外边界',...base,scene:'offset',subject:[rect(-48,-32,96,64),[[-16,-12],[-16,12],[16,12],[16,-12]]],params:{delta:5,fill_rule:'NonZero',join:'Miter',miter_limit:2,arc_tolerance:.25}},
    {id:'concave',label:'凹区域 · 尖角与折返',...base,scene:'offset',subject:[[[-45,-30],[45,-30],[45,-8],[5,-8],[5,30],[-45,30]]],params:{delta:-4,fill_rule:'NonZero',join:'Round',miter_limit:2,arc_tolerance:.25}},
    {id:'tree-hole',label:'层级查看 · 调整距离观察孔洞',...base,scene:'offset',output:'tree',subject:[rect(0,0,40,40),rect(10,10,20,20).reverse()],params:{delta:2,fill_rule:'NonZero',join:'Miter',miter_limit:2,arc_tolerance:.25}},
  ],
  stroke:[
    {id:'turns',label:'折线路线 · 多个转角',...base,scene:'stroke',path:[[-52,-24],[-22,24],[12,-12],[52,20]],params:{width:12,cap:'Round',join:'Round',miter_limit:2,arc_tolerance:.25}},
    {id:'return',label:'返回起点 · 开放路径',...base,scene:'stroke',path:[[-40,-24],[36,-24],[36,24],[-40,-24]],params:{width:9,cap:'Square',join:'Bevel',miter_limit:2,arc_tolerance:.25}},
    {id:'tree-return',label:'层级查看 · 返回起点的开放路线',...base,scene:'stroke',output:'tree',path:[[0,0],[30,0],[30,30],[0,30],[0,0]],params:{width:4,cap:'Square',join:'Miter',miter_limit:2,arc_tolerance:.25}},
  ],
  minkowski:[
    {id:'open',label:'开放折线 · 图案直接相加',...base,scene:'minkowski',path:[[-45,-20],[-10,22],[40,-12]],pattern:patterns.rectangle.points,params:{path_is_closed:false}},
    {id:'closed',label:'闭合矩形 · 扫掠保留孔洞',...base,scene:'minkowski',path:rect(-36,-24,72,48),pattern:patterns.rectangle.points,params:{path_is_closed:true}},
    {id:'decimal-grid',label:'小数扫掠 · 两点图案',...base,scene:'minkowski',mode:'decimal',precision:2,path:[[-1,0],[1,0]],pattern:[[0,-.25],[0,.25]],params:{path_is_closed:false}},
    {id:'tree-rectangle',label:'整数闭合扫掠 · 11 点外轮廓与孔洞',...base,scene:'minkowski',output:'tree',path:rect(0,0,30,20),pattern:rect(-2,-1,4,2),params:{path_is_closed:true}},
    {id:'tree-rectangle-d',label:'小数闭合扫掠 · 四分之一网格',...base,scene:'minkowski',mode:'decimal',precision:2,output:'tree',path:rect(0,0,7.5,5),pattern:rect(-.5,-.25,1,.5),params:{path_is_closed:true}},
  ],
};
