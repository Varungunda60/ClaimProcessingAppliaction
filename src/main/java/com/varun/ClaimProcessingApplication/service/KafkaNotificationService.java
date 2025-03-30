package com.varun.ClaimProcessingApplication.service;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.kafka.core.KafkaTemplate;

import com.varun.ClaimProcessingApplication.dto.ClaimStatusUpdateMessage;

public class KafkaNotificationService {

    private static final String CLAIM_STATUS_TOPIC = "claim-status-updates";

    @Autowired
    private KafkaTemplate<String, Object> kafkaTemplate;

    public void sendClaimStatusUpdate(Long claimId, String newStatus, String userEmail) {
        ClaimStatusUpdateMessage message = new ClaimStatusUpdateMessage(claimId, newStatus, userEmail);
        kafkaTemplate.send(CLAIM_STATUS_TOPIC, message);
    }

}
