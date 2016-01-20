package at.fh.ooe.swk.ufo.web.application.exception;

import java.io.Serializable;

import javax.enterprise.context.ApplicationScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.inject.Inject;

import org.apache.logging.log4j.Logger;

import at.fh.ooe.swk.ufo.service.proxy.api.model.ResultModel;
import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;

/**
 * The exception handler which handles the service exceptions which are
 * dtermined from the service result instance.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
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
			fc.addMessage(clientId, new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getErrorUnexpected(), ""));
			handled = Boolean.TRUE;
		}

		return handled;
	}

}
