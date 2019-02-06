package pack;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;


public class Check {
	
	public Check() {}
	
	/**
	 * Check if string contain alphanumeric characters only
	 */
	public static boolean isAlphNum(String s) {
		if(s==null || !s.matches("[a-zA-Z0-9]+")) return false;	
		return true;
	}
	
	/**
	 * Numbers with no more than 1 dot
	 */
	public static boolean isNum(String s) {
		if(s==null || !s.matches("[0-9.]+"))	return false;
		if(s.split("\\.",-1).length-1 > 1)		return false; //1 dot only
		return true;
	}
	
	
	/**
	 * Logout wrapper
	 */
	public static void logout(HttpServletResponse response) {
		Cookie kuih = new Cookie("accID", "");
    	kuih.setMaxAge(0);
    	response.addCookie(kuih);
    	kuih = new Cookie("username", "");
        response.addCookie(kuih);
        kuih.setMaxAge(0);
	}
	
}


