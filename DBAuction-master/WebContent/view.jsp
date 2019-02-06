
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

<!-- View each auction item -->
    <%
    Item item = null;
    List<QnA> qnas = null;
    int id = 0;
    try {
        AppDB db = new AppDB(); 
        Connection con = db.getConnection();
        
        String sid = request.getParameter("id");
        String search = request.getParameter("s");
        
        View view = new View(con);        
        item = view.getItem(sid);
        id = view.id;
        qnas = view.getQnA(search);
        //bid button link to suhail's works

        //Close the connection
        con.close();
        
    } catch (Exception ex) {    
        out.print(ex);
    }
%>

<%if(item != null){ %>


<h2> Book Details: </h2>
<form method="GET" action="#" > <!-- Suhail's -->
<!--    action=#?id=<....%request.getParameter("id");%....>> -->
    <button type="submit">BID NOW</button>
</form>
<table class="meh">
  <tr>
    <th></th>
    <th>Details</th> 
  </tr>
  <%if(item != null){ %>
  <tr>
    <td>Title:</td>
    <td><%out.print(item.title); %></td>
  </tr>
  <tr>
    <td>Author:</td>
    <td><%out.print(item.author); %></td>
  </tr>
  <tr>
    <td>Publisher:</td>
    <td><%out.print(item.publisher); %></td>
  </tr>
  <tr>
    <td>ISBN:</td>
    <td><%out.print(item.isbn); %></td>
  </tr>
  <tr>
    <td>Genre:</td>
    <td><%out.print(item.getGenre()); %></td>
  </tr>
  <tr>
    <td>Award:</td>
    <td><%out.print(item.getAward()); %></td>
  </tr>
  <% } %>
</table>


<h2> Auction Details: </h2>
<%if(item != null){ %>
<table class="meh">
  <tr>
    <th></th>
    <th>Details</th> 
  </tr>
  <tr>
    <td>Username:</td>
    <td><% out.print(item.seller); %></td>
  </tr>
  <tr>
    <td>Bid:</td>
    <td>$ <%out.print(item.getBid()); %></td>
  </tr>
  <tr>
    <td>Start Date:</td>
    <td><%out.print(item.getStartDate()); %></td>
  </tr>
  <tr>
    <td>End Date:</td>
    <td><%out.print(item.getEndDate()); %></td>
  </tr>
  <% }  %>
</table>


<br><br>
<form name="ask" method="GET" action="ok/view.jsp?id=<%=id%>">
    Search Question: <br>
    <input type="text" name="s" value="">
    <input type="submit" value="Search">
    <input type="reset">
</form>

<br>
<h2>View/Post Questions</h2>
<table class="qna">
  <%
  if(qnas != null && qnas.size() > 0){
      for(QnA qna : qnas){ %>
  <tr>
    <td> User: <% out.print(qna.name); %> </td>
    <td> <% out.print(qna.question); %> </td>
    <td> <% out.print(qna.getqTime()); %> </td>
    
    <% if(accID == qna.accID){ %>  
    <td> 
        <form method="GET" action="view_editQ.jsp">
            <input type="hidden" name=x value=a>
            <input type="hidden" name=qid value=<%=qna.qID%>>
            <input type="submit" value="Delete">
        </form>
        <form method="GET" action="view_editQ.jsp">
            <input type="hidden" name=x value=b>
            <input type="hidden" name=qid value=<%=qna.qID%>>
            <input type="submit" value="Edit">
        </form> 
    </td>
    <%} %>
  </tr>
  
  <tr>
    <% if(qna.answer != null && qna.answer.length()>0){%>
    <td> Seller: </td>
    <td> <% out.print(qna.answer); %> </td>
    <td> <% out.print(qna.getaTime()); %> </td>
    <% if(accID == item.accID){ %>  
    <td> 
        <form method="GET" action="view_editQ.jsp">
            <input type="hidden" name=x value=c>
            <input type="hidden" name=qid value=<%=qna.qID%>>
            <input type="submit" value="Delete">
        </form>
        <form method="GET" action="view_editQ.jsp">
            <input type="hidden" name=x value=d>
            <input type="hidden" name=qid value=<%=qna.qID%>>
            <input type="submit" value="Edit">
        </form> 
    </td>
    <%} %>
    <% } else { %>
    <td colspan="3"> <i>No reply yet.</i> </td>
    <td> 
        <form method="GET" action="view_editQ.jsp">
            <input type="hidden" name=x value=d>
            <input type="hidden" name=qid value=<%=qna.qID%>>
            <input type="submit" value="Reply">
        </form>
    </td>
    <% } %>    
  </tr>
  <%
      }
  } else {
    out.print("No question");  
  }
  %>
  
</table>

<br><br>
<form id="ask" method="POST" action="view.jsp?id=<%=id%>">
    Post Question Here: <br>
    <textarea name="q" form="ask" rows="4" cols="50"> </textarea>
    <input type="submit" value="Post">
    <input type="reset">

</form>


<%} else {%>            <!-- auctionID does not exist -->
<b>Item not found.</b><br>
<a href="search.jsp">View all</a>

<%}%>


</body>
</html>