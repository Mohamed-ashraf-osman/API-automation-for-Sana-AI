# Sana Platform API Automation

A clean, minimalist Maven-based Java automation project for API testing using RestAssured, TestNG, and Allure Reports.

## Tech Stack

- **Java 17**
- **RestAssured 5.4.0** - HTTP client for API testing
- **TestNG 7.10.2** - Test framework with BDD style support
- **Jackson Databind 2.17.0** - JSON serialization/deserialization
- **Allure Reports 2.24.0** - Enterprise test reporting

## Project Structure

```
api-automation/
├── pom.xml                              # Maven dependencies & build config
├── testng.xml                           # TestNG suite configuration
├── README.md                            # This file
└── src/
    └── test/
        ├── java/
        │   └── com/apitest/
        │       ├── base/
        │       │   └── BaseTest.java               # Base configuration class
        │       ├── tests/
        │       │   └── SanaPlatformTest.java       # Main test class
        │       └── utils/
        │           └── AllureReportUtil.java       # Allure reporting utility
        └── resources/
            └── allure.properties                   # Allure configuration
```

## API Test Flow

The `SanaPlatformTest` class automates the following flow:

1. **POST /api/auth/send_otp**
   - Sends OTP to phone number
   - Body: `{"phone": "+923217566932"}`

2. **POST /api/auth/verify_otp**
   - Verifies OTP and extracts authentication token
   - Body: `{"otp": "123456", "phone": "+923217566932"}`
   - Extracts: `profile.auth_token`

3. **PUT /api/auth/edit_profile**
   - Updates user profile using Bearer token
   - Requires: Authorization header

4. **GET /api/stocks/positions/bulk/list**
   - Retrieves manual investment positions
   - Requires: Authorization header

## Mandatory Assertions (Applied to All Requests)

✓ **Status Code = 200**
✓ **Response Time < 500ms**
✓ **Response contains `status` key with value `"success"`**
✓ **Response contains `message` key**

## Running Tests

### Run All Tests
```powershell
mvn clean test
```

### Run Specific Test Class
```powershell
mvn clean test -Dtest=SanaPlatformTest
```

### Run Specific Test Method
```powershell
mvn clean test -Dtest=SanaPlatformTest#sendOtpTest
```

## Allure Reports

### Generate Allure Report
```powershell
mvn allure:report
```

### View Allure Report
```powershell
mvn allure:serve
```

This opens the Allure report in your default browser (usually at http://localhost:4040)

### Report Output Location
- **Raw Results**: `target/allure-results/`
- **Generated Report**: `target/site/allure-report/`

## Features

### BaseTest Configuration
- Centralized RestAssured configuration
- Base URI: `https://mock-server.postman.com`
- Automatic request/response logging
- Allure filter integration

### BDD Style Testing
All tests use the given/when/then pattern:
```java
given()
    .contentType("application/json")
    .header("Authorization", "Bearer " + token)
.when()
    .get("/api/endpoint")
.then()
    .statusCode(200)
    .time(lessThan(500L))
    .body("status", equalTo("success"))
```

### Allure Reporting
Tests include detailed Allure reporting with:
- Step-by-step test execution logs
- Response details (status code, time, status)
- Assertion verification logs
- JSON response attachments
- Response time tracking

### Token Management
- Extracts `auth_token` from verify OTP response
- Reuses token in subsequent requests via Bearer token header
- Dependent test methods ensure proper test flow

## Allure Report Features

The generated Allure report includes:

✓ **Test Summary** - Overall pass/fail statistics
✓ **Timeline** - Test execution sequence and duration
✓ **Steps** - Detailed breakdown of each test step
✓ **Attachments** - JSON response bodies
✓ **History** - Test execution history trends
✓ **Categorization** - Tests organized by suites
✓ **Duration Metrics** - Response time analysis

## Configuration

### Update Base URL
Edit `BaseTest.java`:
```java
RestAssured.baseURI = "https://your-api-url.com";
```

### Update Test Data
Edit `SanaPlatformTest.java`:
```java
private static final String PHONE = "+your-phone";
private static final String OTP = "your-otp";
```

## Dependencies

All dependencies are managed in `pom.xml`:
- RestAssured for REST API testing
- TestNG for test execution and assertions
- Jackson for JSON processing
- Allure for comprehensive reporting
- AspectJ for Allure weaving

## Logging

### RestAssured Logging
- Request and Response logging enabled by default
- Visible in console output

### Allure Logging
- All test steps logged to Allure report
- Assertions marked with checkmarks in report
- Response details attached to each step

## Notes

- Base URL is set to Postman mock server
- All tests use BDD style (given/when/then)
- Tests maintain proper dependency order via `dependsOnMethods`
- Response time assertions < 500ms
- All responses validated for status and message keys

## Future Enhancements

- Data-driven tests with CSV/Excel
- Parallel test execution
- Custom Allure categories
- API contract validation (Pact)
- Performance benchmarking
- API documentation generation

---

**Version**: 1.0.0
**Last Updated**: March 2026

