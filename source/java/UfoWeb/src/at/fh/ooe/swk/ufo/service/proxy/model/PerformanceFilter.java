package at.fh.ooe.swk.ufo.service.proxy.model;

import java.util.Calendar;
import java.util.List;

public interface PerformanceFilter {

	Calendar getFromDate();

	Calendar getToDate();

	List<Long> getArtistIds();

	List<Long> getVenueIds();
}
