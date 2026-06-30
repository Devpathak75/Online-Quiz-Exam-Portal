<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,com.quiz.dao.DBConnection"%>
<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<%
if(session.getAttribute("adminUser")==null){
response.sendRedirect("../index.jsp");
return;
}

String search=request.getParameter("search");
if(search==null)
search="";
%>

<!DOCTYPE html>

<html>

<head>

<title>Remaining Students</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI',Tahoma,sans-serif;
}

body{

margin:0;

font-family:'Segoe UI',Tahoma,sans-serif;

background:#eef2f7;

display:flex;

flex-direction:column;

min-height:100vh;

overflow-x:hidden;

}

/*==========================
        PROFESSIONAL HEADER
===========================*/


.page-header{

width:98%;

margin:25px auto;

background:white;

border-radius:15px;

padding:20px 30px;

display:flex;

justify-content:space-between;

align-items:center;

box-shadow:0 10px 25px rgba(0,0,0,.12);

}

.page-header h2{

margin:0;

font-size:30px;

color:#1e40af;

}

.top-header{

height:90px;

background:linear-gradient(90deg,#0f172a,#1e3a8a,#2563eb);

display:flex;

align-items:center;

justify-content:space-between;

padding:0 25px;

box-shadow:0 5px 20px rgba(0,0,0,.25);
}

.header-logo{

width:140px;

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

box-shadow:0 3px 10px rgba(0,0,0,.25);

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

font-size:24px;

font-weight:700;

color:white;

letter-spacing:1px;

}

.header-title h3{

margin-top:5px;

font-size:15px;

font-weight:400;

color:#dbeafe;

}

.container{

width:95%;

margin:auto;

}


.search{

display:flex;

gap:12px;

margin-bottom:25px;

}

.search input{

width:360px;

padding:13px 15px;

font-size:15px;

border:1px solid #d1d5db;

border-radius:8px;

outline:none;

transition:.3s;

}

.search input:focus{

border-color:#2563eb;

box-shadow:0 0 10px rgba(37,99,235,.2);

}

.search button{

padding:13px 24px;

background:#2563eb;

color:white;

border:none;

border-radius:8px;

font-weight:bold;

cursor:pointer;

transition:.3s;

}

.search button:hover{

background:#1d4ed8;

}

table{

width:100%;

background:white;

border-collapse:collapse;

border-radius:15px;

overflow:hidden;

box-shadow:0 10px 30px rgba(0,0,0,.12);

}

th{

background:#1e40af;

color:white;

padding:15px;

font-size:15px;

}

td{

padding:14px;

border-bottom:1px solid #e5e7eb;

}

tr:nth-child(even){

background:#f8fafc;

}

tr:hover{

background:#dbeafe;

}
.pending{

color:#e74c3c;
font-weight:bold;

}

.back{

display:inline-block;

margin-top:25px;

padding:13px 26px;

background:#1e40af;

color:white;

font-weight:bold;

border-radius:10px;

text-decoration:none;

transition:.3s;

}

.back:hover{

background:#0f172a;

transform:translateY(-3px);

}


/*==========================
        FOOTER
===========================*/

.bottom-footer{

background:#0f172a;

padding:22px;

text-align:center;

color:white;

margin-top:348px;

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

.admin-box{

background:linear-gradient(135deg,#2563eb,#1d4ed8);

color:white;

padding:12px 22px;

border-radius:10px;

font-weight:bold;

box-shadow:0 5px 15px rgba(37,99,235,.25);

}
}

</style>

</head>

<body>

<div class="top-header">

<div class="header-logo">

<img src="images/college.png">

</div>

<div class="header-title">

<h1>DEVS INSTITUTE OF TECHNOLOGY AND ENGINEERING</h1>

<h3>ONLINE QUIZ EXAMINATION SYSTEM</h3>

</div>


<div class="header-logo">

<img src="images/university.png">

</div>

</div>

<div class="page-header">

    <h2>⏳ Remaining Students</h2>

    <div class="admin-box">
        Welcome,
        <%=session.getAttribute("adminName")%>
    </div>

</div>


<div class="container">

<form method="get" class="search">

<input
type="text"
name="search"
placeholder="Search by Enrollment or Name"
value="<%=search%>">

<button type="submit">

Search

</button>

</form>

<table>

<tr>

<th>Enrollment</th>
<th>Name</th>
<th>Email</th>
<th>Department</th>
<th>Status</th>

</tr>

<%

Connection con=DBConnection.getConnection();

PreparedStatement ps;

if(search.trim().equals("")){

ps=con.prepareStatement(

"SELECT * FROM students WHERE attempted=0 ORDER BY enrollment"

);

}
else{

ps=con.prepareStatement(

"SELECT * FROM students WHERE attempted=0 AND (enrollment LIKE ? OR name LIKE ?) ORDER BY enrollment"

);

ps.setString(1,"%"+search+"%");
ps.setString(2,"%"+search+"%");

}

ResultSet rs=ps.executeQuery();

while(rs.next()){

%>

<tr>

<td><%=rs.getString("enrollment")%></td>

<td><%=rs.getString("name")%></td>

<td><%=rs.getString("email")%></td>

<td><%=rs.getString("department")%></td>

<td>

<span class="pending">

NOT ATTEMPTED

</span>

</td>

</tr>

<%

}

rs.close();
ps.close();
con.close();

%>

</table>

<a href="adminDashboard.jsp" class="back">

← Back to Dashboard

</a>

</div>

</body>

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
