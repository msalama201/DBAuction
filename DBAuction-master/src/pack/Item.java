package pack;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;

public class Item {
	//hurr durr muh encapsulation is ded
	public int auctionID, accID, rating;
	public String title, author, publisher, isbn, award, seller;
	public float bid;
	public Date startDate, endDate;
	public boolean[] genre;
	
	/**
	 * Create item based on current cursor at ResultSet
	 * @throws SQLException
	 */
	public Item(ResultSet rs, int mode) throws SQLException {
		this.auctionID = rs.getInt("auctionID");
		this.accID = rs.getInt("accID");
		this.title = rs.getString("title");
		this.author = rs.getString("author");
		this.publisher = rs.getString("publisher");
		this.isbn = rs.getString("isbn");
		this.award = rs.getString("award_title");
		this.bid = rs.getFloat("currentBid");
		this.startDate = rs.getDate("start_date");
		this.endDate = rs.getDate("end_date");
		if(mode == 1) this.rating = rs.getInt("rating");
		if(mode == 1) this.seller = rs.getString("username");
		boolean[] genre = new boolean[18];
		if(rs.getBoolean("fantasy")) genre[0] = true;
		if(rs.getBoolean("scifi")) genre[1] = true;
		if(rs.getBoolean("thriller")) genre[2] = true;
		if(rs.getBoolean("comic")) genre[3] = true;
		if(rs.getBoolean("youngAdult")) genre[4] = true;
		if(rs.getBoolean("drama")) genre[5] = true;
		if(rs.getBoolean("romance")) genre[6] = true;
		if(rs.getBoolean("historical")) genre[7] = true;
		if(rs.getBoolean("biography")) genre[8] = true;
		if(rs.getBoolean("arts")) genre[9] = true;
		if(rs.getBoolean("tech")) genre[10] = true;
		if(rs.getBoolean("food")) genre[11] = true;
		if(rs.getBoolean("diy")) genre[12] = true;
		if(rs.getBoolean("outdoor")) genre[13] = true;
		if(rs.getBoolean("health")) genre[14] = true;
		if(rs.getBoolean("religion")) genre[15] = true;
		if(rs.getBoolean("naturalScience")) genre[16] = true;
		if(rs.getBoolean("socialScience")) genre[17] = true;
		this.genre = genre;
	}
	
	public Item() {
		
	}
	
		
	public int getAuctionID() {
		return this.auctionID;
	}
	
	public String getBid() {
		return String.format("%.2f", this.bid);
	}
		
	public String getStartDate() {
		return this.startDate.toString();
	}
	
	public String getEndDate() {
		return this.endDate.toString();
	}
	
	/**
	 * Boolean array to string of genres.
	 */
	public String getGenre() {
		String g = " ";
		if(genre[0]) g += "Fantasy, ";
		if(genre[1]) g += "Science Fiction, ";
		if(genre[2]) g += "Thriller, ";
		if(genre[3]) g += "Comic, ";
		if(genre[4]) g += "Young Adult, ";
		if(genre[5]) g += "Drama, ";
		if(genre[6]) g += "Romance, ";
		if(genre[7]) g += "Historical, ";
		if(genre[8]) g += "Biography, ";
		if(genre[9]) g += "Arts, ";
		if(genre[10]) g += "Tech, ";
		if(genre[11]) g += "Food, ";
		if(genre[12]) g += "DIY, ";
		if(genre[13]) g += "Outdoor, ";
		if(genre[14]) g += "Health, ";
		if(genre[15]) g += "Religion, ";
		if(genre[16]) g += "Natural Science, ";
		if(genre[17]) g += "Social Science, ";
		if(g.length() > 3)g = g.substring(0, g.length()-2);
		return g;
	}
	
	public String getAward() {
		if(award != null && award.length()>0) return this.award;
		return "-";
	}

	@Override
	public String toString() {
		return "Item [auctionID=" + auctionID + ", accID=" + accID + ", title=" + title + ", author=" + author
				+ ", publisher=" + publisher + ", isbn=" + isbn + ", award=" + award + ", bid=" + bid + ", startDate="
				+ startDate + ", endDate=" + endDate + ", genre=" + Arrays.toString(genre) + "]";
	}
}
