package at.fh.ooe.swk.ufo.web.performances.model;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Objects;

/**
 * Row model for performances which maps the performances to their start hour
 * which is the mapping to the corresponding dynamic columns.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 7, 2016
 */
public class PerformanceRowModel {

	private final VenueViewModel venue;
	private final Map<Integer, List<PerformanceViewModel>> map;

	public PerformanceRowModel(VenueViewModel venue, Map<Integer, List<PerformanceViewModel>> map) {
		super();
		Objects.requireNonNull(venue, "Venue must be given");
		Objects.requireNonNull(venue, "Performances map must be given");

		this.venue = venue;
		this.map = map;
	}

	// ##################################################
	// Helper
	// ##################################################
	/**
	 * Performs the filtering on the row model for the dynmaic columns.
	 * 
	 * @param filters
	 *            the filter map
	 * @param columns
	 *            the table columns
	 * @return true if filter applies on the proper column model, false
	 *         otherwise
	 */
	public boolean containsFilteredValue(Map<String, Object> filters, List<PerformanceColumnModel> columns) {
		for (Entry<String, Object> entry : filters.entrySet()) {
			boolean valid = Boolean.FALSE;
			final String filter = (String) entry.getValue();
			final int startHour = columns.get(Integer.valueOf(entry.getKey())).getStartHour();
			final List<PerformanceViewModel> models = map.get(startHour);
			if ((models != null) && (!models.isEmpty())) {
				for (PerformanceViewModel model : models) {
					if ((model.getArtist() != null)
							&& (model.getArtist().getFullName().toUpperCase().contains(filter.toUpperCase()))) {
						valid = Boolean.TRUE;
					}
					if ((model.getArtist().getArtistGroup() != null)
							&& (model.getArtist().getArtistGroup().toUpperCase().contains(filter.toUpperCase()))) {
						valid = Boolean.TRUE;
					}
					if ((model.getArtist().getArtistCategory() != null)
							&& (model.getArtist().getArtistCategory().toUpperCase().contains(filter.toUpperCase()))) {
						valid = Boolean.TRUE;
					}
				}
			}
			if (!valid) {
				return Boolean.FALSE;
			}
		}

		return Boolean.TRUE;
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public VenueViewModel getVenue() {
		return venue;
	}

	/**
	 * Returns the model for the column or null if no model is mapped to the
	 * given column
	 * 
	 * @param hour
	 *            the hour represents the column
	 * @return the found model, null otherwise
	 */
	public PerformanceViewModel getModelForColumn(final int hour) {
		List<PerformanceViewModel> list = map.get(hour);
		return (list != null) ? list.get(0) : null;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((venue == null) ? 0 : venue.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PerformanceRowModel other = (PerformanceRowModel) obj;
		if (venue == null) {
			if (other.venue != null)
				return false;
		} else if (!venue.equals(other.venue))
			return false;
		return true;
	}

}
