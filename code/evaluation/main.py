#!/usr/bin/env python3
import csv,json
from pathlib import Path

def read(p):
    with open(p,encoding='utf-8-sig',newline='') as f:
        return {x['case_id']:x for x in csv.DictReader(f)}

def score(pred,truth):
    p,g=read(pred),read(truth)
    keys=sorted(set(p)&set(g))
    hits=sum(p[k]['deletion_status']==g[k]['deletion_status'] for k in keys)
    same=sum(json.loads(p[k]['steps_json'])==json.loads(g[k]['steps_json']) and p[k]['deletion_status']==g[k]['deletion_status'] for k in keys)
    return {'cases':len(keys),'status_accuracy':hits/max(1,len(keys)),'exact_row_accuracy':same/max(1,len(keys))}

if __name__=='__main__':
    print(json.dumps(score(Path('work_sample.csv'),Path('dataset/sample_output.csv')),indent=2))
