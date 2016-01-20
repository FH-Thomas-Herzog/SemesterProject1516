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

import org.primefaces.event.SelectEvent;

import at.fh.ooe.swk.ufo.service.proxy.api.model.PerformanceFilter;
import at.fh.ooe.swk.ufo.web.application.annotation.ServiceTimeZone;
import at.fh.ooe.swk.ufo.web.application.model.IdMapperModel;

@SessionScoped
@Named("performanceFilterBean")
public class PerformanceFilterBean implements Serializable {

	private static final long serialVersionUID = 6065461910973062558L;

	@Inject
	private PerformanceSupport support;
	@Inject
	@ServiceTimeZone
	private TimeZone serviceTimeZone;

	private Calendar fromDate;
	private Calendar toDate;
	private List<IdMapperModel<Long>> artistIds;
	private List<IdMapperModel<Long>> venueIds;

	private Calendar minDate;
	private Calendar maxDate;

	private static final int MAX_DAY_COUNT = 7;

	@PostConstruct
	public void postConstruct() {
		// Set borders to current year
		minDate = Calendar.getInstance();
		maxDate = (Calendar) minDate.clone();
		minDate.set(minDate.get(Calendar.YEAR), Calendar.JANUARY, 1, 0, 0, 0);
		maxDate.set(maxDate.get(Calendar.YEAR), Calendar.DECEMBER, 31, 0, 0, 0);

		// Reset to default filters
		reset();
	}

	public PerformanceFilter createFilter() {
		final Calendar fromDateTmp = (Calendar) fromDate.clone();
		fromDateTmp.setTimeZone(serviceTimeZone);
		final Calendar toDateTmp = (Calendar) toDate.clone();
		toDateTmp.setTimeZone(serviceTimeZone);
		toDateTmp.set(Calendar.HOUR_OF_DAY, 23);
		toDateTmp.set(Calendar.MINUTE, 59);

		return new PerformanceFilter() {

			@Override
			public Calendar getFromDate() {
				return fromDateTmp;
			}

			@Override
			public Calendar getToDate() {
				return toDateTmp;
			}

			@Override
			public List<Long> getArtistIds() {
				return artistIds.parallelStream().map(model -> model.id).collect(Collectors.toList());
			}

			@Override
			public List<Long> getVenueIds() {
				return venueIds.parallelStream().map(model -> model.id).collect(Collectors.toList());
			}

		};
	}

	// ##################################################
	// Actions
	// ##################################################
	public void filter() {
		support.loadPerformances();
	}

	public void clear() {
		reset();
		filter();
	}

	public void reset() {
		fromDate = Calendar.getInstance();
		fromDate.set(fromDate.get(Calendar.YEAR), fromDate.get(Calendar.MONTH), fromDate.get(Calendar.DATE), 0, 0);
		toDate = (Calendar) fromDate.clone();
		toDate.set(toDate.get(Calendar.YEAR), toDate.get(Calendar.MONTH), toDate.get(Calendar.DATE), 23, 59);
		toDate.add(Calendar.DAY_OF_YEAR, 7);

		artistIds = new ArrayList<>();
		venueIds = new ArrayList<>();
	}

	// ##################################################
	// Event Lsiteners
	// ##################################################
	public void onFromDateSelect(SelectEvent event) {
		final Date date = (Date) event.getObject();
		final Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		// In case day range overflowed
		if (isDayOverflow((Calendar) cal.clone(), (Calendar) toDate.clone())) {
			toDate = (Calendar) cal.clone();
			toDate.add(Calendar.DAY_OF_YEAR, MAX_DAY_COUNT);
		}
		// In case of invalid range
		else if (toDate.compareTo(fromDate) < 0) {
			toDate = (Calendar) cal.clone();
		}
		setFromDate(date);
	}

	public void onToDateSelect(SelectEvent event) {
		final Date date = (Date) event.getObject();
		final Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		// In case day range overflowed
		if (isDayOverflow((Calendar) fromDate.clone(), (Calendar) cal.clone())) {
			fromDate = (Calendar) cal.clone();
			fromDate.add(Calendar.DAY_OF_YEAR, -MAX_DAY_COUNT);
		}
		// In case of invalid range
		else if (toDate.compareTo(fromDate) < 0) {
			fromDate = (Calendar) cal.clone();
		}
		setToDate(date);
	}

	// ##################################################
	// Helper
	// ##################################################
	public boolean isDayOverflow(final Calendar from, final Calendar to) {
		from.add(Calendar.DAY_OF_YEAR, MAX_DAY_COUNT);
		return (from.compareTo(to) < 0);
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

	public int getMaxDayCount() {
		return MAX_DAY_COUNT;
	}
}
