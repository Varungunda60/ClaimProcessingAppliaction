package com.varun.ClaimProcessingApplication.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.varun.ClaimProcessingApplication.dto.ClaimDTO;
import com.varun.ClaimProcessingApplication.entity.Claim;

public interface ClaimRepository extends JpaRepository<Claim, Long> {
    List<Claim> findByUserId(Long userId);

    Claim save(Claim claim);

    List<Claim> findClaimsByStatusAndLastUpdatedBefore(String status, Date lastUpdated);

}