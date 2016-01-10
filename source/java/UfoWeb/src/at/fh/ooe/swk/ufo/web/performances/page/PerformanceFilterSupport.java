package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;
import javax.enterprise.context.SessionScoped;
import javax.faces.convert.Converter;
import javax.faces.model.SelectItem;
import javax.inject.Inject;
import javax.inject.Named;

import org.apache.logging.log4j.Logger;

import at.fh.ooe.swk.ufo.web.application.bean.LanguageBean;
import at.fh.ooe.swk.ufo.web.application.converter.SelectItemIdMapperModelConverter;
import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;
import at.fh.ooe.swk.ufo.web.application.model.IdMapperModel;
import at.fh.ooe.swk.ufo.webservice.ArtistServiceSoap;
import at.fh.ooe.swk.ufo.webservice.VenueServiceSoap;

@SessionScoped
@Named("performanceFilterSupport")
public class PerformanceFilterSupport implements Serializable {

	private static final long serialVersionUID = -2624440244824919675L;

	@Inject
	private transient ArtistServiceSoap artistWebservice;
	@Inject
	private transient VenueServiceSoap venueWebservice;
	@Inject
	private Logger log;
	@Inject
	private MessagesBundle bundle;
	@Inject
	private LanguageBean languageBean;

	private Converter artistItemConverter;
	private Converter venueItemConverter;
	private List<SelectItem> artistItems = new ArrayList<>();
	private List<SelectItem> venueItems = new ArrayList<>();

	@PostConstruct
	public void init() {
		loadArtistFilterOptions();
		loadVenueFilterOptions();
	}

	public void loadArtistFilterOptions() {
		// Caused context not active if used in lambda expression
		final Locale locale = languageBean.getLocale();
		try {
			artistItems = Arrays.asList(artistWebservice.getSimpleArtists()).parallelStream().map(artist -> {
				final String label = new StringBuilder(artist.getLastName()).append(", ").append(artist.getFirstName())
						.toString();
				final String description = new StringBuilder(artist.getEmail()).append("( ")
						.append(new Locale("", artist.getCountryCode()).getDisplayCountry(locale)).append(")")
						.toString();
				return new SelectItem(new IdMapperModel<Long>(artist.getId(), UUID.randomUUID().toString()), label,
						description);
			}).collect(Collectors.toList());
		} catch (Exception e) {
			artistItems = new ArrayList<>();
			log.error("Could not load artists", e);
		}
		artistItemConverter = new SelectItemIdMapperModelConverter(artistItems, bundle);
	}

	public void loadVenueFilterOptions() {
		try {
			venueItems = Arrays.asList(venueWebservice.getVenues()).parallelStream().map(venue -> {
				return new SelectItem(new IdMapperModel<Long>(venue.getId(), UUID.randomUUID().toString()),
						venue.getName(), venue.getFullAddress());
			}).collect(Collectors.toList());
		} catch (Exception e) {
			venueItems = new ArrayList<>();
			log.error("Could not load artists", e);
		}
		venueItemConverter = new SelectItemIdMapperModelConverter(venueItems, bundle);
	}

	public Converter getArtistItemConverter() {
		return artistItemConverter;
	}

	public Converter getVenueItemConverter() {
		return venueItemConverter;
	}

	public List<SelectItem> getArtistItems() {
		return artistItems;
	}

	public List<SelectItem> getVenueItems() {
		return venueItems;
	}
}
