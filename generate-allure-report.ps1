# Generate and serve Allure report
# This script generates the Allure report from the test results and serves it locally

$reportDir = "target\allure-report"
$resultsDir = "target\allure-results"

Write-Host "Generating Allure report..." -ForegroundColor Green

# Check if allure command is available
$allureCmd = Get-Command allure -ErrorAction SilentlyContinue

if ($null -eq $allureCmd) {
    Write-Host "Allure CLI not found. Please install it globally or use Docker:" -ForegroundColor Yellow
    Write-Host "  npm install -g allure-commandline" -ForegroundColor Cyan
    Write-Host "`nAlternatively, Allure results are available in: $resultsDir" -ForegroundColor Yellow
    exit 1
}

# Generate the report
allure generate $resultsDir -o $reportDir -c

if ($LASTEXITCODE -eq 0) {
    Write-Host "Report generated successfully!" -ForegroundColor Green
    Write-Host "Opening report in browser..." -ForegroundColor Green
    allure open $reportDir
} else {
    Write-Host "Failed to generate report" -ForegroundColor Red
    exit 1
}

