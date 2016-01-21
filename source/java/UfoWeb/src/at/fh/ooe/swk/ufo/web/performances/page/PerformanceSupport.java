package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.function.Consumer;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.context.SessionScoped;
import javax.enterprise.inject.Instance;
import javax.enterprise.inject.Produces;
import javax.faces.convert.Converter;
import javax.faces.model.SelectItem;
import javax.faces.model.SelectItemGroup;
import javax.inject.Inject;
import javax.inject.Named;

import at.fh.ooe.swk.ufo.service.api.model.ResultModel;
import at.fh.ooe.swk.ufo.service.api.proxy.ArtistServiceProxy;
import at.fh.ooe.swk.ufo.service.api.proxy.PerformanceServiceProxy;
import at.fh.ooe.swk.ufo.service.api.proxy.VenueServiceProxy;
import at.fh.ooe.swk.ufo.web.application.bean.LanguageBean;
import at.fh.ooe.swk.ufo.web.application.converter.SelectItemEnumConverter;
import at.fh.ooe.swk.ufo.web.application.converter.SelectItemIdHolderLongConverter;
import at.fh.ooe.swk.ufo.web.application.converter.SelectItemObjectConverter;
import at.fh.ooe.swk.ufo.web.application.exception.ProxyServiceExceptionHandler;
import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;
import at.fh.ooe.swk.ufo.web.application.model.SimpleNameViewModel;
import at.fh.ooe.swk.ufo.web.performances.constants.ArtistSearchOption;
import at.fh.ooe.swk.ufo.web.performances.constants.PerformanceSearchOption;
import at.fh.ooe.swk.ufo.web.performances.constants.VenueSearchOption;
import at.fh.ooe.swk.ufo.web.performances.model.ArtistViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.VenueViewModel;

@SessionScoped
@Named("performanceSupport")
public class PerformanceSupport implements Serializable {

	private static final long serialVersionUID = -2624440244824919675L;

	@Inject
	private ArtistServiceProxy artistServiceProxy;
	@Inject
	private VenueServiceProxy venueServiceProxy;
	@Inject
	private PerformanceServiceProxy performanceServiceProxy;
	@Inject
	private ProxyServiceExceptionHandler proxyExceptionHandler;

	@Inject
	private Instance<PerformanceLazyDataTableModel> dataTableSubPageInstances;

	@Inject
	private MessagesBundle bundle;
	@Inject
	private LanguageBean languageBean;
	@Inject
	private PerformanceFilterBean performanceFilter;

	private List<PerformanceLazyDataTableModel> performanceTableModels = new ArrayList<>();
	private List<PerformanceViewModel> performances = new ArrayList<>();
	private List<SimpleNameViewModel<Long>> artistGroups = new ArrayList<>();
	private List<SimpleNameViewModel<Long>> artistCategories = new ArrayList<>();
	private List<ArtistViewModel> artists = new ArrayList<>();
	private List<VenueViewModel> venues = new ArrayList<>();

	private List<SelectItem> artistGroupItems = new ArrayList<>();
	private List<SelectItem> artistCategoryItems = new ArrayList<>();
	private List<SelectItem> artistItems = new ArrayList<>();
	private List<SelectItem> venueItems = new ArrayList<>();

	public static class SelectItemComparator implements Comparator<SelectItem> {
		@Override
		public int compare(SelectItem o1, SelectItem o2) {
			return o1.getLabel().compareTo(o2.getLabel());
		}
	}

	@PostConstruct
	public void init() {
		loadSimpleArtists();
		loadSimpleVenues();
		loadSimpleArtistGroups();
		loadSimpleArtistCategories();
		loadPerformances();
	}

	@Produces
	@RequestScoped
	@Named("artistSearchOptionItems")
	public List<SelectItem> getArtistSearchOtpionItems() {
		final List<SelectItem> items = new ArrayList<>(ArtistSearchOption.values().length);
		items.add(new SelectItem(ArtistSearchOption.NAME, bundle.getName()));
		items.add(new SelectItem(ArtistSearchOption.ARTIST_CATEGORY, bundle.getArtistCategory()));
		items.add(new SelectItem(ArtistSearchOption.ARTIST_GROUP, bundle.getArtistGroup()));
		items.add(new SelectItem(ArtistSearchOption.COUNTRY, bundle.getCountry()));

		return items;
	}

