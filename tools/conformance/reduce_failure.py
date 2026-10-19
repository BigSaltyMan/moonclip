# Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
"""Opt-in v1 flat failure reducer. Never writes a permanent regression automatically."""
import argparse
import copy
import datetime
import re
from pathlib import Path
import subprocess
import sys
from compare import (Invalid, canonical_bytes, compare_paths, decode, load,
                     require, sha256, validate_input, validate_paths)

ROOT=Path(__file__).resolve().parents[2]
DEFAULT_FAILURES=ROOT/'_build/conformance/failures'


def build_probe():
    # A single compilation per invocation, never per candidate.
    subprocess.run(['moon','build','--target','native','cmd/reduce_probe'],cwd=ROOT,check=True)
    directory=ROOT/'_build/native/debug/build/cmd/reduce_probe'
    executable=next((directory/name for name in ('reduce_probe.exe','reduce_probe') if (directory/name).is_file()),directory/'reduce_probe.exe')
    require(executable.is_file(),'probe','compiled executable missing')
    return [str(executable)]


def invoke(command,request,timeout):
    try:
        p=subprocess.run(command,input=canonical_bytes(request),capture_output=True,timeout=timeout,cwd=ROOT)
    except subprocess.TimeoutExpired:
        return {'transport':'timeout'}
    except OSError as error:
        return {'transport':'launch_error','error':str(error)}
    if p.returncode:
        return {'transport':'process_error','returncode':p.returncode,
                'stderr':p.stderr.decode('utf-8',errors='replace')[:2000]}
    try:
        value=decode(p.stdout,'probe response')
        require(type(value) is dict and value.get('status') in ('success','error'),'probe','invalid status')
        if value['status']=='success':validate_paths(value.get('paths'),'probe.paths',output=True)
        else:require(type(value.get('error')) is str and type(value.get('error_kind')) is str,'probe','missing typed error')
        return {'transport':'ok','result':value}
    except Invalid as error:
        return {'transport':'invalid_output','error':str(error),'stdout':p.stdout.decode('utf-8',errors='replace')[:2000]}


def observe(request,oracle,moonclip,timeout=10):
    # Both run, including when the first process fails; no oracle inference.
    a=invoke(oracle,request,timeout);b=invoke(moonclip,request,timeout)
    if a['transport']!='ok':category='oracle_'+a['transport']
    elif b['transport']!='ok':category='moonclip_'+b['transport']
    elif a['result']['status']!='success':category='oracle_error'
    elif b['result']['status']!='success':category='moonclip_error:'+b['result']['error_kind']
    else:
        try:compare_paths(a['result']['paths'],b['result']['paths'])
        except Invalid:category='difference'
        else:category='match'
    return dict(category=category,oracle=a,moonclip=b)


def size(request):
    paths=request['subject']+request['clip']
    return (len(paths),sum(map(len,paths)),sum(abs(x)+abs(y) for p in paths for x,y in p),canonical_bytes(request))


def candidates(request):
    for operand in ('subject','clip'):
        for pi,path in enumerate(request[operand]):
            c=copy.deepcopy(request);del c[operand][pi];yield c
        for pi,path in enumerate(request[operand]):
            for vi in range(len(path)):
                c=copy.deepcopy(request);del c[operand][pi][vi];yield c
    for replacements in ('simple','half'):
        for operand in ('subject','clip'):
            for pi,path in enumerate(request[operand]):
                for vi,point in enumerate(path):
                    for axis,value in enumerate(point):
                        targets=(0,1 if value>0 else -1) if replacements=='simple' else ((abs(value)//2)*(1 if value>=0 else -1),)
                        for target in targets:
                            if target==value:continue
                            c=copy.deepcopy(request);c[operand][pi][vi][axis]=target;yield c


def reduce_case(original,run,max_attempts=40,output=DEFAULT_FAILURES,label='real-library-failure',versions=None):
    require(type(max_attempts) is int and 0<=max_attempts<=10000,'attempts','expected integer 0..10000')
    validate_input(original,'original')
    require(original['format_version']==1 and original['fill_rule'] in ('EvenOdd','NonZero'),'reducer','public v1 Boolean only')
    first=run(original)
    if first['category']=='match':return None  # No directory or fake regression.
    category=first['category'];current=copy.deepcopy(original);latest=first;history=[]
    supported=category=='difference' or category in ('moonclip_error:ExecutionFailure','moonclip_error:NumericFailure','moonclip_error:ResourceLimitExceeded')
    reason='unsupported_failure_class'
    if supported:
        reason='no_further_reduction'
        while len(history)<max_attempts:
            changed=False
            for candidate in candidates(current):
                if len(history)>=max_attempts:break
                if size(candidate)>=size(current):continue
                require(candidate['operation']==original['operation'] and candidate['fill_rule']==original['fill_rule'],'reducer','operation changed')
                try:validate_input(candidate,'candidate')
                except Invalid:
                    history.append(dict(input_sha256=sha256(canonical_bytes(candidate)),category='invalid_candidate',accepted=False));continue
                result=run(candidate);accepted=result['category']==category
                history.append(dict(input_sha256=sha256(canonical_bytes(candidate)),category=result['category'],accepted=accepted))
                if accepted:current=candidate;latest=result;changed=True;break
            if not changed:break
        if len(history)>=max_attempts:reason='attempt_limit'
    stamp=datetime.datetime.now(datetime.timezone.utc).strftime('%Y%m%dT%H%M%S%fZ')
    directory=Path(output)/(sha256(canonical_bytes(original))[:16]+'-'+stamp)
    directory.mkdir(parents=True,exist_ok=False)
    metadata=dict(label=label,failure_category=category,seed=(int(re.search(r'Locked seed (\d+)',original['source'].get('intent',''))[1]) if re.search(r'Locked seed (\d+)',original['source'].get('intent','')) else None),
                  source=original['source'],versions=versions or {},max_attempts=max_attempts,
                  attempts=len(history),stop_reason=reason,globally_minimal=False,
                  original_sha256=sha256(canonical_bytes(original)),reduced_sha256=sha256(canonical_bytes(current)),history=history)
    for name,value in [('original.json',original),('reduced.json',current),('original-results.json',first),('reduced-results.json',latest),('metadata.json',metadata)]:
        (directory/name).write_bytes(canonical_bytes(value))
    return directory


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('input',type=Path);p.add_argument('--max-attempts',type=int,default=40)
    p.add_argument('--timeout',type=float,default=10)
    args=p.parse_args();require(0<args.timeout<=300,'timeout','expected (0,300] seconds')
    request=load(args.input,True);validate_input(request,'input')
    sys.path.insert(0,str(ROOT/'tools/oracle'))
    from generate import verified_binary
    oracle=[str(verified_binary(ROOT))];probe=build_probe()
    versions=dict(moon=subprocess.check_output(['moon','version','--all'],text=True),
                  git=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),
                  oracle=load(ROOT/'tools/oracle/upstream-lock.json'),python=sys.version,
                  oracle_binary_sha256=sha256(Path(oracle[0]).read_bytes()),probe_binary_sha256=sha256(Path(probe[0]).read_bytes()))
    directory=reduce_case(request,lambda c:observe(c,oracle,probe,args.timeout),args.max_attempts,versions=versions)
    print('No failure reproduced; no regression files created.' if directory is None else 'Failure archived: '+str(directory))

if __name__=='__main__':
    try:main()
    except (Invalid,OSError,subprocess.CalledProcessError) as error:print('reducer: '+str(error),file=sys.stderr);sys.exit(2)
