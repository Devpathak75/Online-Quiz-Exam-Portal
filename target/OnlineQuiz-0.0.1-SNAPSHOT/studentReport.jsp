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
font-family:Segoe UI;

}

body{

background:#eef2f7;

}

.header{

background:#1f3b64;
padding:20px;
color:white;
text-align:center;

}

.header h1{

font-size:30px;

}

.header h3{

margin-top:10px;
font-weight:normal;

}

.container{

width:900px;
margin:40px auto;
background:white;
border-radius:12px;
box-shadow:0 5px 20px rgba(0,0,0,.2);
overflow:hidden;

}

.title{

background:#3498db;
color:white;
padding:18px;
font-size:24px;
text-align:center;

}

.report{

padding:35px;

}

table{

width:100%;
border-collapse:collapse;

}

td{

padding:15px;
font-size:18px;
border-bottom:1px solid #ddd;

}

.label{

font-weight:bold;
width:250px;
background:#f7f7f7;

}

.pass{

color:green;
font-weight:bold;

}

.fail{

color:red;
font-weight:bold;

}

.pending{

color:#e67e22;
font-weight:bold;

}

.buttons{

margin-top:30px;
display:flex;
justify-content:center;
gap:15px;
flex-wrap:wrap;

}


.btn{

display:inline-block;
padding:12px 22px;
margin:5px;
border-radius:8px;
text-decoration:none;
color:white;
font-weight:bold;

}

.back{

background:#34495e;

}

.print{

background:#27ae60;

}

.pdf{

background:#8e44ad;

}

.mail{

background:#e67e22;

}

.btn:hover{

opacity:.9;

}


.footer{

text-align:center;
padding:30px;
background:#f8f9fa;
font-size:16px;
color:#444;

}



</style>

</head>

<body>

<div class="header">

<h1>

DEVS INSTITUTE OF TECHNOLOGY AND ENGINEERING

</h1>

<h3>

ONLINE QUIZ EXAMINATION SYSTEM

</h3>

</div>

<div class="container">

<div class="title">

Student Examination Report

</div>

<div style="
text-align:center;
padding:20px;
background:#f8f9fa;
border-bottom:1px solid #ddd;
line-height:28px;
">

<h2 style="margin:0;color:#2c3e50;">

DEVS INSTITUTE OF TECHNOLOGY AND ENGINEERING

</h2>

<h3 style="margin-top:8px;color:#555;font-weight:normal;">

Online Quiz Examination System

</h3>

<p style="margin-top:12px;font-size:16px;">

<b>Generated on :</b>

<%=new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new java.util.Date())%>

</p>

</div>

<div class="report">

<table>

<tr>
<td class="label">Enrollment Number</td>
<td><%=rs.getString("enrollment")%></td>
</tr>

<tr>
<td class="label">Student Name</td>
<td><%=rs.getString("name")%></td>
</tr>

<tr>
<td class="label">Email Address</td>
<td><%=rs.getString("email")%></td>
</tr>

<tr>
<td class="label">Department</td>
<td><%=rs.getString("department")%></td>
</tr>


<tr>
<td class="label">Exam Status</td>
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

COMPLETED

</span>

<%

}

%>

</td>
</tr>




<tr>
<td class="label">Score</td>
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
<td class="label">Percentage</td>
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


</div>

<tr>
<td class="label">Grade</td>
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
<td class="label">Result</td>
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
<td class="label">Time Taken</td>
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
<td class="label">Exam Date</td>
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
<td class="label">Exam Time</td>
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

<a href="#" class="btn print" onclick="window.print();return false;">
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

</html>
