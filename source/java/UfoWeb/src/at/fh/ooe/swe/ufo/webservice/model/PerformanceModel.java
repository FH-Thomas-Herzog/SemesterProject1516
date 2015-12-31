package at.fh.ooe.swe.ufo.webservice.model;

import java.io.Serializable;
import java.util.Calendar;

public class PerformanceModel implements Serializable {

	private static final long serialVersionUID = -4687100651071119288L;

	private String name;
	private String country;
	private String venue;
	private Calendar startDate;
	private Calendar endDate;

	public PerformanceModel(String name, String country, String venue, Calendar startDate, Calendar endDate) {
		super();
		this.name = name;
		this.country = country;
		this.venue = venue;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String countryCode) {
		this.country = countryCode;
	}

	public String getVenue() {
		return venue;
	}

	public void setVenue(String venue) {
		this.venue = venue;
	}

	public Calendar getStartDate() {
		return startDate;
	}

	public void setStartDate(Calendar startDate) {
		this.startDate = startDate;
	}

	public Calendar getEndDate() {
		return endDate;
	}

	public void setEndDate(Calendar endDate) {
		this.endDate = endDate;
	}

}
