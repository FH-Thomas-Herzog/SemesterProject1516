package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.context.SessionScoped;
import javax.enterprise.inject.Produces;
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

@ApplicationScoped
public class PerformanceFilterSupport implements Serializable {

	private static final long serialVersionUID = -2624440244824919675L;

	@Inject
	private transient ArtistServiceSoap artistWebservice;
	@Inject
	private Logger log;
	@Inject
	private MessagesBundle bundle;

	@Produces
	@RequestScoped
	@Named("artistFilterItems")
	public List<SelectItem> createArtistFilterOptions(LanguageBean languageBean) {
		List<SelectItem> items = new ArrayList<>();
		// Caused context not active if used in lambda expression
		final Locale locale = languageBean.getLocale();
		try {
			items = Arrays.asList(artistWebservice.getSimpleArtists()).parallelStream().map(artist -> {
				final String label = new StringBuilder(artist.getLastName()).append(", ").append(artist.getFirstName())
						.toString();
				final String description = new StringBuilder(artist.getEmail()).append("( ")
						.append(new Locale("", artist.getCountryCode()).getDisplayCountry(locale))
						.append(")").toString();
				return new SelectItem(new IdMapperModel<Long>(artist.getId(), UUID.randomUUID().toString()), label,
						description);
			}).collect(Collectors.toList());
		} catch (Exception e) {
			log.error("Could not load artists", e);
		}

		return items;
	}

	@Produces
	@RequestScoped
	@Named("artistFilterItemsConverter")
	public Converter createArtistFilterOptionsConverter(@Named("artistFilterItems") List<SelectItem> items) {
		return new SelectItemIdMapperModelConverter(items, bundle);
	}
}
