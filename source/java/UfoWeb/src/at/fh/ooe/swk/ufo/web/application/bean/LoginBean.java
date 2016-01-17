package at.fh.ooe.swk.ufo.web.application.bean;

import java.io.Serializable;

import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.inject.Inject;
import javax.inject.Named;

import org.primefaces.context.RequestContext;

import at.fh.ooe.swk.ufo.service.proxy.api.SecurityServiceProxy;
import at.fh.ooe.swk.ufo.service.proxy.model.ResultModel;
import at.fh.ooe.swk.ufo.web.application.ProxyServiceExceptionHandler;
import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;

@RequestScoped
@Named("loginBean")
public class LoginBean implements Serializable {

	private static final long serialVersionUID = -1357295414632657607L;

	@Inject
	private FacesContext fc;
	@Inject
	private MessagesBundle bundle;

	@Inject
	private SecurityServiceProxy securityService;
	@Inject
	private ProxyServiceExceptionHandler proxyExceptionHandler;

	@Inject
	private UserContextModel utxModel;

	private String username;
	private String password;

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

	public void logout() {
		utxModel.setUsername(null);
		utxModel.setPassword(null);
		utxModel.setLogged(Boolean.FALSE);
	}

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
