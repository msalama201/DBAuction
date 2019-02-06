package pack.sort;

import java.util.Comparator;

import pack.Item;

/**
 * search.jsp sort
 * @author Maryam
 */
public class SortTitle implements Comparator<Item> {
	@Override
	public int compare(Item o1, Item o2) {
		return o1.title.toLowerCase().compareTo(o2.title.toLowerCase());
	}
}