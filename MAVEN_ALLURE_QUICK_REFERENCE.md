# 🚀 QUICK REFERENCE - ALLURE MAVEN PLUGIN

## Problem SOLVED ✅
**Issue**: "allure command not recognized"
**Solution**: Allure Maven Plugin configured in pom.xml
**Status**: WORKING & TESTED

---

## Essential Commands

### Generate Report & Open It
```powershell
mvn clean test allure:report && start target\site\allure-maven-plugin\index.html
```

### Just Generate Report
```powershell
mvn allure:report
```

### Run Tests Only (No Report)
```powershell
mvn clean test
```

### Open Existing Report
```powershell
start target\site\allure-maven-plugin\index.html
```

---

## Test Results

✅ Tests: 4/4 PASSED
✅ Failures: 0
✅ Errors: 0
✅ Build: SUCCESS

---

## Report Features

- 📊 Epic/Feature/Story organization
- 🔍 Full request/response logging
- 📝 Step-by-step execution
- ⏱️ Timing metrics
- 📎 JSON body attachments
- 🎯 Severity tracking (CRITICAL)

---

## POM.xml Configuration ✅

### Allure Maven Plugin
```xml
<plugin>
    <groupId>io.qameta.allure</groupId>
    <artifactId>allure-maven</artifactId>
    <version>2.10.0</version>
    <configuration>
        <reportVersion>${allure.version}</reportVersion>
    </configuration>
</plugin>
```

### Surefire Plugin with AspectJ ✅
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-surefire-plugin</artifactId>
    <version>3.2.5</version>
    <configuration>
        <argLine>
            -javaagent:"${settings.localRepository}"/org/aspectj/aspectjweaver/${aspectj.version}/aspectjweaver-${aspectj.version}.jar
        </argLine>
    </configuration>
    <dependencies>
        <dependency>
            <groupId>org.aspectj</groupId>
            <artifactId>aspectjweaver</artifactId>
            <version>${aspectj.version}</version>
        </dependency>
    </dependencies>
</plugin>
```

### Dependencies ✅
- ✅ allure-testng v2.24.0
- ✅ allure-rest-assured v2.24.0
- ✅ rest-assured v5.4.0
- ✅ jackson-databind v2.17.0
- ✅ wiremock-jre8 v2.35.0

---

## Test Code ✅

### Class Level
```java
@Epic("Sana Platform - API Automation Testing")
@Feature("Authentication & Portfolio Management")
@Story("User Authentication and Profile Management")
```

### Test Methods
```java
@Test(priority = X)
@Severity(SeverityLevel.CRITICAL)
@Description("Test description...")
public void testName() { ... }
```

### API Requests
```java
given()
    .filter(new AllureRestAssured())
    // ... request specification ...
```

### Helper Methods
```java
@Step("Step description")
private void methodName() { ... }
```

---

## Report Location

```
target\site\allure-maven-plugin\index.html
```

---

## No Installation Needed!

❌ Don't need: Node.js, npm, allure-commandline
✅ Just use: Maven (already installed)

---

## Typical Workflow

1. Make test changes
2. Run: `mvn clean test allure:report`
3. Open: `target\site\allure-maven-plugin\index.html`
4. View results in browser

---

## Report Tabs

| Tab | Shows |
|-----|-------|
| Overview | Stats, timeline, pass rate |
| Suites | Test hierarchy & execution |
| Tests | Individual test details + attachments |
| Behaviors | Epic/Feature/Story view |
| Timeline | Chronological execution |
| Categories | Test categorization |

---

## Each Test Shows

- Test name & description
- Severity level (CRITICAL)
- Pass/Fail status
- Execution time
- Steps with parameters
- **Attachments** (Full request/response JSON)

---

## Status: ✅ READY TO USE

All requirements met. Report generation working perfectly through Maven!