	@Produces
	@RequestScoped
	@Named("artistSearchOptionItemsConverter")
	public Converter getArtistSearchOtpionItemsConverter(
			final @Named("artistSearchOptionItems") List<SelectItem> items) {
		return new SelectItemEnumConverter(items, bundle);
	}

	@Produces
	@RequestScoped
	@Named("venueSearchOptionItems")
	public List<SelectItem> getVenueSearchOtpionItems() {
		final List<SelectItem> items = new ArrayList<>(VenueSearchOption.values().length);
		items.add(new SelectItem(VenueSearchOption.NAME, bundle.getName()));
		items.add(new SelectItem(VenueSearchOption.ADDRESS, bundle.getAddress()));

		return items;
	}

	@Produces
	@RequestScoped
	@Named("venueSearchOptionItemsConverter")
	public Converter getVenueSearchOtpionItemsConverter(final @Named("venueSearchOptionItems") List<SelectItem> items) {
		return new SelectItemEnumConverter(items, bundle);
	}

	@Produces
	@RequestScoped
	@Named("performanceSearchOptionItems")
	public List<SelectItem> getPerformanceSearchOtpionItems() {
		final List<SelectItem> items = new ArrayList<>(ArtistSearchOption.values().length);
		items.add(new SelectItem(PerformanceSearchOption.ALL, bundle.getAll()));
		items.add(new SelectItem(PerformanceSearchOption.MOVED, bundle.getMoved()));
		items.add(new SelectItem(PerformanceSearchOption.NOT_MOVED, bundle.getNotMoved()));

		return items;
	}

	@Produces
	@RequestScoped
	@Named("performanceSearchOptionItemsConverter")
	public Converter getPerformanceSearchOtpionItemsConverter(
			final @Named("performanceSearchOptionItems") List<SelectItem> items) {
		return new SelectItemEnumConverter(items, bundle);
	}

	@Produces
	@RequestScoped
	@Named("countryOptionItems")
	public List<SelectItem> getCountrySearchOtpionItems() {
		final Locale locale = languageBean.getLocale();
		return Arrays.asList(Locale.getISOCountries()).parallelStream().map(country -> new Locale("", country))
				.collect(Collectors.toList()).parallelStream()
				.map(l -> new SelectItem(l, l.getDisplayCountry(locale), l.getCountry().toUpperCase()))
				.sorted(new SelectItemComparator()).collect(Collectors.toList());
	}

	@Produces
	@RequestScoped
	@Named("countryOptionItemsConverter")
	public Converter getCountrySearchOtpionItemsConverter(final @Named("countryOptionItems") List<SelectItem> items) {
		return new SelectItemObjectConverter(items, bundle);
	}

	@Produces
	@RequestScoped
	@Named("performanceItems")
	public List<SelectItemGroup> getPerformanceItems() {
		final Calendar now = Calendar.getInstance();
		final List<SelectItemGroup> items = new ArrayList<>();

		// DateTimeFormatter for the group label
		final DateFormat dateTimeFormatter = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT,
				languageBean.getLocale());

		// Map performances to their startDate value
		final Map<Calendar, List<PerformanceViewModel>> groups = performances.parallelStream()
				.filter(m -> (now.compareTo(m.getStartDate()) < 0))
				.collect(Collectors.groupingBy(model -> model.getStartDate()));

		// Create items groups
		groups.entrySet().forEach(entry -> {
			final List<SelectItem> groupedItems = entry.getValue().parallelStream()
					.map(m -> new SelectItem(m, new StringBuilder(m.getVenue().getName()).append(" - ")
							.append(m.getArtist().getFullName()).toString()))
					.sorted(new SelectItemComparator()).collect(Collectors.toList());
			final SelectItemGroup group = new SelectItemGroup(dateTimeFormatter.format(entry.getKey().getTime()), "",
					Boolean.FALSE, groupedItems.toArray(new SelectItem[groupedItems.size()]));
			items.add(group);
		});

