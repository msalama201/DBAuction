package pack.sort;

import java.util.Comparator;

import pack.Item;

/**
 * search.jsp sort
 * @author Maryam
 */
public class sortBid implements Comparator<Item> {
	@Override
	public int compare(Item o1, Item o2) {
		return Double.compare(o1.bid, o2.bid);
	}
}