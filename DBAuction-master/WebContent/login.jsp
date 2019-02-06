
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="pack.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>BA - Login</title>
</head>

<body>

<div class="topnav">
  <a href="home.jsp">Home</a>
  <a href="#suhail">Sell</a>
  <a href="wish.jsp">Wishlist</a>
  <a href="index.jsp">Sign In/Up</a>
  <a href="account.jsp"> Settings</a>
  <a href="logout.jsp">Logout</a>
  <form method="GET" action="search.jsp">
  <input type="text" name="t" placeholder="Search Book...">
  </form>
  
</div>
<!-- Make non-persistent cookie after successful login -->
<h1> Book Auction </h1>
<h2>Login:</h2>

    <%
    try {
        AppDB db = new AppDB(); 
        Connection con = db.getConnection();
        
        //Get parameters from the HTML form at the index.jsp
        String username = request.getParameter("username");
        String pword = request.getParameter("password");
        
        RegLogin log = new RegLogin(con);
        int id = log.tryLogin(username, pword);
        if(id == -1){
        	out.println("Login failed: "+log.error);
        } else{
        	out.print("Login successful");
        	Cookie kuih = new Cookie("accID", Integer.toString(id));
        	kuih.setMaxAge(60*60);
        	response.addCookie(kuih);
        	kuih = new Cookie("username", username);
            response.addCookie(kuih);
            kuih.setMaxAge(60*60);
        }

        con.close();
        
    } catch (Exception ex) {
        out.print(ex);
    }
%>

</body>
</html>