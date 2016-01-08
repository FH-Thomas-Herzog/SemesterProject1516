package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.TimeZone;

import javax.annotation.PostConstruct;
import javax.inject.Named;

import org.apache.deltaspike.core.api.scope.ViewAccessScoped;

import at.fh.ooe.swk.ufo.webservice.PerformanceFilterRequest;

@ViewAccessScoped
@Named("performanceFilterBean")
public class PerformanceFilterBean implements Serializable {

	private static final long serialVersionUID = 6065461910973062558L;

	private Calendar startDate;
	private Calendar endDate;
	private List<Long> artistIds;
	private List<Long> venueIds;

	private final TimeZone zone = TimeZone.getTimeZone("UTC");

	@PostConstruct
	public void postConstruct() {
		resetFilters();
	}

	public void resetFilters() {
		startDate = Calendar.getInstance();
		startDate.clear();
		startDate.set(2015, Calendar.DECEMBER, 22, 0, 1, 0);
		endDate = (Calendar) startDate.clone();
		endDate.clear();
		endDate.set(2015, Calendar.DECEMBER, 22, 23, 59, 00);
		artistIds = new ArrayList<>();
		venueIds = new ArrayList<>();
	}

	public PerformanceFilterRequest createRequestModel() {
		startDate.setTimeZone(zone);
		endDate.setTimeZone(zone);
		return new PerformanceFilterRequest(startDate, endDate, artistIds.toArray(new Long[artistIds.size()]),
				venueIds.toArray(new Long[venueIds.size()]));
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public List<Long> getArtistIds() {
		return artistIds;
	}

	public void setArtistIds(List<Long> artistIds) {
		this.artistIds = artistIds;
	}

	public List<Long> getVenueIds() {
		return venueIds;
	}

	public void setVenueIds(List<Long> venueIds) {
		this.venueIds = venueIds;
	}

}
