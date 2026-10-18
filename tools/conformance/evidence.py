"""Read actual filtered MoonBit runs; generated case counts are never pass evidence."""
import re
from compare import require

def internal_evidence(directory):
    result={}
    for target in ('native','js'):
        path=directory/('internal-'+target+'.log')
        if not path.exists():
            result[target]={'status':'not_recorded'}
            continue
        summaries=re.findall(r'Total tests: (\d+), passed: (\d+), failed: (\d+)\.',path.read_text(encoding='utf-8'))
        require(summaries==[('48','48','0')],str(path),'expected one successful actual run of exactly 48 internal cases')
        result[target]={'status':'passed','executed':48,'passed':48,'failed':0,'Positive':24,'Negative':24}
    return result


def tree_evidence(directory):
    result={}
    for kind,count,stem,marker in [('public',152,'tree','reference tree: *'),('internal',48,'internal-tree','reference internal tree: *')]:
        result[kind]={}
        for target in ('native','js'):
            path=directory/(stem+'-'+target+'.log')
            if not path.exists():
                result[kind][target]={'status':'not_recorded'}
                continue
            text=path.read_text(encoding='utf-8')
            require(text.splitlines().count('Selection: '+marker)==1,str(path),'missing distinct tree selection marker')
            summaries=re.findall(r'Total tests: (\d+), passed: (\d+), failed: (\d+)\.',text)
            require(summaries==[(str(count),str(count),'0')],str(path),'wrong tree execution count or failures')
            result[kind][target]={'status':'passed','executed':count,'passed':count,'failed':0}
    return result


def offset_evidence(directory):
    result={}
    for target in ('native','js'):
        path=directory/('offset-'+target+'.log')
        if not path.exists():
            result[target]={'status':'not_recorded'};continue
        text=path.read_text(encoding='utf-8')
        require(text.splitlines().count('Selection: reference offset paths: *')==1,str(path),'missing offset selection marker')
        summaries=re.findall(r'Total tests: (\d+), passed: (\d+), failed: (\d+)\.',text)
        require(summaries==[('272','272','0')],str(path),'expected exactly 272 successful offset cases')
        result[target]={'status':'passed','executed':272,'passed':272,'failed':0}
    return result


def stroke_evidence(directory):
    result={}
    for target in ('native','js'):
        path=directory/('stroke-'+target+'.log')
        if not path.exists():
            result[target]={'status':'not_recorded'};continue
        text=path.read_text(encoding='utf-8')
        require(text.splitlines().count('Selection: reference stroke paths: *')==1,str(path),'missing stroke selection marker')
        summaries=re.findall(r'Total tests: (\d+), passed: (\d+), failed: (\d+)\.',text)
        require(summaries==[('276','276','0')],str(path),'expected exactly 276 successful stroke cases')
        result[target]={'status':'passed','executed':276,'passed':276,'failed':0}
    return result


def composition_evidence(directory):
    result={}
    for target in ('native','js'):
        path=directory/('composition-'+target+'.log')
        if not path.exists():
            result[target]={'status':'not_recorded'};continue
        text=path.read_text(encoding='utf-8')
        require(text.splitlines().count('Selection: reference composition: *')==1,str(path),'missing composition selection marker')
        summaries=re.findall(r'Total tests: (\d+), passed: (\d+), failed: (\d+)\.',text)
        require(summaries==[('24','24','0')],str(path),'expected exactly 24 successful composition recipes')
        result[target]={'status':'passed','executed':24,'passed':24,'failed':0}
    return result


def decimal_evidence(directory):
    result={}
    for target in ('native','js'):
        path=directory/('decimal-'+target+'.log')
        if not path.exists():
            result[target]={'status':'not_recorded'};continue
        text=path.read_text(encoding='utf-8')
        require(text.splitlines().count('Selection: reference decimal paths: *')==1,str(path),'missing decimal selection marker')
        summaries=re.findall(r'Total tests: (\d+), passed: (\d+), failed: (\d+)\.',text)
        require(summaries==[('220','220','0')],str(path),'expected exactly 220 successful decimal cases')
        result[target]={'status':'passed','executed':220,'passed':220,'failed':0}
    return result


def simplify_evidence(directory):
    result={}
    for target in ('native','js'):
        path=directory/('simplify-'+target+'.log')
        if not path.exists():
            result[target]={'status':'not_recorded'};continue
        text=path.read_text(encoding='utf-8')
        require(text.splitlines().count('Selection: reference simplify paths: *')==1,str(path),'missing simplify selection marker')
        summaries=re.findall(r'Total tests: (\d+), passed: (\d+), failed: (\d+)\.',text)
        require(summaries==[('224','224','0')],str(path),'expected exactly 224 successful simplify cases')
        result[target]={'status':'passed','executed':224,'passed':224,'failed':0}
    return result
