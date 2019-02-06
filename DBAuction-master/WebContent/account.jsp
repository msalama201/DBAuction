
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="pack.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>BA - Settings</title>
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
    %>


<%
List<String> ls = null;
try{
    AppDB app = new AppDB();
    Connection con = app.getConnection();
    
    Account act = new Account(con);
    int userID = act.getUserID(accID);
    System.out.println("uid:"+userID);
    ls = act.getUserDetail(userID);
    con.close();
} catch (Exception ex) { 
    out.print(ex);
}
%>


<h2>Edit User Details</h2>
<form name="frmUser" method="POST" action="okaccount.jsp">
<%String fname = ls.get(0), faddr = ls.get(1), fphone = ls.get(2); %>
  <table>
    <tbody>
        <tr>
            <td>Full Name: </td>
            <td><input type="text" name="name" value="<%=fname%>"/></td>
        </tr>
        <tr>
            <td>Address: </td>
            <td><input type="text" name="address" value="<%=faddr%>"/></td>
        </tr>
        <tr>
            <td>Phone: </td>
            <td><input type="text" name="phone" value="<%=fphone%>"/></td>
            
        </tr>
    </tbody>
  </table>
  <input type="hidden" name="branch" value="f1"/>
    <input type="submit" value="Edit"/>
</form>


<h2>Change Password</h2>
<form name="frmPword" method="POST" action="okaccount.jsp">
  <table>
    <tbody>
        <tr>
            <td>New Password: </td>
            <td><input type="text" name="pword" required/></td>
        </tr>
        <tr>
            <td>Re-type Password: </td>
            <td><input type="text" name="pword2" required/></td>
            
        </tr>
    </tbody>
  </table>
  <input type="hidden" name="branch" value="f2"/>
    <input type="submit" value="Edit"/>
</form>


<h2>Create new Account Under the Same User</h2>
<form name="frmPword" method="POST" action="okaccount.jsp">
  <table>
    <tbody>
        <tr>
            <td>Username: </td>
            <td><input type="text" name="username" required/></td>
        </tr>
        <tr>
            <td>Password: </td>
            <td><input type="password" name="pword" required/></td>
        </tr>
        <tr>
            <td>Re-type Password: </td>
            <td><input type="password" name="pword2" required/></td>
        </tr>
    </tbody>
  </table>
  <input type="hidden" name="branch" value="f3"/>
    <input type="submit" value="Create"/>
</form>


<h2>Delete Account</h2>
<form method="POST" action="okaccount.jsp">
  <table>
    <tbody>
        <tr>
            <td>Delete current account: </td>
            <td><input type="hidden" name="branch" value="f4"/></td>
        </tr>
    </tbody>
  </table>
    <input type="submit" value="Delete"/>
</form>


<h2>Delete User</h2>
<form method="POST" action="okaccount.jsp">
  <table>
    <tr>
       <td>Deleting user will delete all accounts: </td>
       <td><input type="hidden" name="branch" value="f5"/></td>
    </tr>
  </table>
    <input type="submit" value="Delete"/>
</form>

  <% }  %>  <!-- Close if else check for accID -->

</body>
</html>