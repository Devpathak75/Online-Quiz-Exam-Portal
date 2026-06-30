<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<html>
<head>
<title>Online Quiz Examination System</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI';
}

body{

height:100vh;
display:flex;
justify-content:center;
align-items:center;
background:linear-gradient(135deg,#4e54c8,#8f94fb);

}

.container{

width:1000px;
height:600px;
background:white;
border-radius:18px;
overflow:hidden;
display:flex;
box-shadow:0 15px 40px rgba(0,0,0,.35);

}

.left{

width:45%;
background:linear-gradient(135deg,#2b5876,#4e4376);
color:white;
display:flex;
flex-direction:column;
justify-content:center;
align-items:center;
padding:40px;

}

.left h1{

font-size:34px;
margin-bottom:15px;

}

.left h3{

font-size:22px;
margin-bottom:20px;

}

.left p{

text-align:center;
line-height:28px;
font-size:17px;

}

.logo{

font-size:80px;
margin-bottom:20px;

}

.right{

width:55%;
padding:40px;

}

.heading{

font-size:30px;
font-weight:bold;
text-align:center;
margin-bottom:25px;
color:#2c3e50;

}

.tabs{

display:flex;
justify-content:center;
margin-bottom:25px;

}

.tab{

width:150px;
padding:12px;
text-align:center;
cursor:pointer;
font-weight:bold;
border:1px solid #3498db;

}

.active{

background:#3498db;
color:white;

}

.lefttab{

border-radius:8px 0 0 8px;

}

.righttab{

border-radius:0 8px 8px 0;

}

input{

width:100%;
padding:13px;
margin-top:12px;
border-radius:8px;
border:1px solid #ccc;
font-size:15px;

}

button{

width:100%;
padding:13px;
margin-top:18px;
border:none;
border-radius:8px;
font-size:16px;
cursor:pointer;
color:white;

}

.studentBtn{

background:#3498db;

}

.studentBtn:hover{

background:#2874a6;

}

.adminBtn{

background:#27ae60;

}

.adminBtn:hover{

background:#1e8449;

}

.error{

margin-top:10px;
margin-bottom:10px;
color:red;
font-weight:bold;
text-align:center;

}

.attempt{

margin-top:10px;
margin-bottom:10px;
color:#e67e22;
font-weight:bold;
text-align:center;

}

.form{

display:none;

}

.show{

display:block;

}

.footer{

margin-top:30px;
text-align:center;
font-size:13px;
color:#777;

}

</style>

<script>

function showStudent(){

    document.getElementById("studentForm").className="form show";
    document.getElementById("adminForm").className="form";

    document.getElementById("studentTab").className="tab active lefttab";
    document.getElementById("adminTab").className="tab righttab";

    document.getElementById("loginHeading").innerHTML="🎓 Student Login";

}

function showAdmin(){

    document.getElementById("adminForm").className="form show";
    document.getElementById("studentForm").className="form";

    document.getElementById("adminTab").className="tab active righttab";
    document.getElementById("studentTab").className="tab lefttab";

    document.getElementById("loginHeading").innerHTML="👨‍💼 Admin Login";

}

window.onload=function(){

    showStudent();

}

</script>

</head>

<body>

<div class="container">

<div class="left">

<div class="logo">🎓</div>

<h1>Dev Foundation</h1>
<h4> Devs Institute of technology and engineering</h4>
<h3>Online Quiz Examination System</h3>

<p>

Secure Examination Portal

<br><br>

Student Login

<br>

Administrator Login

<br><br>

Online Exam Quiz Portal

</p>

</div>

<div class="right">

<div class="heading" id="loginHeading">

🎓 Student Login

</div>

<div class="tabs">

<div
id="studentTab"
class="tab active lefttab"
onclick="showStudent()">

Student

</div>

<div
id="adminTab"
class="tab righttab"
onclick="showAdmin()">

Admin

</div>

</div>

<!-- STUDENT -->

<div id="studentForm" class="form show">

<%

String error=request.getParameter("error");
String attempted=request.getParameter("attempted");

if(error!=null){

%>

<div class="error">

Invalid Enrollment or Password

</div>

<%

}

if(attempted!=null){

%>

<div class="attempt">

You have already attempted this examination.

</div>

<%

}

%>

<form action="login" method="post">

<input
type="text"
name="enroll"
placeholder="Enrollment Number"
required>

<input
type="password"
name="pass"
placeholder="Password"
required>

<button
type="submit"
class="studentBtn">

Student Login

</button>

</form>

</div>

<!-- ADMIN -->

<div id="adminForm" class="form">

<%

String adminError=request.getParameter("adminError");

if(adminError!=null){

%>

<div class="error">

Invalid Admin Username or Password

</div>

<%

}

%>

<form action="AdminLoginServlet" method="post">

<input
type="text"
name="username"
placeholder="Admin Username"
required>

<input
type="password"
name="password"
placeholder="Admin Password"
required>

<button
type="submit"
class="adminBtn">

Admin Login

</button>

</form>

</div>

<div class="footer">

© 2026 Devs Institute of Technology and Engineering | Online Quiz Examination System

</div>

</div>

</div>

</body>
</html>
