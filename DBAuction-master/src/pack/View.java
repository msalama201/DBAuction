package pack;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class View {
	Connection con;
	public int id;
	
	public View(Connection con) {
		this.con = con;
	}
	
	/**
	 * Get book and auction details for the item.
	 * @return
	 */
	public Item getItem(String sid) {
		if(!Check.isNum(sid)) {
			System.out.println("Not num:_"+sid+"_");
			return null;
		}
		this.id = Integer.parseInt(sid);
		System.out.println("id: "+this.id);
		if(this.id == 0) {
			System.out.println("id = 0 y tho");
			return null;
		}
		
		Item item = null;
		System.out.println("Getting item...");
		String query = "SELECT * FROM joinSearch";		
		try {
			setup(this.id);
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			while(rs.next()) {
				item = new Item(rs, 1);	
			}
			
			st.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return item;
	}
	
	/**
	 * Setup temporary tables for the item.
	 * @throws SQLException
	 */
	private void setup(int id) throws SQLException {
		//largely based on AdvSearch.setup() + filter id
		String setup = "DROP TABLE IF EXISTS maxBid";
		Statement st = con.createStatement();
		st.executeUpdate(setup);
		
		setup = "CREATE TEMPORARY TABLE maxBid AS("
		+"	SELECT Bids.auctionID, MAX(bid_amount) AS currentBid "
		+"	FROM Auction.Bids"
		+"	WHERE auctionID="+id
		+"	GROUP BY Bids.auctionID)";
		System.out.println(setup);
		st.executeUpdate(setup);
				
		setup = "DROP TABLE IF EXISTS joinSearch";
		st.executeUpdate(setup);
		setup = "CREATE TEMPORARY TABLE joinSearch AS ("
		+"	SELECT a.auctionID, m.currentBid, a.accID, c.username, c.rating, title, author, publisher, b.isbn, start_date, end_date,"
		+"    fantasy, scifi, thriller, comic, youngAdult, drama, romance, historical, biography,"
		+"	  arts, tech, food, diy, outdoor, health, religion, naturalScience, socialScience, award_title"
		+"	FROM Books b"
		+"	JOIN AuctionT a ON a.isbn = b.isbn"
		+"  LEFT JOIN Genre_Award g ON g.isbn = a.isbn"
		+"	LEFT JOIN maxBid m ON m.auctionID = a.auctionID"
		+"	LEFT JOIN Account c ON c.accID = a.accID"
		+"	WHERE a.auctionID="+id+")";
		st.executeUpdate(setup);
		st.close();
	}
	
	/**
	 * If param null, return all questions and answers.
	 */
	public List<QnA> getQnA(String search) {
		List<QnA> qnas = new ArrayList<QnA>();

		String query = "SELECT qID, q.auctionID, q.accID, a.username, question, answer,"
				+" qTime, aTime" 
				+" FROM QnA q LEFT JOIN Account a ON a.accID = q.accID"
				+" WHERE auctionID="+id;
		if(search != null && search.length()>0) {
			query += " AND question LIKE ?";
		}
		try {
			PreparedStatement ps = con.prepareStatement(query);
			if(search != null && search.length()>0) {
				ps.setString(1, "%"+search+"%");
			}
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				QnA qna = new QnA(rs);
				qnas.add(qna);
			}
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return qnas;
	}
	
	/**
	 * Submit new question.
	 */
	public int askQnA(String question, int id) {
		if(id == 0) return 1;		//ignore
		String add = "INSERT INTO QnA (accID, auctionID, question) VALUES (?, ?, ?)";
		try {
			PreparedStatement ps = con.prepareStatement(add);
			ps.setInt(1, id);
			ps.setInt(2, this.id);
			ps.setString(3, question);
			
			System.out.println(ps.toString().substring(20));
			
			ps.executeUpdate();
			ps.close();
			return 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 1;
	}
	
	
	/**
	 * Delete question if no answer yet. Else set to null.
	 */
	public int remQuestion(int qID) {
		String sql = "SELECT * FROM QnA";
		try {
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			rs.next();
			if(rs.getString("answer") == null) {
				sql = "DELETE FROM QnA WHERE qID="+qID;
			} else {
				sql = "UPDATE QnA SET question=NULL, accID=0 WHERE qID="+qID;
			}
			st.executeUpdate(sql);
			st.close();
			return 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 1;
	}
	
	
	/**
	 * Edit question.
	 */
	public int editQuestion(int qID, String edit) {
		String sql = "UPDATE QnA SET question=? WHERE qID=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, edit);
			ps.setInt(2, qID);
			ps.executeUpdate();
			ps.close();
			return 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 1;
	}
	
	
	/**
	 * Add/edit reply.
	 */
	public int reply(int qID, String reply) {
		String sql = "UPDATE QnA SET answer=? WHERE qID=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, reply);
			ps.setInt(2, qID);
			ps.executeUpdate();
			ps.close();
			return 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 1;
	}
	
	/**
	 * Delete reply. If question has been deleted, delete all.
	 */
	public int remReply(int qID) {
		String sql = "SELECT * FROM QnA WHERE qID="+qID;
		try {
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			rs.next();
			if(rs.getString("question") == null) {
				sql = "DELETE FROM QnA WHERE qID="+qID;
			} else {
				sql = "UPDATE QnA SET answer=NULL WHERE qID="+qID;
			}
			st.executeUpdate(sql);
			st.close();
			return 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 1;
	}

}
