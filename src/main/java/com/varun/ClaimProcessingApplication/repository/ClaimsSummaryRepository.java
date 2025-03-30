package com.varun.ClaimProcessingApplication.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.varun.ClaimProcessingApplication.entity.ClaimsSummary;

@Repository
public interface ClaimsSummaryRepository extends JpaRepository<ClaimsSummary, Long> {
    // Method to find the most recent summary report
    ClaimsSummary findTopByOrderByReportGeneratedDesc();

    // Additional method to find summaries over a specific period
    List<ClaimsSummary> findByReportGeneratedBetween(Date start, Date end);
}
