# 📊 ALLURE REPORT COPY & SHARING GUIDE

## Quick Start (Recommended)

### Option 1: One-Click Automated Script
```powershell
.\report-manager.ps1
```
**This opens an interactive menu where you can:**
- ✅ Generate & open report
- ✅ Serve report live
- ✅ Copy to Desktop
- ✅ Copy to Documents
- ✅ Create backups
- ✅ Manage backups
- ✅ Create zip for sharing

### Option 2: Batch File (Windows)
```cmd
generate-report.bat
```
**Does automatically:**
- ✅ Runs tests
- ✅ Generates report
- ✅ Creates timestamped backup
- ✅ Opens in browser

### Option 3: PowerShell Script
```powershell
.\generate-report.ps1
```
**Colored output version of batch file**

---

## Manual Commands

### Generate Report
```powershell
# Method 1: Serve with auto-refresh (Recommended)
allure serve target/allure-results

# Method 2: Generate static HTML
allure generate target/allure-results -o target/allure-report --clean

# Method 3: Open existing report
allure open target/allure-report
```

### Copy Report

**To Desktop:**
```powershell
Copy-Item -Path "target\allure-report" -Destination "$env:USERPROFILE\Desktop\allure-report" -Recurse
```

**To Documents:**
```powershell
Copy-Item -Path "target\allure-report" -Destination "$env:USERPROFILE\Documents\allure-report" -Recurse
```

**To Custom Location:**
```powershell
Copy-Item -Path "target\allure-report" -Destination "D:\Reports\allure-report" -Recurse
```

**With Timestamp:**
```powershell
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
Copy-Item -Path "target\allure-report" -Destination "reports-backup\allure-report_$timestamp" -Recurse
```

---

## Using report-manager.ps1 Menu

### Step 1: Open PowerShell
```powershell
cd "C:\Users\Mohamed Ashraf\IdeaProjects\API testing Task"
.\report-manager.ps1
```

### Step 2: Choose Option from Menu
```
╔════════════════════════════════════════╗
║     ALLURE REPORT MANAGEMENT MENU      ║
╚════════════════════════════════════════╝

  1️⃣  Generate & Open Report
  2️⃣  Serve Report (Live)
  3️⃣  Copy to Desktop
  4️⃣  Copy to Documents
  5️⃣  Create Timestamped Backup
  6️⃣  List All Backups
  7️⃣  Open Backup Report
  8️⃣  Create Zip for Sharing
  9️⃣  Clean Old Backups
  0️⃣  Exit

Select option: 
```

### Step 3: Follow Instructions

**Example: Copy to Desktop**
```
Select option: 3

✅ Report copied to: C:\Users\Mohamed Ashraf\Desktop\allure-report
```

---

## Report Structure

### What Gets Copied
```
allure-report/
├── index.html              (Main report - Opens in browser)
├── css/                    (Styling)
├── js/                     (Interactive features)
├── data/                   (Test results JSON)
├── plugins/                (Report plugins)
└── images/                 (Visual assets)
```

### Recommended: Copy Entire Folder
The full folder includes all assets for complete functionality.

---

## Sharing Reports

### Email a Report
```powershell
# Step 1: Create zip
Compress-Archive -Path "target\allure-report" -DestinationPath "allure-report.zip"

# Step 2: Email the zip file
# Attach: allure-report.zip
```

### Upload to Server
```powershell
# Copy to web server
Copy-Item -Path "target\allure-report\*" -Destination "C:\inetpub\wwwroot\reports" -Recurse -Force

# Access at: http://localhost/reports/index.html
```

### Share via Network
```powershell
# Copy to shared folder
Copy-Item -Path "target\allure-report" -Destination "\\server\shared\reports\allure-report" -Recurse -Force
```

### Upload to Cloud
```powershell
# Copy to OneDrive
Copy-Item -Path "target\allure-report" -Destination "$env:OneDrive\Reports\allure-report" -Recurse

# Copy to Google Drive
Copy-Item -Path "target\allure-report" -Destination "C:\Users\Mohamed Ashraf\Google Drive\Reports\allure-report" -Recurse
```

---

## Report Backup System

### Automatic Backups
Every time you run `generate-report.ps1` or `generate-report.bat`, a timestamped backup is created:

```
reports-backup/
├── allure-report_2026-03-11_21-50-00/
├── allure-report_2026-03-11_22-10-30/
├── allure-report_2026-03-11_23-15-45/
└── ...
```

### View Backups
```powershell
# Using menu option 6
.\report-manager.ps1
# Select: 6 - List All Backups

# Or manually
Get-ChildItem "reports-backup" | Sort-Object LastWriteTime -Descending
```

