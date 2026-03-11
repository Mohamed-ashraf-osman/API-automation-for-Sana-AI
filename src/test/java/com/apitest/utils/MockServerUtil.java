package com.apitest.utils;

import com.github.tomakehurst.wiremock.WireMockServer;
import com.github.tomakehurst.wiremock.client.WireMock;

import static com.github.tomakehurst.wiremock.client.WireMock.*;
import static com.github.tomakehurst.wiremock.core.WireMockConfiguration.wireMockConfig;

public class MockServerUtil {

    private static WireMockServer wireMockServer;

    public static void startMockServer() {
        if (wireMockServer == null) {
            wireMockServer = new WireMockServer(wireMockConfig().port(8080));
            wireMockServer.start();
            WireMock.reset();
            setupMockEndpoints();
        }
    }

    public static void stopMockServer() {
        if (wireMockServer != null && wireMockServer.isRunning()) {
            wireMockServer.stop();
            wireMockServer = null;
        }
    }

    private static void setupMockEndpoints() {
        // Mock: POST /api/auth/send_otp
        wireMockServer.stubFor(post(urlEqualTo("/api/auth/send_otp"))
            .willReturn(aResponse()
                .withStatus(200)
                .withHeader("Content-Type", "application/json")
                .withBody("{\"status\": \"success\", \"message\": \"OTP sent successfully\", \"data\": {\"otp_id\": \"123\"}}")));

        // Mock: POST /api/auth/verify_otp
        wireMockServer.stubFor(post(urlEqualTo("/api/auth/verify_otp"))
            .willReturn(aResponse()
                .withStatus(200)
                .withHeader("Content-Type", "application/json")
                .withBody("{\"status\": \"success\", \"message\": \"OTP verified\", \"profile\": {\"auth_token\": \"test-token-12345\", \"user_id\": 1}}")));

        // Mock: PUT /api/auth/edit_profile
        wireMockServer.stubFor(put(urlEqualTo("/api/auth/edit_profile"))
            .willReturn(aResponse()
                .withStatus(200)
                .withHeader("Content-Type", "application/json")
                .withBody("{\"status\": \"success\", \"message\": \"Profile updated successfully\", \"data\": {\"user_id\": 1}}")));

        // Mock: GET /api/stocks/positions/bulk/list
        wireMockServer.stubFor(get(urlEqualTo("/api/stocks/positions/bulk/list"))
            .willReturn(aResponse()
                .withStatus(200)
                .withHeader("Content-Type", "application/json")
                .withBody("{\"status\": \"success\", \"message\": \"Positions retrieved\", \"data\": [{\"symbol\": \"AAPL\", \"quantity\": 10}]}")));
    }

    public static String getMockServerUrl() {
        return "http://localhost:8080";
    }
}

