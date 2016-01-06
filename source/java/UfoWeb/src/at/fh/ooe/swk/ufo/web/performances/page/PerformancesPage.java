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
import javax.enterprise.inject.Instance;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.inject.Inject;
import javax.inject.Named;

import org.apache.deltaspike.core.api.scope.ViewAccessScoped;
import org.apache.logging.log4j.Logger;

import at.fh.ooe.swk.ufo.web.application.bean.LanguageBean;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoap;

@ViewAccessScoped
@Named("performancePage")
public class PerformancesPage implements Serializable {

	private static final long serialVersionUID = 5519942591137456554L;

	@Inject
	private FacesContext fc;

	@Inject
	private transient PerformanceServiceSoap performanceWebservice;
	@Inject
	private Logger log;

	@Inject
	private Instance<DataTableSubPage> dataTableSubPageInstances;
	@Inject
	private PerformanceFilterSubPage performanceFilterPage;
	@Inject
	private LanguageBean languageBean;

	private Integer selectedUser;
	private List<DataTableSubPage> tables;

	public PerformancesPage() {
		super();
	}

	@PostConstruct
	public void postConstruct() {
		selectedUser = 1;
		loadPerformances();
	}

	// ##################################################
	// Event listener
	// ##################################################

	// ##################################################
	// Helper
	// ##################################################
	private void loadPerformances() {
		tables = new ArrayList<>();
		if (performanceWebservice != null) {
			List<PerformanceViewModel> performances = null;
			try {
				// Formatter for current set locale
				Format formatter = DateTimeFormatter.ofLocalizedDate(FormatStyle.LONG)
						.withLocale(languageBean.getLocale()).toFormat();
				// Load performances depending on set filter
				performances = Arrays
						.asList(performanceWebservice.getPerformances(performanceFilterPage.createRequestModel()))
						.parallelStream().map(model -> new PerformanceViewModel(model)).collect(Collectors.toList());
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
					final DataTableSubPage table = dataTableSubPageInstances.get();
					table.init(entry.getKey(), entry.getValue());
					tables.add(table);
				}

				fc.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "loaded performances", "bla"));
			} catch (Exception e) {
				fc.addMessage(null,
						new FacesMessage(FacesMessage.SEVERITY_ERROR, "Could not load performances", "bla"));
			}
		}
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public Integer getSelectedUser() {
		return selectedUser;
	}

	public void setSelectedUser(Integer selectedUser) {
		this.selectedUser = selectedUser;
	}

	public List<DataTableSubPage> getTables() {
		return tables;
	}

	public void setTables(List<DataTableSubPage> tables) {
		this.tables = tables;
	}
}
