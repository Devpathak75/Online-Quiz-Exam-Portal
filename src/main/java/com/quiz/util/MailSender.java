package com.quiz.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSender {

    //==================================================
    // GMAIL CONFIGURATION
    //==================================================

    private static final String FROM_EMAIL =
            "devinstituteoftechnologyandeng@gmail.com";

    private static final String APP_PASSWORD =
            "bpcnqabjpkrqmghu";

    //==================================================
    // CREATE MAIL SESSION
    //==================================================

    private static Session getMailSession(){

        Properties props = new Properties();

        props.put("mail.smtp.host","smtp.gmail.com");
        props.put("mail.smtp.port","587");
        props.put("mail.smtp.auth","true");
        props.put("mail.smtp.starttls.enable","true");

        return Session.getInstance(

                props,

                new Authenticator(){

                    @Override
                    protected PasswordAuthentication getPasswordAuthentication(){

                        return new PasswordAuthentication(

                                FROM_EMAIL,

                                APP_PASSWORD

                        );

                    }

                }

        );

    }

    //==================================================
    // STUDENT RESULT EMAIL
    //==================================================

    public static void sendResult(

            String toEmail,

            String name,

            String enrollment,

            String department,

            int score,

            int total,

            double percentage,

            String grade,

            long minutes,

            long seconds){

        try{

            Session session=getMailSession();

            Message message=new MimeMessage(session);

            message.setFrom(new InternetAddress(FROM_EMAIL));

            message.setRecipients(

                    Message.RecipientType.TO,

                    InternetAddress.parse(toEmail)

            );

            message.setSubject(

                    "Online Quiz Examination Result"

            );

            String result;

            if(score>=15){

                result="PASS";

            }else{

                result="FAIL";

            }

            String html=
                    "<html>"

                  + "<body style='margin:0;padding:25px;background:#f5f6fa;font-family:Segoe UI;'>"

                  + "<table align='center' width='700' style='background:white;border-radius:10px;border:1px solid #dddddd;'>"

                  + "<tr>"

                  + "<td style='background:#1f3b64;color:white;padding:25px;text-align:center;'>"

                  + "<h1 style='margin:0;'>"

                  + "DEVS INSTITUTE OF TECHNOLOGY AND ENGINEERING"

                  + "</h1>"

                  + "<h3 style='margin-top:10px;'>"

                  + "Online Quiz Examination System"

                  + "</h3>"

                  + "</td>"

                  + "</tr>"

                  + "<tr>"

                  + "<td style='padding:30px;'>"

                  + "<h2>Hello "

                  + name

                  + ",</h2>"

                  + "<p>"

                  + "Congratulations! Your online examination has been completed successfully."

                  + "</p>"

                  + "<table style='width:100%;border-collapse:collapse;' border='1' cellpadding='10'>"

                  + "<tr><td><b>Name</b></td><td>"

                  + name

                  + "</td></tr>"

                  + "<tr><td><b>Enrollment</b></td><td>"

                  + enrollment

                  + "</td></tr>"

                  + "<tr><td><b>Department</b></td><td>"

                  + department

                  + "</td></tr>"

                  + "<tr><td><b>Email</b></td><td>"

                  + toEmail

                  + "</td></tr>"

                  + "<tr><td><b>Marks</b></td><td>"

                  + score

                  + " / "

                  + total

                  + "</td></tr>"

                  + "<tr><td><b>Percentage</b></td><td>"

                  + String.format("%.2f",percentage)

                  + "%</td></tr>"

                  + "<tr><td><b>Grade</b></td><td>"

                  + grade

                  + "</td></tr>"

                  + "<tr><td><b>Time Taken</b></td><td>"

                  + minutes

                  + " Min "

                  + seconds

                  + " Sec</td></tr>"

                  + "<tr><td><b>Result</b></td><td><b>"

                  + result

                  + "</b></td></tr>";
            
            html +=

            "</table>"

          + "<br>"

          + "<div style='background:#eef7ff;padding:15px;"
          + "border-left:5px solid #0d6efd;'>"

          + "<b>Remarks :</b><br>"

          + "Thank you for participating in the Online Quiz Examination."

          + "<br><br>"

          + "Please keep this email for your future reference."

          + "</div>"

          + "<br>"

          + "<p>"

          + "Regards,<br>"

          + "<b>Quiz Examination Cell</b><br>"

          + "Devs Institute of Technology and Engineering"

          + "</p>"

          + "</td>"

          + "</tr>"

          + "<tr>"

          + "<td style='background:#f2f2f2;padding:15px;"
          + "text-align:center;font-size:13px;color:#666;'>"

          + "© 2026 Devs Institute of Technology and Engineering"

          + "<br>"

          + "Online Quiz Examination System"

          + "</td>"

          + "</tr>"

          + "</table>"

          + "</body>"

          + "</html>";

      message.setContent(html,"text/html");

      Transport.send(message);

      System.out.println("Student Result Email Sent Successfully.");

  }

  catch(MessagingException e){

      e.printStackTrace();

  }

}

//==================================================
// ADMIN OTP EMAIL
//==================================================

public static void sendAdminOtp(

      String toEmail,

      String adminName,

      String otp){

  try{

      Session session=getMailSession();

      Message message=new MimeMessage(session);

      message.setFrom(new InternetAddress(FROM_EMAIL));

      message.setRecipients(

              Message.RecipientType.TO,

              InternetAddress.parse(toEmail)

      );

      message.setSubject(

              "Admin Login OTP"

      );

      String html=
    		  
              "<html>"

            + "<body style='margin:0;padding:30px;background:#f3f6fb;font-family:Segoe UI;'>"

            + "<table align='center' width='700' style='background:#ffffff;border-radius:12px;"
            + "border:1px solid #dcdcdc;'>"

            + "<tr>"

            + "<td style='background:#1f3b64;color:white;padding:25px;text-align:center;'>"

            + "<h1 style='margin:0;'>"

            + "DEVS INSTITUTE OF TECHNOLOGY AND ENGINEERING"

            + "</h1>"

            + "<h3 style='margin-top:10px;'>"

            + "Online Quiz Examination System"

            + "</h3>"

            + "</td>"

            + "</tr>"

            + "<tr>"

            + "<td style='padding:35px;'>"

            + "<h2 style='color:#2c3e50;'>"

            + "Administrator Login Verification"

            + "</h2>"

            + "<br>"

            + "<p>Dear <b>"

            + adminName

            + "</b>,</p>"

            + "<p>"

            + "Your username and password have been verified successfully."

            + "</p>"

            + "<p>"

            + "Use the following One-Time Password (OTP) to continue your login."

            + "</p>"

            + "<br>"

            + "<div style='width:260px;"
            + "margin:auto;"
            + "padding:20px;"
            + "text-align:center;"
            + "background:#eef6ff;"
            + "border:3px dashed #0d6efd;"
            + "border-radius:12px;"
            + "font-size:42px;"
            + "font-weight:bold;"
            + "letter-spacing:10px;"
            + "color:#0d47a1;'>"

            + otp

            + "</div>"

            + "<br>"

            + "<p style='color:#d32f2f;'>"

            + "<b>OTP Validity :</b> 5 Minutes"

            + "</p>"

            + "<p>"

            + "Do not share this OTP with anyone."

            + "</p>"

            + "<p>"

            + "If you did not request this login, please ignore this email."

            + "</p>"

            + "<br>";
      
      html +=

      "<hr>"

    + "<br>"

    + "<p>"

    + "Regards,<br><br>"

    + "<b>Quiz Examination Cell</b><br>"

    + "Devs Institute of Technology and Engineering"

    + "</p>"

    + "</td>"

    + "</tr>"

    + "<tr>"

    + "<td style='background:#f5f5f5;"
    + "padding:18px;"
    + "text-align:center;"
    + "font-size:13px;"
    + "color:#666;'>"

    + "© 2026 Devs Institute of Technology and Engineering"

    + "<br>"

    + "Online Quiz Examination System"

    + "</td>"

    + "</tr>"

    + "</table>"

    + "</body>"

    + "</html>";

message.setContent(html, "text/html");

Transport.send(message);

System.out.println("Admin OTP Email Sent Successfully.");

}

catch (MessagingException e) {

e.printStackTrace();

}

}

}