package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.util.Calendar;
import java.util.TimeZone;

import javax.enterprise.inject.Instance;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.inject.Inject;
import javax.inject.Named;

import org.apache.deltaspike.core.api.scope.ViewAccessScoped;
import org.apache.logging.log4j.Logger;
import org.primefaces.context.RequestContext;

import at.fh.ooe.swk.ufo.service.proxy.api.PerformanceServiceProxy;
import at.fh.ooe.swk.ufo.service.proxy.model.PerformanceModel;
import at.fh.ooe.swk.ufo.service.proxy.model.ResultModel;
import at.fh.ooe.swk.ufo.web.application.ProxyServiceExceptionHandler;
import at.fh.ooe.swk.ufo.web.application.bean.LanguageBean;
import at.fh.ooe.swk.ufo.web.application.bean.UserContextModel;
import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceEditViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;

@ViewAccessScoped
@Named("performanceEditDialog")
public class PerformanceEditDialogBean implements Serializable {

	private static final long serialVersionUID = -2482703918283199463L;

	@Inject
	private FacesContext fc;
	@Inject
	private Logger log;
	@Inject
	private MessagesBundle bundle;
	@Inject
	private TimeZone timeZone;

	@Inject
	private PerformanceServiceProxy performanceService;
	@Inject
	private ProxyServiceExceptionHandler proxaExceptionHanlder;

	@Inject
	private LanguageBean languageBean;
	@Inject
	private PerformanceSupport support;
	@Inject
	private PerformancesPage page;
	@Inject
	private PerformanceEditViewModel editViewModel;
	@Inject
	private UserContextModel utx;

	private Calendar minDate;
	private Calendar maxDate;
	private Integer startHour;
	private Boolean started;

	public void init(PerformanceViewModel model) {
		final Calendar now = Calendar.getInstance();
		// prepare date borders
		minDate = Calendar.getInstance();
		maxDate = Calendar.getInstance();
		maxDate.set(now.get(Calendar.YEAR), Calendar.DECEMBER, 31, 23, 0, 0);

		// init edit view
		if (model == null) {
			editViewModel.init(now, 1);
		} else {
			editViewModel.init(model);
		}

		minDate.setTimeZone(timeZone);
		maxDate.setTimeZone(timeZone);
		started = Boolean.TRUE;
	}

	// ##################################################
	// Actions
	// ##################################################
	public void newEntry(ActionEvent event) {
		init(null);
	}

	public void save(ActionEvent event) {
		final String clientId = event.getComponent().getClientId();
		final Calendar startDate = editViewModel.getDate();
		startDate.set(Calendar.HOUR_OF_DAY, editViewModel.getHour());

		try {
			// prepare request
			final PerformanceModel model = new PerformanceModel();
			model.setUsername(utx.getUsername());
			model.setPassword(utx.getPassword());
			model.setLanguageCode(languageBean.getLocale().getLanguage());
			model.setId(editViewModel.getId());
			model.setVersion(editViewModel.getVersion());
			model.setArtistId(editViewModel.getArtist().getId());
			model.setVenueId(editViewModel.getVenue().getId());
			model.setStartDate(startDate);

			// Call web service
			ResultModel<PerformanceViewModel> result = performanceService.save(model);

			// Handle response
			if ((!proxaExceptionHanlder.handleException(null, result)) && (result.getResult() != null)) {
				support.loadArtistFilterOptions();
				support.loadVenueFilterOptions();
				page.loadPerformances();
				init(result.getResult());
				RequestContext.getCurrentInstance().execute("updateFilterAndContent();");
			}
		} catch (Exception e) {
			log.error("Could not save perforamnce", e);
			fc.addMessage(clientId, new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getUnexpectedError(), ""));
		}
	}

	public void delete(ActionEvent event) {
		final String clientId = event.getComponent().getClientId();
		try {
			// Prepare request
			final PerformanceModel model = new PerformanceModel();
			model.setId(editViewModel.getId());
			model.setVersion(editViewModel.getVersion());
			model.setUsername(utx.getUsername());
			model.setPassword(utx.getPassword());
			model.setLanguageCode(languageBean.getLocale().getLanguage());

			// Call web service
			ResultModel<Boolean> result = performanceService.delete(model);

			// Handle response
			if ((!proxaExceptionHanlder.handleException(null, result)) && (result.getResult() != null)) {
				support.loadArtistFilterOptions();
				support.loadVenueFilterOptions();
				page.loadPerformances();
				init(null);
				RequestContext.getCurrentInstance().execute("updateFilterAndContent();");
			}
		} catch (Exception e) {
			log.error("Could not delete perforamnce", e);
			fc.addMessage(clientId, new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getUnexpectedError(), ""));
		}
	}

	// ##################################################
	// Event Listener
	// ##################################################
	public void onClose() {
		reset();
	}

	public void reset() {
		minDate = null;
		maxDate = null;
		startHour = null;

		editViewModel.reset();

		started = Boolean.FALSE;
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public Calendar getMinDate() {
		return minDate;
	}

	public Calendar getMaxDate() {
		return maxDate;
	}

	public Integer getStartHour() {
		return startHour;
	}

	public Boolean getStarted() {
		return started;
	}
}
