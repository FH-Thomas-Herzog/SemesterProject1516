package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;
import javax.enterprise.context.SessionScoped;
import javax.inject.Inject;
import javax.inject.Named;

import at.fh.ooe.swk.ufo.web.application.model.IdMapperModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceFilterRequest;

@SessionScoped
@Named("performanceFilterBean")
public class PerformanceFilterBean implements Serializable {

	private static final long serialVersionUID = 6065461910973062558L;

	@Inject
	private PerformancesPage page;
	@Inject
	private PerformanceFilterSupport supportBean;
	@Inject
	private TimeZone timeZone;

	private Calendar fromDate;
	private List<IdMapperModel<Long>> artistIds;
	private List<IdMapperModel<Long>> venueIds;

	private Calendar minDate;
	private Calendar maxDate;

	@PostConstruct
	public void postConstruct() {
		// Set borders to current year
		minDate = Calendar.getInstance();
		maxDate = (Calendar) minDate.clone();
		minDate.setTimeZone(timeZone);
		maxDate.setTimeZone(timeZone);
		minDate.set(minDate.get(Calendar.YEAR), Calendar.JANUARY, 1, 0, 0, 0);
		maxDate.set(maxDate.get(Calendar.YEAR), Calendar.DECEMBER, 31, 0, 0, 0);

		// Reset to default filters
		reset();
	}

	public PerformanceFilterRequest createRequestModel() {
		fromDate.setTimeZone(timeZone);
		Calendar toDate = (Calendar) fromDate.clone();
		toDate.set(Calendar.HOUR_OF_DAY, 23);
		toDate.set(Calendar.MINUTE, 59);
		return new PerformanceFilterRequest(fromDate, toDate,
				artistIds.parallelStream().map(model -> model.id).toArray(Long[]::new),
				venueIds.parallelStream().map(model -> model.id).toArray(Long[]::new));
	}

	// ##################################################
	// Actions
	// ##################################################
	public void filter() {
		page.loadPerformances();
	}

	public void clear() {
		reset();
		// reload data
		supportBean.init();
		page.loadPerformances();
	}

	public void reset() {
		fromDate = Calendar.getInstance();
		artistIds = new ArrayList<>();
		venueIds = new ArrayList<>();
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public List<IdMapperModel<Long>> getArtistIds() {
		return artistIds;
	}

	public void setArtistIds(List<IdMapperModel<Long>> artistIds) {
		this.artistIds = artistIds;
	}

	public List<IdMapperModel<Long>> getVenueIds() {
		return venueIds;
	}

	public void setVenueIds(List<IdMapperModel<Long>> venueIds) {
		this.venueIds = venueIds;
	}

	public Date getFromDate() {
		return fromDate.getTime();
	}

	public void setFromDate(Date fromDate) {
		this.fromDate.setTime(fromDate);
	}

	public Date getMinDate() {
		return minDate.getTime();
	}

	public Date getMaxDate() {
		return maxDate.getTime();
	}
}
