package at.fh.ooe.swk.ufo.web.application.producer;

import java.io.Serializable;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.Dependent;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.inject.Produces;
import javax.enterprise.inject.spi.InjectionPoint;
import javax.faces.context.FacesContext;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.apache.deltaspike.core.api.common.DeltaSpike;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * The commons CDI producer whih provides common used resources.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 22, 2016
 */
@ApplicationScoped
public class CommonProducer implements Serializable {

	private static final long serialVersionUID = 2126602113404183470L;

	/**
	 * Deltaspike provides a producer for injection of the
	 * {@link ServletContext}
	 */
	@Inject
	@DeltaSpike
	private ServletContext servletContext;

	/**
	 * Creates a logger instance and gets the logger name from the injection
	 * point.
	 * 
	 * @param ip
	 *            the injection point to get backed bean class for logger name
	 * @return the logger instance
	 */
	@Produces
	@Dependent
	public Logger produceLogger(InjectionPoint ip) {
		return LogManager.getLogger(ip.getBean().getBeanClass());
	}

	/**
	 * Produces the faces context for each request. Could be null if no
	 * {@link FacesContext} is available.
	 * 
	 * @return the current {@link FacesContext} instance
	 */
	@Produces
	@RequestScoped
	public FacesContext produceFacesContext() {
		return FacesContext.getCurrentInstance();
	}
}
