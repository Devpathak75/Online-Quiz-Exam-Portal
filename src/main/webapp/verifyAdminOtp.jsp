<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

if(session.getAttribute("adminOtp")==null){

    response.sendRedirect("index.jsp");

    return;

}

String error=request.getParameter("error");
String email=(String)session.getAttribute("adminEmail");
String admin=(String)session.getAttribute("tempAdminName");
%>


<%
Long otpTime=(Long)session.getAttribute("adminOtpTime");

long remaining=300;

if(otpTime!=null){

remaining=300-(System.currentTimeMillis()-otpTime)/1000;

if(remaining<0)
remaining=0;

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Admin OTP Verification</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI';
}


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

width:75px;

height:75px;

object-fit:contain;

background:white;

padding:6px;

border-radius:50%;

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

font-size:34px;

font-weight:700;

color:#ffffff !important;

letter-spacing:1px;

text-shadow:1px 1px 4px rgba(0,0,0,.4);

}

.header-title h3{

margin-top:6px;

font-size:18px;

font-weight:400;

color:#e2e8f0 !important;

letter-spacing:1px;

}

/*==========================
        PAGE
===========================*/

.page{

display:flex;

justify-content:center;

padding:50px 20px;

}


body{

margin:0;

background:#edf2f7;

font-family:'Segoe UI',Tahoma,sans-serif;

}

.container{

width:560px;

background:white;

padding:40px;

border-radius:20px;

box-shadow:0 20px 45px rgba(0,0,0,.20);

transition:.35s;

}

.container:hover{

transform:translateY(-6px);

box-shadow:0 30px 55px rgba(0,0,0,.30);

}
.logo{

font-size:70px;
text-align:center;

}

h1{

text-align:center;
margin-top:10px;
color:#2c3e50;

}

h3{

text-align:center;
margin-top:10px;
font-weight:normal;
color:#555;

}

.mail{

margin-top:25px;
text-align:center;
font-size:16px;
color:#444;

}

.mail b{

color:#3498db;

}

.error{

margin-top:20px;
padding:12px;
background:#ffebee;
color:#c62828;
border-radius:8px;
text-align:center;
font-weight:bold;

}

input{

width:100%;
padding:15px;
margin-top:25px;
font-size:24px;
text-align:center;
letter-spacing:8px;
border-radius:8px;
border:1px solid #bbb;

}

button{

width:100%;
padding:15px;
margin-top:25px;
border:none;
border-radius:8px;
background:#3498db;
color:white;
font-size:18px;
cursor:pointer;

}

button:hover{

background:#2874a6;

}

.timer{

margin-top:20px;
text-align:center;
font-size:17px;
font-weight:bold;
color:#e67e22;

}

.links{

margin-top:25px;
display:flex;
justify-content:space-between;

}

.links a{

text-decoration:none;
font-weight:bold;

}

/*==========================
        FOOTER
===========================*/

.bottom-footer{

background:#0f172a;

color:white;

text-align:center;

padding:18px;

margin-top:40px;

}

.bottom-footer h3{

font-size:18px;

margin-bottom:5px;

}

.bottom-footer span{

color:#38bdf8;

font-weight:bold;

}

.bottom-footer p{

color:#cbd5e1;

font-size:14px;

}
/*==========================
        FOOTER
===========================*/

.bottom-footer{

width :100%;

background:#0f172a;

color:white;

text-align:center;

padding:18px;

margin-top:25px;

}

.bottom-footer h3{

font-size:18px;

margin:0;

}

.bottom-footer span{

color:#38bdf8;

font-weight:bold;

}

.bottom-footer p{

margin-top:8px;

color:#cbd5e1;

font-size:14px;

}

.bottom-footer:hover{

background:#172554;

transition:.3s;

}
}

</style>

</head>

<body>


<body>

<!-- HEADER -->

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

<div class="page">

<div class="container">


<div class="logo">🔐</div>

<h1>Admin OTP Verification</h1>

<h3>Online Quiz Examination System</h3>

<div class="mail">

OTP has been sent to

<br><br>

<b><%=email%></b>

<br><br>

Administrator :

<b><%=admin%></b>

</div>

<%

if(error!=null){

%>

<div class="error">

❌ Invalid OTP

</div>

<%

}

%>

<form action="AdminVerifyOtpServlet" method="post">

<input
type="text"
name="otp"
maxlength="6"
placeholder="Enter OTP"
required>

<button type="submit">

Verify OTP

</button>

</form>

<div class="timer">

OTP expires in

<span id="count">

05:00

</span>

</div>

<div class="links">

<a href="AdminSendOtpServlet">

🔄 Resend OTP

</a>

<a href="index.jsp">

⬅ Back to Login

</a>

</div>

<br>

<hr>

<br>

<script>

var timeLeft=<%=remaining%>;

function startTimer(){

    var minute = Math.floor(timeLeft/60);

    var second = timeLeft%60;

    if(minute < 10){

        minute = "0" + minute;

    }

    if(second < 10){

        second = "0" + second;

    }

    document.getElementById("count").innerHTML =
            minute + ":" + second;

    if(timeLeft <= 0){

        alert("OTP Expired. Please click Resend OTP.");

      
        return;

    }

    timeLeft--;

}

startTimer();

setInterval(startTimer,1000);

document.querySelector("input[name='otp']").focus();


</script>

</div>

</div>

<!-- FOOTER -->

<div class="bottom-footer">

    <h3>

        🚀 Developed & Designed by

        <span>Dev Deepak Pathak</span>

    </h3>

    <p>

        Full Stack Java Developer • Java • JSP • Servlets • MySQL • HTML • CSS • JavaScript

    </p>

    <p style="margin-top:8px;">

        © 2026 Devs Institute of Technology and Engineering | All Rights Reserved

    </p>

</div>

</body>

</html>