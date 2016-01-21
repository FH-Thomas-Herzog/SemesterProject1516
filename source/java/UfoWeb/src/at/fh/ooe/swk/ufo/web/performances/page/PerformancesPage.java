package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.text.Format;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.function.Consumer;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;
import javax.enterprise.context.SessionScoped;
import javax.enterprise.inject.Instance;
import javax.faces.context.FacesContext;
import javax.inject.Inject;
import javax.inject.Named;

import org.apache.logging.log4j.Logger;
import org.primefaces.context.RequestContext;

import at.fh.ooe.swk.ufo.service.api.model.ResultModel;
import at.fh.ooe.swk.ufo.service.api.proxy.ArtistServiceProxy;
import at.fh.ooe.swk.ufo.service.api.proxy.PerformanceServiceProxy;
import at.fh.ooe.swk.ufo.web.application.bean.LanguageBean;
import at.fh.ooe.swk.ufo.web.application.exception.ProxyServiceExceptionHandler;
import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;
import at.fh.ooe.swk.ufo.web.performances.constants.ArtistSearchOption;
import at.fh.ooe.swk.ufo.web.performances.constants.VenueSearchOption;
import at.fh.ooe.swk.ufo.web.performances.model.ArtistViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.VenueViewModel;

@SessionScoped
@Named("performancePage")
public class PerformancesPage implements Serializable {

	private static final long serialVersionUID = 5519942591137456554L;

	@Inject
	private ProxyServiceExceptionHandler proxyExceptionHandler;

	@Inject
	private ArtistServiceProxy artistServiceProxy;

	@Inject
	private PerformanceSupport support;
	@Inject
	private LanguageBean languageBean;

	private String artistSearch;
	private ArtistViewModel selectedArtist;
	private ArtistSearchOption selectedArtistSearchOption;
	private List<ArtistViewModel> filteredArtists;

	private String venueSearch;
	private VenueSearchOption selectedVenueSearchOption;
	private List<VenueViewModel> filteredVenues;

	public PerformancesPage() {
		super();
	}

	@PostConstruct
	public void postConstruct() {
		onArtistsSearchReset();
		onVenuesSearchReset();
	}

	// ##################################################
	// Artist section
	// ##################################################
	public void onArtistsSearchReset() {
		selectedArtistSearchOption = ArtistSearchOption.NAME;
		filteredArtists = null;
		artistSearch = null;
	}

	public void onArtistSearch() {
		if ((artistSearch == null) || (artistSearch.trim().isEmpty())) {
			filteredArtists = null;
		} else {
			final Locale locale = languageBean.getLocale();
			final String query = artistSearch.toUpperCase();
			filteredArtists = support.getArtists().parallelStream().filter(artist -> {
				switch (selectedArtistSearchOption) {
				case NAME:
					return artist.getFullName().toUpperCase().contains(query);
				case ARTIST_GROUP:
					return ((artist.getArtistGroup() != null)
							&& (artist.getArtistGroup().toUpperCase().contains(query)));
				case ARTIST_CATEGORY:
					return (artist.getArtistCategory() != null)
							&& (artist.getArtistCategory().toUpperCase().contains(query));
				case COUNTRY:
					return (artist.getCountryName(locale) != null)
							? artist.getCountryName(locale).toUpperCase().contains(query) : Boolean.FALSE;
				default:
					throw new IllegalArgumentException(
							"SearchOption: " + selectedArtistSearchOption.name() + " not supported");
				}
			}).collect(Collectors.toList());
		}
	}

	public void prepareArtistDialog(Long id) {
		selectedArtist = null;
		ResultModel<ArtistViewModel> result = artistServiceProxy.getArtist(id);
		if ((!proxyExceptionHandler.handleException(null, result)) && (result.getResult() != null)) {
			selectedArtist = result.getResult();
			RequestContext.getCurrentInstance().execute("PF('artistInfoDialog').show();");
		}
	}

	public void onArtistDialogClose() {
		selectedArtist = null;
	}

	// ##################################################
	// Venue section
	// ##################################################
	public void onVenuesSearchReset() {
		selectedVenueSearchOption = VenueSearchOption.NAME;
		filteredVenues = null;
		venueSearch = null;
	}

	public void onVenueSearch() {
		if ((venueSearch == null) || (venueSearch.trim().isEmpty())) {
			filteredVenues = null;
		} else {
			final String query = venueSearch.toUpperCase();
			filteredVenues = support.getVenues().parallelStream().filter(venue -> {
				switch (selectedVenueSearchOption) {
				case NAME:
					return venue.getName().toUpperCase().contains(query);
				case ADDRESS:
					return venue.getAddress().toUpperCase().contains(query);
				default:
					throw new IllegalArgumentException(
							"SearchOption: " + selectedArtistSearchOption.name() + " not supported");
				}

			}).collect(Collectors.toList());
		}
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public String getArtistSearch() {
		return artistSearch;
	}

	public void setArtistSearch(String artistSearch) {
		this.artistSearch = artistSearch;
	}

	public ArtistViewModel getSelectedArtist() {
		return selectedArtist;
	}

	public ArtistSearchOption getSelectedArtistSearchOption() {
		return selectedArtistSearchOption;
	}

	public void setSelectedArtistSearchOption(ArtistSearchOption selectedArtistSearchOption) {
		this.selectedArtistSearchOption = selectedArtistSearchOption;
	}

	public List<ArtistViewModel> getFilteredArtists() {
		return filteredArtists;
	}

	public VenueSearchOption getSelectedVenueSearchOption() {
		return selectedVenueSearchOption;
	}

	public void setSelectedVenueSearchOption(VenueSearchOption selectedVenueSearchOption) {
		this.selectedVenueSearchOption = selectedVenueSearchOption;
	}

	public String getVenueSearch() {
		return venueSearch;
	}

	public void setVenueSearch(String venueSearch) {
		this.venueSearch = venueSearch;
	}

	public List<VenueViewModel> getFilteredVenues() {
		return filteredVenues;
	}

}
