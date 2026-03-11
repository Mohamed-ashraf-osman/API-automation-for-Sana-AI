# ❌ ALLURE CLI NOT INSTALLED - SOLUTIONS

## Problem
You're getting an error because **Allure CLI is not installed** on your system.

## Solutions

### Option 1: Install Node.js + npm (Recommended)
**Step 1**: Download Node.js
- Go to: https://nodejs.org/
- Download LTS version (v20.x or later)
- Install it

**Step 2**: Verify installation
```powershell
node --version
npm --version
```

**Step 3**: Install Allure CLI
```powershell
npm install -g allure-commandline
```

**Step 4**: Verify Allure installation
```powershell
allure --version
```

**Step 5**: View your report
```powershell
cd "C:\Users\Mohamed Ashraf\IdeaProjects\API testing Task"
allure serve target/allure-results
```

---

### Option 2: Use Docker (No installation needed)
If you don't want to install Node.js, use Docker:

```powershell
docker run -p 4040:4040 -v "C:\Users\Mohamed Ashraf\IdeaProjects\API testing Task\target\allure-results:/app/allure-results" frankescobar/allure-docker-service:2.14.0
```

Then open: http://localhost:4040

---

### Option 3: View Reports Manually (No tools needed)
Open the raw HTML attachment files directly:

```powershell
# Open Windows Explorer
explorer "C:\Users\Mohamed Ashraf\IdeaProjects\API testing Task\target\allure-results"

# Look for files ending with "-attachment.html"
# Double-click to view request/response details
```

---

## Quick Fix Steps

1. **Install Node.js** (if not already installed)
   - Download from: https://nodejs.org/
   - Run the installer
   - Restart PowerShell

2. **Install Allure CLI**
   ```powershell
   npm install -g allure-commandline
   ```

3. **View your professional report**
   ```powershell
   cd "C:\Users\Mohamed Ashraf\IdeaProjects\API testing Task"
   allure serve target/allure-results
   ```

4. **Done!** Your browser will open with the interactive Allure report

---

## Verify Everything Works

After installation, run these commands:

```powershell
# Check Node.js
node --version

# Check npm
npm --version

# Check Allure
allure --version

# View report
allure serve target/allure-results
```

Expected output:
```
v20.x.x (or later)
10.x.x (or later)
2.24.x
Browser opens with report
```

---

## Still Having Issues?

Make sure you:
- ✅ Installed Node.js (not just npm)
- ✅ Restarted PowerShell after installation
- ✅ The target/allure-results folder exists (run `mvn clean test` first)
- ✅ Have internet access (for docker option)

---

## What Happens When You Run `allure serve`

1. Allure processes all the result files from `target/allure-results/`
2. Generates an interactive HTML report
3. Starts a local web server
4. Opens the report in your default browser
5. Report is available at: http://localhost:4040

You can then:
- Click on tests to see details
- View request/response data
- Navigate by Epic/Feature/Story
- Check timing and metrics

---

**Next Step**: Install Node.js, then run:
```powershell
npm install -g allure-commandline
allure serve target/allure-results
```

