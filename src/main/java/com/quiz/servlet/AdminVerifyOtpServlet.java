package com.quiz.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminVerifyOtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {

            response.sendRedirect("index.jsp");
            return;

        }

        String enteredOtp = request.getParameter("otp");

        String sessionOtp = (String) session.getAttribute("adminOtp");

        Long otpTime = (Long) session.getAttribute("adminOtpTime");

        if (sessionOtp == null || otpTime == null) {

            response.sendRedirect("index.jsp");
            return;

        }

        long currentTime = System.currentTimeMillis();

        // OTP Valid for 5 Minutes
        if (currentTime - otpTime > 300000) {

            session.removeAttribute("adminOtp");
            session.removeAttribute("adminOtpTime");

            response.sendRedirect("verifyAdminOtp.jsp?error=expired");

            return;

        }

        // OTP Correct
        if (sessionOtp.equals(enteredOtp)) {

            // Create Real Admin Login Session
            session.setAttribute(
                    "adminUser",
                    session.getAttribute("tempAdminUser"));

            session.setAttribute(
                    "adminName",
                    session.getAttribute("tempAdminName"));

            // Remove Temporary Session Data
            session.removeAttribute("tempAdminUser");
            session.removeAttribute("tempAdminName");

            session.removeAttribute("adminOtp");
            session.removeAttribute("adminOtpTime");

            response.sendRedirect("adminDashboard.jsp");

        } else {

            response.sendRedirect("verifyAdminOtp.jsp?error=1");

        }

    }

}