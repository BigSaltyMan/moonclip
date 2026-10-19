import {spawnSync} from 'node:child_process';
import {createServer} from 'node:http';
import {readFile, mkdir, cp} from 'node:fs/promises';
import {dirname, resolve, extname} from 'node:path';
import {fileURLToPath} from 'node:url';
const root=dirname(fileURLToPath(import.meta.url));
const bash=process.platform==='win32'?'C:/Program Files/Git/bin/bash.exe':'bash';
if(!process.argv.includes('--reuse')){const build=spawnSync(bash,['../scripts/build_demo.sh'],{cwd:root,stdio:'inherit'});if(build.status!==0)process.exit(build.status??1);}
if(process.argv.includes('--dev')) {
  const types={'.html':'text/html; charset=utf-8','.js':'text/javascript; charset=utf-8','.css':'text/css','.json':'application/json','.svg':'image/svg+xml'};
  const server=createServer(async(req,res)=>{
    try{const name=decodeURIComponent(new URL(req.url,'http://localhost').pathname);const path=resolve(root,'.'+(name==='/'?'/index.html':name));
      if(!path.startsWith(root+'/')&&!path.startsWith(root+'\\')){res.writeHead(403).end();return;}
      const data=await readFile(path);res.writeHead(200,{'Content-Type':types[extname(path)]??'application/octet-stream','Cache-Control':'no-store'});res.end(data);
    }catch{res.writeHead(404).end('Not found');}
  });server.listen(4173,'127.0.0.1',()=>console.log('MoonClip demo: http://127.0.0.1:4173'));
} else {await mkdir(root+'/dist',{recursive:true});for(const name of ['index.html','style.css','app.js','cases.js','worker.js','export.js','generated'])await cp(root+'/'+name,root+'/dist/'+name,{recursive:true});console.log('Static demo: demo/dist');}
