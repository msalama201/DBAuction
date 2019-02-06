<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="pack.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>Book Auction</title>
</head>

<body>
<h1>Book Auction</h1>

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



<% if (session.getAttribute("user") == null) { 
    		response.sendRedirect("login2.jsp");
       } else { %>
<%--     	<%@ include file="search.jsp?"%> --%>
    <div class="content">
    	<h1>Hello, <%=session.getAttribute("user")%></h1>
    <%
    try {
        AppDB db = new AppDB(); 
        Connection con = db.getConnection();
        
        PreparedStatement auctionPs = null;
		PreparedStatement accountPs = null;
		PreparedStatement emailPs = null;
		ResultSet auctionRs = null;
		ResultSet accountRs = null;
		ResultSet emailRs = null;
        
        Locale locale = new Locale("en", "US");
		NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
		String user = (session.getAttribute("user")).toString();
		
		String emailQuery = "SELECT * FROM Email WHERE accID=?";//ada buang bool
		String accountQuery = "SELECT * FROM Account WHERE username=?";
		String auctionQuery = "SELECT * FROM AuctionT WHERE accID=?";
		
		
		accountPs = con.prepareStatement(accountQuery);
		accountPs.setString(1, user);
		accountRs = accountPs.executeQuery();
		int accID = 0;
		if(accountRs.next())
		{
			accID = accountRs.getInt(1);
		}
		// Display admin commands if access level is 3 ada somethin delete sini check ori
		
		
		emailPs = con.prepareStatement(emailQuery);
		emailPs.setInt(1, accID);
		emailRs = emailPs.executeQuery();
		if (emailRs.next()) { %>
			<h2>Your E-mails</h2>
			<table>
				<tr>
					<th>Mails</th>
				</tr>
		<%	do { %>
				<tr>
					<td>
						<%= emailRs.getString("content") %>
						
					</td>
				</tr>
		<%	} while (emailRs.next()); %>
			</table>
	<%	}   		
		
		
		
		
		auctionPs = con.prepareStatement(auctionQuery);
		auctionPs.setInt(1, accID);
		auctionRs = auctionPs.executeQuery();
		
			//ada delete somthing gak asscces level 
			if (auctionRs.next()) { 
		%>
			<h2>Your created book auctions:</h2>
			<table>
				<tr>
					<th>Item</th>
					<th>Current Bid</th>
					<th>End Date/Time</th>
				</tr>
			<%	do { %>
					<tr>
					<td> 
						<a href="auction.jsp?productId=<%= auctionRs.getInt("auctionID") %>">
						</a>
					</td>
					<td><%= currency.format(auctionRs.getDouble("min_sell")) %></td>
					<td><%= auctionRs.getString("end_date") %></td>
				</tr> 			
			<%	} while (auctionRs.next()); %>
				</table>
		<%	} else { %>
				<h2>You have not posted any auctions.</h2>
		<%	}
			
			auctionRs.close();
			auctionPs.close();
			accountRs.close();
			accountPs.close();
			emailRs.close();
			emailPs.close();
			con.close();
        } 
    catch (Exception ex) {
        out.print(ex);
    }
    %>
    </div>
    <% 
    } %>
</body>
</html>