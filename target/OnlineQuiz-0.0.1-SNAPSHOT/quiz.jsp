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
font-family:'Segoe UI',sans-serif;

}

body{

background:#eef2f7;

}

/*================ HEADER ================*/

.header{

background:#1f3b64;
color:white;
padding:20px;
text-align:center;

}

.header h1{

font-size:30px;

}

.header h3{

margin-top:8px;
font-weight:normal;

}

/*================ MAIN ================*/

.container{

width:95%;
margin:20px auto;
display:flex;
gap:20px;

}

/*================ LEFT ================*/

.left{

width:72%;

}

/*================ USER CARD ================*/

.userCard{

background:white;
padding:18px;
border-radius:12px;
box-shadow:0 5px 15px rgba(0,0,0,.15);
margin-bottom:18px;

}

.userCard table{

width:100%;

}

.userCard td{

padding:8px;

}

.label{

font-weight:bold;
color:#1f3b64;

}

/*================ TIMER ================*/

.timer{

background:#2c3e50;
color:#00ffcc;
padding:15px;
font-size:22px;
font-weight:bold;
text-align:center;
border-radius:10px;
margin-bottom:20px;

}

/*================ WARNING ================*/

.warning{

background:#fdecea;
color:#d63031;
padding:12px;
border-radius:8px;
margin-bottom:15px;
font-weight:bold;

}

/*================ QUESTION CARD ================*/

.questionCard{

background:white;
padding:30px;
border-radius:12px;
box-shadow:0 5px 15px rgba(0,0,0,.15);

}

.questionTitle{

font-size:24px;
color:#1f3b64;
margin-bottom:20px;

}

.question{

font-size:20px;
margin-bottom:25px;

}

/*================ OPTIONS ================*/

.option{

display:block;
background:#f4f6f8;
padding:15px;
margin-bottom:15px;
border-radius:10px;
cursor:pointer;
font-size:17px;
transition:.3s;

}

.option:hover{

background:#dfe6e9;

}

.option input{

margin-right:12px;

}

/*================ BUTTONS ================*/

.buttons{

margin-top:25px;

}

.btn{

padding:12px 22px;
border:none;
border-radius:8px;
cursor:pointer;
color:white;
font-size:15px;
margin-right:10px;

}

.prev{

background:#f39c12;

}

.next{

background:#3498db;

}

.submit{

background:#27ae60;

}

/*================ RIGHT PANEL ================*/

.right{

width:28%;

}

.paletteCard{

background:white;
padding:20px;
border-radius:12px;
box-shadow:0 5px 15px rgba(0,0,0,.15);

}

.paletteTitle{

text-align:center;
font-size:22px;
font-weight:bold;
margin-bottom:20px;
color:#1f3b64;

}

.palette{

display:grid;
grid-template-columns:repeat(5,60px);
justify-content:center;
gap:15px;

}

.palette button{

width:60px;
height:60px;
font-size:18px;
font-weight:bold;
border:none;
border-radius:10px;
cursor:pointer;
transition:.3s;

}

.white{

background:#ecf0f1;

}

.red{

background:#e74c3c;
color:white;

}

.green{

background:#2ecc71;
color:white;

}

.blue{

background:#3498db;
color:white;

}

/*================ LEGEND ================*/

.legend{

margin-top:20px;
font-size:15px;

}

.legend p{

margin-bottom:10px;

}

.box{

display:inline-block;
width:15px;
height:15px;
margin-right:8px;
border-radius:3px;

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

Question Palette

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

<script>

if(localStorage.getItem("endTime")==null){

localStorage.setItem(

"endTime",

new Date().getTime()+1800000

);

}

var endTime=localStorage.getItem("endTime");

function updateTimer(){

var now=new Date().getTime();

var remain=Math.floor((endTime-now)/1000);

if(remain<=0){

localStorage.removeItem("endTime");

var form=document.getElementById("quizForm");

var hidden=document.createElement("input");

hidden.type="hidden";

hidden.name="action";

hidden.value="submit";

form.appendChild(hidden);

form.submit();

return;

}

var min=Math.floor(remain/60);

var sec=remain%60;

document.getElementById("timer").innerHTML=

min+" Min "+sec+" Sec";

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

</body>

</html>

<%

rs.close();

ps.close();

con.close();

%>