		items.sort(new SelectItemComparator());

		return items;
	}

	@Produces
	@RequestScoped
	@Named("performanceItemsConverter")
	public Converter getPerformanceItemsConverter(final @Named("performanceItems") List<SelectItemGroup> items) {
		return new SelectItemIdHolderLongConverter(items.stream()
				.flatMap(group -> Arrays.asList(group.getSelectItems()).parallelStream()).collect(Collectors.toList()),
				bundle);
	}

	@Produces
	@RequestScoped
	@Named("artistsItemsConverter")
	public Converter getArtistItemConverter() {
		return new SelectItemIdHolderLongConverter(artistItems, bundle);
	}

	@Produces
	@RequestScoped
	@Named("venuesItemsConverter")
	public Converter getVenueItemConverter() {
		return new SelectItemIdHolderLongConverter(venueItems, bundle);
	}

	@Produces
	@RequestScoped
	@Named("artistGroupItemsConverter")
	public Converter getArtistGroupItemConverter() {
		return new SelectItemIdHolderLongConverter(artistGroupItems, bundle);
	}

	@Produces
	@RequestScoped
	@Named("artistCategoryItemsConverter")
	public Converter getArtistCategoryItemConverter() {
		return new SelectItemIdHolderLongConverter(artistCategoryItems, bundle);
	}

	public void loadSimpleArtists() {
		artists = new ArrayList<>();
		artistItems = new ArrayList<>();
		// Caused context not active if used in lambda expression
		final Locale locale = languageBean.getLocale();
		final ResultModel<List<ArtistViewModel>> result = artistServiceProxy.getSimpleArtists();
		proxyExceptionHandler.handleException(null, result);

		if (result.getResult() != null) {
			artists = result.getResult();
			artistItems = artists.parallelStream().map(artist -> {
				final String label = new StringBuilder(artist.getLastName()).append(", ").append(artist.getFirstName())
						.toString();
				final String description = new StringBuilder(artist.getEmail()).append("( ")
						.append(artist.getCountryName(locale)).append(")").toString();
				return new SelectItem(artist, label, description);
			}).sorted(new SelectItemComparator()).collect(Collectors.toList());
		}
	}

	public void loadSimpleVenues() {
		venues = new ArrayList<>();
		venueItems = new ArrayList<>();

		final ResultModel<List<VenueViewModel>> result = venueServiceProxy.getVenues();
		proxyExceptionHandler.handleException(null, result);

		if (result.getResult() != null) {
			venues = result.getResult();
			venueItems = venues.parallelStream().map(venue -> {
				return new SelectItem(venue, venue.getName(), venue.getAddress());
			}).sorted(new SelectItemComparator()).collect(Collectors.toList());
		}
	}

	public void loadSimpleArtistGroups() {
		artistGroups = new ArrayList<>();
		artistGroupItems = new ArrayList<>();

		final ResultModel<List<SimpleNameViewModel<Long>>> result = artistServiceProxy.getSimpleArtistGroups();
		proxyExceptionHandler.handleException(null, result);

		if (result.getResult() != null) {
			artistGroups = result.getResult();
			artistGroupItems = artistGroups.parallelStream().map(item -> new SelectItem(item, item.getName()))
					.sorted(new SelectItemComparator()).collect(Collectors.toList());
		}
	}

	public void loadSimpleArtistCategories() {
		artistCategories = new ArrayList<>();
		artistCategoryItems = new ArrayList<>();

		final ResultModel<List<SimpleNameViewModel<Long>>> result = artistServiceProxy.getSimpleArtistCategories();
		proxyExceptionHandler.handleException(null, result);

		if (result.getResult() != null) {
			artistCategories = result.getResult();
			artistCategoryItems = artistCategories.parallelStream().map(item -> new SelectItem(item, item.getName()))
					.sorted(new SelectItemComparator()).collect(Collectors.toList());
		}
	}

	public void loadPerformances() {
		performances = new ArrayList<>();
		performanceTableModels = new ArrayList<>();

		// Load performances via proxy
		final ResultModel<List<PerformanceViewModel>> result = performanceServiceProxy
				.getPerforamnces(performanceFilter.createFilter());

		// HAndle Exception
		proxyExceptionHandler.handleException(null, result);
		// Handle loaded performances
		if (result.getResult() != null) {
			performances = result.getResult();
			final SortedMap<Calendar, List<PerformanceViewModel>> sortedMap = new TreeMap<>(new Comparator<Calendar>() {
				@Override
				public int compare(Calendar o1, Calendar o2) {
					final Calendar cal1 = (Calendar) o1.clone();
					cal1.set(cal1.get(Calendar.YEAR), cal1.get(Calendar.MONTH), cal1.get(Calendar.DATE), 0, 0);
					final Calendar cal2 = (Calendar) o2.clone();
					cal2.set(cal2.get(Calendar.YEAR), cal2.get(Calendar.MONTH), cal2.get(Calendar.DATE), 0, 0);
					return cal1.compareTo(cal2);
				}
			});
			// group performances by their start date value
			sortedMap.putAll(result.getResult().parallelStream().collect(Collectors.groupingBy(model -> {
				final Calendar cal = (Calendar) model.getStartDate().clone();
				cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE), 0, 0);
				return cal;
			})));
			// Sort performances by their full startDate
			sortedMap.entrySet().forEach(new Consumer<Entry<Calendar, List<PerformanceViewModel>>>() {
				public void accept(Entry<Calendar, List<PerformanceViewModel>> t) {
					t.getValue().sort(new Comparator<PerformanceViewModel>() {
						public int compare(PerformanceViewModel o1, PerformanceViewModel o2) {
							return o1.getStartDate().compareTo(o2.getStartDate());
						};
					});
				};
			});
			// Prepare table pages for each date
			for (Entry<Calendar, List<PerformanceViewModel>> entry : sortedMap.entrySet()) {
				final PerformanceLazyDataTableModel table = dataTableSubPageInstances.get();
				table.init(entry.getKey(), entry.getValue());
				performanceTableModels.add(table);
			}
		}
	}

	public ArtistViewModel getArtistIdMapperForId(long id) {
		final List<ArtistViewModel> filtered = artists.parallelStream().filter(artist -> artist.getId().equals(id))
				.collect(Collectors.toList());
		return (!filtered.isEmpty()) ? filtered.get(0) : null;
	}

	public VenueViewModel getVenueItMapperForId(long id) {
		final List<VenueViewModel> filtered = venues.parallelStream().filter(venue -> venue.getId().equals(id))
				.collect(Collectors.toList());
		return (!filtered.isEmpty()) ? filtered.get(0) : null;
	}

	public VenueViewModel getVenueViewForId(long id) {
		final List<VenueViewModel> filtered = venues.parallelStream()
				.filter(venue -> Long.valueOf(id).equals(venue.getId())).collect(Collectors.toList());
		return (!filtered.isEmpty()) ? filtered.get(0) : null;
	}

	public List<SelectItem> getArtistItems() {
		return artistItems;
	}

	public List<SelectItem> getVenueItems() {
		return venueItems;
	}

	public List<ArtistViewModel> getArtists() {
		return artists;
	}

	public List<VenueViewModel> getVenues() {
		return venues;
	}

	public List<PerformanceLazyDataTableModel> getPerformanceTableModels() {
		return performanceTableModels;
	}

	public List<SimpleNameViewModel<Long>> getArtistGroups() {
		return artistGroups;
	}

	public List<SimpleNameViewModel<Long>> getArtistCategories() {
		return artistCategories;
	}

	public List<SelectItem> getArtistGroupItems() {
		return artistGroupItems;
	}

	public List<SelectItem> getArtistCategoryItems() {
		return artistCategoryItems;
	}

}
