package at.fh.ooe.swk.ufo.web.performances.model;

import java.util.Calendar;

import javax.enterprise.context.Dependent;

import at.fh.ooe.swk.ufo.web.application.model.AbstractIdHolderModel;

/**
 * The performances view model. CDI Dependent scoped bean because we want to use
 * injection here. No problem is still a strong referenced bean, not part of an
 * context at all.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 23, 2016
 */
@Dependent
public class PerformanceViewModel extends AbstractIdHolderModel<Long> implements Comparable<PerformanceViewModel> {

	private static final long serialVersionUID = 3692624909190619132L;

	private Long version;
	private Calendar startDate;
	private Calendar formerStartDate;
	private Calendar endDate;
	private Calendar formerEndDate;
	private boolean moved;

	private ArtistViewModel artist;
	private VenueViewModel venue;
	private VenueViewModel formerVenue;

	private Calendar now;

	public PerformanceViewModel() {
		super();
	}

	/**
	 * Initializes this view model.
	 * 
	 * @param id
	 * @param version
	 * @param startDate
	 * @param formerStartDate
	 * @param endDate
	 * @param formerEndDate
	 * @param artist
	 * @param venue
	 * @param formerVenue
	 */
	public void init(Long id, Long version, Calendar startDate, Calendar formerStartDate, Calendar endDate,
			Calendar formerEndDate, ArtistViewModel artist, VenueViewModel venue, VenueViewModel formerVenue) {
		now = Calendar.getInstance();

		this.id = id;
		this.version = version;
		this.startDate = startDate;
		this.formerStartDate = formerStartDate;
		this.endDate = endDate;
		this.formerEndDate = formerEndDate;
		this.formerEndDate = formerEndDate;
		this.moved = formerStartDate != null;
		this.artist = artist;
		this.venue = venue;
		this.formerVenue = formerVenue;
	}

	// ##################################################
	// Helper
	// ##################################################
	@Override
	public int compareTo(PerformanceViewModel o) {
		return artist.getFullName().compareTo(o.getArtist().getFullName());
	}

	public boolean isInPast() {
		return ((now == null) || (startDate == null) || (now.compareTo(startDate) >= 0));
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public void setId(Long id) {
		this.id = id;
	}

	public Long getVersion() {
		return version;
	}

	public void setVersion(Long version) {
		this.version = version;
	}

	public Calendar getStartDate() {
		return startDate;
	}

	public Calendar getEndDate() {
		return endDate;
	}

	public Calendar getFormerStartDate() {
		return formerStartDate;
	}

	public Calendar getFormerEndDate() {
		return formerEndDate;
	}

	public boolean isMoved() {
		return moved;
	}

	public ArtistViewModel getArtist() {
		return artist;
	}

	public VenueViewModel getVenue() {
		return venue;
	}

	public VenueViewModel getFormerVenue() {
		return formerVenue;
	}
}
