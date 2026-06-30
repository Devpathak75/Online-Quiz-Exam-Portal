# 🎓 Online Quiz & Examination Portal

A complete **Java Enterprise Web Application** developed using **Java Servlets, JSP, JDBC, Maven, MySQL, Apache Tomcat, JavaMail API, and OpenPDF** that enables educational institutions to conduct online examinations securely with dedicated modules for students and administrators.

---

# 📖 Project Overview

The Online Quiz & Examination Portal is a web-based examination management system designed to simplify the process of conducting quizzes, evaluating student performance, and managing examination records digitally.

The system provides separate interfaces for students and administrators. Students can securely log in, attempt quizzes, view results, and download reports, while administrators can authenticate using OTP verification, monitor examination activities, manage reports, and generate PDF documents.

This project follows the **MVC (Model-View-Controller)** architecture using Java Servlets as controllers, JSP pages as the presentation layer, and MySQL as the backend database.

---

# 🚀 Features

## 👨‍🎓 Student Module

* Student Login Authentication
* Enrollment Number Login
* Password Validation
* Secure Session Management
* Online Quiz Interface
* Previous & Next Navigation
* Answer Tracking
* Question Status Management
* Automatic Score Calculation
* Result Display
* Student Performance Report
* PDF Report Download
* Logout Functionality

---

## 👨‍💼 Admin Module

* Admin Login
* Email OTP Verification
* OTP Expiration Validation
* Dashboard
* View Attempted Students
* View Remaining Students
* Generate Student Reports
* Export Reports to PDF
* Logout

---

# 🔒 Security Features

* Session-Based Authentication
* Session Validation
* Authorization Checks
* Prepared SQL Statements
* OTP-Based Admin Login
* Email Verification
* Secure Logout
* Protected Dashboard Access

---

# 🛠 Technology Stack

### Backend

* Java
* Java Servlets
* JSP
* JDBC
* Maven

### Database

* MySQL

### Server

* Apache Tomcat

### Libraries

* JavaMail API
* OpenPDF

### Frontend

* HTML
* CSS
* JavaScript
* JSP

---

# 📂 Project Structure

```
src
 ├── main
 │    ├── java
 │    │      ├── dao
 │    │      │      └── DBConnection.java
 │    │      │
 │    │      ├── servlet
 │    │      │      ├── LoginServlet.java
 │    │      │      ├── QuestionServlet.java
 │    │      │      ├── PdfServlet.java
 │    │      │      ├── LogoutServlet.java
 │    │      │      ├── AdminLoginServlet.java
 │    │      │      ├── AdminSendOtpServlet.java
 │    │      │      └── AdminVerifyOtpServlet.java
 │    │      │
 │    │      └── util
 │    │             └── MailSender.java
 │    │
 │    └── webapp
 │           ├── index.jsp
 │           ├── quiz.jsp
 │           ├── result.jsp
 │           ├── adminDashboard.jsp
 │           ├── attemptedStudents.jsp
 │           ├── remainingStudents.jsp
 │           ├── studentReport.jsp
 │           └── verifyAdminOtp.jsp
```

---

# ⚙ System Workflow

### Student Workflow

```
Student Login
        │
        ▼
Authentication
        │
        ▼
Quiz Starts
        │
        ▼
Navigate Questions
        │
        ▼
Store Answers
        │
        ▼
Submit Quiz
        │
        ▼
Calculate Score
        │
        ▼
View Result
        │
        ▼
Download PDF
```

---

### Admin Workflow

```
Admin Login
      │
      ▼
Generate OTP
      │
      ▼
Email Verification
      │
      ▼
Admin Dashboard
      │
      ├── Attempted Students
      ├── Remaining Students
      ├── Reports
      └── PDF Export
```

---

# 📄 Major Components

## DBConnection

Responsible for establishing JDBC connectivity with the MySQL database.

## LoginServlet

Authenticates student credentials.

## QuestionServlet

Handles quiz navigation, stores answers, and manages question status.

## AdminLoginServlet

Authenticates administrator credentials.

## AdminSendOtpServlet

Generates and emails OTP for secure admin access.

## AdminVerifyOtpServlet

Validates OTP and grants dashboard access.

## PdfServlet

Generates downloadable PDF reports using OpenPDF.

## MailSender

Configures Gmail SMTP and sends verification emails.

---

# 🎯 Learning Outcomes

Through this project, I gained practical experience in:

* Java Enterprise Development
* MVC Architecture
* JSP & Servlets
* JDBC Connectivity
* MySQL Database Design
* Session Management
* Authentication & Authorization
* Email Integration
* PDF Report Generation
* Maven Dependency Management
* Apache Tomcat Deployment
* Backend Logic Development
* Exception Handling
* Database Operations
* Software Project Structuring

---

# 🚀 Future Enhancements

* Password Encryption (BCrypt)
* Student Registration
* Forgot Password
* Random Question Generator
* Exam Timer
* Negative Marking
* Subject-wise Exams
* Question Bank Management
* Analytics Dashboard
* Charts & Reports
* Responsive UI
* Spring Boot Migration
* REST APIs
* JWT Authentication
* Docker Deployment
* CI/CD Integration
* Cloud Deployment (AWS/Azure)

---

# 📌 Highlights

✔ Java Enterprise Project

✔ Full Stack Web Application

✔ Email OTP Authentication

✔ Session Management

✔ JDBC Database Connectivity

✔ PDF Report Generation

✔ Admin Dashboard

✔ Student Dashboard

✔ Maven Build Management

✔ MySQL Integration

✔ Apache Tomcat Deployment

✔ MVC Architecture

---

# 👨‍💻 Developer

**Dev Pathak**

B.Tech – Artificial Intelligence & Data Science

Passionate about Java Full Stack Development, Software Engineering, Database Systems, and building real-world web applications that solve practical problems.

---

⭐ If you found this project helpful, consider giving it a Star and sharing your feedback.
