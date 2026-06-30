<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String error=request.getParameter("error");
String attempted=request.getParameter("attempted");
String adminError=request.getParameter("adminError");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Online Quiz Examination System</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',Tahoma,sans-serif;
}

body{

background:#edf2f7;

}

/*==========================
        HEADER
===========================*/

/*==========================
        HEADER
===========================*/

.top-header{

    width:100%;

    background:linear-gradient(90deg,#0f172a,#1e3a8a,#2563eb);

    display:flex;

    justify-content:space-between;

    align-items:center;

    padding:15px 35px;

    box-shadow:0 5px 20px rgba(0,0,0,.25);

}

.header-logo{

    width:90px;

    display:flex;

    justify-content:center;

    align-items:center;

}

.header-logo img{

    width:80px;

    height:80px;

    object-fit:contain;

    background:white;

    border-radius:60%;

    padding:6px;

    box-shadow:0 5px 15px rgba(0,0,0,.30);

    transition:.3s;

}

.header-logo img:hover{

    transform:scale(1.08) rotate(5deg);

}

.header-title{

    flex:1;

    text-align:center;

    color:white;

}

.header-title h1{

    font-size:32px;

    margin-bottom:6px;

    letter-spacing:1px;

}

.header-title h3{

    color:#dbeafe;

    font-weight:400;

    letter-spacing:1px;

}
/*==========================
        PAGE
===========================*/

.page{

display:flex;

justify-content:center;

align-items:center;

padding:55px 20px;

}

/*==========================
        CARD
===========================*/

.container{

width:1110px;

min-height:600px;

background:white;

display:flex;

border-radius:22px;

overflow:hidden;

box-shadow:0 20px 45px rgba(0,0,0,.18);

transition:.35s;

}

.container:hover{

transform:translateY(-8px);

box-shadow:0 30px 60px rgba(0,0,0,.28);

}

/*==========================
        LEFT PANEL
===========================*/

.left{

width:42%;

background:linear-gradient(145deg,#0f172a,#1e40af,#2563eb);

padding:60px 45px;

color:white;

display:flex;

flex-direction:column;

justify-content:center;

align-items:center;

text-align:center;

position:relative;

overflow:hidden;

}

.left:before{

content:"";

position:absolute;

width:320px;

height:320px;

background:rgba(255,255,255,.08);

border-radius:50%;

top:-120px;

left:-100px;

}

.left:after{

content:"";

position:absolute;

width:260px;

height:260px;

background:rgba(255,255,255,.06);

border-radius:50%;

right:-80px;

bottom:-90px;

}

.logo{

font-size:95px;

margin-bottom:18px;

z-index:2;

}

.logo1 {

    width:100%;

    display:flex;

    justify-content:center;

    align-items:center;

    margin-bottom:25px;

    z-index:2;

}

.logo1 img{

    width:150px;

    height:150px;

    object-fit:contain;

    filter:drop-shadow(0 8px 20px rgba(0,0,0,.35));

    animation:floatLogo 3s ease-in-out infinite;

    transition:.3s;

}

.logo1 img:hover{

    transform:scale(1.08);

    animation-play-state:paused;

}

@keyframes floatLogo{

    0%{

        transform:translateY(0px);

    }

    25%{

        transform:translateY(-6px);

    }

    50%{

        transform:translateY(0px);

    }

    75%{

        transform:translateY(6px);

    }

    100%{

        transform:translateY(0px);

    }

}

.left h1{

font-size:36px;

margin-bottom:6px;

z-index:2;

}

.left h4{

font-size:18px;

font-weight:400;

color:#dbeafe;

margin-bottom:25px;

line-height:28px;

z-index:2;

}

.left h2{

font-size:26px;

margin-bottom:28px;

z-index:2;

}

.features{

width:100%;

z-index:2;

margin-top:10px;

}

.feature{

background:rgba(255,255,255,.12);

padding:14px 18px;

margin-bottom:16px;

border-radius:12px;

font-size:17px;

backdrop-filter:blur(4px);

transition:.3s;

}

.feature:hover{

background:rgba(255,255,255,.20);

transform:translateX(8px);

}

/*==========================
        RIGHT PANEL
===========================*/

.right{

width:58%;

padding:55px;

background:#ffffff;

display:flex;

flex-direction:column;

justify-content:center;

}

.heading{

text-align:center;

font-size:34px;

font-weight:bold;

color:#1e3a8a;

margin-bottom:30px;

}

/*==========================
        TABS
===========================*/

.tabs{

display:flex;

margin-bottom:30px;

}

.tab{

flex:1;

padding:15px;

text-align:center;

font-size:17px;

font-weight:bold;

cursor:pointer;

border:2px solid #2563eb;

transition:.30s;

}

.lefttab{

border-radius:10px 0 0 10px;

}

.righttab{

border-radius:0 10px 10px 0;

}

.active{

background:#2563eb;

color:white;

}

.tab:hover:not(.active){

    background:#e8f0ff;

    color:#1e3a8a;

}

/*==========================
        FORM
===========================*/

.form{

display:none;

}

.show{

display:block;

}

input{

width:100%;

padding:15px;

margin-top:18px;

font-size:16px;

border-radius:10px;

border:1px solid #d1d5db;

transition:.30s;

outline:none;

background:#f8fafc;

}

input:focus{

border-color:#2563eb;

background:white;

box-shadow:0 0 10px rgba(37,99,235,.20);

}

button{

width:100%;

padding:15px;

margin-top:28px;

border:none;

border-radius:10px;

font-size:17px;

font-weight:bold;

cursor:pointer;

transition:.30s;

}

.studentBtn{

background:#2563eb;

color:white;

}

.studentBtn:hover{

background:#1d4ed8;

transform:translateY(-3px);

box-shadow:0 10px 25px rgba(37,99,235,.35);

}

.adminBtn{

background:#16a34a;

color:white;

}

.adminBtn:hover{

background:#15803d;

transform:translateY(-3px);

box-shadow:0 10px 25px rgba(22,163,74,.35);

}

.error{

margin:18px 0;

padding:13px;

border-radius:10px;

background:#fee2e2;

color:#dc2626;

font-weight:bold;

text-align:center;

}

.attempt{

margin:18px 0;

padding:13px;

border-radius:10px;

background:#fef3c7;

color:#d97706;

font-weight:bold;

text-align:center;

}

.footer{

margin-top:35px;

text-align:center;

font-size:13px;

color:#777;

}


/*==========================
        BOTTOM FOOTER
===========================*/

.bottom-footer{

    width:100%;

    background:#0f172a;

    color:#ffffff;

    text-align:center;

    padding:18px 10px;

    margin-top:10px;

    box-shadow:0 -3px 10px rgba(0,0,0,.15);

}

.bottom-footer h3{

    margin:0;

    font-size:18px;

    letter-spacing:.5px;

    color:#ffffff;

}

.bottom-footer p{

    margin-top:6px;

    font-size:14px;

    color:#cbd5e1;

}

.bottom-footer span{

    color:#38bdf8;

    font-weight:bold;

}

.bottom-footer:hover{

    background:#172554;

    transition:.3s;

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

<%
if(adminError!=null){
%>

showAdmin();

<%
}else{
%>

showStudent();

<%
}
%>

}

</script>

</head>

<body>

<!-- ===========================
        TOP HEADER
=========================== -->

<div class="top-header">

    <div class="header-logo">
        <img src="images/college.png" alt="College Logo">
    </div>

    <div class="header-title">
        <h1>DEVS INSTITUTE OF TECHNOLOGY AND ENGINEERING</h1>
        <h3>ONLINE QUIZ EXAMINATION SYSTEM</h3>
    </div>

    <div class="header-logo">
        <img src="images/university.png" alt="University Logo">
    </div>

</div>

<!-- ===========================
        MAIN PAGE
=========================== -->

<div class="page">

<div class="container">

<!-- ===========================
        LEFT PANEL
=========================== -->

<div class="left">

<div class="logo">🎓</div>

<h1>Dev Foundation</h1>

<h4>
Devs Institute of Technology and Engineering
</h4>

<h2>
Online Quiz Examination System
</h2>

<div class="features">

<div class="feature">
🔐 Secure Examination Portal
</div>

<div class="feature">
🎓 Student Login
</div>

<div class="feature">
👨‍💼 Administrator Login
</div>

<div class="feature">
📝 Online Exam Quiz Portal
</div>


</div>

</div>

<!-- ===========================
        RIGHT PANEL
=========================== -->

<div class="right">

<div class="logo1">

 <img src="images/college.png" alt="College Logo">

</div>

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

<!-- ===========================
        STUDENT LOGIN
=========================== -->

<div id="studentForm" class="form show">

<%

if(error!=null){

%>

<div class="error">

⚠ Invalid Enrollment Number or Password

</div>

<%

}

if(attempted!=null){

%>

<div class="attempt">

⚠ You have already attempted this examination.

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

LOGIN

</button>

</form>

</div>

<!-- ===========================
        ADMIN LOGIN
=========================== -->

<div id="adminForm" class="form">

<%

if(adminError!=null){

%>

<div class="error">

⚠ Invalid Admin Username or Password

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

LOGIN

</button>

</form>

</div>

<div class="footer">

© 2026 Devs Institute of Technology and Engineering<br>

Online Quiz Examination System

</div>

</div>

</div>

</div>

</body>

<div class="bottom-footer">

    <h3>🚀 Developed & Designed by <span>Dev Deepak Pathak</span></h3>

    <p>
        Full Stack Java Developer • Java • JSP • Servlets • MySQL • HTML • CSS • JavaScript
    </p>

    <p style="margin-top:8px;">
        © 2026 Devs Institute of Technology and Engineering | All Rights Reserved
    </p>

</div>

</html>