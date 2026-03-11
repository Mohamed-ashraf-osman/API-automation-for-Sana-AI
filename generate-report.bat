@echo off
REM Generate Allure Report and Copy to Shared Location

echo.
echo ========================================
echo   ALLURE REPORT GENERATOR & COPIER
echo ========================================
echo.

REM Run tests
echo [1] Running tests...
call mvn clean test

echo.
echo [2] Generating Allure report...
call allure generate target/allure-results -o target/allure-report --clean

echo.
echo [3] Creating backup directory...
if not exist "reports-backup" mkdir reports-backup

echo.
echo [4] Copying report to backup...
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)
set reportname=allure-report_%mydate%_%mytime%
xcopy /E /I /Y "target\allure-report" "reports-backup\%reportname%"

echo.
echo [5] Opening report in browser...
start target\allure-report\index.html

echo.
echo ========================================
echo   ✅ REPORT READY FOR COPY
echo ========================================
echo.
echo   Report Location: target\allure-report\index.html
echo   Backup Location: reports-backup\%reportname%\index.html
echo.
pause

