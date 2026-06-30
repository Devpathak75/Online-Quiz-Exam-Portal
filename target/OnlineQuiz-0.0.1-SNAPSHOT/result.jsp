<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>
<%@ page import="com.quiz.dao.DBConnection"%>
<%@ page import="com.quiz.util.MailSender"%>

<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

//===================== SESSION =====================

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

//===================== SCORE =====================

Connection con=DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
"SELECT correct FROM questions WHERE department=? ORDER BY id"
);

ps.setString(1, department);

ResultSet rs=ps.executeQuery();

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

//===================== TIME =====================

long endTime=System.currentTimeMillis();

long totalSeconds=(endTime-startTime)/1000;

long minutes=totalSeconds/60;

long seconds=totalSeconds%60;

//===================== RESULT =====================

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

//===================== SAVE =====================

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

//===================== EMAIL =====================

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

}
catch(Exception e){

System.out.println(e);

}
%>

<html>

<head>

<title>Online Quiz Result</title>

<style>

*{

margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;

}

body{

background:linear-gradient(135deg,#4e54c8,#8f94fb);
padding:40px;

}

.container{

width:900px;
margin:auto;
background:white;
border-radius:18px;
overflow:hidden;
box-shadow:0 12px 35px rgba(0,0,0,.35);

}

.header{

background:#1f3b64;
padding:25px;
text-align:center;
color:white;

}

.header h1{

font-size:32px;

}

.header h3{

margin-top:8px;
font-weight:normal;

}

.resultTitle{

background:#3498db;
color:white;
text-align:center;
padding:18px;
font-size:28px;
font-weight:bold;

}

.generated{

text-align:center;
padding:20px;
background:#f4f6f8;
line-height:30px;
border-bottom:1px solid #ddd;

}

.generated h2{

color:#2c3e50;

}

.generated h3{

font-weight:normal;
color:#666;

}

.main{

padding:35px;

}

.infoTable{

width:100%;
border-collapse:collapse;
margin-bottom:25px;

}

.infoTable td{

padding:14px;
border:1px solid #ddd;
font-size:17px;

}

.label{

background:#f4f6f8;
font-weight:bold;
width:280px;

}

.scoreCard{

display:flex;
justify-content:space-around;
margin-top:35px;
margin-bottom:35px;
flex-wrap:wrap;

}

.card{

width:180px;
background:#3498db;
color:white;
padding:20px;
border-radius:12px;
text-align:center;
margin:10px;

}

.card h2{

font-size:40px;

}

.card p{

margin-top:10px;
font-size:18px;

}

.resultBox{

text-align:center;
padding:20px;
margin-top:20px;
border-radius:10px;
font-size:26px;
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

.progress{

width:100%;
height:25px;
background:#ddd;
border-radius:20px;
overflow:hidden;
margin-top:25px;

}

.bar{

height:100%;
background:#3498db;

}

.buttons{

margin-top:35px;
display:flex;
justify-content:center;
gap:15px;
flex-wrap:wrap;

}

.btn{

padding:12px 25px;
border-radius:8px;
text-decoration:none;
color:white;
font-weight:bold;

}

.login{

background:#3498db;

}

.print{

background:#27ae60;

}

.footer{

padding:25px;
background:#f4f6f8;
text-align:center;
color:#555;

}

</style>

</head>

<body>

<div class="container">

<div class="header">

<h1>

DEVS INSTITUTE OF TECHNOLOGY AND ENGINEERING

</h1>

<h3>

ONLINE QUIZ EXAMINATION SYSTEM

</h3>

</div>

<div class="resultTitle">

🎉 EXAM COMPLETED

</div>

<div class="generated">

<h2>

DEVS INSTITUTE OF TECHNOLOGY AND ENGINEERING

</h2>

<h3>

Online Quiz Examination System

</h3>

<b>

Generated On :

<%=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date())%>

</b>

</div>

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

<div class="scoreCard">

<div class="card">

<h2>

<%=score%>

</h2>

<p>

Score

</p>

</div>

<div class="card">

<h2>

<%=String.format("%.2f",percentage)%>%

</h2>

<p>

Percentage

</p>

</div>

<div class="card">

<h2>

<%=grade%>

</h2>

<p>

Grade

</p>

</div>

<div class="card">

<h2>

<%=total%>

</h2>

<p>

Total Questions

</p>

</div>

</div>

<div class="progress">

<div class="bar"

style="width:<%=percentage%>%">

</div>

</div>

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

<div class="buttons">

<a
href="#"
class="btn print"
onclick="window.print();return false;">

🖨 Print Result

</a>

<a
href="index.jsp"
class="btn login">

🏠 Back To Login

</a>

</div>

</div>

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

All rights reserved © 2026

</p>

</div>

</div>

<script>

localStorage.removeItem("endTime");

window.history.forward();

function noBack(){

window.history.forward();

}

</script>

<%

rs.close();

ps.close();

save.close();

con.close();

session.invalidate();

%>

</body>

</html>