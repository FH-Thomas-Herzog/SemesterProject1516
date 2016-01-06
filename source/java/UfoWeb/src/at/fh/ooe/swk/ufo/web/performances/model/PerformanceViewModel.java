package at.fh.ooe.swk.ufo.web.performances.model;

import java.util.Calendar;

import at.fh.ooe.swk.ufo.webservice.PerformanceModel;

public class PerformanceViewModel {

	private Object id;
	private Calendar startDate;
	private Calendar endDate;
	private boolean moved;
	private String venueName;
	private String artistName;
	private String artistGroupName;
	private Long artistId;
	private Long artistGroupId;
	private long venueId;

	public PerformanceViewModel() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PerformanceViewModel(PerformanceModel model) {
		super();
		this.id = model.getId();
		this.startDate = model.getStartDate();
		this.endDate = model.getEndDate();
		this.moved = model.isMoved();
		this.venueId = model.getVenueId();
		this.venueName = model.getVenueName();
		this.artistName = model.getArtistName();
		this.artistId = model.getArtistId();
		this.artistGroupName = model.getArtistGroupName();
		this.artistGroupId = model.getArtistGroupId();
	}

	public Object getId() {
		return id;
	}

	public void setId(Object id) {
		this.id = id;
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

	public boolean isMoved() {
		return moved;
	}

	public void setMoved(boolean moved) {
		this.moved = moved;
	}

	public String getVenueName() {
		return venueName;
	}

	public void setVenueName(String venueName) {
		this.venueName = venueName;
	}

	public String getArtistName() {
		return artistName;
	}

	public void setArtistName(String artistName) {
		this.artistName = artistName;
	}

	public String getArtistGroupName() {
		return artistGroupName;
	}

	public void setArtistGroupName(String artistGroupName) {
		this.artistGroupName = artistGroupName;
	}

	public Long getArtistId() {
		return artistId;
	}

	public void setArtistId(Long artistId) {
		this.artistId = artistId;
	}

	public Long getArtistGroupId() {
		return artistGroupId;
	}

	public void setArtistGroupId(Long artistGroupId) {
		this.artistGroupId = artistGroupId;
	}

	public long getVenueId() {
		return venueId;
	}

	public void setVenueId(long venueId) {
		this.venueId = venueId;
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
