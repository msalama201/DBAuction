<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="pack.*, pack.sort.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/search.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script>
    function chk1Only(flag, val, click){
        var x = document.getElementsByClassName(val);
        if(x[0].checked == true && x[1].checked == true){
            x[0].checked = false;
            x[1].checked = false;
            x[click].checked = true;
        }
    }
    function remAward(){
        document.getElementById('award').value='';
    }
    function addAward(){
        var x = document.getElementsByClassName('award');
        x[0].checked = true;
        x[1].checked = false;
    }
    function nonfictionOnly(flag, val, click){
    	chk1Only(flag, val, click);
    	var y = document.getElementsByClassName('f');
        y[0].checked = false;
    	var i;
    	for(i=1; i < 9; i++){
    		var x = document.getElementsByClassName(i);
            x[0].checked = false;
            x[1].checked = true;
    	}
    	for(i=9; i < 19; i++){
            var x = document.getElementsByClassName(i);
            x[1].checked = false;
        }
    }
    function fictionOnly(flag, val, click){
        chk1Only(flag, val, click);
        var y = document.getElementsByClassName('nf');
        y[0].checked = false;
        var i;
        for(i=9; i < 19; i++){
            var x = document.getElementsByClassName(i);
            x[0].checked = false;
            x[1].checked = true;
        }
        for(i=1; i < 9; i++){
            var x = document.getElementsByClassName(i);
            x[1].checked = false;
        }
    }
    </script>
<title>BA - Search</title>
</head>

<body>

<!-- Choo! Choo! Ugly form incoming. -->
<div class="sidenav">

