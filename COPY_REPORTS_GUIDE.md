# 📊 How to Copy & Share Allure Reports

## Automated Way (Recommended)

### Option 1: Batch Script (Windows CMD)
```cmd
generate-report.bat
```
This automatically:
- ✅ Runs all tests
- ✅ Generates Allure report
- ✅ Creates timestamped backup
- ✅ Opens report in browser
- ✅ Shows copy locations

### Option 2: PowerShell Script
```powershell
.\generate-report.ps1
```
Same as batch but with colored output and better formatting.

---

## Manual Steps

### Step 1: Run Tests
```powershell
mvn clean test
```

### Step 2: Generate Report
```powershell
allure serve target/allure-results
```
Or:
```powershell
allure generate target/allure-results -o target/allure-report --clean
```

### Step 3: Copy Report
After report is generated, you can:

#### Copy Entire Report Folder
```powershell
# Copy to desktop
Copy-Item -Path "target\allure-report" -Destination "$env:USERPROFILE\Desktop\allure-report" -Recurse

# Copy to backup
Copy-Item -Path "target\allure-report" -Destination "reports-backup\allure-report_$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss')" -Recurse
```

#### Copy HTML File Only
```powershell
# Copy main report file
Copy-Item -Path "target\allure-report\index.html" -Destination "$env:USERPROFILE\Desktop\report.html"
```

---

## Report Locations

### Active Reports
```
target/allure-report/
├── index.html          (Main report file)
├── css/
├── js/
├── data/
└── widgets/
```

### Backup Location (Auto-created)
```
reports-backup/
├── allure-report_2026-03-11_21-50-00/
│   └── index.html
├── allure-report_2026-03-11_22-10-30/
│   └── index.html
└── ... (multiple backups)
```

---

## Sharing Reports

### Option 1: Share HTML File
```powershell
# Copy to shared folder
Copy-Item "target\allure-report\index.html" -Destination "\\server\shared\reports\report.html"
```

### Option 2: Share Entire Folder
```powershell
# Zip the report
Compress-Archive -Path "target\allure-report" -DestinationPath "reports\allure-report.zip"
```

### Option 3: Email Report
```powershell
# Copy to Documents
Copy-Item -Path "target\allure-report" -Destination "$env:USERPROFILE\Documents\allure-report" -Recurse
# Then email the folder
```

### Option 4: Upload to Server
```powershell
# Copy to web server directory
Copy-Item -Path "target\allure-report\*" -Destination "C:\inetpub\wwwroot\reports" -Recurse -Force
```

---

## View Reports After Copy

### Local File
```powershell
# Open in browser
start "path\to\allure-report\index.html"
```

### From Backup
```powershell
start "reports-backup\allure-report_2026-03-11_21-50-00\index.html"
```

### From Desktop
```powershell
start "$env:USERPROFILE\Desktop\allure-report\index.html"
```

---

## Report Contents You Can Copy

| File/Folder | Purpose | Size |
|-------------|---------|------|
| index.html | Main report page | ~50KB |
| data/ | Test results JSON | ~100KB |
| css/ | Styling | ~50KB |
| js/ | JavaScript code | ~200KB |
| plugins/ | Report plugins | ~100KB |
| **Total** | **Complete report** | **~500KB** |

---

## Quick Commands

```powershell
# Generate and open report
allure serve target/allure-results

# Generate report only
allure generate target/allure-results -o target/allure-report --clean

# Copy report to Desktop
Copy-Item "target\allure-report" "$env:USERPROFILE\Desktop\allure-report" -Recurse

# Copy report to Documents
Copy-Item "target\allure-report" "$env:USERPROFILE\Documents\allure-report" -Recurse

# Create timestamped backup
Copy-Item "target\allure-report" "reports-backup\allure-report_$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss')" -Recurse

# Zip for easy sharing
Compress-Archive -Path "target\allure-report" -DestinationPath "allure-report.zip"

# View all backups
Get-ChildItem "reports-backup"
```

---

## Automated Backup System

The scripts automatically create backups with timestamps:

```
reports-backup/
├── allure-report_2026-03-11_21-50-00/
├── allure-report_2026-03-11_22-10-30/
├── allure-report_2026-03-11_22-30-15/
└── ... (each run creates a new backup)
```

**To list all backups:**
```powershell
Get-ChildItem "reports-backup" | Sort-Object LastWriteTime -Descending
```

**To delete old backups:**
```powershell
# Keep only last 10 backups
Get-ChildItem "reports-backup" | Sort-Object LastWriteTime -Descending | Select-Object -Skip 10 | Remove-Item -Recurse
```

---

## Opening Reports

### In Browser
```powershell
# Direct open
start "target\allure-report\index.html"

# Using Allure CLI
allure open target/allure-report
```

### Share Link
If reports are on a web server:
```
http://your-server.com/reports/index.html
```

---

## What Can Be Copied

✅ **index.html** - Standalone report file
✅ **Entire folder** - Complete with all assets
✅ **Zipped archive** - For easy transfer
✅ **To cloud storage** - OneDrive, Google Drive, etc.
✅ **To email** - Attach the zip file
✅ **To shared server** - Network folder or web server
✅ **To CI/CD** - Jenkins artifacts, GitHub, GitLab

---

## One-Click Solution

**Just run this:**
```powershell
.\generate-report.ps1
```

It does everything automatically:
1. Runs tests
2. Generates report
3. Creates backup
4. Opens in browser
5. Shows copy locations

**Done! Report is ready to copy from `reports-backup` folder.**

---

## File Structure for Copying

**Minimal (Just HTML):**
```
allure-report.zip
└── index.html (can view standalone)
```

**Complete (With Assets):**
```
allure-report.zip
├── index.html
├── css/
├── js/
├── data/
├── plugins/
└── images/
```

**Recommended for sharing:** Copy entire `allure-report` folder.

---

## Need Help?

| Task | Command |
|------|---------|
| Generate & view | `.\generate-report.ps1` |
| Just generate | `allure generate target/allure-results -o target/allure-report` |
| View existing | `allure open target/allure-report` |
| Copy to Desktop | `Copy-Item "target\allure-report" "$env:USERPROFILE\Desktop\" -Recurse` |
| Backup with timestamp | `Copy-Item "target\allure-report" "reports-backup\report_$(Get-Date -Format 'yyyyMMdd_HHmmss')" -Recurse` |
| List backups | `Get-ChildItem "reports-backup"` |

---

**Note**: Reports are automatically generated in `target/allure-report/` after each test run. Just copy from there or use the scripts for automatic backup!

