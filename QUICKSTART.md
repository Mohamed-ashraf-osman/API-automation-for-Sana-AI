# Quick Start Guide

## Prerequisites

- Java 17 installed
- Maven 3.6+ installed
- Internet connection (for downloading dependencies)

## Setup & Run

### 1. Clone/Open Project
```powershell
cd "C:\Users\Mohamed Ashraf\IdeaProjects\API testing Task"
```

### 2. Download Dependencies
```powershell
mvn clean install
```

### 3. Run Tests
```powershell
mvn clean test
```

Expected output:
```
[INFO] Running com.apitest.tests.SanaPlatformTest
[INFO] Tests run: 4, Failures: 0, Skipped: 0, Time elapsed: X.XXX s
[INFO] BUILD SUCCESS
```

### 4. Generate Allure Report
```powershell
mvn allure:report
```

### 5. View Report (Interactive)
```powershell
mvn allure:serve
```

The report opens automatically in your browser.

### 6. View Report (Static HTML)
Report location: `target/site/allure-report/index.html`

Open in any browser:
```powershell
start target\site\allure-report\index.html
```

## Report Sections

1. **Overview** - Overall statistics and duration
2. **Categories** - Tests grouped by status
3. **Suites** - Test organization
4. **Timeline** - Execution order and timing
5. **Behaviors** - Feature mapping
6. **Packages** - Code organization
7. **History** - Trends over time

## What Each Test Does

### Test 1: sendOtpTest
- Sends OTP request
- Verifies: Status 200, Time < 500ms, Status='success', Message key exists

### Test 2: verifyOtpTest (Depends on: sendOtpTest)
- Verifies OTP and extracts auth_token
- Verifies: Status 200, Time < 500ms, Status='success', Message key exists
- Captures: authentication token for subsequent tests

### Test 3: editProfileTest (Depends on: verifyOtpTest)
- Updates profile with Bearer token
- Verifies: Status 200, Time < 500ms, Status='success', Message key exists

### Test 4: listManualInvestmentTest (Depends on: verifyOtpTest)
- Retrieves investment positions
- Verifies: Status 200, Time < 500ms, Status='success', Message key exists

## Troubleshooting

### No reports generated?
- Ensure AspectJ weaver is in classpath
- Check `target/allure-results/` exists
- Clear cache: `mvn clean`

### Tests failing?
- Verify API base URL is correct in `BaseTest.java`
- Check network connectivity
- Validate test data (phone, OTP) in `SanaPlatformTest.java`

### Report not opening?
- Ensure port 4040 is available
- Try: `mvn allure:report` then open `target/site/allure-report/index.html`

## Useful Commands

```powershell
# Clean and rebuild
mvn clean install

# Run tests with logging
mvn clean test -X

# Run specific test
mvn clean test -Dtest=SanaPlatformTest#sendOtpTest

# Generate report without running tests (uses previous results)
mvn allure:report

# Open report in browser
mvn allure:serve

# Clear all results
mvn clean
```

## Environment Variables

No environment variables required. All configuration is in:
- `pom.xml` - Maven dependencies
- `src/test/resources/allure.properties` - Allure settings
- `BaseTest.java` - API base URL

## Next Steps

1. Update `BaseTest.java` with your actual API URL
2. Update test data in `SanaPlatformTest.java`
3. Run tests: `mvn clean test`
4. View report: `mvn allure:serve`

---

For full documentation, see README.md

