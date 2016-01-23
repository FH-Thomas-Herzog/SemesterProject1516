package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.util.Calendar;
import java.util.TimeZone;

import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.faces.event.ValueChangeEvent;
import javax.inject.Inject;
import javax.inject.Named;

import org.apache.deltaspike.core.api.scope.ViewAccessScoped;
import org.apache.logging.log4j.Logger;
import org.primefaces.context.RequestContext;

import at.fh.ooe.swk.ufo.service.api.annotation.ServiceTimeZone;
import at.fh.ooe.swk.ufo.service.api.model.PerformanceServiceRequestModel;
import at.fh.ooe.swk.ufo.service.api.model.ResultModel;
import at.fh.ooe.swk.ufo.service.api.proxy.PerformanceServiceProxy;
import at.fh.ooe.swk.ufo.web.application.bean.LanguageBean;
import at.fh.ooe.swk.ufo.web.application.bean.UserContextModel;
import at.fh.ooe.swk.ufo.web.application.exception.ProxyServiceExceptionHandler;
import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceEditViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;

/**
 * The edit view dialog bean which handdles the perforamnces save/delete
 * actions.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 23, 2016
 */
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
	@ServiceTimeZone
	private TimeZone serviceTimeZone;

	@Inject
	private PerformanceServiceProxy performanceService;
	@Inject
	private ProxyServiceExceptionHandler proxaExceptionHanlder;

	@Inject
	private LanguageBean languageBean;
	@Inject
	private PerformanceSupport support;
	@Inject
	private PerformanceEditViewModel editViewModel;
	@Inject
	private UserContextModel utx;

	private PerformanceViewModel selectedPerformance;
	private Calendar minDate;
	private Calendar maxDate;
	private Integer startHour;
	private Boolean started;

	/**
	 * Initializes this edit view bean with the given model. If null it
	 * indicates a new perforamnces is intended.
	 * 
	 * @param model
	 *            the model to initialize this handler. May be null
	 */
	public void init(PerformanceViewModel model) {
		reset();
		this.selectedPerformance = model;
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

		// prepare request
		startDate.setTimeZone(serviceTimeZone);
		final PerformanceServiceRequestModel model = new PerformanceServiceRequestModel();
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
		proxaExceptionHanlder.handleException(clientId, result);

		// Handle response
		if (result.getResult() != null) {
			init(result.getResult());
			RequestContext.getCurrentInstance().execute("updateFilterAndContent();");
		}
	}

	public void delete(ActionEvent event) {
		final String clientId = event.getComponent().getClientId();
		// Prepare request
		final PerformanceServiceRequestModel model = new PerformanceServiceRequestModel();
		model.setId(editViewModel.getId());
		model.setVersion(editViewModel.getVersion());
		model.setUsername(utx.getUsername());
		model.setPassword(utx.getPassword());
		model.setLanguageCode(languageBean.getLocale().getLanguage());

		// Call web service
		ResultModel<Boolean> result = performanceService.delete(model);

		// Handle response
		proxaExceptionHanlder.handleException(clientId, result);
		if (result.getResult() != null) {
			init(null);
			RequestContext.getCurrentInstance().execute("updateFilterAndContent();");
		}
	}

	// ##################################################
	// Event Listener
	// ##################################################
	public void onClose() {
		support.loadPerformances();
		reset();
	}

	public void onPerformanceSelect(ValueChangeEvent event) {
		PerformanceViewModel model = (PerformanceViewModel) event.getNewValue();
		init(model);
	}

	// ##################################################
	// Helper
	// ##################################################
	public void reset() {
		selectedPerformance = null;
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

	public PerformanceViewModel getSelectedPerformance() {
		return selectedPerformance;
	}

	public void setSelectedPerformance(PerformanceViewModel selectedPerformance) {
		this.selectedPerformance = selectedPerformance;
	}
}
