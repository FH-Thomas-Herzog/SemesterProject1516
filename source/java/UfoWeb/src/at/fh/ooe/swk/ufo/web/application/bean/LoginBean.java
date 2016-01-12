package at.fh.ooe.swk.ufo.web.application.bean;

import java.io.Serializable;

import javax.enterprise.context.RequestScoped;
import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.inject.Inject;
import javax.inject.Named;

import org.apache.logging.log4j.Logger;

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

	@SessionScoped
	private UserContextModel utxModel;

	public void login() {
		if (securityWebservice != null) {
			try {
				final ResultModelOfNullableOfBoolean result = securityWebservice
						.validateUserCredentials(utxModel.getUsername(), utxModel.getPassword());
				if (result.getErrorCode() != null) {
					fctx.addMessage(null,
							new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getUnexpectedError(), ""));
					log.error("WebSerivce returned error. code: " + result.getErrorCode() + " / error: "
							+ result.getError());
				} else {
					utxModel.setLogged(result.getResult());
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
}
