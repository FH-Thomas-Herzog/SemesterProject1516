package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.text.Format;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.ArrayList;
import java.util.Arrays;
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
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.inject.Inject;
import javax.inject.Named;

import org.apache.logging.log4j.Logger;

import at.fh.ooe.swk.ufo.web.application.bean.LanguageBean;
import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;
import at.fh.ooe.swk.ufo.web.application.model.IdLabelModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoap;
import at.fh.ooe.swk.ufo.webservice.ResultModelOfListOfPerformanceModel;

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
	private transient PerformanceServiceSoap performanceWebservice;
	@Inject
	private Instance<PerformanceViewModel> perforamnceModelInstance;

	@Inject
	private Instance<PerformanceLazyDataTableModel> dataTableSubPageInstances;
	@Inject
	private PerformanceFilterBean performanceFilterPage;
	@Inject
	private LanguageBean languageBean;

	private List<PerformanceLazyDataTableModel> tables;

	public PerformancesPage() {
		super();
	}

	@PostConstruct
	public void postConstruct() {
		loadPerformances();
	}

	// ##################################################
	// Helper
	// ##################################################
	public void loadPerformances() {
		tables = new ArrayList<>();
		if (performanceWebservice != null) {
			List<PerformanceViewModel> performances = null;
			try {
				// Formatter for current set locale
				Format formatter = DateTimeFormatter.ofLocalizedDate(FormatStyle.LONG)
						.withLocale(languageBean.getLocale()).toFormat();
				final ResultModelOfListOfPerformanceModel result = performanceWebservice
						.getPerformances(performanceFilterPage.createRequestModel());
				if (result.getErrorCode() != null) {
					log.error("Webservice returned error code: " + result.getErrorCode() + " / error: "
							+ result.getError());
					fc.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getUnexpectedError(), ""));
				} else {
					// Load performances depending on set filter
					performances = Arrays.asList(result.getResult()).parallelStream().map(model -> {
						final PerformanceViewModel viewModel = perforamnceModelInstance.get();
						viewModel.init(model);
						return viewModel;
					}).collect(Collectors.toList());
					// group performances by their start date value
					final Map<String, List<PerformanceViewModel>> map = performances.parallelStream()
							.collect(Collectors.groupingBy(model -> formatter
									.format(((GregorianCalendar) model.getStartDate()).toZonedDateTime())));
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

					fc.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "loaded performances", ""));
				}
			} catch (Exception e) {
				log.error("Error during load", e);
				fc.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getUnexpectedError(), ""));
			}
		}
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public List<PerformanceLazyDataTableModel> getTables() {
		return tables;
	}
}
