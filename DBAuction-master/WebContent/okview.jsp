<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="pack.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>BA - View</title>
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

<h1> Book Auction</h1>

    <%
    int accID = 0;
    String username = "";
    Cookie kuih[] = request.getCookies();
    for(int i=0;i<kuih.length;i++){  
        if(kuih[i].getName().equals("accID")){
            accID = Integer.parseInt(kuih[i].getValue());
        }
        if(kuih[i].getName().equals("username")){
            username = kuih[i].getValue();
        }
    }  
    %>

<!-- Submit question for view.jsp -->
    <%
    int id = 0;
    try {
        AppDB db = new AppDB(); 
        Connection con = db.getConnection();
        
        String sid = request.getParameter("id");
        String ask = request.getParameter("q");
        
        View view = new View(con);        
        view.getItem(sid);
        id = view.id;
        if(ask != null) view.askQnA(ask, accID);

        //Close the connection
        con.close();
        
    } catch (Exception ex) {    
        out.print(ex);
    }
%>


</body>
</html>