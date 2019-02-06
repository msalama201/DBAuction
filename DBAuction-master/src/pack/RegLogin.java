package pack;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Statement;


public class RegLogin {
	 Connection con;
	 public String error;

	
	public RegLogin(Connection con) {
		this.con = con;
	}
	
	/**
	 * Make new entry in User and Account tables. If insert Account fail,
	 *  delete User entry.
	 * @return
	 */
	public int insertGeneral(String name, String email, String username, 
			String pword, String pword2) {
		
		int userID = this.insertUser(name, email);
		if(userID > 0) {
			int status = this.insertAccount(userID, username, pword, pword2);
			if(status < 0) { //fail to make new account
				String delete = "DELETE FROM Auction.User WHERE userID=?";
				try {
					PreparedStatement ps = con.prepareStatement(delete);
					ps.setLong(1, userID);
					ps.executeUpdate();
					ps.close();
					
				}catch(SQLException e) {
					e.printStackTrace();
				}
				return -1;
			}
		} else {
			return -1;
		}
		return 0;
	}
	
	/**
	 * Make new entry in User table. Name must be alphanumeric, email must have no
	 * whitespace.
	 * @return
	 */
	public int insertUser(String name, String email) {
		if(!Check.isAlphNum(name)){
			error = "Name must be alphanumeric only";
			return -1;
		} 
		email.toLowerCase();
		String insert = "INSERT INTO User(nameUser, email) VALUES (?, ?)";

        try {
            PreparedStatement ps = 
            		con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, name);
            ps.setString(2, email);
        	ps.executeUpdate();
        	ResultSet result = ps.getGeneratedKeys();
        	int userID = -1;
        	if(result.next()) {
        		userID = result.getInt(1);
        	}
        	ps.close();
        	return userID;
        	
        } catch(SQLIntegrityConstraintViolationException e) {
        	e.printStackTrace();
        	error = "Email unavailable - If you lose your password"
            		+" there's nothing we can do";
        	return -1;
        } catch(SQLException e) {
        	e.printStackTrace();
        	error = "Registration failed";
        	return -1;
        }
        	
	}
	
	
	/**
	 * Make new entry in Account table. Username & password must be alphanumeric,
	 * passwords must match.
	 * @return
	 */
	public int insertAccount(int userID, String username, String pword, String pword2) {
        if(!Check.isAlphNum(username)){
        	error = "Username must be alphanumeric only";
        	return -1;
        } else if(!Check.isAlphNum(pword)){
        	error = "Password must be alphanumeric only";       
        	return -1;
		} else if(pword.compareTo(pword2)!= 0){	
			error = "Password fields does not match"; 
			return -1;
        }
        
        String insert = "INSERT INTO Account(userID, username, pword) VALUES (?, ?, ?)";     
        try {
            PreparedStatement ps = con.prepareStatement(insert);

            ps.setInt(1, userID);
            ps.setString(2, username);
            ps.setString(3, pword);
            System.out.println(ps.toString().substring(25));           
        	ps.executeUpdate();
        	ps.close();
        } catch(SQLIntegrityConstraintViolationException e) {
        	e.printStackTrace();
        	error = "Username unavailable";
        	return -1;
        } catch(SQLException e) {
        	e.printStackTrace();
        	error = "Registration failed";
        	return -1;
        }
        
		return 0;
	}
	
	
	/**
	 * Check if password match with username, if exist.
	 * @return
	 */
	public int tryLogin(String username, String pword) {
		int accID = -1;
		 //Check for illegal chars
	    if(!Check.isAlphNum(username)){
	        error = "Username must be alphanumeric only";
	        return -1;
	    } else if(!Check.isAlphNum(pword)){
	       error = "Password must be alphanumeric only";       
	       return -1;
	    }
	    
	    //Find username
        String query = "SELECT pword, accID FROM Auction.Account " 
                +"WHERE username LIKE ?";
        try {
        	PreparedStatement ps = con.prepareStatement(query);
        	ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            
            //Check if username exist
            if(!rs.isBeforeFirst()) {
            	error = "Username does not exist";
            	ps.close();
            	return -1;
            }
            
            rs.next();
            //Check if password match
            if(!rs.getString("pword").equals(pword)){    
                error = "Wrong username and/or password";
                ps.close();
                return -1;
            } else {
            	accID = rs.getInt("accID");
            }
            ps.close();
            
        } catch(SQLException e) {
        	e.printStackTrace();
        	error = "Login failed";
        	return -1;
        }         
		return accID;
	}	
         
}
