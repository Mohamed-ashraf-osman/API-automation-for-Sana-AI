# Allure Report Generator and Copier Script
# PowerShell Version

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ALLURE REPORT GENERATOR & COPIER" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Run Tests
Write-Host "[1] Running tests..." -ForegroundColor Yellow
mvn clean test
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Tests failed!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[2] Generating Allure report..." -ForegroundColor Yellow
allure generate target/allure-results -o target/allure-report --clean

Write-Host ""
Write-Host "[3] Creating backup directory..." -ForegroundColor Yellow
if (-not (Test-Path "reports-backup")) {
    New-Item -ItemType Directory -Path "reports-backup" | Out-Null
}

Write-Host ""
Write-Host "[4] Copying report to backup..." -ForegroundColor Yellow
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$reportName = "allure-report_$timestamp"
$backupPath = "reports-backup\$reportName"
Copy-Item -Path "target\allure-report" -Destination $backupPath -Recurse -Force

Write-Host ""
Write-Host "[5] Opening report in browser..." -ForegroundColor Yellow
Start-Process "target\allure-report\index.html"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  ✅ REPORT READY FOR COPY" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "   📊 Report Locations:" -ForegroundColor Cyan
Write-Host "   └─ Active:  target\allure-report\index.html" -ForegroundColor White
Write-Host "   └─ Backup:  $backupPath\index.html" -ForegroundColor White
Write-Host ""
Write-Host "   🔗 You can copy these locations:" -ForegroundColor Cyan
Write-Host "   └─ Share backup folder for archiving" -ForegroundColor White
Write-Host "   └─ Send HTML file to team" -ForegroundColor White
Write-Host "   └─ Upload to report server" -ForegroundColor White
Write-Host ""

