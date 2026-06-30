<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.quiz.dao.DBConnection"%>
<%@ page import="com.quiz.util.MailSender"%>

<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

//==================================================
// SESSION CHECK
//==================================================

int[] answers=(int[])session.getAttribute("answers");
Long startTime=(Long)session.getAttribute("startTime");

String user=(String)session.getAttribute("user");
String name=(String)session.getAttribute("name");
String email=(String)session.getAttribute("email");
String department=(String)session.getAttribute("department");

if(answers==null || startTime==null || user==null){

    response.sendRedirect("index.jsp");
    return;

}

//==================================================
// DATABASE CONNECTION
//==================================================

Connection con=DBConnection.getConnection();

PreparedStatement ps=con.prepareStatement(

"SELECT correct FROM questions WHERE department=? ORDER BY id"

);

ps.setString(1,department);

ResultSet rs=ps.executeQuery();

//==================================================
// SCORE CALCULATION
//==================================================

int score=0;

int total=20;

int index=0;

while(rs.next()){

    if(index<answers.length){

        if(answers[index]==rs.getInt("correct")){

            score++;

        }

    }

    index++;

}

//==================================================
// TIME CALCULATION
//==================================================

long endTime=System.currentTimeMillis();

long totalSeconds=(endTime-startTime)/1000;

long minutes=totalSeconds/60;

long seconds=totalSeconds%60;

//==================================================
// RESULT CALCULATION
//==================================================

double percentage=(score*100.0)/total;

String grade;

if(percentage>=75){

    grade="A";

}
else if(percentage>=60){

    grade="B";

}
else if(percentage>=50){

    grade="C";

}
else{

    grade="F";

}

String result;

if(score>=15){

    result="PASS";

}
else{

    result="FAIL";

}

//==================================================
// SAVE RESULT
//==================================================

PreparedStatement save=con.prepareStatement(

"UPDATE students SET attempted=?,score=?,total_questions=?,percentage=?,grade=?,result=?,time_taken=?,exam_date=CURDATE(),exam_time=CURTIME() WHERE enrollment=?"

);

save.setInt(1,1);
save.setInt(2,score);
save.setInt(3,total);
save.setDouble(4,percentage);
save.setString(5,grade);
save.setString(6,result);
save.setString(7,minutes+" Min "+seconds+" Sec");
save.setString(8,user);

save.executeUpdate();

//==================================================
// SEND RESULT EMAIL
//==================================================

try{

    MailSender.sendResult(

        email,
        name,
        user,
        department,
        score,
        total,
        percentage,
        grade,
        minutes,
        seconds

    );

}catch(Exception e){

    System.out.println(e);

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Online Quiz Result</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI',Tahoma,sans-serif;
}

body{

    background:#eef2f7;

}

/*==========================================
            TOP HEADER
==========================================*/

