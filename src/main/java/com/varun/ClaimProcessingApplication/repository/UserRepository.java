package com.varun.ClaimProcessingApplication.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.varun.ClaimProcessingApplication.entity.User;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
}
