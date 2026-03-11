package com.apitest.base;

import com.apitest.utils.MockServerUtil;
import io.qameta.allure.restassured.AllureRestAssured;
import io.restassured.RestAssured;
import io.restassured.filter.log.RequestLoggingFilter;
import io.restassured.filter.log.ResponseLoggingFilter;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.AfterClass;

public class BaseTest {

    @BeforeClass
    public void setup() {
        MockServerUtil.startMockServer();
        RestAssured.baseURI = MockServerUtil.getMockServerUrl();
        RestAssured.filters(
            new RequestLoggingFilter(),
            new ResponseLoggingFilter(),
            new AllureRestAssured()
        );
    }

    @AfterClass
    public void tearDown() {
        MockServerUtil.stopMockServer();
    }
}
