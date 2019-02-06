package pack;

import java.sql.ResultSet;
import java.sql.SQLException;

public class WishObj {
	//something something encapsulation
	public String title, isbn, author, publisher, award;
	public int wID, accID, minBid, maxBid;
	
	public WishObj(ResultSet rs) throws SQLException {
		this.wID = rs.getInt("wID");
		this.accID = rs.getInt("accID");
		this.title = rs.getString("title");
		this.author = rs.getString("author");
		this.isbn = rs.getString("isbn");
		this.publisher = rs.getString("publisher");
		this.award = rs.getString("award_title");
		this.minBid = rs.getInt("minBid");
		this.maxBid = rs.getInt("maxBid");
		this.nullToEmpty();
	}
	
	/**
	 * Set null string to empty for pretty table.
	 */
	void nullToEmpty() {
		if(title == null) title = "";
		if(author == null) author = "";
		if(publisher == null) publisher = "";
		if(award == null) award = "";
		if(isbn == null) isbn = "";
	}
	
	public WishObj() {
		
	}

	
	@Override
	public String toString() {
		return "WishObj [title=" + title + ", isbn=" + isbn + ", author=" + author + ", publisher=" + publisher
				+ ", award=" + award + ", accID=" + accID + ", minBid=" + minBid + ", maxBid=" + maxBid + "]";
	}

}
