package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.util.Calendar;

import javax.inject.Inject;
import javax.inject.Named;

import org.apache.deltaspike.core.api.scope.ViewAccessScoped;
import org.primefaces.extensions.event.TimeSelectEvent;

import at.fh.ooe.swk.ufo.web.performances.model.PerformanceEditViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;

@ViewAccessScoped
@Named("performanceEditDialog")
public class PerformanceEditDialogBean implements Serializable {

	private static final long serialVersionUID = -2482703918283199463L;

	@Inject
	private PerformanceEditViewModel editViewModel;

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

		// prepare min hours
		if ((now.get(Calendar.MINUTE) > 0) && (now.get(Calendar.SECOND) > 0) && (now.get(Calendar.MILLISECOND) > 0)) {
			startHour = now.get(Calendar.HOUR) + 1;
		} else {
			startHour = now.get(Calendar.HOUR);
		}

		// init edit view
		if (model == null) {
			editViewModel.init(now, startHour);
		} else {
			editViewModel.init(model, startHour);
		}

		started = Boolean.TRUE;
	}

	// ##################################################
	// Actions
	// ##################################################
	public void save() {

	}

	public void delete() {

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
