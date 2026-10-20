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
  boolean:[
    {id:'overlap',label:'交叠矩形 · 负坐标',...base,scene:'boolean',subject:[rect(-48,-28,62,52)],clip:[rect(-10,-8,60,48)],params:{operation:'Intersection',fill_rule:'EvenOdd'}},
    {id:'hole',label:'孔洞与交叠区域',...base,scene:'boolean',subject:[rect(-50,-32,100,64),[[-18,-14],[-18,14],[18,14],[18,-14]]],clip:[rect(-8,-40,32,80)],params:{operation:'Difference',fill_rule:'NonZero'}},
    {id:'tree-island',label:'层级查看 · 外轮廓 / 孔洞 / 岛',...base,scene:'boolean',output:'tree',subject:[rect(0,0,60,60),rect(10,10,40,40).reverse(),rect(20,20,20,20)],clip:[],params:{operation:'Union',fill_rule:'NonZero'}},
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
  ],
};
