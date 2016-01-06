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
@Named("performanceFilterPage")
public class PerformanceFilterSubPage implements Serializable {

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
		startDate.set(2015, Calendar.DECEMBER, 10, 1, 0, 0);
		endDate = (Calendar) startDate.clone();
		endDate.clear();
		endDate.set(2015, Calendar.DECEMBER, 25, 23, 59, 00);
		artistIds = new ArrayList<>();
		venueIds = new ArrayList<>();
	}

	public PerformanceFilterRequest createRequestModel() {
		startDate.setTimeZone(zone);
		endDate.setTimeZone(zone);
		return new PerformanceFilterRequest(startDate, endDate, artistIds.toArray(new Long[artistIds.size()]),
				venueIds.toArray(new Long[venueIds.size()]));
	}
}
