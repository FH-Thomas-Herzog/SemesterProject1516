package at.fh.ooe.swk.ufo.web.performances.model;

import java.io.Serializable;
import java.util.Calendar;
import java.util.TimeZone;

import javax.enterprise.context.Dependent;
import javax.inject.Inject;

import at.fh.ooe.swk.ufo.webservice.PerformanceModel;

@Dependent
public class PerformanceViewModel implements Comparable<PerformanceViewModel>, Serializable {

	private static final long serialVersionUID = 3692624909190619132L;

	@Inject
	private TimeZone timeZone;

	private Long id;
	private Long version;
	private Calendar startDate;
	private Calendar formerStartDate;
	private Calendar endDate;
	private boolean moved;
	private String venueName;
	private String groupName;
	private String categoryName;
	private String name;
	private Long artistId;
	private Long venueId;

	private Calendar now;

	public PerformanceViewModel() {
		super();
	}

	public void init(PerformanceModel model) {
		now = Calendar.getInstance();

		id = model.getId();
		version = model.getVersion();
		startDate = model.getStartDate();
		endDate = model.getEndDate();
		formerStartDate = model.getFormerStartDate();
		moved = formerStartDate != null;
		venueId = model.getVenue().getId();
		venueName = model.getVenue().getName();
		name = new StringBuilder().append(model.getArtist().getLastName()).append(", ").append(model.getArtist().getFirstName())
				.toString();
		groupName = model.getArtist().getArtistGroup();
		categoryName = "";
		artistId = model.getArtist().getId();
		// Set to expected time zone
		startDate.setTimeZone(timeZone);
		endDate.setTimeZone(timeZone);
	}

	// ##################################################
	// Helper
	// ##################################################
	@Override
	public int compareTo(PerformanceViewModel o) {
		return name.compareTo(o.name);
	}

	public boolean isInPast() {
		return ((now == null) || (startDate == null) || (now.compareTo(startDate) >= 0));
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public Long getId() {
		return id;
	}

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

	public boolean isMoved() {
		return moved;
	}

	public String getVenueName() {
		return venueName;
	}

	public String getName() {
		return name;
	}

	public String getGroupName() {
		return groupName;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public Long getArtistId() {
		return artistId;
	}

	public Long getVenueId() {
		return venueId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PerformanceViewModel other = (PerformanceViewModel) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
}
