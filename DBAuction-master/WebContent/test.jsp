<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="pack.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Book Auction - Test</title>
    

</head>

<body>
    
 
    
    <%  
    int id = 45;
    Cookie kuihID = new Cookie("accID", Integer.toString(id));
    //kuihID.setMaxAge(60*60*5); non persistent no need to delete
    response.addCookie(kuihID);
    %>
Read Cookie Test<br>

    <%
    Cookie kuih[] = request.getCookies();
    if(kuih==null)System.out.println("null weyh");
    
    for(int i=0;i<kuih.length;i++){  
    	 out.print("<br>"+kuih[i].getName()+" "+kuih[i].getValue());  
    	} 
    
    %>
    
    
    <%
    //use this to delete cookie
    Cookie kuihID2 =new Cookie("accID","");
    kuihID2.setMaxAge(0);  
    response.addCookie(kuihID2);  
    %>

</body>
</html>