### Open Backup
```powershell
# Using menu option 7 - Opens interactive selector
.\report-manager.ps1
# Select: 7 - Open Backup Report

# Or manually
start "reports-backup\allure-report_2026-03-11_21-50-00\index.html"
```

### Clean Old Backups
```powershell
# Using menu option 9
.\report-manager.ps1
# Select: 9 - Clean Old Backups

# Or manually delete:
Remove-Item "reports-backup\allure-report_2026-03-11_21-50-00" -Recurse
```

---

## Quick Functions (If Using menu)

After running `.\report-manager.ps1`, you can also use functions directly:

```powershell
# Import functions
. .\report-manager.ps1

# Generate and open
Generate-Report

# Serve live
Serve-Report

# Copy to Desktop
Copy-ReportToDesktop

# Create backup
Backup-Report

# List backups
List-Backups

# Create zip
Zip-Report

# Clean old backups
Clean-OldBackups -Days 7
```

---

## File Locations Reference

| Location | Purpose |
|----------|---------|
| `target/allure-report/` | Active report (regenerates each run) |
| `target/allure-results/` | Raw test data (input for report) |
| `reports-backup/` | All timestamped backups |
| `$env:USERPROFILE\Desktop\` | Desktop copies |
| `$env:USERPROFILE\Documents\` | Document copies |

---

## Common Tasks

### Task: Generate Report and Show It
**Method 1: Menu**
```
Run: .\report-manager.ps1
Select: 1 (Generate & Open Report)
```

**Method 2: Command**
```powershell
allure serve target/allure-results
```

### Task: Backup Current Report
**Method 1: Menu**
```
Run: .\report-manager.ps1
Select: 5 (Create Timestamped Backup)
```

**Method 2: Command**
```powershell
Backup-Report
```

### Task: Share Report with Team
**Method 1: Create Zip**
```
Run: .\report-manager.ps1
Select: 8 (Create Zip for Sharing)
```

**Method 2: Manual**
```powershell
Compress-Archive -Path "target\allure-report" -DestinationPath "allure-report.zip"
```

### Task: View Old Report
**Method 1: Menu**
```
Run: .\report-manager.ps1
Select: 7 (Open Backup Report)
```

**Method 2: Direct**
```powershell
start "reports-backup\allure-report_2026-03-11_21-50-00\index.html"
```

---

## Integration with CI/CD

### Jenkins
```groovy
stage('Report') {
    steps {
        powershell 'allure generate target/allure-results -o target/allure-report --clean'
        publishHTML([
            reportDir: 'target/allure-report',
            reportFiles: 'index.html',
            reportName: 'Allure Report'
        ])
    }
}
```

### GitHub Actions
```yaml
- name: Generate Allure Report
  run: allure generate target/allure-results -o target/allure-report --clean

- name: Upload Report
  uses: actions/upload-artifact@v2
  with:
    name: allure-report
    path: target/allure-report
```

---

## Troubleshooting

### Problem: "allure command not found"
**Solution**: Install Allure
```powershell
# Using Chocolatey
choco install allure

# Or download from: https://docs.qameta.io/allure/
```

### Problem: Port 4040 already in use (for `allure serve`)
**Solution**: Kill existing process
```powershell
# Find and kill
Get-Process | Where-Object {$_.Port -eq 4040} | Stop-Process
```

### Problem: Can't copy - access denied
**Solution**: Run PowerShell as Administrator
```powershell
# Right-click PowerShell > Run as Administrator
```

### Problem: Backup folder not found
**Solution**: Create it manually
```powershell
New-Item -ItemType Directory -Path "reports-backup"
```

---

## Summary

✅ **Easiest**: Run `.\report-manager.ps1` and use menu
✅ **Fastest**: Run `generate-report.bat` or `generate-report.ps1`
✅ **Manual**: Copy from `target/allure-report` folder directly
✅ **Sharing**: Create zip with option 8 in menu

---

## What's Available Now

| File | Purpose |
|------|---------|
| `generate-report.bat` | Batch script for Windows CMD |
| `generate-report.ps1` | PowerShell script version |
| `report-manager.ps1` | Interactive menu for all operations |
| `COPY_REPORTS_GUIDE.md` | This guide (detailed) |

**All scripts do the same things - just pick your preferred one!**

---

**Choose Your Method:**
1. **Simplest**: Click `generate-report.bat`
2. **Flexible**: Run `.\report-manager.ps1` (menu-driven)
3. **Fast**: Run `.\generate-report.ps1`
4. **Manual**: Copy `target\allure-report` folder

All work perfectly! 🎉

