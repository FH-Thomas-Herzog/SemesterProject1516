package at.fh.ooe.swk.ufo.web.performances.model;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Objects;

import javax.inject.Inject;
import javax.inject.Named;

import org.apache.deltaspike.core.api.scope.ViewAccessScoped;

import at.fh.ooe.swk.ufo.web.application.model.IdMapperModel;
import at.fh.ooe.swk.ufo.web.performances.page.PerformanceSupport;

@ViewAccessScoped
@Named("performanceEditViewModel")
public class PerformanceEditViewModel implements Serializable {

	private static final long serialVersionUID = 1994942977872442719L;

	@Inject
	private PerformanceSupport support;

	private Long id;
	private IdMapperModel<Long> artist;
	private IdMapperModel<Long> venue;
	private Calendar date;
	private Integer hour;

	public void init(Calendar now, int startHour) {
		Objects.requireNonNull(now);

		reset();

		// prepare initial date
		date = Calendar.getInstance();
		date.set(now.get(Calendar.YEAR), now.get(Calendar.MONTH), now.get(Calendar.DATE), 0, 0, 0);
		// prepare times
		hour = startHour;
	}

	public void init(PerformanceViewModel model, int startHour) {
		Objects.requireNonNull(model);

		reset();

		id = model.getId();
		artist = support.getArtistForId(model.getArtistId());
		venue = support.getVenueForId(model.getVenueId());
		date = model.getStartDate();
		hour = startHour;
	}

	public void reset() {
		id = null;
		artist = null;
		venue = null;
		date = null;
		hour = null;
	}

	public Long getId() {
		return id;
	}

	public IdMapperModel<Long> getArtist() {
		return artist;
	}

	public void setArtist(IdMapperModel<Long> artist) {
		this.artist = artist;
	}

	public IdMapperModel<Long> getVenue() {
		return venue;
	}

	public void setVenue(IdMapperModel<Long> venue) {
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
