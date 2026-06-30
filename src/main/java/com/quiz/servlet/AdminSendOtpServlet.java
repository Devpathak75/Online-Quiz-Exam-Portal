package com.quiz.servlet;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.quiz.util.MailSender;

public class AdminSendOtpServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException,IOException{

        HttpSession session=request.getSession(false);

        if(session==null){

            response.sendRedirect("index.jsp");

            return;

        }

        String adminEmail=(String)session.getAttribute("adminEmail");

        String adminName=(String)session.getAttribute("adminName");

        if(adminEmail==null){

            response.sendRedirect("index.jsp");

            return;

        }

        Random random=new Random();

        int otp=100000+random.nextInt(900000);

        session.setAttribute("adminOtp",
                String.valueOf(otp));

        session.setAttribute("adminOtpTime",
                System.currentTimeMillis());

        session.setAttribute("adminOtpTime", System.currentTimeMillis());
        
        try{

            MailSender.sendAdminOtp(

                    adminEmail,

                    adminName,

                    String.valueOf(otp)

            );

        }catch(Exception e){

            e.printStackTrace();

        }

        response.sendRedirect("verifyAdminOtp.jsp");

    }

}