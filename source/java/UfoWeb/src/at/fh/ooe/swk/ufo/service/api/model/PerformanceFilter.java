package at.fh.ooe.swk.ufo.service.api.model;

import java.util.Calendar;
import java.util.List;

/**
 * The filter specification for the performance filter.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
public interface PerformanceFilter {

	Calendar getFromDate();

	Calendar getToDate();

	List<Long> getArtistIds();

	List<Long> getVenueIds();

	List<Long> getArtistGroupIds();

	List<Long> getArtistCategoryIds();

	List<String> getCountries();
	
	Boolean getMoved();
}
