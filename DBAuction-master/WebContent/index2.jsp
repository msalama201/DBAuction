<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="pack.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>Book Auction</title>
</head>
<body>

<div class="topnav">
  <a href="index.jsp">Home</a>
  <a href="#suhail">Sell</a>
  <a href="search.jsp">Advanced Search</a>
  <form method="GET" action="search.jsp">
  <input type="text" name="t" placeholder="Search Book">
  </form>
  
</div>

<h1> Book Auction</h1>

<!-- Login -->
<h2>Login:</h2>
<form name="frmLogin" method="POST" action="login2.jsp">
<table>
    <tbody>

        <tr>
            <td>Username: </td>
            <td><input type="text" name="username" required/></td>
        </tr>
        <tr>
            <td>Password: </td>
            <td><input type="password" name="password" required/></td>
        </tr>

    </tbody>
</table>
    <input type="submit" name="Login" value="Login"/>
</form>
<br></br>

<!-- Register -->
<h2>Register:</h2>
<form name="frmRegister" method="POST" action="register.jsp">
<table>
    <tbody>

        <tr>
            <td>Name: </td>
            <td><input type="text" name="new_name" required/></td>
        </tr>	
        <tr>
            <td>Email: </td>
            <td><input type="email" name="new_email" required/></td>
        </tr>
        <tr>
            <td>Username:  (for login)</td>
            <td><input type="text" name="new_username" required/></td>
        </tr>
        <tr>
            <td>Password: </td>
            <td><input type="password" name="new_password" required/></td>
        </tr>
        <tr>
            <td>Retype Password: </td>
            <td><input type="password" name="new_password2" required/></td>
        </tr>
		
    
    </tbody>
</table>
    <input type="submit" name="Register" value="Register"/>
</form>

</body>
</html>