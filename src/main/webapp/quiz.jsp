<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,com.quiz.dao.DBConnection"%>

<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

//================ SESSION =================

Integer qIndex=(Integer)session.getAttribute("qIndex");

int[] status=(int[])session.getAttribute("status");

int[] answers=(int[])session.getAttribute("answers");

String name=(String)session.getAttribute("name");

String enroll=(String)session.getAttribute("user");

String email=(String)session.getAttribute("email");

String department=(String)session.getAttribute("department");

String subject=(String)session.getAttribute("subject");

//================ SECURITY =================

if(qIndex==null || status==null || answers==null){

response.sendRedirect("index.jsp");

return;

}

//================ VISITED =================

if(status[qIndex]==0){

status[qIndex]=1;

session.setAttribute("status",status);

}

//================ LOAD QUESTION =================

Connection con=DBConnection.getConnection();

PreparedStatement ps=con.prepareStatement(

"SELECT * FROM questions WHERE department=? ORDER BY id LIMIT ?,1"

);

ps.setString(1,department);

ps.setInt(2,qIndex);

ResultSet rs=ps.executeQuery();

//================ PREVIOUS ANSWER =================

int selected=answers[qIndex];

//================ CHECK ALL ANSWERED =================

boolean allAnswered=true;

for(int i=0;i<answers.length;i++){

if(answers[i]==0){

allAnswered=false;

break;

}

}
%>

<html>

<head>

<title>Online Quiz Examination</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',Tahoma,sans-serif;
}

body{

background:#edf2f7;

min-height:100vh;

display:flex;

flex-direction:column;

overflow-x:hidden;

}

/*==================================================
                    HEADER
===================================================*/

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

width:90px;

display:flex;

justify-content:center;

align-items:center;

flex-shrink:0;

}

.header-logo img{

width:62px;

height:62px;

background:white;

padding:5px;

border-radius:50%;

object-fit:contain;

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

letter-spacing:1px;

font-weight:700;

color:white;

}

.header-title h3{

margin-top:5px;

font-size:16px;

font-weight:400;

color:#dbeafe;

}

/*==================================================
                MAIN CONTAINER
===================================================*/

.container{

width:96%;

margin:25px auto;

display:flex;

gap:22px;

flex:1;

}

/*==================================================
                LEFT PANEL
===================================================*/

.left{

width:73%;

}

/*==================================================
                USER CARD
===================================================*/

.userCard{

background:white;

border-radius:16px;

padding:22px;

box-shadow:0 10px 30px rgba(0,0,0,.10);

margin-bottom:22px;

transition:.3s;

}

.userCard:hover{

transform:translateY(-3px);

}

.userCard table{

width:100%;

}

.userCard td{

padding:10px;

font-size:15px;

}

.label{

font-weight:bold;

color:#1e3a8a;

}

/*==================================================
                    TIMER
===================================================*/

