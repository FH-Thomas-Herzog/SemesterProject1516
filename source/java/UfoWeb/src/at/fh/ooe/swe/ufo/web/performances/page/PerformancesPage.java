package at.fh.ooe.swe.ufo.web.performances.page;

import java.io.Serializable;

import javax.annotation.PostConstruct;
import javax.enterprise.context.SessionScoped;
import javax.inject.Named;

import at.fh.ooe.swe.ufo.webservice.model.UserModel;

@SessionScoped
@Named("performancePage")
public class PerformancesPage implements Serializable {

	private static final long serialVersionUID = 5519942591137456554L;

	private Integer selectedUser;

	@PostConstruct
	public void postConstruct() {
		selectedUser = 1;
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
}
