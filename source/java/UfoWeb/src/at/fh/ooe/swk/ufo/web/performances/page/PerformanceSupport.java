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
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.model.SelectItem;
import javax.inject.Inject;
import javax.inject.Named;

import org.apache.logging.log4j.Logger;

import com.sun.org.apache.bcel.internal.generic.NEWARRAY;

import at.fh.ooe.swk.ufo.web.application.bean.LanguageBean;
import at.fh.ooe.swk.ufo.web.application.converter.SelectItemIdMapperModelConverter;
import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;
import at.fh.ooe.swk.ufo.web.application.model.IdMapperModel;
import at.fh.ooe.swk.ufo.webservice.ArtistServiceSoap;
import at.fh.ooe.swk.ufo.webservice.ListResultModelOfArtistModel;
import at.fh.ooe.swk.ufo.webservice.ListResultModelOfVenueModel;
import at.fh.ooe.swk.ufo.webservice.ResultModelOfListOfArtistModel;
import at.fh.ooe.swk.ufo.webservice.ResultModelOfListOfVenueModel;
import at.fh.ooe.swk.ufo.webservice.VenueServiceSoap;

@SessionScoped
@Named("performanceSupport")
public class PerformanceSupport implements Serializable {

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
	@Inject
	private FacesContext fc;

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
			final ListResultModelOfArtistModel result = artistWebservice.getSimpleArtists();
			if (result.getErrorCode() != null) {
				artistItems = new ArrayList<>();
				log.error(
						"Webservice returned error code: " + result.getErrorCode() + " / error: " + result.getError());
				fc.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getUnexpectedError(), ""));
			} else {
				artistItems = Arrays.asList(result.getResult()).parallelStream().map(artist -> {
					final String label = new StringBuilder(artist.getLastName()).append(", ")
							.append(artist.getFirstName()).toString();
					final String description = new StringBuilder(artist.getEmail()).append("( ")
							.append(new Locale("", artist.getCountryCode()).getDisplayCountry(locale)).append(")")
							.toString();
					return new SelectItem(new IdMapperModel<Long>(artist.getId(), UUID.randomUUID().toString()), label,
							description);
				}).collect(Collectors.toList());
			}
		} catch (Exception e) {
			artistItems = new ArrayList<>();
			log.error("Could not load artists", e);
		}
		artistItemConverter = new SelectItemIdMapperModelConverter(artistItems, bundle);
	}

	public void loadVenueFilterOptions() {
		try {
			final ListResultModelOfVenueModel result = venueWebservice.getVenues();
			if (result.getErrorCode() != null) {
				log.error(
						"webservice returned error code: " + result.getErrorCode() + " / error: " + result.getError());
				venueItems = new ArrayList<>();
				fc.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getUnexpectedError(), ""));
			} else {
				venueItems = Arrays.asList(result.getResult()).parallelStream().map(venue -> {
					return new SelectItem(new IdMapperModel<Long>(venue.getId(), UUID.randomUUID().toString()),
							venue.getName(), venue.getFullAddress());
				}).collect(Collectors.toList());
			}
		} catch (Exception e) {
			venueItems = new ArrayList<>();
			log.error("Could not load artists", e);
			fc.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getUnexpectedError(), ""));
		}
		venueItemConverter = new SelectItemIdMapperModelConverter(venueItems, bundle);
	}

	public IdMapperModel<Long> getArtistForId(long id) {
		for (SelectItem selectItem : artistItems) {
			final IdMapperModel<Long> model = (IdMapperModel<Long>) selectItem.getValue();
			if (model.getId().equals(id)) {
				return (IdMapperModel<Long>) selectItem.getValue();
			}
		}
		return null;
	}

	public IdMapperModel<Long> getVenueForId(long id) {
		for (SelectItem selectItem : venueItems) {
			final IdMapperModel<Long> model = (IdMapperModel<Long>) selectItem.getValue();
			if (model.getId().equals(id)) {
				return (IdMapperModel<Long>) selectItem.getValue();
			}
		}
		return null;
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
