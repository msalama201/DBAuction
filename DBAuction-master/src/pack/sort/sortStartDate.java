package pack.sort;

import java.util.Comparator;

import pack.Item;

/**
 * search.jsp sort
 * @author Maryam
 */
public class sortStartDate implements Comparator<Item> {
	@Override
	public int compare(Item o1, Item o2) {
		return o1.startDate.compareTo(o2.startDate);
	}
}