<form name="searchCrit" method="GET" action="search.jsp">
    <input type="submit" value="Search">
    <input type="reset" value="Reset"><br><br>
    
    Sort by: <select name="s">
       <option value="1" selected>Title</option>
       <option value="2">Ending Soon</option>
       <option value="3">Newly Listed</option>
       <option value="4">Low Bidding Price</option>
       <option value="5">High Bidding Price</option>
    </select>    
    
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
            <td><input type="text" oninput="addAward()" name="w" id="award" value=""></td>
        </tr>
    </tbody>
    </table>

    <br> Yes/No <br>
    <input onclick="chk1Only(this.value, 'aw',0);" type="checkbox" name="aw" value="y" class="aw">
    <input onclick="chk1Only(this.value, 'aw',1); remAward();" type="checkbox" name="aw" value="n" class="aw"> Award-Winning
    
    <br><br>
    <!-- Fiction -->
    <input onclick="fictionOnly(this.value, 'f',0);" type="checkbox" name="fic1" class="f">
    <input onclick="nonfictionOnly(this.value, 'f',1);" type="checkbox" name="fic2" class="f"> <b>FICTION</b>
    <br>
     
    <input onclick="chk1Only(this.value, '1',0);" type="checkbox" name="gYes" value="1" class="1">
    <input onclick="chk1Only(this.value, '1',1);" type="checkbox" name="gNo" value="1" class="1"> Fantasy
    <br>
    <input onclick="chk1Only(this.value, '2',0);" type="checkbox" name="gYes" value="2" class="2">
    <input onclick="chk1Only(this.value, '2',1);" type="checkbox" name="gNo" value="2" class="2"> Science Fiction
    <br>
    <input onclick="chk1Only(this.value, '3',0);" type="checkbox" name="gYes" value="3" class="3">
    <input onclick="chk1Only(this.value, '3',1);" type="checkbox" name="gNo" value="3" class="3"> Thriller/Horror
    <br>
    <input onclick="chk1Only(this.value, '4',0);" type="checkbox" name="gYes" value="4" class="4">
    <input onclick="chk1Only(this.value, '4',1);" type="checkbox" name="gNo" value="4" class="4"> Comic/Graphic Novel
    <br>
    <input onclick="chk1Only(this.value, '5',0);" type="checkbox" name="gYes" value="5" class="5">
    <input onclick="chk1Only(this.value, '5',1);" type="checkbox" name="gNo" value="5" class="5"> Young Adult
    <br>
    <input onclick="chk1Only(this.value, '6',0);" type="checkbox" name="gYes" value="6" class="6">
    <input onclick="chk1Only(this.value, '6',1);" type="checkbox" name="gNo" value="6" class="6"> Drama
    <br>
    <input onclick="chk1Only(this.value, '7',0);" type="checkbox" name="gYes" value="7" class="7">
    <input onclick="chk1Only(this.value, '7',1);" type="checkbox" name="gNo" value="7" class="7"> Romance
    <br>
    <input onclick="chk1Only(this.value, '8',0);" type="checkbox" name="gYes" value="8" class="8">
    <input onclick="chk1Only(this.value, '8',1);" type="checkbox" name="gNo" value="8" class="8"> Historical
    <br>
    <br>
    
    <!-- Non-Fiction -->
    <input onclick="nonfictionOnly(this.value, 'nf',0);" type="checkbox" name="nFic1" class="nf">
    <input onclick="fictionOnly(this.value, 'nf',1);" type="checkbox" name="nFic2" class="nf"> <b>NON-FICTION</b>
    <br>
    
    <input onclick="chk1Only(this.value, '9',0);" type="checkbox" name="gYes" value="9" class="9">
    <input onclick="chk1Only(this.value, '9',1);" type="checkbox" name="gNo" value="9" class="9"> Biography
    <br>
    <input onclick="chk1Only(this.value, '10',0);" type="checkbox" name="gYes" value="10" class="10">
    <input onclick="chk1Only(this.value, '10',1);" type="checkbox" name="gNo" value="10" class="10"> Arts/Photography
    <br>
    <input onclick="chk1Only(this.value, '11',0);" type="checkbox" name="gYes" value="11" class="11">
    <input onclick="chk1Only(this.value, '11',1);" type="checkbox" name="gNo" value="11" class="11"> Technology
    <br> 
    <input onclick="chk1Only(this.value, '12',0);" type="checkbox" name="gYes" value="12" class="12">
    <input onclick="chk1Only(this.value, '12',1);" type="checkbox" name="gNo" value="12" class="12"> Cookbook/Food
    <br> 
    <input onclick="chk1Only(this.value, '13',0);" type="checkbox" name="gYes" value="13" class="13">
    <input onclick="chk1Only(this.value, '13',1);" type="checkbox" name="gNo" value="13" class="13"> Crafts/DIY
    <br> 
    <input onclick="chk1Only(this.value, '14',0);" type="checkbox" name="gYes" value="14" class="14">
    <input onclick="chk1Only(this.value, '14',1);" type="checkbox" name="gNo" value="14" class="14"> Outdoor
    <br> 
    <input onclick="chk1Only(this.value, '15',0);" type="checkbox" name="gYes" value="15" class="15">
    <input onclick="chk1Only(this.value, '15',1);" type="checkbox" name="gNo" value="15" class="15"> Health
    <br> 
    <input onclick="chk1Only(this.value, '16',0);" type="checkbox" name="gYes" value="16" class="16">
    <input onclick="chk1Only(this.value, '16',1);" type="checkbox" name="gNo" value="16" class="16"> Religion
    <br> 
    <input onclick="chk1Only(this.value, '17',0);" type="checkbox" name="gYes" value="17" class="17">
    <input onclick="chk1Only(this.value, '17',1);" type="checkbox" name="gNo" value="17" class="17"> Natural Science
    <br> 
    <input onclick="chk1Only(this.value, '18',0);" type="checkbox" name="gYes" value="18" class="18">
    <input onclick="chk1Only(this.value, '18',1);" type="checkbox" name="gNo" value="18" class="18"> Social Science
    <br> 
    
</form>
</div>


