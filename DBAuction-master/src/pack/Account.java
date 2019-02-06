package pack;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class Account {
	Connection con;
	public String error;
	
	public Account(Connection con) {
		this.con = con;
	}
	
	public Account() {
		
	}
	
	
	/**
	 * Get userID from accID
	 */
	public int getUserID(int accID) {
		if(accID < 1) return -1;
		String sql = "SELECT userID FROM Account WHERE accID="+accID;
		try {
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			int id = -1;
			while(rs.next()) {
				id = rs.getInt("userID");
			}
			st.close();
			return id;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
	public List<String> getUserDetail(int userID){
		if(userID < 1) return null;
		List<String> ls = null;
		String sql = "SELECT * FROM User WHERE userID="+userID;
		try {
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			ls = new ArrayList<String>();
			while(rs.next()) {
				ls.add(rs.getString("nameUser"));
				ls.add(rs.getString("address"));
				ls.add(rs.getString("phone"));
			}
			st.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ls;
	}
	
	/**
	 * Edit user details.
	 */
	public int editUser(int userID, String name, String address, String phone) {
		if(userID < 1) return -1;
		String sql = "UPDATE User SET nameUser=?, address=?,"
				+ " phone=? WHERE userID=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, address);
			ps.setString(3, phone);
			ps.setInt(4, userID);
			ps.executeUpdate();
			ps.close();
			return 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 1;
	}
	
	/**
	 * Edit password.
	 */
	public int editPword(int accID, String pword, String pword2) {
		if(accID < 1) return -1;
		if(!Check.isAlphNum(pword)){
        	error = "Password must be alphanumeric only";       
        	return -1;
		} else if(pword.compareTo(pword2)!= 0){	
			error = "Password fields does not match"; 
			return -1;
        }
		String sql = "UPDATE Account SET pword=? WHERE accID=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, pword);
			ps.setInt(2, accID);
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
	 * Create a new account under the same user.
	 */
	public int createNewAcc(int userID, String username, String pword, String pword2) {
		RegLogin r = new RegLogin(con);
		return r.insertAccount(userID, username, pword, pword2);
	}
	
	
	/**
	 * Remove account. Set bids to 0, if user has only 1 account, delete user.
	 */
	public int remAccount(int accID) {
		if(accID < 1) return -1;
		String sql = "UPDATE Bids SET accID=0 WHERE accID="+accID;
		sql = "SELECT COUNT(*) AS X FROM Account WHERE accID="+accID;
		try {
			Statement st = con.createStatement();
			st.executeUpdate(sql);
			sql = "SELECT COUNT(*) AS X FROM Account WHERE accID="+accID;
			ResultSet rs = st.executeQuery(sql);
			rs.next();
			if(rs.getInt("X") > 1) {
				sql = "DELETE FROM Account WHERE accID="+accID;
				st.executeUpdate(sql);
			} else {
				st.close();
				int userID = this.getUserID(accID);
				return this.remUser(userID, accID);
			}
			st.close();
			return 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;	
	}
	
	/**
	 * Remove user, nullify? account. Set bids to 0 first.
	 */
	public int remUser(int userID, int accID) {
		if(userID < 1) return -1;
		String sql = "UPDATE Bids SET accID=0 WHERE accID="+accID;
		try {
			Statement st = con.createStatement();
			st.executeUpdate(sql);
			sql = "DELETE FROM User WHERE userID="+userID;
			st.executeUpdate(sql);
			st.close();
			return 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;		
	}

}
