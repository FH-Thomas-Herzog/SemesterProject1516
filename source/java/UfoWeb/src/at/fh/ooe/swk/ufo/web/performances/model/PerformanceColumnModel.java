package at.fh.ooe.swk.ufo.web.performances.model;

import java.text.DateFormat;
import java.util.Calendar;
import java.util.Locale;
import java.util.Objects;

public class PerformanceColumnModel {

	private final Calendar startDate;
	private final Calendar endDate;
	private final String header;
	private final Locale locale;

	public PerformanceColumnModel(Calendar startDate, Locale locale) {
		super();
		Objects.requireNonNull(startDate, "Column Header model needs startDate to be provided");
		Objects.requireNonNull(locale, "Cannot localize header with null locale");

		this.startDate = startDate;
		this.endDate = (Calendar) startDate.clone();
		endDate.add(Calendar.HOUR, 1);
		this.locale = locale;
		this.header = buildLocalizedHeader(startDate) + " - " + buildLocalizedHeader(endDate);
	}

	// ####################################################
	// Getter and Setter
	// ####################################################
	public Calendar getStartDate() {
		return startDate;
	}

	public Calendar getEndDate() {
		return endDate;
	}

	public String getHeader() {
		return header;
	}

	// ####################################################
	// Helper
	// ####################################################
	private String buildLocalizedHeader(Calendar date) {
		return DateFormat.getTimeInstance(DateFormat.SHORT, locale).format(date.getTime());
	}
	
	public boolean isSameHour(final Calendar calendar){
		return startDate.get(Calendar.HOUR) == calendar.get(Calendar.HOUR);
	}
}
