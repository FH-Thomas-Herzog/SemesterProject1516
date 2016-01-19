package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.context.SessionScoped;
import javax.enterprise.inject.Produces;
import javax.faces.convert.Converter;
import javax.faces.model.SelectItem;
import javax.inject.Inject;
import javax.inject.Named;

import at.fh.ooe.swk.ufo.service.proxy.api.ArtistServiceProxy;
import at.fh.ooe.swk.ufo.service.proxy.api.VenueServiceProxy;
import at.fh.ooe.swk.ufo.service.proxy.model.ResultModel;
import at.fh.ooe.swk.ufo.web.application.ProxyServiceExceptionHandler;
import at.fh.ooe.swk.ufo.web.application.bean.LanguageBean;
import at.fh.ooe.swk.ufo.web.application.converter.SelectItemEnumConverter;
import at.fh.ooe.swk.ufo.web.application.converter.SelectItemIdMapperModelConverter;
import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;
import at.fh.ooe.swk.ufo.web.application.model.IdMapperModel;
import at.fh.ooe.swk.ufo.web.performances.constants.ArtistSearchOption;
import at.fh.ooe.swk.ufo.web.performances.constants.VenueSearchOption;
import at.fh.ooe.swk.ufo.web.performances.model.ArtistViewModel;
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
	private ProxyServiceExceptionHandler proxyExceptionHandler;

	@Inject
	private MessagesBundle bundle;
	@Inject
	private LanguageBean languageBean;

	private List<ArtistViewModel> artists;
	private List<VenueViewModel> venues;
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
		loadArtistFilterOptions();
		loadVenueFilterOptions();
	}

	@Produces
	@RequestScoped
	@Named("artistSearchOptionItems")
	public List<SelectItem> getArtistSearchOtpionItems() {
		final List<SelectItem> items = new ArrayList<>(ArtistSearchOption.values().length);
		items.add(new SelectItem(ArtistSearchOption.NAME, bundle.getName()));
		items.add(new SelectItem(ArtistSearchOption.ARTIST_CATEGORY, bundle.getArtistCategory()));
		items.add(new SelectItem(ArtistSearchOption.ARTIST_GROUP, bundle.getArtistGroup()));

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

	public void loadArtistFilterOptions() {
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
				return new SelectItem(new IdMapperModel<Long>(artist.getId(), UUID.randomUUID().toString()), label,
						description);
			}).sorted(new SelectItemComparator()).collect(Collectors.toList());
		}
	}

	public void loadVenueFilterOptions() {
		venues = new ArrayList<>();
		venueItems = new ArrayList<>();

		final ResultModel<List<VenueViewModel>> result = venueServiceProxy.getVenues();
		proxyExceptionHandler.handleException(null, result);

		if (result.getResult() != null) {
			venues = result.getResult();
			venueItems = venues.parallelStream().map(venue -> {
				return new SelectItem(new IdMapperModel<Long>(venue.getId(), UUID.randomUUID().toString()),
						venue.getName(), venue.getAddress());
			}).sorted(new SelectItemComparator()).collect(Collectors.toList());
		}
	}

	public IdMapperModel<Long> getArtistIdMapperForId(long id) {
		for (SelectItem selectItem : artistItems) {
			final IdMapperModel<Long> model = (IdMapperModel<Long>) selectItem.getValue();
			if (model.getId().equals(id)) {
				return (IdMapperModel<Long>) selectItem.getValue();
			}
		}
		return null;
	}

	public IdMapperModel<Long> getVenueItMapperForId(long id) {
		for (SelectItem selectItem : venueItems) {
			final IdMapperModel<Long> model = (IdMapperModel<Long>) selectItem.getValue();
			if (model.getId().equals(id)) {
				return (IdMapperModel<Long>) selectItem.getValue();
			}
		}
		return null;
	}

	public VenueViewModel getVenueViewForId(long id) {
		final List<VenueViewModel> filtered = venues.parallelStream()
				.filter(venue -> Long.valueOf(id).equals(venue.getId())).collect(Collectors.toList());
		return (!filtered.isEmpty()) ? filtered.get(0) : null;
	}

	public Converter getArtistItemConverter() {
		return new SelectItemIdMapperModelConverter(artistItems, bundle);
	}

	public Converter getVenueItemConverter() {
		return new SelectItemIdMapperModelConverter(venueItems, bundle);
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

}