.timer{

background:linear-gradient(90deg,#1e3a8a,#2563eb);

color:white;

padding:18px;

border-radius:14px;

font-size:24px;

font-weight:bold;

text-align:center;

margin-bottom:20px;

box-shadow:0 8px 20px rgba(37,99,235,.25);

}

/*==================================================
                WARNING
===================================================*/

.warning{

background:#fff3cd;

color:#b45309;

padding:14px;

border-left:6px solid orange;

border-radius:10px;

margin-bottom:20px;

font-weight:bold;

}

/*==================================================
                QUESTION CARD
===================================================*/

.questionCard{

background:white;

border-radius:16px;

padding:30px;

box-shadow:0 10px 30px rgba(0,0,0,.10);

transition:.3s;

}

.questionCard:hover{

transform:translateY(-3px);

}

.questionTitle{

font-size:26px;

font-weight:bold;

color:#1e3a8a;

margin-bottom:25px;

}

.question{

font-size:22px;

line-height:34px;

margin-bottom:30px;

font-weight:600;

color:#222;

}

/*==================================================
                OPTIONS
===================================================*/

.option{

display:block;

padding:16px 18px;

margin-bottom:15px;

background:#f8fafc;

border:2px solid #dbeafe;

border-radius:12px;

cursor:pointer;

transition:.3s;

font-size:17px;

}

.option:hover{

background:#dbeafe;

border-color:#2563eb;

transform:translateX(6px);

}

.option input{

margin-right:12px;

transform:scale(1.2);

}

/*==================================================
                BUTTONS
===================================================*/

.buttons{

margin-top:30px;

}

.btn{

padding:13px 25px;

border:none;

border-radius:10px;

font-size:15px;

font-weight:bold;

cursor:pointer;

color:white;

transition:.3s;

margin-right:10px;

}

.prev{

background:#f59e0b;

}

.prev:hover{

background:#d97706;

}

.next{

background:#2563eb;

}

.next:hover{

background:#1d4ed8;

}

.submit{

background:#16a34a;

}

.submit:hover{

background:#15803d;

}

/*=========================================
            RIGHT PANEL
==========================================*/

.right{

width:27%;

}

.paletteCard{

background:white;

border-radius:18px;

padding:25px;

box-shadow:0 12px 30px rgba(0,0,0,.10);

position:sticky;

top:20px;

}

.paletteTitle{

text-align:center;

font-size:24px;

font-weight:bold;

margin-bottom:22px;

color:#1e3a8a;

}

.palette{

display:grid;

grid-template-columns:repeat(5,58px);

justify-content:center;

gap:14px;

}

.palette button{

width:58px;

height:58px;

border:none;

border-radius:14px;

font-size:17px;

font-weight:bold;

cursor:pointer;

transition:.3s;

box-shadow:0 5px 12px rgba(0,0,0,.12);

}

.palette button:hover{

transform:translateY(-3px) scale(1.05);

}

.white{

background:#f3f4f6;

color:#333;

}

.red{

background:#ef4444;

color:white;

}

.blue{

background:#2563eb;

color:white;

box-shadow:0 0 18px rgba(37,99,235,.45);

}

.green{

background:#22c55e;

color:white;

}

.legend{

margin-top:30px;

padding-top:18px;

border-top:1px solid #e5e7eb;

font-size:15px;

}

.legend p{

display:flex;

align-items:center;

margin-bottom:14px;

font-weight:500;

}

.box{

width:18px;

height:18px;

border-radius:5px;

margin-right:12px;

display:inline-block;

}

/*=========================================
            FOOTER
==========================================*/

.bottom-footer{

background:#0f172a;

padding:22px;

text-align:center;

color:white;

margin-top:auto;

}

.bottom-footer h3{

font-size:18px;

margin:0;

}

.bottom-footer span{

color:#38bdf8;

}

.bottom-footer p{

margin-top:8px;

font-size:14px;

color:#cbd5e1;

}

</style>

</head>

<body>

<!--==================== HEADER ====================-->

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

<div class="container">

<!-- LEFT -->

<div class="left">

<div class="userCard">

<table>

<tr>

<td class="label">Student Name</td>

<td><%=name%></td>

<td class="label">Enrollment</td>

<td><%=enroll%></td>

</tr>

<tr>

<td class="label">Email</td>

<td><%=email%></td>

<td class="label">Department</td>

<td>

<b style="color:#3498db;">

<%=department%>

</b>

<tr>
<td class="label">Subject</td>
<td><%=subject%></td>
</tr>

</td>

</tr>

</table>

</div>

<div class="timer">

⏱ Time Left :

<span id="timer">

Loading...

</span>

</div>

<%

String msg=request.getParameter("msg");

if("attemptAll".equals(msg)){

%>

<div class="warning">

⚠ Please attempt all questions before submitting the examination.

</div>

<%

}

%>

<form id="quizForm" action="QuestionServlet" method="post">

<%

if(rs.next()){

%>

<div class="questionCard">

<div class="questionTitle">

Question <%=qIndex+1%> of 20

</div>

<div class="question">

<b>

<%=rs.getString("question")%>

</b>

</div>

<label class="option">

<input type="radio" name="answer" value="1"

<%=selected==1?"checked":""%>>

<%=rs.getString("option1")%>

</label>

<label class="option">

<input type="radio" name="answer" value="2"

<%=selected==2?"checked":""%>>

<%=rs.getString("option2")%>

</label>

<label class="option">

<input type="radio" name="answer" value="3"

<%=selected==3?"checked":""%>>

<%=rs.getString("option3")%>

</label>

<label class="option">

<input type="radio" name="answer" value="4"

<%=selected==4?"checked":""%>>

<%=rs.getString("option4")%>

</label>

<div class="buttons">

<% if(qIndex>0){ %>

<button class="btn prev"
type="submit"
name="action"
value="prev">

⬅ Previous

</button>

<% } %>

<% if(qIndex<19){ %>

<button class="btn next"
type="submit"
name="action"
value="next">

Next ➜

</button>

<% } %>

<button
type="button"
class="btn submit"
onclick="submitQuiz()">

Submit Exam

</button>

</div>

</div>

<%

}

%>

</form>

</div>

<!-- RIGHT -->

<div class="right">

<div class="paletteCard">

<div class="paletteTitle">

📝 Question Palette

</div>

<div class="palette">

<%
for(int i=0;i<20;i++){

String color="white";

if(status[i]==1)
color="red";

if(status[i]==2)
color="green";

if(i==qIndex)
color="blue";
%>

<form action="QuestionServlet"
method="post"
style="display:inline;">

<input
type="hidden"
name="jumpIndex"
value="<%=i%>">

<button
type="submit"
class="<%=color%>"
name="action"
value="jump">

<%=i+1%>

</button>

</form>

<%
}
%>

</div>

<div class="legend">

<p>

<span class="box"
style="background:#3498db;"></span>

Current Question

</p>

<p>

<span class="box"
style="background:#2ecc71;"></span>

Answered

</p>

<p>

<span class="box"
style="background:#e74c3c;"></span>

Visited

</p>

<p>

<span class="box"
style="background:#ecf0f1;border:1px solid #999;"></span>

Not Visited

</p>

</div>

</div>

</div>

</div>

<!-- TIMER -->


<%
Long start = (Long)session.getAttribute("startTime");

if(start == null){
    start = System.currentTimeMillis();
    session.setAttribute("startTime", start);
}

// 30 Minutes
long endTime = start + (30 * 60 * 1000);

// For testing 5 minutes:
// long endTime = start + (5 * 60 * 1000);
%>

<!-- TIMER -->

<script>

var endTime = <%=endTime%>;

function updateTimer(){

    var now = new Date().getTime();

    var remain = Math.floor((endTime - now) / 1000);

    if(remain <= 0){

        document.getElementById("timer").innerHTML = "00 Min 00 Sec";

        var form = document.getElementById("quizForm");

        var hidden = document.createElement("input");

        hidden.type = "hidden";
        hidden.name = "action";
        hidden.value = "submit";

        form.appendChild(hidden);

        form.submit();

        return;

    }

    var min = Math.floor(remain / 60);
    var sec = remain % 60;

    if(min < 10){
        min = "0" + min;
    }

    if(sec < 10){
        sec = "0" + sec;
    }

    document.getElementById("timer").innerHTML =
            min + " Min " + sec + " Sec";

}

updateTimer();

setInterval(updateTimer,1000);

</script>

<script>

function submitQuiz(){

var ans=document.querySelector(

'input[name="answer"]:checked'

);

if(ans==null){

alert("Please select an answer before submitting this question.");

return;

}

var form=document.getElementById("quizForm");

var input=document.createElement("input");

input.type="hidden";

input.name="action";

input.value="submit";

form.appendChild(input);

form.submit();

}

</script>

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

</body>

</html>

<%

rs.close();

ps.close();

con.close();

%>