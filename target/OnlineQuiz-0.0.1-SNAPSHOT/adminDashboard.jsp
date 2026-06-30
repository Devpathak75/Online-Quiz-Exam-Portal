<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

Connection con = DBConnection.getConnection();

int totalStudents=0;
int attemptedStudents=0;
int remainingStudents=0;
int highestScore=0;
int lowestScore=0;
double averageScore=0;

PreparedStatement ps;
ResultSet rs;

// Total Students
ps=con.prepareStatement("SELECT COUNT(*) FROM students");
rs=ps.executeQuery();
if(rs.next()){
    totalStudents=rs.getInt(1);
}
rs.close();
ps.close();

// Attempted
ps=con.prepareStatement("SELECT COUNT(*) FROM students WHERE attempted=1");
rs=ps.executeQuery();
if(rs.next()){
    attemptedStudents=rs.getInt(1);
}
rs.close();
ps.close();

remainingStudents=totalStudents-attemptedStudents;

// Highest Score
try{
ps=con.prepareStatement("SELECT IFNULL(MAX(score),0) FROM students");
rs=ps.executeQuery();
if(rs.next()){
    highestScore=rs.getInt(1);
}
rs.close();
ps.close();
}catch(Exception e){}

// Lowest Score
try{
ps=con.prepareStatement("SELECT IFNULL(MIN(score),0) FROM students WHERE attempted=1");
rs=ps.executeQuery();
if(rs.next()){
    lowestScore=rs.getInt(1);
}
rs.close();
ps.close();
}catch(Exception e){}

// Average
try{
ps=con.prepareStatement("SELECT IFNULL(AVG(score),0) FROM students WHERE attempted=1");
rs=ps.executeQuery();
if(rs.next()){
    averageScore=rs.getDouble(1);
}
rs.close();
ps.close();
}catch(Exception e){}

String search=request.getParameter("search");
if(search==null){
    search="";
}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Admin Dashboard</title>

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
color:white;
padding:18px 30px;
display:flex;
justify-content:space-between;
align-items:center;

}

.header h2{

font-size:28px;

}

.admin{

font-size:18px;

}

.navbar{

background:white;
padding:15px;
display:flex;
justify-content:center;
gap:15px;
box-shadow:0 2px 10px rgba(0,0,0,.15);

}

.navbar a{

text-decoration:none;
background:#3498db;
color:white;
padding:12px 18px;
border-radius:8px;
font-weight:bold;
transition:.3s;

}

.navbar a:hover{

background:#21618c;

}

.container{

width:96%;
margin:auto;
margin-top:25px;

}

.overview{

font-size:28px;
font-weight:bold;
margin-bottom:20px;
color:#2c3e50;

}

.cards{

display:grid;
grid-template-columns:repeat(6,1fr);
gap:18px;

}

.card{

background:white;
padding:22px;
border-radius:12px;
box-shadow:0 5px 15px rgba(0,0,0,.15);
text-align:center;

}

.card h3{

font-size:16px;
color:#555;

}

.card h1{

margin-top:12px;
font-size:35px;
color:#3498db;

}

.searchBox{

margin-top:35px;
margin-bottom:25px;
display:flex;
gap:10px;

}

.searchBox input{

width:400px;
padding:12px;
border-radius:8px;
border:1px solid #ccc;
font-size:15px;

}

.searchBox button{

padding:12px 25px;
background:#27ae60;
border:none;
color:white;
border-radius:8px;
cursor:pointer;
font-size:15px;

}

.searchBox button:hover{

background:#1e8449;

}

table{

width:100%;
border-collapse:collapse;
background:white;
box-shadow:0 5px 15px rgba(0,0,0,.15);

}

th{

background:#3498db;
color:white;
padding:15px;

}

td{

padding:12px;
text-align:center;
border-bottom:1px solid #ddd;

}

.pass{

color:green;
font-weight:bold;

}

.pending{

color:#e67e22;
font-weight:bold;

}

.viewBtn{

background:#8e44ad;
color:white;
padding:8px 15px;
border-radius:6px;
text-decoration:none;

}

.viewBtn:hover{

background:#6c3483;

}

</style>

</head>

<body>

<div class="header">

<h2>DEVS INSTITUTE OF TECHNOLOGY AND ENGINEERING</h2>

<div class="admin">

👨‍💼 Welcome Admin

</div>

