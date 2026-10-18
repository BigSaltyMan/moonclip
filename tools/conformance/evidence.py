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
