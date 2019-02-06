package pack;

import java.sql.Connection;


public class TD {

	public static void main(String[] args) {
		AppDB a = new AppDB();
		Connection c = a.getConnection();
		Wish w = new Wish(c);
		w.checkNewAuction(3, "I Am a Strange Loop", "Douglas R. Hofstadter",
				"Basic Books", "0465008372", null, 25);

	}

}
