# 🚀 QUICK START - REPORT TOOLS

## 3 Ways to Copy Your Reports

### 1️⃣ EASIEST - Double Click
```
Double-click: generate-report.bat
```
✅ Automatically runs everything
✅ Opens report in browser
✅ Creates backup
✅ Shows locations

---

### 2️⃣ FLEXIBLE - Open Menu
```powershell
.\report-manager.ps1
```
Then select from menu:
```
1. Generate & Open Report
3. Copy to Desktop
4. Copy to Documents
5. Create Timestamped Backup
8. Create Zip for Sharing
```

---

### 3️⃣ AUTOMATED - PowerShell
```powershell
.\generate-report.ps1
```
✅ Same as batch
✅ With colored output

---

## After Running Any Tool

Your reports will be in:

📁 **Desktop**: 
```
C:\Users\Mohamed Ashraf\Desktop\allure-report\index.html
```

📁 **Documents**:
```
C:\Users\Mohamed Ashraf\Documents\allure-report\index.html
```

📁 **Project**:
```
C:\Users\Mohamed Ashraf\IdeaProjects\API testing Task\target\allure-report\index.html
```

📁 **Backup**:
```
C:\Users\Mohamed Ashraf\IdeaProjects\API testing Task\reports-backup\allure-report_2026-03-11_21-50-00\index.html
```

📦 **Zip** (For Sharing):
```
allure-report_2026-03-11_21-50-00.zip
```

---

## Open Your Report

After copying, open it:

```powershell
# From Desktop
start "$env:USERPROFILE\Desktop\allure-report\index.html"

# From Documents
start "$env:USERPROFILE\Documents\allure-report\index.html"

# From Project
start "target\allure-report\index.html"
```

---

## Share Your Report

**Send via Email:**
```
Attach: allure-report_2026-03-11_21-50-00.zip
```

**Upload to Server:**
```powershell
Copy-Item "target\allure-report" "\\server\shared\reports\" -Recurse
```

**Share via Cloud:**
```powershell
Copy-Item "target\allure-report" "$env:OneDrive\Reports\" -Recurse
```

---

## That's It!

Pick ONE of these:

1. **Simplest**: `generate-report.bat` (double-click)
2. **Flexible**: `.\report-manager.ps1` (menu)
3. **PowerShell**: `.\generate-report.ps1` (auto)

Your report will be ready to copy! 🎉

