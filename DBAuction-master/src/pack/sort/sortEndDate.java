package pack.sort;

import java.util.Comparator;

import pack.Item;

/**
 * search.jsp sort
 * @author Maryam
 */
public class sortEndDate implements Comparator<Item> {
	@Override
	public int compare(Item o1, Item o2) {
		return o1.endDate.compareTo(o2.endDate);
	}
}