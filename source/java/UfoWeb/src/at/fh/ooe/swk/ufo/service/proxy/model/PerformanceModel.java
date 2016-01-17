package at.fh.ooe.swk.ufo.service.proxy.model;

import java.util.Calendar;

public class PerformanceModel extends AbstractCredentialsModel {

	private Long id;
	private Long version;
	private Long artistId;
	private Long venueId;
	private Calendar startDate;

	public PerformanceModel() {
		super();
	}

	public PerformanceModel(String username, String password, String languageCode, Long id, Long version, Long artistId,
			Long venueId, Calendar startDate) {
		super(username, password, languageCode);
		this.id = id;
		this.version = version;
		this.artistId = artistId;
		this.venueId = venueId;
		this.startDate = startDate;
	}

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

	public Long getArtistId() {
		return artistId;
	}

	public void setArtistId(Long artistId) {
		this.artistId = artistId;
	}

	public Long getVenueId() {
		return venueId;
	}

	public void setVenueId(Long venueId) {
		this.venueId = venueId;
	}

	public Calendar getStartDate() {
		return startDate;
	}

	public void setStartDate(Calendar startDate) {
		this.startDate = startDate;
	}

}
