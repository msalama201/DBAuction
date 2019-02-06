
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="pack.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>BA - Edit Question</title>
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
    
     <%
    int id = 0;
     View view = null;
    try {
        AppDB db = new AppDB(); 
        Connection con = db.getConnection();
        view = new View(con);
        String sss = request.getParameter("x");
        String yy = request.getParameter("y");
        char x = '0';
        if(sss != null) x = sss.charAt(0);
        int qID = Integer.parseInt(request.getParameter("qid"));
        String edit = request.getParameter("edit");
        
        if(x == 'a'){
        	int err = view.remQuestion(qID);
        	if(err == 0){
                out.print("Your question has been deleted.");
            }
        } else if(x == 'b'){    %>
        	
        	<form action="view_editQ.jsp">
        	   <input type="hidden" name=qid value=<%=qID%>>
        	   <input type="hidden" name=y value=1>
        	   <textarea name="edit" rows="5" cols="50" 
        	           placeholder="Re-type question here..."></textarea>
        	   <input type="submit" value="Edit">
        	</form>
        	
     <% } else if(x == 'c'){
    	   int err = view.remReply(qID);
    	   if(err == 0){
    		    out.print("Your reply has been deleted.");
    	   }
    	  
    	} else if(x == 'd'){     %>
    	 
    		<form action="view_editQ.jsp">
            <input type="hidden" name=qid value=<%=qID%>>
            <input type="hidden" name=y value=2>
            <textarea name="edit" rows="5" cols="50" 
                    placeholder="(Re)type reply here..."></textarea>
            <input type="submit" value="Reply">
         </form>    		
    		
    <%  } else if(edit != null && edit.length()>0 && yy.equals("1")){
        	
            int err = view.editQuestion(qID, edit);
            if(err == 0){
            	out.print("Your question has been edited.");
            }
        } else if(edit != null && edit.length()>0 && yy.equals("2")){
            
            int err = view.reply(qID, edit);
            if(err == 0){
                out.print("Your question has been edited.");
            }
        } else {
        	out.print("What are you doing here?");
        }

        //Close the connection
        con.close();
        
    } catch (Exception ex) {    
        out.print(ex);
    }
%>


</body>
</html>