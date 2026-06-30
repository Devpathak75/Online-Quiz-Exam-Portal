package com.quiz.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.quiz.dao.DBConnection;
import com.quiz.util.MailSender;

public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            ps = con.prepareStatement(
                    "SELECT * FROM admin WHERE username=? AND password=?");

            ps.setString(1, username);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {

                HttpSession session = request.getSession(true);

                String adminUser = rs.getString("username");
                String adminName = rs.getString("full_name");
                String adminEmail = rs.getString("email");

                Random random = new Random();

                String otp = String.valueOf(
                        100000 + random.nextInt(900000));

                // OTP
                session.setAttribute("adminOtp", otp);
                session.setAttribute("adminOtpTime",
                        System.currentTimeMillis());

                // Temporary Admin Details
                session.setAttribute("tempAdminUser", adminUser);
                session.setAttribute("tempAdminName", adminName);
                session.setAttribute("adminEmail", adminEmail);

                // Send OTP
                MailSender.sendAdminOtp(
                        adminEmail,
                        adminName,
                        otp);

                response.sendRedirect("verifyAdminOtp.jsp");

            } else {

                response.sendRedirect("index.jsp?adminError=1");

            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect("index.jsp?adminError=1");

        } finally {

            try {
                if (rs != null)
                    rs.close();
            } catch (Exception e) {
            }

            try {
                if (ps != null)
                    ps.close();
            } catch (Exception e) {
            }

            try {
                if (con != null)
                    con.close();
            } catch (Exception e) {
            }

        }

    }

}