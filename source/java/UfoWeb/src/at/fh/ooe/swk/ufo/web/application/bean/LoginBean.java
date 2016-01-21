package at.fh.ooe.swk.ufo.web.application.bean;

import java.io.Serializable;

import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.inject.Inject;
import javax.inject.Named;

import org.primefaces.context.RequestContext;

import at.fh.ooe.swk.ufo.service.api.model.ResultModel;
import at.fh.ooe.swk.ufo.service.api.proxy.SecurityServiceProxy;
import at.fh.ooe.swk.ufo.web.application.exception.ProxyServiceExceptionHandler;
import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;

/**
 * This beans handles the login and logout actions
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
@RequestScoped
@Named("loginBean")
public class LoginBean implements Serializable {

	private static final long serialVersionUID = -1357295414632657607L;

	@Inject
	private FacesContext fc;
	@Inject
	private MessagesBundle bundle;
	@Inject
	private ProxyServiceExceptionHandler proxyExceptionHandler;

	@Inject
	private SecurityServiceProxy securityService;

	@Inject
	private UserContextModel utxModel;

	private String username;
	private String password;

	/**
	 * Performs the login action
	 * 
	 * @param event
	 *            {@link ActionEvent}
	 */
	public void login(ActionEvent event) {
		final String clientId = event.getComponent().getClientId();
		final ResultModel<Boolean> result = securityService.login(username, password);
		if ((!proxyExceptionHandler.handleException(clientId, result)) && (result.getResult() != null)) {
			utxModel.setLogged(result.getResult());
			if (utxModel.isLogged()) {
				utxModel.setUsername(username);
				utxModel.setPassword(password);
				RequestContext.getCurrentInstance().execute("PF('loginDialog').hide();");
			} else {
				fc.addMessage(clientId, new FacesMessage(FacesMessage.SEVERITY_WARN, bundle.getErrorLoginFailed(), ""));
			}
		}
	}

	/**
	 * Performs the logout action
	 */
	public void logout() {
		utxModel.setUsername(null);
		utxModel.setPassword(null);
		utxModel.setLogged(Boolean.FALSE);
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
