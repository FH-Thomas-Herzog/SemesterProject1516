package at.fh.ooe.swk.ufo.web.performances.model;

import java.util.Calendar;
import java.util.TimeZone;

import at.fh.ooe.swk.ufo.webservice.PerformanceModel;

public class PerformanceViewModel implements Comparable<PerformanceViewModel> {

	public static enum EntityType {
		ARTIST, ARTIST_GROUP
	}

	private final Object id;
	private final Calendar startDate;
	private final Calendar endDate;
	private final boolean moved;
	private final String venueName;
	private final String name;
	private final Object entityId;
	private final Object venueId;
	private final EntityType type;

	private static final TimeZone ZONE = TimeZone.getTimeZone("UTC");

	public PerformanceViewModel(PerformanceModel model) {
		super();
		id = model.getId();
		startDate = model.getStartDate();
		endDate = model.getEndDate();
		moved = model.isMoved();
		venueId = model.getVenueId();
		venueName = (model.getVenueName() != null) ? model.getVenueName() : "";
		if ((model.getArtistId() != null)) {
			name = (model.getArtistName() != null) ? model.getArtistName() : "";
			entityId = model.getArtistId();
			type = EntityType.ARTIST;
		} else {
			name = (model.getArtistGroupName() != null) ? model.getArtistGroupName() : "";
			entityId = model.getArtistGroupId();
			type = EntityType.ARTIST_GROUP;
		}
		// Set to expected time zone
		startDate.setTimeZone(ZONE);
		endDate.setTimeZone(ZONE);
	}

	// ##################################################
	// Helper
	// ##################################################
	@Override
	public int compareTo(PerformanceViewModel o) {
		return name.compareTo(o.name);
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public Object getId() {
		return id;
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

	public Object getEntityId() {
		return entityId;
	}

	public Object getVenueId() {
		return venueId;
	}

	public EntityType getType() {
		return type;
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
