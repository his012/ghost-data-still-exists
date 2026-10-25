$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Push-Location $root
try {
  if (-not (Test-Path 'dataset/deletion_requests.csv')) {
    $temp = Join-Path $root '.upstream-dataset-fetch'
    if (Test-Path $temp) { throw "Temporary directory already exists: $temp" }
    git clone --depth 1 https://github.com/interviewstreet/hackerrank-orchestrate-october26.git $temp
    if ($LASTEXITCODE -ne 0) { throw 'Git clone failed' }
    Copy-Item -Recurse (Join-Path $temp 'dataset') (Join-Path $root 'dataset')
    Remove-Item -Recurse -Force $temp
  }
  python -m pip install -r requirements.txt
  if ($LASTEXITCODE -ne 0) { throw 'Dependency install failed' }
  python -m unittest discover -s code/evaluation -p 'test_*.py' -v
  if ($LASTEXITCODE -ne 0) { throw 'Regression tests failed' }
  python code/main.py --requests sample_deletion_requests.csv --output work_sample.csv
  if ($LASTEXITCODE -ne 0) { throw 'Sample prediction run failed' }
  python code/evaluation/main.py --prediction work_sample.csv
  if ($LASTEXITCODE -ne 0) { throw 'Sample evaluation failed' }
  python code/main.py
  if ($LASTEXITCODE -ne 0) { throw 'Full prediction run failed' }
  Write-Host 'Fresh output.csv created; inspect evaluation metrics before submitting.'
} finally {
  Pop-Location
}
