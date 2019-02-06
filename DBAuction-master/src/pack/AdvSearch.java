package pack;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class AdvSearch {
	 Connection con;
	 public String error;
	 String title="", isbn="", author="", publisher="", award="", gYes[], gNo[];
	 int isAward, minBid, maxBid;
	 //isAward -1 ignore, 0 null, 1 not null
	 
	 
	/**
	 * For searching title only
	 */
	public AdvSearch(Connection con, String title) {
		this.con = con;
		this.title = title;
	}
	
	/**
	 * For advanced search
	 */
	public AdvSearch(Connection con, String title, String isbn, String author,
			String publisher, String award, int isAward, int minBid, int maxBid) {
		this.con = con;
		if(title != null) this.title = title;
		if(isbn != null) this.isbn = isbn;
		if(author != null) this.author = author;
		if(publisher != null) this.publisher = publisher;
		if(award != null) this.award = award;
		this.isAward = isAward;
		if(minBid > 0) this.minBid = minBid;
		if(maxBid > 0) this.maxBid = maxBid;
	}

	
	/**
	 * Search based on title only
	 */
	public List<Item> searchTitle() {
		System.out.println("Title Search..."+title+"...");
		String query = "SELECT * FROM joinSearch WHERE title LIKE ?";
		List<Item> items = null;
		try {
			setup();
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, "%"+title+"%");
			ResultSet rs = ps.executeQuery();
			items = makeList(rs);
		
			ps.close();
		}catch(SQLException e) {
			e.printStackTrace();
			error = "Title search fail";
			return null;
		}
		return items;
	}
	
	/**
	 * Search based on all criteria
	 */
	public List<Item> searchDetailed() {
		System.out.println("Detailed Search...");
		List<Item> items = null;
		try {
			setup();
			PreparedStatement ps = makeQuery();
			System.out.println("p: "+ps.toString().substring(35));
			ResultSet rs = ps.executeQuery();
			items = makeList(rs);
			
			ps.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return items;		
	}
	
	/**
	 * Setup temporary tables to be used for search.
	 * @throws SQLException
	 */
	private void setup() throws SQLException {
		String setup = "DROP TABLE IF EXISTS maxBid";
		Statement st = con.createStatement();
		st.executeUpdate(setup);
		
		setup = "CREATE TEMPORARY TABLE maxBid AS("
		+"	SELECT Bids.auctionID, MAX(bid_amount) AS currentBid "
		+"	FROM Auction.Bids"
		+"	GROUP BY Bids.auctionID)";
		st.executeUpdate(setup);
		
		setup = "DROP TABLE IF EXISTS joinSearch";
		st.executeUpdate(setup);
		setup = "CREATE TEMPORARY TABLE joinSearch AS ("
		+"	SELECT a.auctionID, m.currentBid, a.accID, title, author, publisher, b.isbn, start_date, end_date,"
		+"    fantasy, scifi, thriller, comic, youngAdult, drama, romance, historical, biography,"
		+"	  arts, tech, food, diy, outdoor, health, religion, naturalScience, socialScience, award_title"
		+"	FROM Books b"
		+"	JOIN AuctionT a ON a.isbn = b.isbn"
		+"  LEFT JOIN Genre_Award g ON g.isbn = a.isbn"
		+"	LEFT JOIN maxBid m ON m.auctionID = a.auctionID"
		+" 	WHERE end_date > NOW())";
		st.executeUpdate(setup);
		st.close();
	}
	
	/**
	 * Create PreparedStatement for advanced search.
	 * @return
	 * @throws SQLException
	 */
	private PreparedStatement makeQuery() throws SQLException {
		String query = "SELECT * FROM joinSearch WHERE ";
		if(isbn != null && isbn.length() != 0)		query += "isbn LIKE ? AND ";
		if(title != null && title.length() != 0)	query += "title LIKE ? AND ";
		if(author != null && author.length() != 0)	query += "author LIKE ? AND ";
		if(publisher != null && publisher.length() != 0)	query += "publisher LIKE ? AND ";
		if(award != null && award.length() != 0) 	query += "award_title LIKE ? AND ";
		if(minBid != 0) 			query += "currentBid > ? AND ";
		if(maxBid != 0)				query += "currentBid < ? AND ";
		if(gYes != null) {
			for(String s : gYes) {
				if(s.equals("1")) 	query += "fantasy=1 AND ";
				if(s.equals("2"))	query += "scifi=1 AND ";
				if(s.equals("3")) 	query += "thriller=1 AND ";
				if(s.equals("4")) 	query += "comic=1 AND ";
				if(s.equals("5"))	query += "youngAdult=1 AND ";
				if(s.equals("6")) 	query += "drama=1 AND ";
				if(s.equals("7"))	query += "romance=1 AND ";
				if(s.equals("8")) 	query += "historical=1 AND ";
				if(s.equals("9"))	query += "biography=1 AND ";
				if(s.equals("10"))	query += "arts=1 AND ";
				if(s.equals("11"))	query += "tech=1 AND ";
				if(s.equals("12"))	query += "food=1 AND ";
				if(s.equals("13"))	query += "diy=1 AND ";
				if(s.equals("14"))	query += "outdoor=1 AND ";
				if(s.equals("15"))	query += "health=1 AND ";
				if(s.equals("16"))	query += "religion=1 AND ";
				if(s.equals("17"))	query += "naturalScience=1 AND ";
				if(s.equals("18"))	query += "socialScience=1 AND ";
			}			
		}
		if(gNo != null) {
			for(String s : gNo) {
				if(s.equals("1"))	query += "fantasy=0 AND ";
				if(s.equals("2")) 	query += "scifi=0 AND ";
				if(s.equals("3")) 	query += "thriller=0 AND ";
				if(s.equals("4")) 	query += "comic=0 AND ";
				if(s.equals("5"))	query += "youngAdult=0 AND ";
				if(s.equals("6")) 	query += "drama=0 AND ";
				if(s.equals("7"))	query += "romance=0 AND ";
				if(s.equals("8")) 	query += "historical=0 AND ";
				if(s.equals("9"))	query += "biography=0 AND ";
				if(s.equals("10"))	query += "arts=0 AND ";
				if(s.equals("11"))	query += "tech=0 AND ";
				if(s.equals("12"))	query += "food=0 AND ";
				if(s.equals("13"))	query += "diy=0 AND ";
				if(s.equals("14"))	query += "outdoor=0 AND ";
				if(s.equals("15"))	query += "health=0 AND ";
				if(s.equals("16"))	query += "religion=0 AND ";
				if(s.equals("17"))	query += "naturalScience=0 AND ";
				if(s.equals("18"))	query += "socialScience=0 AND ";
			}			
		}
		if(isAward == 0)			query += "award_title IS NULL AND ";
		if(isAward == 1)			query += "award_title IS NOT NULL AND ";
		query = query.substring(0, query.length()- 4);
		if(query.endsWith("WH")) query = query.substring(0, query.length()-2);
					
		PreparedStatement ps = con.prepareStatement(query);
		int i = 0;
		if(isbn.length() != 0)		ps.setString(++i, "%"+isbn+"%");
		if(title.length() != 0)		ps.setString(++i, "%"+title+"%");			
		if(author.length() != 0)	ps.setString(++i, "%"+author+"%");
		if(publisher.length() != 0)	ps.setString(++i, "%"+publisher+"%");
		if(award.length() != 0)		ps.setString(++i, "%"+award+"%");
		if(minBid != 0)				ps.setInt(++i, minBid);
		if(maxBid != 0)				ps.setInt(++i, maxBid);
		
		ps.execute();	
		return ps;
	}

	/**
	 * Make arraylist of Item from ResultSet.
	 * @throws SQLException
	 */
	List<Item> makeList(ResultSet rs) throws SQLException {
		List<Item> items = new ArrayList<Item>();
		System.out.println("Making list...");
		while(rs.next()) {
			Item i = new Item(rs, 0);
			items.add(i);
		}
		return items;
	}
		
	
	public void setgYes(String gYes[]) {
		this.gYes = gYes;
	}

	public void setgNo(String gNo[]) {
		this.gNo = gNo;
	}

	@Override
	public String toString() {
		return "AdvSearch [title=" + title + ", isbn=" + isbn + ", author=" + author + ", publisher=" + publisher
				+ ", award=" + award + ", gYes=" + Arrays.toString(gYes) + ", gNo=" + Arrays.toString(gNo)
				+ ", isAward=" + isAward + ", minBid=" + minBid + ", maxBid=" + maxBid + "]";
	}
	
}
