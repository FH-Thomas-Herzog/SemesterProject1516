package at.fh.ooe.swk.ufo.web.application.exception;

import java.util.Iterator;

import javax.faces.FacesException;
import javax.faces.application.FacesMessage;
import javax.faces.context.ExceptionHandler;
import javax.faces.context.ExceptionHandlerWrapper;
import javax.faces.context.FacesContext;
import javax.faces.event.ExceptionQueuedEvent;
import javax.faces.event.ExceptionQueuedEventContext;

import org.apache.deltaspike.core.api.provider.BeanProvider;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;

/**
 * Custom global exception handler which catches all not handled exceptions.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
public class GlobalExceptionHandler extends ExceptionHandlerWrapper {

	private final ExceptionHandler wrapped;
	private final MessagesBundle bundle;

	private static final Logger log = LogManager.getLogger(GlobalExceptionHandler.class.getName());

	public GlobalExceptionHandler(final ExceptionHandler wrapped) {
		super();
		this.wrapped = wrapped;
		bundle = BeanProvider.getContextualReference(MessagesBundle.class);
	}

	@Override
	public ExceptionHandler getWrapped() {
		return wrapped;
	}

	@Override
	public void handle() throws FacesException {

		final Iterator<ExceptionQueuedEvent> i = getUnhandledExceptionQueuedEvents().iterator();
		while (i.hasNext()) {
			ExceptionQueuedEvent event = i.next();
			ExceptionQueuedEventContext context = (ExceptionQueuedEventContext) event.getSource();

			// get the exception from context
			Throwable t = context.getException();

			final FacesContext fc = FacesContext.getCurrentInstance();

			try {
				log.error("Critical Exception!", t);
				fc.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getUnexpectedError(), ""));
				fc.renderResponse();

			} catch (Exception e) {
				log.error(GlobalExceptionHandler.class.getName() + " could not handle exception", t);
				log.error("This excpetion occurred during handling", e);
			} finally {
				i.remove();
			}
		}
		// parent hanle
		getWrapped().handle();
	}
}
