package at.fh.ooe.swk.ufo.web.application.bean;

import java.io.Serializable;

import javax.enterprise.context.RequestScoped;
import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.inject.Inject;
import javax.inject.Named;

import org.apache.logging.log4j.Logger;
import org.primefaces.context.RequestContext;

import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;
import at.fh.ooe.swk.ufo.webservice.LoginModel;
import at.fh.ooe.swk.ufo.webservice.ResultModelOfNullableOfBoolean;
import at.fh.ooe.swk.ufo.webservice.SecurityServiceSoap;

@RequestScoped
@Named("loginBean")
public class LoginBean implements Serializable {

	private static final long serialVersionUID = -1357295414632657607L;

	@Inject
	private Logger log;
	@Inject
	private FacesContext fctx;
	@Inject
	private MessagesBundle bundle;

	@Inject
	private transient SecurityServiceSoap securityWebservice;

	@Inject
	private UserContextModel utxModel;

	private String username;
	private String password;

	public void login() {
		if (securityWebservice != null) {
			try {
				final ResultModelOfNullableOfBoolean result = securityWebservice.validateUserCredentials(username,
						password);
				if (result.getErrorCode() != null) {
					fctx.addMessage(null,
							new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getUnexpectedError(), ""));
					log.error("WebSerivce returned error. code: " + result.getErrorCode() + " / error: "
							+ result.getError());
				} else {
					utxModel.setLogged(result.getResult());
					if (utxModel.isLogged()) {
						utxModel.setUsername(username);
						utxModel.setPassword(password);
						RequestContext.getCurrentInstance().execute("PF('loginDialog').hide();");
					}
				}
			} catch (Exception e) {
				log.error("Error during webservice call", e);
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
