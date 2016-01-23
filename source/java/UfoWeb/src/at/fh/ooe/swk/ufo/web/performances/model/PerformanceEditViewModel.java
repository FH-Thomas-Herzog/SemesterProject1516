package at.fh.ooe.swk.ufo.web.performances.model;

import java.util.Calendar;
import java.util.Objects;

import javax.inject.Named;

import org.apache.deltaspike.core.api.scope.ViewAccessScoped;

import at.fh.ooe.swk.ufo.web.application.model.IdHolder;

/**
 * ViewScoped edit view bean for editing performances.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 23, 2016
 */
@ViewAccessScoped
@Named("performanceEditViewModel")
public class PerformanceEditViewModel implements IdHolder<Long> {

	private static final long serialVersionUID = 1994942977872442719L;

	private Long id;
	private Long version;
	private ArtistViewModel artist;
	private VenueViewModel venue;
	private Calendar date;
	private Integer hour;

	/**
	 * Initializes and indicates a new performances will be created.
	 * 
	 * @param now
	 *            the now date time.
	 * @param startHour
	 *            the min start hour value
	 */
	public void init(Calendar now, int startHour) {
		Objects.requireNonNull(now);

		reset();

		date = Calendar.getInstance();
		date.set(now.get(Calendar.YEAR), now.get(Calendar.MONTH), now.get(Calendar.DATE), 0, 0, 0);
		hour = startHour;
	}

	/**
	 * Initializes this model with an existing performance.
	 * 
	 * @param model
	 *            the performance view model to retrieve data from
	 */
	public void init(PerformanceViewModel model) {
		Objects.requireNonNull(model);

		reset();

		id = model.getId();
		version = model.getVersion();
		artist = model.getArtist();
		venue = model.getVenue();
		date = model.getStartDate();
		hour = model.getStartDate().get(Calendar.HOUR_OF_DAY);
	}

	/**
	 * Resets this view model.
	 */
	public void reset() {
		id = null;
		version = null;
		artist = null;
		venue = null;
		date = null;
		hour = null;
	}

	// ####################################################
	// Getter and Setter
	// ####################################################
	public Long getId() {
		return id;
	}

	public Long getVersion() {
		return version;
	}

	public ArtistViewModel getArtist() {
		return artist;
	}

	public void setArtist(ArtistViewModel artist) {
		this.artist = artist;
	}

	public VenueViewModel getVenue() {
		return venue;
	}

	public void setVenue(VenueViewModel venue) {
		this.venue = venue;
	}

	public Calendar getDate() {
		return date;
	}

	public void setDate(Calendar date) {
		this.date = date;
	}

	public Integer getHour() {
		return hour;
	}

	public void setHour(Integer hour) {
		this.hour = hour;
	}
}
