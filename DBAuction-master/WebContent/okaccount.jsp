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
  <a href="search.jsp">Adv. Search</a>
  <a href="wish.jsp">Wishlist</a>
  <a href="index.jsp">Sign In/Up</a>
  <a href="account.jsp"> Settings</a>
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

try{
	AppDB app = new AppDB();
	Connection con = app.getConnection();
	
	Account act = new Account(con);
	
	String branch = request.getParameter("branch");
	if(branch == null) {
		out.print("You shouldn't be here");

	} else if(branch.equals("f1")){    //user details
		int userID = act.getUserID(accID);
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String phone = request.getParameter("phone");
		
		if(act.editUser(userID, name, address, phone)==0){
            out.print("User details updated.");
        } else {
            out.print("Failed to update user details.");
        }
		
	} else if(branch.equals("f2")){    //chg pword
		String pword = request.getParameter("pword");
		String pword2 = request.getParameter("pword2");
		if(act.editPword(accID, pword, pword2)==0){
			out.print("Password has been changed.");
		} else {
			out.print("Failed to change password.");
		}
		
	} else if(branch.equals("f3")){    //new acc
		String uname = request.getParameter("username");
		String pword = request.getParameter("pword");
        String pword2 = request.getParameter("pword2");
        int userID = act.getUserID(accID);
        if(userID > 0 && act.createNewAcc(userID, uname, pword, pword2) ==0){
        	out.print("New account created.");
        } else {
        	out.print("Failed to create new account.");
        }
        
		
	} else if(branch.equals("f4")){    //del acc
		if(act.remAccount(accID)==0){
			out.print("Successfully deleted account.");
			Check.logout(response);
        } else {
            out.print("Failed to delete account.");
        }
		
	
	} else if(branch.equals("f5")) {   //del user
		int userID = act.getUserID(accID);
		if(userID > 0 && act.remUser(userID, accID)==0){
			out.print("Successfully deleted user.");
			Check.logout(response);
		} else {
			out.print("Failed to delete user.");
		}
	}
		
    con.close();
} catch (Exception ex) { 
    out.print(ex);
}
%>

</body>
</html>