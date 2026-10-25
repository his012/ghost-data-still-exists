# Evaluation report

## Historical public-sample baseline (32 requests)

- Deletion-status accuracy: **29/32 = 90.625%**
- Exact row and sequence accuracy: **5/32 = 15.625%**
- Step precision: **76.582%**
- Step recall: **62.694%**
- Step F1: **68.946%**
- Aligned field-level accuracy: **79.193%**

These scores belong to the *previous* source and output, NOT an independent evaluation of the newer parser.

## Four participant-created checks

1. Marketing opt-out is NOT_APPLICABLE, not deletion.
2. Portuguese permanent-deletion request is recognized.
3. `DISABLE_DATA_FLOW` occurs before `DELETE_RECORD`.
4. An account tombstone is REDACTED rather than deleted.

Earlier implementation passed these four synthetic contract checks.

## Failures and improvements

SQL parsing previously relied on fixed table names and could omit failover/search snapshots. The improved code uses SQLite schema introspection and honors snapshot capture time. The text parser links related trace-ID events and avoids conflating nearby users. Evidence-declared resource categories take precedence over ID-prefix guesses. The optional image OCR dependency remains important.

Full 32-sample re-evaluation and a fresh 518-case predictions run are required before scoring improvements. Reproduce with:

```bash
python code/main.py --requests sample_deletion_requests.csv --output work_sample.csv
python code/evaluation/main.py --prediction work_sample.csv
python code/main.py
```
