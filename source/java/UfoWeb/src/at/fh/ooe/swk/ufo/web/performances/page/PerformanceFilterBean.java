package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import javax.annotation.PostConstruct;
import javax.enterprise.context.SessionScoped;
import javax.inject.Inject;
import javax.inject.Named;

import at.fh.ooe.swk.ufo.webservice.PerformanceFilterRequest;

@SessionScoped
@Named("performanceFilterBean")
public class PerformanceFilterBean implements Serializable {

	private static final long serialVersionUID = 6065461910973062558L;

	@Inject
	private PerformancesPage page;

	private Calendar fromDate;
	private Calendar toDate;
	private List<Long> artistIds;
	private List<Long> venueIds;

	private Calendar minDate;
	private Calendar maxDate;

	private final TimeZone zone = TimeZone.getTimeZone("UTC");

	@PostConstruct
	public void postConstruct() {
		// Set borders to current year
		minDate = Calendar.getInstance();
		maxDate = (Calendar) minDate.clone();
		minDate.setTimeZone(zone);
		maxDate.setTimeZone(zone);
		minDate.set(minDate.get(Calendar.YEAR), Calendar.JANUARY, 1, 0, 0, 0);
		maxDate.set(maxDate.get(Calendar.YEAR), Calendar.DECEMBER, 31, 0, 0, 0);

		// Reset to default filters
		reset();
	}

	public PerformanceFilterRequest createRequestModel() {
		fromDate.setTimeZone(zone);
		toDate.setTimeZone(zone);
		return new PerformanceFilterRequest(fromDate, toDate, artistIds.toArray(new Long[artistIds.size()]),
				venueIds.toArray(new Long[venueIds.size()]));
	}

	// ##################################################
	// Actions
	// ##################################################
	public void filter() {
		page.loadPerformances();
	}

	public void reset() {
		fromDate = (Calendar) minDate.clone();
		toDate = (Calendar) maxDate.clone();
		artistIds = new ArrayList<>();
		venueIds = new ArrayList<>();
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

	public Date getFromDate() {
		return fromDate.getTime();
	}

	public void setFromDate(Date fromDate) {
		this.fromDate.setTime(fromDate);
	}

	public Date getToDate() {
		return toDate.getTime();
	}

	public void setToDate(Date toDate) {
		this.toDate.setTime(toDate);
	}

	public Date getMinDate() {
		return minDate.getTime();
	}

	public Date getMaxDate() {
		return maxDate.getTime();
	}
}
