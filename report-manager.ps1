# Quick Report Management Script
# Easy functions for copying and managing Allure reports

function Generate-Report {
    <#
    .SYNOPSIS
    Generate Allure report and open in browser
    #>
    Write-Host "Generating Allure report..." -ForegroundColor Green
    allure generate target/allure-results -o target/allure-report --clean
    Start-Process "target\allure-report\index.html"
    Write-Host "✅ Report opened in browser" -ForegroundColor Green
}

function Serve-Report {
    <#
    .SYNOPSIS
    Serve Allure report with auto-refresh
    #>
    Write-Host "Starting Allure server (auto-opens in browser)..." -ForegroundColor Green
    allure serve target/allure-results
}

function Copy-ReportToDesktop {
    <#
    .SYNOPSIS
    Copy report to Desktop
    #>
    $dest = "$env:USERPROFILE\Desktop\allure-report"
    Write-Host "Copying report to Desktop..." -ForegroundColor Green
    Copy-Item -Path "target\allure-report" -Destination $dest -Recurse -Force
    Write-Host "✅ Report copied to: $dest" -ForegroundColor Green
    Start-Process $dest
}

function Copy-ReportToDocuments {
    <#
    .SYNOPSIS
    Copy report to Documents
    #>
    $dest = "$env:USERPROFILE\Documents\allure-report"
    Write-Host "Copying report to Documents..." -ForegroundColor Green
    Copy-Item -Path "target\allure-report" -Destination $dest -Recurse -Force
    Write-Host "✅ Report copied to: $dest" -ForegroundColor Green
}

function Backup-Report {
    <#
    .SYNOPSIS
    Create timestamped backup of report
    #>
    if (-not (Test-Path "reports-backup")) {
        New-Item -ItemType Directory -Path "reports-backup" | Out-Null
    }

    $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
    $backupPath = "reports-backup\allure-report_$timestamp"

    Write-Host "Creating backup..." -ForegroundColor Green
    Copy-Item -Path "target\allure-report" -Destination $backupPath -Recurse -Force
    Write-Host "✅ Backup created: $backupPath" -ForegroundColor Green
}

function List-Backups {
    <#
    .SYNOPSIS
    List all report backups
    #>
    Write-Host "Available backups:" -ForegroundColor Cyan
    Get-ChildItem "reports-backup" -Directory | Sort-Object LastWriteTime -Descending | ForEach-Object {
        $size = (Get-ChildItem $_.FullName -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
        Write-Host "  📁 $($_.Name) - $([math]::Round($size, 2)) MB" -ForegroundColor White
    }
}

function Open-Backup {
    <#
    .SYNOPSIS
    Open backup report from list
    #>
    $backups = Get-ChildItem "reports-backup" -Directory | Sort-Object LastWriteTime -Descending

    if ($backups.Count -eq 0) {
        Write-Host "No backups found" -ForegroundColor Red
        return
    }

    Write-Host "Available backups:" -ForegroundColor Cyan
    for ($i = 0; $i -lt $backups.Count; $i++) {
        Write-Host "  [$($i + 1)] $($backups[$i].Name)"
    }

    $choice = Read-Host "Select backup number"
    if ($choice -gt 0 -and $choice -le $backups.Count) {
        $selected = $backups[$choice - 1]
        Start-Process "$($selected.FullName)\index.html"
        Write-Host "✅ Opened: $($selected.Name)" -ForegroundColor Green
    }
}

function Zip-Report {
    <#
    .SYNOPSIS
    Create zip of report for sharing
    #>
    $zipName = "allure-report_$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss').zip"
    Write-Host "Creating zip file: $zipName" -ForegroundColor Green
    Compress-Archive -Path "target\allure-report" -DestinationPath $zipName -Force
    Write-Host "✅ Zip created: $zipName" -ForegroundColor Green
}

function Clean-OldBackups {
    <#
    .SYNOPSIS
    Delete backups older than N days (default: 7)
    #>
    param([int]$Days = 7)

    Write-Host "Deleting backups older than $Days days..." -ForegroundColor Yellow
    $cutoff = (Get-Date).AddDays(-$Days)

    Get-ChildItem "reports-backup" -Directory | Where-Object { $_.LastWriteTime -lt $cutoff } | ForEach-Object {
        Write-Host "  Deleting: $($_.Name)" -ForegroundColor Red
        Remove-Item $_.FullName -Recurse -Force
    }

    Write-Host "✅ Cleanup complete" -ForegroundColor Green
}

function Show-Menu {
    <#
    .SYNOPSIS
    Display interactive menu
    #>
    Clear-Host
    Write-Host ""
    Write-Host "╔════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║     ALLURE REPORT MANAGEMENT MENU      ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  1️⃣  Generate & Open Report" -ForegroundColor Green
    Write-Host "  2️⃣  Serve Report (Live)" -ForegroundColor Green
    Write-Host "  3️⃣  Copy to Desktop" -ForegroundColor Yellow
    Write-Host "  4️⃣  Copy to Documents" -ForegroundColor Yellow
    Write-Host "  5️⃣  Create Timestamped Backup" -ForegroundColor Yellow
    Write-Host "  6️⃣  List All Backups" -ForegroundColor Yellow
    Write-Host "  7️⃣  Open Backup Report" -ForegroundColor Yellow
    Write-Host "  8️⃣  Create Zip for Sharing" -ForegroundColor Magenta
    Write-Host "  9️⃣  Clean Old Backups" -ForegroundColor Red
    Write-Host "  0️⃣  Exit" -ForegroundColor Red
    Write-Host ""
}

function Main {
    <#
    .SYNOPSIS
    Main menu loop
    #>
    do {
        Show-Menu
        $choice = Read-Host "Select option"
        Write-Host ""

        switch ($choice) {
            "1" { Generate-Report }
            "2" { Serve-Report }
            "3" { Copy-ReportToDesktop }
            "4" { Copy-ReportToDocuments }
            "5" { Backup-Report }
            "6" { List-Backups }
            "7" { Open-Backup }
            "8" { Zip-Report }
            "9" { Clean-OldBackups }
            "0" { Write-Host "Exiting..." -ForegroundColor Green; exit }
            default { Write-Host "Invalid option" -ForegroundColor Red }
        }

        Read-Host "Press Enter to continue"
    } while ($true)
}

# Export functions
Export-ModuleMember -Function @(
    'Generate-Report',
    'Serve-Report',
    'Copy-ReportToDesktop',
    'Copy-ReportToDocuments',
    'Backup-Report',
    'List-Backups',
    'Open-Backup',
    'Zip-Report',
    'Clean-OldBackups',
    'Main'
)

# If script is run directly (not imported), show menu
if ($MyInvocation.InvocationName -eq '&') {
    Main
}

