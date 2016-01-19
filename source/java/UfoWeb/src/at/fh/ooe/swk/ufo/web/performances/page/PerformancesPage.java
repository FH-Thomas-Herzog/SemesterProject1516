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

import at.fh.ooe.swk.ufo.service.proxy.api.ArtistServiceProxy;
import at.fh.ooe.swk.ufo.service.proxy.api.PerformanceServiceProxy;
import at.fh.ooe.swk.ufo.service.proxy.model.ResultModel;
import at.fh.ooe.swk.ufo.web.application.ProxyServiceExceptionHandler;
import at.fh.ooe.swk.ufo.web.application.bean.LanguageBean;
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
	private FacesContext fc;
	@Inject
	private Logger log;

	@Inject
	private MessagesBundle bundle;
	@Inject
	private LanguageBean languageBean;
	@Inject
	private ProxyServiceExceptionHandler proxyExceptionHandler;

	@Inject
	private PerformanceServiceProxy performanceServiceProxy;
	@Inject
	private ArtistServiceProxy artistServiceProxy;

	@Inject
	private Instance<PerformanceLazyDataTableModel> dataTableSubPageInstances;
	@Inject
	private PerformanceFilterBean performanceFilterPage;
	@Inject
	private PerformanceSupport support;

	private List<PerformanceLazyDataTableModel> tables;

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
		loadPerformances();
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
			onArtistsSearchReset();
		} else {
			final String query = artistSearch.toUpperCase();
			filteredArtists = support.getArtists().parallelStream().filter(artist -> {
				switch (selectedArtistSearchOption) {
				case NAME:
					return artist.getFullName().toUpperCase().contains(query);
				case ARTIST_GROUP:
					return ((artist.getArtistGroup() != null)
							&& (artist.getArtistGroup().toUpperCase().contains(query)));
				case ARTIST_CATEGORY:
					return Boolean.FALSE;
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
			onVenuesSearchReset();
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
	// Load Methods
	// ##################################################
	public void loadPerformances() {
		tables = new ArrayList<>();

		// Load performances via proxy
		final ResultModel<List<PerformanceViewModel>> result = performanceServiceProxy
				.getPerforamnces(performanceFilterPage.createFilter());

		// HAndle Exception
		proxyExceptionHandler.handleException(null, result);
		// Handle loaded performances
		if (result.getResult() != null) {
			// group performances by their start date value
			final Map<Calendar, List<PerformanceViewModel>> map = result.getResult().parallelStream()
					.collect(Collectors.groupingBy(model -> {
						final Calendar cal = (Calendar) model.getStartDate().clone();
						cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE), 0, 0);
						return cal;
					}));
			// Sort performances by their full startDate
			map.entrySet().forEach(new Consumer<Entry<Calendar, List<PerformanceViewModel>>>() {
				public void accept(Entry<Calendar, List<PerformanceViewModel>> t) {
					t.getValue().sort(new Comparator<PerformanceViewModel>() {
						public int compare(PerformanceViewModel o1, PerformanceViewModel o2) {
							return o1.getStartDate().compareTo(o2.getStartDate());
						};
					});
				};
			});
			// Prepare table pages for each date
			for (Entry<Calendar, List<PerformanceViewModel>> entry : map.entrySet()) {
				final PerformanceLazyDataTableModel table = dataTableSubPageInstances.get();
				table.init(entry.getKey(), entry.getValue());
				tables.add(table);
			}
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

	public List<PerformanceLazyDataTableModel> getTables() {
		return tables;
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
