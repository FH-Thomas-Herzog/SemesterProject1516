package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.TimeZone;
import java.util.stream.Collectors;

import javax.enterprise.inject.Instance;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.inject.Inject;
import javax.inject.Named;

import org.apache.deltaspike.core.api.scope.ViewAccessScoped;
import org.apache.logging.log4j.Logger;
import org.primefaces.context.RequestContext;
import org.primefaces.model.map.DefaultMapModel;

import at.fh.ooe.swk.ufo.web.application.bean.LanguageBean;
import at.fh.ooe.swk.ufo.web.application.bean.UserContextModel;
import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceEditViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.VenueViewModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceRequestModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoap;
import at.fh.ooe.swk.ufo.webservice.SingleResultModelOfNullableOfBoolean;
import at.fh.ooe.swk.ufo.webservice.SingleResultModelOfPerformanceModel;

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
	private transient PerformanceServiceSoap performanceWebservice;

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

	@Inject
	private Instance<PerformanceViewModel> perforamnceViewModelInstance;
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
	public void save(ActionEvent event) {
		final String clientId = event.getComponent().getClientId();
		final Calendar startDate = editViewModel.getDate();
		startDate.set(Calendar.HOUR_OF_DAY, editViewModel.getHour());

		try {
			final PerformanceRequestModel request = new PerformanceRequestModel(null, null, null, utx.getUsername(),
					utx.getPassword(), editViewModel.getId(), editViewModel.getVersion(),
					editViewModel.getArtist().getId(), editViewModel.getVenue().getId(),
					languageBean.getLocale().toString(), startDate);

			SingleResultModelOfPerformanceModel result = performanceWebservice.save(request);
			if ((result.getErrorCode() == null) && (result.getServiceErrorCode() == null)) {
				support.loadArtistFilterOptions();
				support.loadVenueFilterOptions();
				page.loadPerformances();
				final PerformanceViewModel viewModel = perforamnceViewModelInstance.get();
				viewModel.init(result.getResult());
				init(viewModel);
				RequestContext.getCurrentInstance().execute("updateFilterAndContent();");
			} else if (result.getServiceErrorCode() != null) {
				log.error("Webservice throw logical error code: " + result.getErrorCode() + " / error: "
						+ result.getError());
				fc.addMessage(clientId, new FacesMessage(FacesMessage.SEVERITY_WARN, result.getError(), ""));
			} else if (result.getErrorCode() != null) {
				log.error("Webservice throw error code: " + result.getErrorCode() + " / error: " + result.getError());
				fc.addMessage(clientId, new FacesMessage(FacesMessage.SEVERITY_WARN, bundle.getUnexpectedError(), ""));
			}
		} catch (Exception e) {
			log.error("Could not save perforamnce", e);
			fc.addMessage(clientId, new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getUnexpectedError(), ""));
		}
	}

	public void delete(ActionEvent event) {
		final String clientId = event.getComponent().getClientId();
		try {
			SingleResultModelOfNullableOfBoolean result = performanceWebservice.delete(utx.getUsername(),
					utx.getPassword(), editViewModel.getId());
			if ((result.getErrorCode() == null) && (result.getServiceErrorCode() == null)) {
				support.loadArtistFilterOptions();
				support.loadVenueFilterOptions();
				page.loadPerformances();
				init(null);
				RequestContext.getCurrentInstance().execute("updateFilterAndContent();");
			} else if (result.getServiceErrorCode() != null) {
				fc.addMessage(clientId, new FacesMessage(FacesMessage.SEVERITY_WARN, result.getError(), ""));
			} else if (result.getErrorCode() != null) {
				log.error("Webservice throw error code: " + result.getErrorCode() + " / error: " + result.getError());
				fc.addMessage(clientId, new FacesMessage(FacesMessage.SEVERITY_WARN, bundle.getUnexpectedError(), ""));
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
