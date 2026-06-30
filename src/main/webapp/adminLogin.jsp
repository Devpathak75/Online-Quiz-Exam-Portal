<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>

<!DOCTYPE html>
<html>
<head>

<title>Admin Login</title>

<style>

body{
margin:0;
padding:0;
font-family:Segoe UI;
background:linear-gradient(135deg,#4e54c8,#8f94fb);
display:flex;
justify-content:center;
align-items:center;
height:100vh;
}

.box{

width:380px;
background:white;
padding:30px;
border-radius:15px;
box-shadow:0 10px 25px rgba(0,0,0,.3);

}

h2{

text-align:center;
margin-bottom:25px;
color:#2c3e50;

}

input{

width:100%;
padding:12px;
margin-top:10px;
margin-bottom:20px;
border-radius:8px;
border:1px solid #ccc;
font-size:15px;

}

button{

width:100%;
padding:12px;
border:none;
border-radius:8px;
background:#3498db;
color:white;
font-size:16px;
cursor:pointer;

}

button:hover{

background:#2980b9;

}

.error{

background:#ffebee;
color:red;
padding:10px;
border-radius:8px;
margin-bottom:15px;
text-align:center;

}

.back{

margin-top:15px;
text-align:center;

}

.back a{

text-decoration:none;
color:#3498db;
font-weight:bold;

}

</style>

</head>

<body>

<div class="box">

<h2>🔐 Admin Login</h2>

<%

if(request.getParameter("error")!=null){

%>

<div class="error">

Invalid Username or Password

</div>

<%

}

%>

<form action="../AdminLoginServlet" method="post">

<input
type="text"
name="username"
placeholder="Enter Username"
required>

<input
type="password"
name="password"
placeholder="Enter Password"
required>

<button type="submit">

Login

</button>

</form>

<div class="back">

<a href="../index.jsp">

← Back to Student Login

</a>

</div>

</div>

</body>
</html>