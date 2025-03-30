# Claims Processing System

## Overview
The **Claims Processing System** is a centralized platform designed to efficiently manage and process insurance claims. The system streamlines claim handling by automating validation, providing real-time status updates, and generating detailed reports. Built on a monolithic architecture, it integrates various technologies to ensure scalability, security, and performance.

---

## Key Features
- **Real-time Claim Updates**: Track claim statuses instantly with Kafka-powered notifications.
- **Automated Validation**: Predefined rules validate claims and calculate settlements.
- **Secure Authentication**: OAuth 2.0 for role-based access control.
- **Efficient Caching**: Redis cache for frequently accessed data (e.g., claim statuses, reports).
- **Comprehensive Reporting**: Generate analytics and summaries for stakeholders.
- **Audit Logging**: Log4j2 and Splunk integration for monitoring and debugging.

---

## Technologies Used
### Backend
- **Framework**: Spring Boot (Java)
- **Security**: OAuth 2.0
- **Logging**: Log4j2 + Splunk
- **Messaging**: Apache Kafka
- **Caching**: Redis


### Database
- **Primary DB**: MySQL (for claims, users, transactions)
- **Tables**: 
  - `Claims` (claim_id, status, amount, etc.)
  - `Users` (user_id, role, etc.)
  - `Transactions` (transaction_id, claim_id, etc.)


---

## System Architecture
1. **Monolithic Backend**: Unified codebase with modules for claims processing, user management, and reporting.
2. **Data Flow**:
   - Claims submitted → Validated → Processed → Reported (with Kafka for real-time updates).

---

## API Endpoints
## API Endpoints

| Category          | Endpoint                          | Description                                  |
|-------------------|-----------------------------------|----------------------------------------------|
| **Claims**        | `POST /claims`                   | Submit a new insurance claim.                |
|                   | `GET /claims/{claimId}`          | Retrieve details of a specific claim.        |
|                   | `PUT /claims/{claimId}`          | Update an existing claim (e.g., status).     |
|                   | `DELETE /claims/{claimId}`       | Delete a claim record.                       |
|                   | `GET /claims/user/{userId}`      | Fetch all claims submitted by a user.        |
| **Users**         | `POST /users/register`           | Register a new user account.                 |
|                   | `POST /users/login`              | Authenticate user and return JWT.            |
|                   | `GET /users/{userId}`            | Retrieve user profile details.               |
|                   | `PUT /users/{userId}`            | Update user information (e.g., email).       |
|                   | `DELETE /users/{userId}`         | Deactivate or delete a user account.         |
| **Reports**       | `GET /reports/claims/status`     | Generate claims report filtered by status.   |
|                   | `GET /reports/claims/summary`    | Generate summary report for a date range.    |
| **Notifications** | `POST /notifications/subscribe`  | Subscribe to Kafka-powered claim updates.    |
|                   | `POST /notifications/unsubscribe`| Unsubscribe from real-time notifications.    |
| **Administrative**| `GET /admin/logs`                | Access system audit logs (admin-only).       |
---

> **Note**: All endpoints (except `/users/login` and `/users/register`) require OAuth 2.0 authentication.

## Setup & Deployment
### Prerequisites
- Java 11+, MySQL 8+, .

### Steps
1. **Backend**:
   ```bash
   git clone <repo-url>
   cd backend
   mvn clean install