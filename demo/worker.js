import {compute} from './generated/moonclip.js';
self.postMessage({ready:true});
self.onmessage=({data:{id,request}})=>{
  try{const start=performance.now();const response=JSON.parse(compute(JSON.stringify(request)));self.postMessage({id,response,elapsed:performance.now()-start});}
  catch(error){self.postMessage({id,response:{ok:false,error:{kind:'BridgeExecutionError',stage:'BrowserBridge',message:String(error)}}});}
};
