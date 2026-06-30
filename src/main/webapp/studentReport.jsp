<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.sql.*,com.quiz.dao.DBConnection"%>
<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<%

if(session.getAttribute("adminUser")==null){

    response.sendRedirect(request.getContextPath()+"/index.jsp");
    return;

}

String enrollment=request.getParameter("enrollment");

Connection con=DBConnection.getConnection();

PreparedStatement ps=con.prepareStatement(

"SELECT * FROM students WHERE enrollment=?"

);

ps.setString(1,enrollment);

ResultSet rs=ps.executeQuery();

if(!rs.next()){
	
	

%>

<h2 style="text-align:center;color:red;margin-top:50px;">

Student Record Not Found

</h2>

<%

return;

}



%>


<%
int attempted = rs.getInt("attempted");
%>



<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Student Report</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',Tahoma,sans-serif;
}

html{

background:#eef2f7;

}

body{

background:#eef2f7;

margin:0;

}

/*=========================================
            A4 REPORT
=========================================*/

.report-page{

width:210mm;

min-height:297mm;

margin:auto;

background:white;

box-shadow:0 0 25px rgba(0,0,0,.20);

border-radius:8px;

overflow:hidden;

position:relative;

}

/*=========================================
            HEADER
=========================================*/

.top-header{

width:100%;
height:120px;

background:linear-gradient(90deg,#0f172a,#1e3a8a,#2563eb);

display:flex;

justify-content:space-between;

align-items:center;

padding:0 35px;

margin-bottom:30px;

}

.header-logo{

width:110px;

display:flex;

justify-content:center;

align-items:center;

}

.header-logo img{

width:70px;

height:70px;

background:white;

padding:5px;

border-radius:50%;

object-fit:contain;

box-shadow:0 5px 12px rgba(0,0,0,.25);

}

.header-title{

flex:1;

text-align:center;

margin-top:0;

color:white;

}

.header-title h1{

font-size:30px;

font-weight:700;

letter-spacing:.7px;

}

.header-title h3{

margin-top:5px;

font-size:22px;

font-weight:400;

color:#dbeafe;

}

/*=========================================
            REPORT TITLE
=========================================*/

.report-title{

background:linear-gradient(90deg,#2563eb,#1d4ed8);

color:white;

padding:18px;

text-align:center;

font-size:30px;

font-weight:bold;

letter-spacing:1px;

}

/*=========================================
        GENERATED SECTION
=========================================*/

.generated{

padding:25px;

text-align:center;

background:#f8fafc;

border-bottom:2px solid #e5e7eb;

}

.generated h2{

font-size:28px;

color:#1e40af;

margin-bottom:8px;

}

.generated h3{

font-size:18px;

font-weight:500;

color:#555;

margin-bottom:15px;

}

.generated p{

font-size:16px;

}

/*=========================================
            MAIN CONTENT
=========================================*/

.report{

padding:30px;

}

/*=========================================
            TABLE
=========================================*/

table{

width:100%;

border-collapse:collapse;

margin-top:15px;

}

td{

padding:16px;

border:1px solid #dbe2ea;

font-size:17px;

}

.label{

width:280px;

background:#f8fafc;

font-weight:700;

color:#1e40af;

}

/*=========================================
            RESULT COLORS
=========================================*/

.pass{

color:#16a34a;

font-weight:bold;

font-size:18px;

}

.fail{

color:#dc2626;

font-weight:bold;

font-size:18px;

}

.pending{

color:#ea580c;

font-weight:bold;

font-size:18px;

}

/*=========================================
            BUTTONS
=========================================*/

.buttons{

margin:35px 0;

display:flex;

justify-content:center;

gap:18px;

flex-wrap:wrap;

}

.btn{

padding:14px 28px;

border-radius:10px;

text-decoration:none;

color:white;

font-weight:bold;

font-size:16px;

transition:.3s;

box-shadow:0 8px 20px rgba(0,0,0,.15);

}

.back{

background:#334155;

}

.print{

background:#16a34a;

}

.pdf{

background:#7c3aed;

}

.btn:hover{

transform:translateY(-3px);

}

/*=========================================
            FOOTER
=========================================*/
.bottom-footer{

width:100%;

margin-top:30px;

padding:20px;

background:#0f172a;

color:white;

text-align:center;

}

.bottom-footer h3{

font-size:18px;

margin-bottom:8px;

}

.bottom-footer span{

color:#38bdf8;

}

.bottom-footer p{

font-size:14px;

color:#cbd5e1;

margin-top:6px;

}

/*=========================================
            PRINT
=========================================*/

@page{

size:A4 portrait;

margin:8mm;

}

@media print{

body{

background:white;

padding:0;

}

.report-page{

width:210mm;

max-width:95%;

margin:30px auto;

background:white;

border-radius:9px;

box-shadow:0 8px 25px rgba(0,0,0,.18);



}

.buttons{

display:none;

}

}

</style>

</head>

<body>

<!-- =========================
        COLLEGE HEADER
========================== -->

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


<div class="report-page">


<!-- =========================
        REPORT TITLE
========================== -->

<div class="report-title">

📋 STUDENT EXAMINATION REPORT

</div>

<!-- =========================
        GENERATED DETAILS
========================== -->

<div class="generated">

<h2>

Student Examination Report

</h2>

<h3>

DEVS INSTITUTE OF TECHNOLOGY AND ENGINEERING

</h3>

<p>

Online Quiz Examination System

</p>

<br>

<p>

<b>

Generated On :

<%=new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new java.util.Date())%>

</b>

</p>

</div>

<!-- =========================
        REPORT BODY
========================== -->

<div class="report">

<table>

<tr>

<td class="label">

Enrollment Number

</td>

<td>

<%=rs.getString("enrollment")%>

</td>

</tr>

<tr>

<td class="label">

Student Name

</td>

<td>

<%=rs.getString("name")%>

</td>

</tr>

<tr>

<td class="label">

Email Address

</td>

<td>

<%=rs.getString("email")%>

</td>

</tr>

<tr>

<td class="label">

Department

</td>

<td>

<%=rs.getString("department")%>

</td>

</tr>

<tr>

<td class="label">

Exam Status

</td>

<td>

<%

if(attempted==0){

%>

<span class="pending">

NOT ATTEMPTED

</span>

<%

}else{

%>

<span class="pass">

COMPLETED ✅

</span>

<%

}

%>

</td>

</tr>

<tr>

<td class="label">

Score

</td>

<td>

<%

if(attempted==0){

out.print("--");

}else{

out.print(rs.getInt("score"));

out.print(" / ");

out.print(rs.getInt("total_questions"));

}

%>

</td>

</tr>

<tr>

<td class="label">

Percentage

</td>

<td>

<%

if(attempted==0){

out.print("--");

}else{

out.print(String.format("%.2f",rs.getDouble("percentage")));

out.print("%");

}

%>

</td>

</tr>

<tr>

<td class="label">

Grade

</td>

<td>

<%

if(attempted==0){

out.print("--");

}else{

out.print(rs.getString("grade"));

}

%>

</td>

</tr>

<tr>

<td class="label">

Result

</td>

<td>

<%

if(attempted==0){

%>

<span class="pending">

NOT ATTEMPTED

</span>

<%

}else{

String result=rs.getString("result");

if("PASS".equalsIgnoreCase(result)){

%>

<span class="pass">

PASS ✅

</span>

<%

}else{

%>

<span class="fail">

FAIL ❌

</span>

<%

}

}

%>

</td>

</tr>

<tr>

<td class="label">

Time Taken

</td>

<td>

<%

if(attempted==0){

out.print("--");

}else{

out.print(rs.getString("time_taken"));

}

%>

</td>

</tr>

<tr>

<td class="label">

Exam Date

</td>

<td>

<%

if(attempted==0){

out.print("--");

}else{

out.print(rs.getDate("exam_date"));

}

%>

</td>

</tr>

<tr>

<td class="label">

Exam Time

</td>

<td>

<%

if(attempted==0){

out.print("--");

}else{

out.print(rs.getTime("exam_time"));

}

%>

</td>

</tr>

</table>

<div class="buttons">

<a href="adminDashboard.jsp" class="btn back">

⬅ Back to Dashboard

</a>

<a href="#"

class="btn print"

onclick="window.print();return false;">

🖨 Print Report

</a>

<a href="<%=request.getContextPath()%>/PdfServlet?type=attempted"

class="btn pdf">

📄 Download PDF

</a>

</div>

</div>


</div>

<script>

window.history.forward();

function noBack(){

window.history.forward();

}

</script>

<%

rs.close();

ps.close();

con.close();

%>

</body>

<!-- ==========================
        FOOTER
=========================== -->

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

</html>