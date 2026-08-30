#!/usr/bin/env python3
"""Apply Release 1277 over an exact staged Release 1276 source tree."""
from __future__ import annotations
import argparse,json,shutil,sys
from pathlib import Path
from typing import Any
TOOLS=Path(__file__).resolve().parents[1]/"tools"; sys.path.insert(0,str(TOOLS))
from stage_assistance import apply_patch
from stage_release120 import digest,load_json

def inventory(root:Path)->dict[str,str]:
    return {p.relative_to(root).as_posix():digest(p.read_bytes()) for p in sorted(root.rglob('*')) if p.is_file()}

def source_identity(root:Path)->str:
    f=inventory(root); f.pop('STAGING-RECEIPT.json',None)
    return digest(json.dumps(f,sort_keys=True,separators=(',',':')).encode())

def validate_manifest(m:dict[str,Any],mp:Path)->dict[str,Any]:
    rel=m.get('base_manifest')
    if not isinstance(rel,str) or not rel: raise RuntimeError('Release 1277 must declare Release 1276 base manifest')
    b=load_json((mp.parent/rel).resolve()); art=b.get('expected_artifact') if isinstance(b,dict) else None
    if not isinstance(b,dict) or b.get('release')!=1276 or m.get('base_release')!=1276: raise RuntimeError('Release 1277 base release drift')
    if not isinstance(art,dict) or art.get('locked') is not True: raise RuntimeError('Release 1277 requires locked Release 1276 artifact')
    if art.get('sha256')!=m.get('base_artifact_sha256'): raise RuntimeError('Release 1277 base artifact drift')
    return b

def validate_base_source(src:Path,m:dict[str,Any])->dict[str,Any]:
    rec=load_json(src/'STAGING-RECEIPT.json')
    if not isinstance(rec,dict) or rec.get('release')!=1276: raise RuntimeError('base source is not staged Release 1276')
    profile='dev' if bool(rec.get('dev_mode')) else 'production'
    actual=source_identity(src); expected=(m.get('base_source_sha256') or {}).get(profile)
    if not isinstance(expected,str) or not expected: raise RuntimeError(f'Release 1277 {profile} predecessor source identity is not locked; candidate is {actual}')
    if actual!=expected: raise RuntimeError(f'Release 1276 {profile} source identity drift: expected {expected}, got {actual}')
    return rec

def main()->int:
    ap=argparse.ArgumentParser(); ap.add_argument('--base-source',type=Path,required=True); ap.add_argument('--destination',type=Path,required=True); ap.add_argument('--manifest',type=Path,required=True); a=ap.parse_args()
    bs=a.base_source.resolve(); dst=a.destination.resolve(); mp=a.manifest.resolve()
    if dst.exists(): raise RuntimeError(f'destination already exists: {dst}')
    m=load_json(mp); base=validate_manifest(m,mp); br=validate_base_source(bs,m); base_id=source_identity(bs); before=inventory(bs); shutil.copytree(bs,dst)
    applied=[apply_patch((mp.parent/n).resolve(),dst) for n in m.get('patches') or []]
    for n in m.get('added_files') or []:
        rel=Path(n); source=(mp.parent/rel).resolve(); target=(dst/rel).resolve()
        if rel.is_absolute() or '..' in rel.parts or target.exists() or not source.is_file(): raise RuntimeError(f'invalid Release 1277 added file: {n}')
        shutil.copy2(source,target)
    applied.extend(apply_patch((mp.parent/n).resolve(),dst) for n in m.get('post_patches') or [])
    after=inventory(dst); changed={p for p in set(before)|set(after) if before.get(p)!=after.get(p)}; expected=set(m.get('expected_changed_paths') or [])
    if changed!=expected: raise RuntimeError(f'changed-path mismatch: expected {sorted(expected)}, got {sorted(changed)}')
    rec={'edition':m.get('edition'),'release':1277,'serial':m.get('serial'),'base':{'release':1276,'artifact_sha256':(base.get('expected_artifact') or {}).get('sha256'),'source_sha256':base_id,'staging_receipt_sha256':digest((bs/'STAGING-RECEIPT.json').read_bytes()),'changed_paths':br.get('changed_paths')},'patches':applied,'changed_paths':sorted(changed),'dev_mode':bool(br.get('dev_mode')),'test_only':bool(br.get('test_only'))}
    (dst/'STAGING-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
    print(f"Staged Release 1277 over locked Release 1276; changed {len(changed)} path(s).")
    return 0

if __name__=='__main__':
    try: raise SystemExit(main())
    except RuntimeError as e: print(f'stage_release1277: {e}',file=sys.stderr); raise SystemExit(2) from e
