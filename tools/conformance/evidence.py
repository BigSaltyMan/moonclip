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
        require(summaries==[('116','116','0')],str(path),'expected exactly 116 successful offset cases')
        result[target]={'status':'passed','executed':116,'passed':116,'failed':0}
    return result
