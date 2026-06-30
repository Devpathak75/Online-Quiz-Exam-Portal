package com.quiz.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import com.quiz.dao.DBConnection;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String enroll = request.getParameter("enroll");
        String pass = request.getParameter("pass");

        // Remove extra spaces
        if (enroll != null)
            enroll = enroll.trim();

        if (pass != null)
            pass = pass.trim();

        try {

            Connection con = DBConnection.getConnection();

            // Database connection check
            if (con == null) {
                System.out.println("DB CONNECTION FAILED");
                response.sendRedirect("index.jsp?error=1");
                return;
            }

            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM students WHERE enrollment=? AND password=?");

            ps.setString(1, enroll);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                System.out.println("LOGIN SUCCESS for : " + enroll);

                // Fetch data from database
                String name = rs.getString("name");
                String email = rs.getString("email");
                String department = rs.getString("department");
                String subject = rs.getString("subject");
                int attempted = rs.getInt("attempted");

                // Check if quiz already attempted
                if (attempted == 1) {
                    System.out.println("ALREADY ATTEMPTED");
                    response.sendRedirect("index.jsp?attempted=1");
                    return;
                }

                // Create session
                HttpSession session = request.getSession();

                // Store student details
                session.setAttribute("user", enroll);
                session.setAttribute("name", name);
                session.setAttribute("email", email);
                session.setAttribute("department", department);
                session.setAttribute("subject", subject);
                // Quiz data
                session.setAttribute("qIndex", 0);
                session.setAttribute("score", 0);
                session.setAttribute("startTime", System.currentTimeMillis());

                // Question status array
                int[] status = new int[20];
                session.setAttribute("status", status);

                // Answers array
                int[] answers = new int[20];
                session.setAttribute("answers", answers);

                // Redirect to quiz page
                response.sendRedirect("quiz.jsp");

            } else {

                System.out.println("LOGIN FAILED");
                response.sendRedirect("index.jsp?error=1");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=1");
        }
    }
}