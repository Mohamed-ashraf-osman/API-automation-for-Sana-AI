package com.apitest.utils;

import io.qameta.allure.Allure;
import io.qameta.allure.Step;

public class AllureReportUtil {

    @Step("Test Step: {stepName}")
    public static void logTestStep(String stepName) {
        Allure.step(stepName);
    }

    @Step("Assertion: {assertion}")
    public static void logAssertion(String assertion) {
        Allure.step("✓ " + assertion);
    }

    public static void logInfo(String message) {
        Allure.step(message);
    }

    public static void logPass(String message) {
        Allure.step("✓ " + message);
    }

    public static void logFail(String message) {
        Allure.step("✗ " + message);
    }

    public static void logWarning(String message) {
        Allure.step("⚠ " + message);
    }

    public static void logResponseDetails(int statusCode, long responseTime, String status) {
        Allure.step("Status Code: " + statusCode);
        Allure.step("Response Time: " + responseTime + "ms");
        Allure.step("Response Status: " + status);
    }

    public static void attachJson(String json, String name) {
        Allure.addAttachment(name, "application/json", json, "json");
    }
}

