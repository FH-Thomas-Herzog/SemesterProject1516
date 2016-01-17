package at.fh.ooe.swk.ufo.web.application;

import java.io.Serializable;

import javax.enterprise.context.ApplicationScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.inject.Inject;

import org.apache.logging.log4j.Logger;

import at.fh.ooe.swk.ufo.service.proxy.model.ResultModel;
import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;

@ApplicationScoped
public class ProxyServiceExceptionHandler implements Serializable {

	private static final long serialVersionUID = 257028342425596493L;

	@Inject
	private FacesContext fc;
	@Inject
	private MessagesBundle bundle;
	@Inject
	private Logger log;

	public boolean handleException(String clientId, ResultModel<?> result) {
		boolean handled = Boolean.FALSE;
		// Handle user relevant error
		if (result.getError() != null) {
			log.error("ServiceProxy returned user relevant error: " + result.getError());
			fc.addMessage(clientId, new FacesMessage(FacesMessage.SEVERITY_WARN, result.getError(), ""));
			handled = Boolean.TRUE;
		}
		// Handle internal error
		if (result.getInternalError() != null) {
			log.error("ServiceProxy throw error: " + result.getInternalError(), result.getException());
			fc.addMessage(clientId, new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getUnexpectedError(), ""));
			handled = Boolean.TRUE;
		}

		return handled;
	}

}
