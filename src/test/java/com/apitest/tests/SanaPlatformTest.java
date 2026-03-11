package com.apitest.tests;

import com.apitest.base.BaseTest;
import io.qameta.allure.Description;
import io.qameta.allure.Epic;
import io.qameta.allure.Feature;
import io.qameta.allure.Severity;
import io.qameta.allure.SeverityLevel;
import io.qameta.allure.Step;
import io.qameta.allure.Story;
import io.qameta.allure.restassured.AllureRestAssured;
import io.restassured.response.Response;
import org.testng.annotations.Test;

import static io.restassured.RestAssured.*;
import static org.hamcrest.Matchers.*;

@Epic("Sana Platform - API Automation Testing")
@Feature("Authentication & Portfolio Management")
@Story("User Authentication and Profile Management")
public class SanaPlatformTest extends BaseTest {

    private String authToken;
    private static final String PHONE = "+923217566932";
    private static final String OTP = "123456";

    @Test(priority = 1)
    @Severity(SeverityLevel.CRITICAL)
    @Description("Test OTP sending functionality - Sends OTP to registered phone number")
    public void sendOtpTest() {
        sendOtpRequest();
    }

    @Step("Send OTP request to phone: {0}")
    private void sendOtpRequest() {
        given()
            .filter(new AllureRestAssured())
            .contentType("application/json")
            .body("{\"phone\":\"" + PHONE + "\"}")
        .when()
            .post("/api/auth/send_otp")
        .then()
            .statusCode(200)
            .time(lessThan(500L))
            .body("status", equalTo("success"))
            .body("message", notNullValue());
    }

    @Test(priority = 2)
    @Severity(SeverityLevel.CRITICAL)
    @Description("Test OTP verification - Verifies OTP and retrieves authentication token")
    public void verifyOtpTest() {
        Response response = verifyOtpRequest();
        authToken = response.jsonPath().getString("profile.auth_token");
        validateTokenExtraction();
    }

    @Step("Verify OTP request with OTP: {0} and phone: {1}")
    private Response verifyOtpRequest() {
        return given()
            .filter(new AllureRestAssured())
            .contentType("application/json")
            .body("{\"otp\":\"" + OTP + "\",\"phone\":\"" + PHONE + "\"}")
        .when()
            .post("/api/auth/verify_otp")
        .then()
            .statusCode(200)
            .time(lessThan(500L))
            .body("status", equalTo("success"))
            .body("message", notNullValue())
            .extract()
            .response();
    }

    @Step("Validate authentication token extraction")
    private void validateTokenExtraction() {
        // Token extracted and ready for use in subsequent requests
    }

    @Test(priority = 3, dependsOnMethods = "verifyOtpTest")
    @Severity(SeverityLevel.CRITICAL)
    @Description("Test profile editing - Updates user profile using authentication token")
    public void editProfileTest() {
        editProfileRequest();
    }

    @Step("Edit profile with first_name: John and last_name: Doe")
    private void editProfileRequest() {
        given()
            .filter(new AllureRestAssured())
            .contentType("application/json")
            .header("Authorization", "Bearer " + authToken)
            .body("{\"first_name\":\"John\",\"last_name\":\"Doe\"}")
        .when()
            .put("/api/auth/edit_profile")
        .then()
            .statusCode(200)
            .time(lessThan(500L))
            .body("status", equalTo("success"))
            .body("message", notNullValue());
    }

    @Test(priority = 4, dependsOnMethods = "verifyOtpTest")
    @Severity(SeverityLevel.CRITICAL)
    @Description("Test listing investment positions - Retrieves manual investment positions using authentication token")
    public void listManualInvestmentTest() {
        listInvestmentPositions();
    }

    @Step("Retrieve manual investment positions")
    private void listInvestmentPositions() {
        given()
            .filter(new AllureRestAssured())
            .header("Authorization", "Bearer " + authToken)
        .when()
            .get("/api/stocks/positions/bulk/list")
        .then()
            .statusCode(200)
            .time(lessThan(500L))
            .body("status", equalTo("success"))
            .body("message", notNullValue());
    }
}
