<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="pack.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>BA - Wishlist</title>
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

<h1> Book Auction</h1>
<!-- Copied from search.jsp -->
<!-- Read cookie -->

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
    
    if(accID == 0){ %>
    
    <a href="index.jsp">  Please login first before using this page. </a>
    	
   <% } else {  %>
   
   
 <h2>Create New Wishlist:</h2>
Leave field empty if it is not applicable.
<form name="makeWish" method="GET" action="okwish.jsp">
    <input type="submit" value="Track">
    <input type="reset" value="Reset">
    <input type="hidden" name="branch" value="add">
    <table>
    <tbody>
        <tr><td>Title: </td>
            <td><input type="text" name="t" value=""></td>
        </tr>
        <tr><td>ISBN: </td>
            <td><input type="text" name="i" value=""></td>
        </tr>
        <tr><td>Author: </td>
            <td><input type="text" name="a" value=""></td>
        </tr>
        <tr><td>Publisher: </td>
            <td><input type="text" name="p" value=""></td>
        </tr>
        <tr><td>Min Bid: </td>
            <td><input type="text" name="b1" min="0"></td>
        </tr>
        <tr><td>Max Bid: </td>
            <td><input type="text" name="b2" min="0"></td>
        </tr>
        <tr><td>Award Title: </td>
            <td><input type="text" name="w" value=""></td>
        </tr>
    </tbody>
    </table>
</form>

    <%
    Wish wish = null;
    List<WishObj> wishlist = null;
    try {
        AppDB db = new AppDB(); 
        Connection con = db.getConnection();
        System.out.println("YAY 100%");

        wish = new Wish(con);       
        wishlist = wish.listWish(accID);
        
        con.close();
    } catch (Exception ex) { 
        out.print(ex);
    }
%>
<br>

<h2> Currently tracking: </h2>
<table>
    <%if(wishlist.isEmpty()){ 
        out.print("No wishlist");
     } else { %>
     
         
   <tr>
    <th>Title</th>
    <th>ISBN</th>
    <th>Author</th>
    <th>Publisher</th>
    <th>Min Bid</th>
    <th>Max Bid</th>
    <th>Award Title</th>
  </tr>
  <%
    for(WishObj w : wishlist){ 
        if(w == null) continue;%>
  <tr>
    <td> <% out.print(w.title); %> </td>
    <td> <% out.print(w.isbn); %> </td>
    <td> <% out.print(w.author); %> </td>
    <td> <% out.print(w.publisher); %> </td>
    <td> $<% if(w.minBid > 0) out.print(w.minBid); %> </td>
    <td> $<% if(w.maxBid > 0) out.print(w.maxBid); %> </td>
    <td> <% out.print(w.award); %> </td>
    <td> 
        <form method="POST" action="okwish.jsp">
            <%int id = w.wID; %>
            <input type="hidden" name="branch" value="del">
            <input type="hidden" name="wid" value="<%=id%>">
            <input type="submit" value="Delete">
        </form>
    </td>
  </tr>

     <% }
  }
    %>
</table>  
     	
  <% }  %>  <!-- Close if else check for accID -->


</body>
</html>