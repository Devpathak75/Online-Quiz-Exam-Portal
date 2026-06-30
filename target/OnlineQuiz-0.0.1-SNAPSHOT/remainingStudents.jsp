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

body{

margin:0;
font-family:Segoe UI;
background:#eef2f7;

}

.header{

background:#2c3e50;
padding:20px;
color:white;
display:flex;
justify-content:space-between;
align-items:center;

}

.container{

width:95%;
margin:auto;
margin-top:20px;

}

.search{

margin-bottom:20px;

}

.search input{

width:350px;
padding:10px;
border-radius:6px;
border:1px solid #ccc;

}

.search button{

padding:10px 20px;
border:none;
background:#3498db;
color:white;
border-radius:6px;
cursor:pointer;

}

table{

width:100%;
border-collapse:collapse;
background:white;
box-shadow:0 5px 15px rgba(0,0,0,.15);

}

th{

background:#e67e22;
color:white;
padding:12px;

}

td{

padding:10px;
text-align:center;
border-bottom:1px solid #ddd;

}

.pending{

color:#e74c3c;
font-weight:bold;

}

.back{

display:inline-block;
margin-top:20px;
padding:12px 25px;
background:#2c3e50;
color:white;
text-decoration:none;
border-radius:8px;

}

</style>

</head>

<body>

<div class="header">

<h2>⏳ Remaining Students</h2>

<div>

Welcome <b><%=session.getAttribute("adminName")%></b>

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

</html>
