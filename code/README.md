# Northstar deletion audit agent

The deterministic evidence graph resolves current and historical identifiers, parses JSON, SQL, text and log evidence, optionally extracts PDFs with pypdf and screenshots with Tesseract, reconstructs state at audit cutoff, applies deletion policies, and produces ordered remediation and verification steps.

## Run

Python 3.10+:

```bash
python code/main.py
```

For public sample scoring:

```bash
python code/main.py --requests sample_deletion_requests.csv --output work_sample.csv
python code/evaluation/main.py --prediction work_sample.csv
```

The updated SQL adapter executes SQLite snapshots against actual column names. Run regression tests:

```bash
python -m unittest discover -s code/evaluation -p 'test_*.py' -v
```

Previously reported public sample accuracy is historical; run evaluation on updated code before quoting current performance.
