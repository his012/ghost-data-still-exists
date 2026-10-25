# Ghost Data Still Exists — HackerRank Orchestrate October 2026

An evidence-grounded deletion-audit engine. Given a deletion request, the agent resolves current and historical identities, reconstructs resource states at `audit_at`, applies retention/deletion policies, and emits ordered findings, remediation steps, and verification steps.

## Run in VS Code (Windows)

Open the project folder in VS Code and use its integrated PowerShell terminal:

```powershell
.\run_local.ps1
```

The helper obtains the public participant-facing `dataset/` from the [official HackerRank starter repository](https://github.com/interviewstreet/hackerrank-orchestrate-october26) if missing, installs `pypdf`, runs regression and sample tests, and generates fresh `output.csv` for all 518 requests. Git and Python 3.10+ are required. Optional image OCR uses separately installed Tesseract.

## Direct commands

```bash
python -m pip install -r requirements.txt
python -m unittest discover -s code/evaluation -p 'test_*.py' -v
python code/main.py --requests sample_deletion_requests.csv --output work_sample.csv
python code/evaluation/main.py --prediction work_sample.csv
python code/main.py
```

## Structure

- `code/main.py`: deterministic identity graph, SQLite/JSON/log/PDF/image parsing, policy evaluation, ordered steps
- `code/evaluation/main.py`: sample evaluation
- `code/evaluation/test_regressions.py`: synthetic regression tests
- `code/evaluation/evaluation_report.md`: historical baseline and methodology
- `code/evaluation/usage_report.md`: full-run inference-cost report
- `output.csv`: **original previous-run predictions**, not regenerated with parser changes

The official `dataset/` is omitted from this repo, as required by the challenge. Never commit secrets or organizer-only truth.

## Accuracy disclaimer

The prior run reported **29/32 status correctness** and **5/32 exact-row correctness** on the public samples. The updated parser fixes need a full rerun and evaluation before their accuracy can be asserted.

## Contest submission

Submit `code.zip`, regenerated `output.csv` and reviewed `log.txt` on [HackerRank](https://www.hackerrank.com/contests/hackerrank-orchestrate-october26/challenges/ghost-data-still-exists).
