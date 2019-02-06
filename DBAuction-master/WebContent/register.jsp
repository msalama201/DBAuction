<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="pack.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>BA - Register</title>
</head>

<body>

<div class="topnav">
  <a href="home.jsp">Home</a>
  <a href="#suhail">Sell</a>
  <a href="search.jsp">Adv. Search</a>
  <a href="wish.jsp">Wishlist</a>
  <a href="index.jsp">Sign In/Up</a>
  <a href="logout.jsp">Logout</a>
  <form method="GET" action="search.jsp">
  <input type="text" name="t" placeholder="Search Book">
  </form>
  
</div>

<h1> Book Auction </h1>
<h2>Register:</h2>
<!-- Report status of registration  -->

    <%
    try {
        AppDB db = new AppDB(); 
        Connection con = db.getConnection();

        //Get parameters from the HTML form at the index.jsp
		String newName = request.getParameter("new_name");
		String newEmail = request.getParameter("new_email");		
        String newUsername = request.getParameter("new_username");
        String newPword = request.getParameter("new_password");
		String newPword2 = request.getParameter("new_password2"); 
	    
		RegLogin reg = new RegLogin(con);
		int status = reg.insertGeneral(newName, newEmail, newUsername,
				newPword, newPword2);
		
		if(status < 0){
			out.print("Registration failed: "+reg.error);
		} else {
			out.print("Registration complete");
		}


        //Close the connection
        con.close();
        
    } catch (Exception ex) {
        out.print(ex);
        out.print("\nRegistration failed (General)");
    }
%>

</body>
</html>