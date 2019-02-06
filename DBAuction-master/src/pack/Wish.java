package pack;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;



public class Wish {
	Connection con;
	public int err = 0;
	
	public Wish(Connection con) {
		this.con = con;
	}
	
	/**
	 * Add new wish for tracking.
	 * @param wish details
	 */
	public void addWish(int accID, String title, String author, String publisher, String award,
			String isbn, int minBid, int maxBid) {
		if(accID < 1) {
			err = -1;
			return;
		}
		String add = "INSERT INTO Wish (accID, isbn, publisher, author, title, "
				+ "award_title, minBid, maxBid) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
				
		try {
			PreparedStatement ps = con.prepareStatement(add);
			ps.setInt(1, accID);
			psStringorNull(ps, 2, isbn);
			psStringorNull(ps, 3, publisher);
			psStringorNull(ps, 4, author);
			psStringorNull(ps, 5, title);
			psStringorNull(ps, 6, award);
			ps.setInt(7, minBid);
			ps.setInt(8, maxBid);
			System.out.println(ps.toString().substring(24));
			ps.executeUpdate();			
			ps.close();
		} catch (SQLException e) {
			err = -1;
			e.printStackTrace();
		}
	}
	
	/**
	 * Remove wishlist.
	 * @param wid
	 */
	public void remWish(int wid) {
		String del = "DELETE FROM Wish WHERE wID="+wid;	
		try {
			Statement st = con.createStatement();
			st.executeUpdate(del);			
			st.close();
		} catch (SQLException e) {
			err = -1;
			e.printStackTrace();
		}
	}
	
	/**
	 * Return all wishlists for the account.
	 * @param accID
	 * @return
	 */
	public List<WishObj> listWish(int accID) {
		String query = "SELECT * FROM Wish WHERE accID="+accID;
		List<WishObj> wishlist = null;
		try {
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			wishlist = new ArrayList<WishObj>();
			while(rs.next()) {
				WishObj w = new WishObj(rs);
				wishlist.add(w);
			}
			
			st.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return wishlist;
	}
	
	/**
	 * Compare the new auction with each wishlist. If match, send email.
	 * @param auction details
	 */
	public void checkNewAuction(int auctionID, String title, String author, String publisher, 
			String isbn, String award, int startBid) {
		
		String query = "SELECT * FROM Wish";
		try {
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			while(rs.next()) {
				String rsTitle = rs.getString("title");
				String rsAuthor = rs.getString("author");
				String rsPubl = rs.getString("publisher");
				String rsIsbn = rs.getString("isbn");
				String rsAward = rs.getString("award_title");
				int rsMinBid = rs.getInt("minBid");
				int rsMaxBid = rs.getInt("MaxBid");
				
				if(rsTitle != null && !title.contains(rsTitle)) continue;
				if(rsAuthor != null && !author.contains(rsAuthor)) continue;
				if(rsPubl != null && !publisher.equals(rsPubl)) continue;
				if(rsIsbn != null && !isbn.contains(rsIsbn)) continue;
				if(rsAward != null && !award.contains(rsAward)) continue;
				if(rsMinBid > 0 && startBid < rsMinBid) continue;
				if(rsMaxBid > 0 && startBid > rsMaxBid) continue;
				
				int accID = rs.getInt("accID");
				//send email noti
				String msgSubject = "Wishlist Alert";
				String msgContent = "URL: view.jsp?id="+auctionID
						+" based on wish id: "+rs.getInt("wID");
				String add = "INSERT INTO Email (accID, staffID, subject, content)"
						+ " VALUES (?, 0, ?, ?)";
				
				PreparedStatement ps = con.prepareStatement(add);
				ps.setInt(1, accID);
				ps.setString(2, msgSubject);
				ps.setString(3, msgContent);
				ps.executeUpdate();
				ps.close();
			}
			st.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}
	
	
	/**
	 * Wrapper setString, setNull
	 */
	private void psStringorNull(PreparedStatement ps, int i, String s) throws SQLException {
		if(s != null && s.length()>0) {
			ps.setString(i, s);
		} else {
			ps.setNull(i, java.sql.Types.VARCHAR);
		}
	}

}
