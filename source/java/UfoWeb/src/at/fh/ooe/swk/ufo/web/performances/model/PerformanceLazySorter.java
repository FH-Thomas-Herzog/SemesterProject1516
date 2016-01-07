package at.fh.ooe.swk.ufo.web.performances.model;

import java.util.Comparator;

/**
 * Custom comparator which compares the rows either by the set venue or the view
 * model on the given start hour.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 7, 2016
 */
public class PerformanceLazySorter implements Comparator<PerformanceRowModel> {

	private final Integer startHour;
	private final boolean ascending;

	/**
	 * Set depending values needed for comparison.
	 * 
	 * @param startHour
	 *            the start hour where the view model reside, if null comparison
	 *            by venue is intended.
	 * @param ascending
	 *            true if ascending order false for descending
	 */
	public PerformanceLazySorter(Integer startHour, boolean ascending) {
		super();
		this.startHour = startHour;
		this.ascending = ascending;
	}

	@Override
	public int compare(PerformanceRowModel o1, PerformanceRowModel o2) {
		int value = 0;
		if (startHour != null) {
			final PerformanceViewModel v1 = o1.getModelForColumn(startHour);
			final PerformanceViewModel v2 = o2.getModelForColumn(startHour);

			if ((v1 == null) && (v2 == null)) {
				value = 0;
			} else if ((v1 == null) && (v2 != null)) {
				value = 1;
			} else if ((v1 != null) && (v2 == null)) {
				value = -1;
			} else {
				value = v1.compareTo(v2);
			}
		} else {
			value = o1.getVenue().label.compareTo(o2.getVenue().getLabel());
		}
		return ascending ? value : (value * -1);
	}
}
