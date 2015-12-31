package at.fh.ooe.swe.ufo.web.performances.page;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import javax.annotation.PostConstruct;
import javax.enterprise.context.SessionScoped;
import javax.inject.Inject;
import javax.inject.Named;

import at.fh.ooe.swe.ufo.webservice.model.PerformanceModel;

@SessionScoped
@Named("performancePage")
public class PerformancesPage implements Serializable {

	private static final long serialVersionUID = 5519942591137456554L;

	@Inject
	private DataTableSubPage dataTableSubPage;

	private Integer selectedUser;
	private List<PerformanceModel> performances = new ArrayList<>();

	@PostConstruct
	public void postConstruct() {
		selectedUser = 1;
		prepareTestPerformances();
	}

	private void prepareTestPerformances() {
		Calendar start = Calendar.getInstance();
		start.set(Calendar.HOUR_OF_DAY, 8);
		start.set(Calendar.MINUTE, 0);
		start.set(Calendar.SECOND, 0);
		start.set(Calendar.MILLISECOND, 0);
		for (int i = 0; i < 6; i++) {
			Calendar end = (Calendar) start.clone();
			end.add(Calendar.HOUR, 1);
			performances.add(new PerformanceModel("Thomas", "AT", "Hauptstraße", start, end));
			start = (Calendar) start.clone();
			start.add(Calendar.HOUR, 1);
		}

		start = Calendar.getInstance();
		start.set(Calendar.HOUR_OF_DAY, 8);
		start.set(Calendar.MINUTE, 0);
		start.set(Calendar.SECOND, 0);
		start.set(Calendar.MILLISECOND, 0);
		for (int i = 0; i < 6; i++) {
			Calendar end = (Calendar) start.clone();
			end.add(Calendar.HOUR, 1);
			performances.add(new PerformanceModel("Thomas", "AT", "Hauptstraße", start, end));
			start = (Calendar) start.clone();
			start.add(Calendar.HOUR, 1);
		}

		dataTableSubPage.init(performances);
	}

	// ##################################################
	// Event listener
	// ##################################################

	// ##################################################
	// Getter and Setter
	// ##################################################
	public Integer getSelectedUser() {
		return selectedUser;
	}

	public void setSelectedUser(Integer selectedUser) {
		this.selectedUser = selectedUser;
	}

	public DataTableSubPage getDataTableSubPage() {
		return dataTableSubPage;
	}
}
