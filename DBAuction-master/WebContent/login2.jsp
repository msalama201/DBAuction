<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="pack.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Book Auction - Login</title>
</head>

<body>
<h1 style="color: #5e9ca0;"> <a href="index.jsp">X</a> Book Auction</h1>
<h2 style="color: #2e6c80;">Login:</h2>

<!-- hooray for clean code -->
    <%
    try {
        AppDB db = new AppDB(); 
        Connection con = db.getConnection();
        
        //Get parameters from the HTML form at the index.jsp
        String username = request.getParameter("username");
        String pword = request.getParameter("password");
        
        RegLogin log = new RegLogin(con);
        int err = log.tryLogin(username, pword);
        if(err == -1){
        	out.println("Login failed: "+log.error);
        } else{
        	out.print("Login successful");
        	session.setAttribute("user", username);
        	response.sendRedirect("home.jsp");
        }

        con.close();
        
    } catch (Exception ex) {
        out.print(ex);
    }
%>

</body>
</html>