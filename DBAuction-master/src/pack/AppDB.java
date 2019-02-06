package pack;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class AppDB {
    private static final String DBNAME = "/Auction";
    private static final String DB_USERNAME = "auctionMSTR";	//muh security
    private static final String DB_PASSWORD = "auctionMSTR";
    private static final String DBURL = "auctiondb.cbtlxellt5gi.us-east-2.rds.amazonaws.com:";
    private static final String DBPORT = "3306";
	
	public AppDB(){
		
	}

	/**
	 * Open connection
	 * @return
	 */
	public Connection getConnection(){
		
		//Create a connection string
		String connectionUrl = "jdbc:mysql://"+DBURL+DBPORT+DBNAME;
		Connection connection = null;
		
		try {
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try {
			//Create a connection to your DB
			connection = DriverManager.getConnection(connectionUrl, DB_USERNAME, DB_PASSWORD);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return connection;
		
	}
	
	/**
	 * Close connection
	 * @param connection
	 */
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
