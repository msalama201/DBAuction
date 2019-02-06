package pack;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;


public class QnA {
	//wat encapsulation?
	public int auctionID, accID, qID;
	public String name, question, answer;
	public Date aTime, qTime;
	
	/**
	 * Create QnA based on current cursor at ResultSet
	 * @throws SQLException
	 */
	public QnA(ResultSet rs) throws SQLException {
		this.qID = rs.getInt("qID");
		this.auctionID = rs.getInt("auctionID");
		this.accID = rs.getInt("accID");
		this.name = rs.getString("username");
		this.question = rs.getString("question");
		if(question == null) question = "Question deleted.";
		this.answer = rs.getString("answer");
		this.aTime = rs.getDate("aTime");
		this.qTime = rs.getDate("qTime");
	}
	
	public QnA() {
		
	}
	
	public String getaTime() {
		return this.aTime.toString();
	}
	
	public String getqTime() {
		return this.qTime.toString();
	}

	
	@Override
	public String toString() {
		return "QnA [auctionID=" + auctionID + ", accID=" + accID + ", name=" + name + ", question=" + question
				+ ", answer=" + answer + "]";
	}

}