<div class="main">


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
<h2>Search:</h2>

    <%
    AdvSearch search = null;
    List<Item> items = null;
    try {
        AppDB db = new AppDB(); 
        Connection con = db.getConnection();

        //Get parameters from the HTML form at the search_adv.html
        //OY! Can they handle NULL? How to ignore them?     		
        System.out.println("YAY 100%");
        
        String title = request.getParameter("t");        
        String isbn = request.getParameter("i");
        String author = request.getParameter("a");
        String publisher = request.getParameter("p");
        String award = request.getParameter("w");
        
        int isAward = -1; //-1 neither, 0 no, 1 yes
        String aw[] = request.getParameterValues("aw");
        if(aw != null){
        	for(String a : aw){
                if(a.equals("n")) isAward = 0;
                if(a.equals("y")) isAward = 1;
            }
        }  
        
        int minBid = 0, maxBid = 0, minYear = 0, maxYear = 0;
        try{
        	String tmp = request.getParameter("b1");
        	if(Check.isNum(tmp)) minBid = Integer.parseInt(tmp);
        	tmp = request.getParameter("b2");
            if(Check.isNum(tmp)) maxBid = Integer.parseInt(tmp);
            
        }catch(NumberFormatException e){
        	System.out.println("huh");
        	e.printStackTrace();
        }
        String gYes[] = request.getParameterValues("gYes");
        String gNo[] = request.getParameterValues("gNo");

        search = new AdvSearch(con, title, isbn, author,
        		publisher, award, isAward, minBid, maxBid);
        if(gYes != null) search.setgYes(gYes);
        if(gNo != null) search.setgNo(gNo);
        
        items = search.searchDetailed();
       //Close the connection
        con.close();      
    } catch (Exception e) {    
        e.printStackTrace();
    }
%>

<!-- Found n items -->
<p>Found <%if(items != null) {out.print(items.size());}
               else {out.print('0');}%> items. <p>
               
               
<!-- sort before display, use comparator -->
<%
if(items != null){
	System.out.println("Sort...");
	String str = request.getParameter("s");
	char c = '1';
	if(str != null && str.length()>0) c = str.charAt(0);
	switch(c){
	case '1':      //title
		Collections.sort(items, new SortTitle());
		break;
	case '2':      //ending soon
		Collections.sort(items, new sortEndDate());
        break;
	case '3':      //newly listed
		Collections.sort(items, new sortStartDate());
		Collections.reverse(items);
        break;
	case '4':      //low bid
		Collections.sort(items, new sortBid());
        break;
	case '5':      //high bid
		Collections.sort(items, new sortBid());
		Collections.reverse(items);
        break;
	default:
		Collections.sort(items, new SortTitle());
        break;
	}
}
%>


<table>
  <tr>
    <th>Title</th>
    <th>Author</th>
    <th>Publisher</th>
    <th>ISBN</th>
    <th>Bid at</th>
    <th>Start Date</th>
    <th>End Date</th>    
  </tr>
  <%
  if(items != null && items.size() > 0){
	  for(Item item : items){ %>
  <tr>
        <%int id = item.getAuctionID(); %>
    <td> <a href=view.jsp?id=<%=id%>> <% out.print(item.title); %>  </a></td>
    <td> <% out.print(item.author); %> </td>
    <td> <% out.print(item.publisher); %> </td>
    <td> <% out.print(item.isbn); %> </td>
    <td> $<% out.print(item.getBid()); %> </td>
    <td> <% out.print(item.getStartDate()); %> </td>
    <td> <% out.print(item.getEndDate()); %> </td>    
  </tr>
  <tr>
    <td colspan="7"> Genre:<% out.print(item.getGenre()); %> </td>    
  </tr> 
  <tr>
    <td colspan="7"> Award: <% out.print(item.getAward()); %> </td>    
  </tr>   
      
  <%
	  }
  } else {
	out.print("Empty items");  
  }
  %>
  
</table>

</div>  



</body>
</html>