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


For copy-and-paste


    <%
    try {
        AppDB db = new AppDB(); 
        Connection con = db.getConnection();


        con.close();
        
    } catch (Exception ex) { 
        out.print(ex);
    }
%>

</body>
</html>