package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.text.Format;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.ArrayList;
import java.util.Collections;
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
import at.fh.ooe.swk.ufo.web.performances.model.ArtistViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;

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
	private LanguageBean languageBean;

	private ArtistViewModel selectedArtist;
	private List<PerformanceLazyDataTableModel> tables;
	private List<ArtistViewModel> artists;

	public PerformancesPage() {
		super();
	}

	@PostConstruct
	public void postConstruct() {
		loadPerformances();
		loadArtists();
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
	// Load Methods
	// ##################################################
	public void loadPerformances() {
		tables = new ArrayList<>();

		// Formatter for current set locale
		Format formatter = DateTimeFormatter.ofLocalizedDate(FormatStyle.LONG).withLocale(languageBean.getLocale())
				.toFormat();

		// Load performances via proxy
		final ResultModel<List<PerformanceViewModel>> result = performanceServiceProxy
				.getPerforamnces(performanceFilterPage.createFilter());

		// HAndle Exception
		proxyExceptionHandler.handleException(null, result);
		// Handle loaded performances
		if (result.getResult() != null) {
			// group performances by their start date value
			final Map<String, List<PerformanceViewModel>> map = result.getResult().parallelStream()
					.collect(Collectors.groupingBy(
							model -> formatter.format(((GregorianCalendar) model.getStartDate()).toZonedDateTime())));
			// Sort performances by their full startDate
			map.entrySet().forEach(new Consumer<Entry<String, List<PerformanceViewModel>>>() {
				public void accept(Entry<String, List<PerformanceViewModel>> t) {
					t.getValue().sort(new Comparator<PerformanceViewModel>() {
						public int compare(PerformanceViewModel o1, PerformanceViewModel o2) {
							return o1.getStartDate().compareTo(o2.getStartDate());
						};
					});
				};
			});
			// Prepare table pages for each date
			for (Entry<String, List<PerformanceViewModel>> entry : map.entrySet()) {
				final PerformanceLazyDataTableModel table = dataTableSubPageInstances.get();
				table.init(entry.getKey(), entry.getValue());
				tables.add(table);
			}
		}
	}

	public void loadArtists() {
		final ResultModel<List<ArtistViewModel>> result = artistServiceProxy.getSimpleArtists();
		if (!proxyExceptionHandler.handleException(null, result)) {
			artists = (result.getResult() != null) ? result.getResult() : Collections.EMPTY_LIST;
		} else {
			artists = Collections.EMPTY_LIST;
		}
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public List<PerformanceLazyDataTableModel> getTables() {
		return tables;
	}

	public ArtistViewModel getSelectedArtist() {
		return selectedArtist;
	}

	public List<ArtistViewModel> getArtists() {
		return artists;
	}
}
