package com.varun.ClaimProcessingApplication.dto;

public class AuthTokenResponse {
    private String username;
    private String token;

    public AuthTokenResponse(String username, String token) {
        this.username = username;
        this.token = token;
    }

    // Getters and Setters
}
