<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="pack.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>Book Auction - Wishlist</title>
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
<!-- Submit new wish from wish.jsp -->

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
    	
   <% } else {  
	   
    Wish wish = null;
    List<WishObj> wishlist = null;
    try {
        AppDB db = new AppDB(); 
        Connection con = db.getConnection();
        wish = new Wish(con);
        
        //copied over from search.jsp
        System.out.println("YAY 100%");
        
        String branch = request.getParameter("branch");
        if(branch.equals("add")){
        	
        	String title = request.getParameter("t");        
            String isbn = request.getParameter("i");
            String author = request.getParameter("a");
            String publisher = request.getParameter("p");
            String award = request.getParameter("w");
            
            int minBid = 0, maxBid = 0;
            try{
                String tmp = request.getParameter("b1");
                System.out.println("b1: "+tmp);
                if(Check.isNum(tmp)) minBid = Integer.parseInt(tmp);
                tmp = request.getParameter("b2");
                System.out.println("b2: "+tmp);
                if(Check.isNum(tmp)) maxBid = Integer.parseInt(tmp);
                
            }catch(NumberFormatException e){
                System.out.println("huh");
                e.printStackTrace();
            }

            wish.addWish(accID, title, author, publisher, award, isbn,
                   minBid, maxBid);
                 
            if(wish.err == 0){  
                out.print("Added to wishlist.");
            } else {
                out.print("Failed to add to wishlist.");
            }
        	
        } else if(branch.equals("del")){
        	String sid = request.getParameter("wid");
            int wid = Integer.parseInt(sid);
            wish.remWish(wid);
            if(wish.err < 0){
            	out.print("Failed to delete wishlist.");
            } else {
            	out.print("Wishlist deleted.");
            }
            
        } else {
        	out.print("Nothing to see here.");
        }
        
        

       con.close();
        
    } catch (Exception ex) { 
        out.print(ex);
    }
}  %>  <!-- Close if else check for accID -->


</body>
</html>