.top-header{

    height:90px;

    background:linear-gradient(90deg,#0f172a,#1e3a8a,#2563eb);

    display:flex;

    justify-content:space-between;

    align-items:center;

    padding:0 25px;

    box-shadow:0 5px 20px rgba(0,0,0,.25);

}

.header-logo{

    width:120px;

    display:flex;

    justify-content:center;

    align-items:center;

    flex-shrink:0;

}

.header-logo img{

    width:62px;

    height:62px;

    object-fit:contain;

    background:white;

    border-radius:50%;

    padding:5px;

    box-shadow:0 5px 15px rgba(0,0,0,.25);

    transition:.3s;

}

.header-logo img:hover{

    transform:scale(1.08);

}

.header-title{

    flex:1;

    text-align:center;

    color:white;

}

.header-title h1{

    margin:0;

    font-size:28px;

    font-weight:700;

    letter-spacing:1px;

}

.header-title h3{

    margin-top:6px;

    font-size:15px;

    color:#dbeafe;

    font-weight:400;

}

/*==========================================
            RESULT CONTAINER
==========================================*/

.container{

    width:900px;

    margin:30px auto;

    background:white;

    border-radius:18px;

    overflow:hidden;

    box-shadow:0 12px 30px rgba(0,0,0,.18);

}

/*==========================================
            RESULT TITLE
==========================================*/

.resultTitle{

    background:linear-gradient(90deg,#2563eb,#1d4ed8);

    color:white;

    text-align:center;

    padding:18px;

    font-size:28px;

    font-weight:bold;

}

/*==========================================
            GENERATED
==========================================*/

.generated{

    text-align:center;

    padding:22px;

    background:#f8fafc;

    border-bottom:1px solid #e5e7eb;

    line-height:30px;

}

.generated h2{

    color:#1e40af;

    font-size:28px;

}

.generated h3{

    color:#555;

    font-weight:500;

}

.generated p{

    font-size:16px;

}

/*==========================================
            MAIN
==========================================*/

.main{

    padding:35px;

}

/*==========================================
            TABLE
==========================================*/

.infoTable{

    width:100%;

    border-collapse:collapse;

}

.infoTable td{

    border:1px solid #dbe2ea;

    padding:15px;

    font-size:16px;

}

.label{

    width:260px;

    background:#f8fafc;

    font-weight:bold;

    color:#1e40af;

}

/*==========================================
            SCORE CARDS
==========================================*/

.scoreCard{

    display:flex;

    justify-content:space-between;

    margin:35px 0;

    flex-wrap:wrap;

}

.card{

    width:180px;

    background:linear-gradient(135deg,#3498db,#2980b9);

    color:white;

    border-radius:12px;

    padding:22px;

    text-align:center;

}

.card h2{

    font-size:40px;

}

.card p{

    margin-top:8px;

    font-size:18px;

}

/*==========================================
            PROGRESS
==========================================*/

.progress{

    width:100%;

    height:22px;

    background:#ddd;

    border-radius:30px;

    overflow:hidden;

}

.bar{

    height:100%;

    background:#3498db;

}

/*==========================================
            RESULT BOX
==========================================*/

.resultBox{

    margin-top:30px;

    padding:25px;

    border-radius:12px;

    text-align:center;

    font-size:24px;

    font-weight:bold;

}

.pass{

    background:#d5f5e3;

    color:#1e8449;

}

.fail{

    background:#fadbd8;

    color:#c0392b;

}

/*==========================================
            BUTTONS
==========================================*/

.buttons{

    margin-top:35px;

    display:flex;

    justify-content:center;

    gap:15px;

    flex-wrap:wrap;

}

.btn{

    padding:13px 25px;

    border-radius:8px;

    text-decoration:none;

    color:white;

    font-weight:bold;

}

.print{

    background:#27ae60;

}

.login{

    background:#2563eb;

}

/*==========================================
            INSIDE FOOTER
==========================================*/

.footer{

    background:#f8fafc;

    text-align:center;

    padding:28px;

    color:#444;

}

/*==========================================
            BOTTOM FOOTER
==========================================*/

.bottom-footer{

    margin-top:30px;

    background:#0f172a;

    color:white;

    text-align:center;

    padding:22px;

}

.bottom-footer h3{

    margin:0;

    font-size:18px;

}

.bottom-footer span{

    color:#38bdf8;

}

.bottom-footer p{

    margin-top:8px;

    color:#cbd5e1;

    font-size:14px;

}

/*==========================================
            PRINT
==========================================*/

@media print{

.top-header,
.bottom-footer,
.buttons{

display:none;

}

body{

background:white;

}

.container{

width:100%;

margin:0;

box-shadow:none;

}

}

</style>

</head>

<body>

<!-- ===================================================
                    TOP HEADER
=================================================== -->

<div class="top-header">

    <div class="header-logo">
        <img src="images/college.png">
    </div>

    <div class="header-title">

        <h1>
            DEVS INSTITUTE OF TECHNOLOGY AND ENGINEERING
        </h1>

        <h3>
            ONLINE QUIZ EXAMINATION SYSTEM
        </h3>

    </div>

    <div class="header-logo">
        <img src="images/university.png">
    </div>

</div>

<!-- ===================================================
                    RESULT CONTAINER
=================================================== -->

<div class="container">

    <!-- RESULT TITLE -->

    <div class="resultTitle">

        🎉 EXAM COMPLETED

    </div>

    <!-- GENERATED -->

    <div class="generated">

        <h2>

            DEVS INSTITUTE OF TECHNOLOGY AND ENGINEERING

        </h2>

        <h3>

            Online Quiz Examination System

        </h3>

        <p>

            <b>

                Generated On :

                <%=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date())%>

            </b>

        </p>

    </div>

    <!-- MAIN -->

    <div class="main">

        <table class="infoTable">

            <tr>

                <td class="label">

                    Student Name

                </td>

                <td>

                    <%=name%>

                </td>

            </tr>

            <tr>

                <td class="label">

                    Enrollment Number

                </td>

                <td>

                    <%=user%>

                </td>

            </tr>

            <tr>

                <td class="label">

                    Email Address

                </td>

                <td>

                    <%=email%>

                </td>

            </tr>

            <tr>

                <td class="label">

                    Department

                </td>

                <td>

                    <%=department%>

                </td>

            </tr>

            <tr>

                <td class="label">

                    Time Taken

                </td>

                <td>

                    <%=minutes%> Min <%=seconds%> Sec

                </td>

            </tr>

        </table>

     <!-- ===================================================
                    SCORE CARDS
=================================================== -->

<div class="scoreCard">

    <div class="card">

        <h2><%=score%></h2>

        <p>Score</p>

    </div>

    <div class="card">

        <h2><%=String.format("%.2f",percentage)%>%</h2>

        <p>Percentage</p>

    </div>

    <div class="card">

        <h2><%=grade%></h2>

        <p>Grade</p>

    </div>

    <div class="card">

        <h2><%=total%></h2>

        <p>Total Questions</p>

    </div>

</div>

<!-- ===================================================
                    PROGRESS BAR
=================================================== -->

<div class="progress">

    <div class="bar"

         style="width:<%=percentage%>%">

    </div>

</div>

<!-- ===================================================
                    RESULT MESSAGE
=================================================== -->

<%

if(result.equals("PASS")){

%>

<div class="resultBox pass">

🎉 CONGRATULATIONS!

<br><br>

YOU HAVE PASSED THE ONLINE QUIZ EXAMINATION

</div>

<%

}else{

%>

<div class="resultBox fail">

❌ BETTER LUCK NEXT TIME

<br><br>

YOU HAVE NOT ACHIEVED THE MINIMUM PASSING MARKS

</div>

<%

}

%>

<!-- ===================================================
                    BUTTONS
=================================================== -->

<div class="buttons">

<a href="#"

class="btn print"

onclick="window.print();return false;">

🖨 Print Result

</a>

<a href="index.jsp"

class="btn login">

🏠 Back To Login

</a>

</div>

</div>

<!-- ===================================================
                INSIDE RESULT FOOTER
=================================================== -->

<div class="footer">

<h2>

DEVS INSTITUTE OF TECHNOLOGY AND ENGINEERING

</h2>

<br>

<h3>

Online Quiz Examination System

</h3>

<br>

<p>

Result Generated Successfully

</p>

<p>

All Rights Reserved © 2026

</p>

</div>

</div>

<!-- ===================================================
                PROFESSIONAL FOOTER
=================================================== -->

<div class="bottom-footer">

<h3>

🚀 Developed & Designed by

<span>Dev Deepak Pathak</span>

</h3>

<p>

Full Stack Java Developer • Java • JSP • Servlets • MySQL • HTML • CSS • JavaScript

</p>

<p>

© 2026 Devs Institute of Technology and Engineering | Online Quiz Examination System

</p>

</div>

<!-- ===================================================
                    JAVASCRIPT
=================================================== -->

<script>

localStorage.removeItem("endTime");

window.history.forward();

function noBack(){

    window.history.forward();

}

window.onload=function(){

    var progress=document.querySelector(".bar");

    progress.style.width="<%=percentage%>%";

}

</script>

<%

//==================================================
// CLOSE DATABASE
//==================================================

rs.close();

ps.close();

save.close();

con.close();

//==================================================
// DESTROY SESSION
//==================================================

session.invalidate();

%>

</body>

</html>