</div>

<div class="navbar">

<a href="adminDashboard.jsp">🏠 Dashboard</a>

<a href="attemptedStudents.jsp">📋 View Attempted Students</a>

<a href="remainingStudents.jsp">⏳ View Remaining Students</a>

<a href="<%=request.getContextPath()%>/PdfServlet?type=attempted">
📄 Download Attempted PDF
</a>

<a href="<%=request.getContextPath()%>/PdfServlet?type=remaining">
📄 Download Remaining PDF
</a>

<a href="<%=request.getContextPath()%>/LogoutServlet">
🚪 Logout
</a>

</div>

<div class="container">

<div class="overview">

Overview

</div>

<div class="cards">

<div class="card">
<h3>Total Students</h3>
<h1><%=totalStudents%></h1>
</div>

<div class="card">
<h3>Attempted Students</h3>
<h1><%=attemptedStudents%></h1>
</div>

<div class="card">
<h3>Remaining Students</h3>
<h1><%=remainingStudents%></h1>
</div>

<div class="card">
<h3>Highest Score</h3>
<h1><%=highestScore%></h1>
</div>

<div class="card">
<h3>Lowest Score</h3>
<h1><%=lowestScore%></h1>
</div>

<div class="card">
<h3>Average Score</h3>
<h1><%=String.format("%.2f",averageScore)%></h1>
</div>

</div>

<form method="get" class="searchBox">

<input
type="text"
name="search"
placeholder="Search Student by Enrollment or Name..."
value="<%=search%>">

<button type="submit">

🔍 Search

</button>

</form>

<table>

<tr>

<th>Enrollment</th>
<th>Name</th>
<th>Department</th>
<th>Subject</th>
<th>Email</th>
<th>Score</th>
<th>Grade</th>
<th>Status</th>
<th>Action</th>

</tr>

<%

PreparedStatement psStudents;

if(search.trim().equals("")){

    psStudents = con.prepareStatement(

        "SELECT * FROM students ORDER BY enrollment"

    );

}
else{

    psStudents = con.prepareStatement(

        "SELECT * FROM students WHERE enrollment LIKE ? OR name LIKE ? ORDER BY enrollment"

    );

    psStudents.setString(1,"%"+search+"%");
    psStudents.setString(2,"%"+search+"%");

}

ResultSet studentRS = psStudents.executeQuery();

while(studentRS.next()){

String enrollment = studentRS.getString("enrollment");
String name = studentRS.getString("name");
String email = studentRS.getString("email");
String department = studentRS.getString("department");
String subject = studentRS.getString("subject");

int attempted = studentRS.getInt("attempted");

%>

<tr>

<td>

<%=enrollment%>

</td>

<td>

<%=name%>

</td>

<td>

<%=department%>

</td>

<td>

<%=subject%>

</td>


<td>

<%=email%>

</td>

<td>

<%

if(attempted==1){

try{

out.print(studentRS.getInt("score"));

out.print(" / ");

out.print(studentRS.getInt("total_questions"));

}
catch(Exception e){

out.print("-");

}

}
else{

out.print("--");

}

%>

</td>

<td>

<%

if(attempted==1){

try{

out.print(studentRS.getString("grade"));

}
catch(Exception e){

out.print("-");

}

}
else{

out.print("--");

}

%>

</td>

<td>

<%

if(attempted==0){

%>

<span class="pending">

NOT ATTEMPTED

</span>

<%

}
else{

String result="";

try{

result=studentRS.getString("result");

}catch(Exception e){}

if("PASS".equalsIgnoreCase(result)){

%>

<span class="pass">

PASS

</span>

<%

}
else{

%>

<span class="fail">

FAIL

</span>

<%

}

}

%>

</td>

<td>

<a
class="viewBtn"
href="studentReport.jsp?enrollment=<%=enrollment%>">

👁 View

</a>

</td>

</tr>

<%

}

studentRS.close();
psStudents.close();

%>
</table>

<br><br>

<div style="text-align:center;color:#555;font-size:15px;">

© 2026 DEVS INSTITUTE OF TECHNOLOGY AND ENGINEERING

<br>

Online Quiz Examination System

</div>

</div>

<script>


const search=document.querySelector(".searchBox input");

search.addEventListener("keyup",function(){

this.style.borderColor="#3498db";

});

</script>

<%

con.close();

%>

</body>

</html>