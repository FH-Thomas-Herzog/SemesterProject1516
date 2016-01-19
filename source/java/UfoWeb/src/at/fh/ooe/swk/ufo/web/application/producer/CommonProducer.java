package at.fh.ooe.swk.ufo.web.application.producer;

import java.io.Serializable;
import java.util.TimeZone;

import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.Dependent;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.inject.Produces;
import javax.enterprise.inject.spi.InjectionPoint;
import javax.faces.context.FacesContext;
import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.ServletContext;

import org.apache.deltaspike.core.api.common.DeltaSpike;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import at.fh.ooe.swk.ufo.web.application.annotation.ServiceTimeZone;
import at.fh.ooe.swk.ufo.web.application.constants.ContextParameter;

@ApplicationScoped
public class CommonProducer implements Serializable {

	private static final long serialVersionUID = 2126602113404183470L;

	@Inject
	@DeltaSpike
	private ServletContext servletContext;

	private TimeZone timeZone;

	@PostConstruct
	public void postConstruct() {
		try {
			timeZone = TimeZone.getTimeZone(ContextParameter.SERVICE_TIMEZONE_KEY.key);
		} catch (Exception e) {
			throw new IllegalArgumentException("Service timezone needs to be provided");
		}
	}

	@Produces
	@Dependent
	public Logger produceLogger(InjectionPoint ip) {
		return LogManager.getLogger(ip.getBean().getBeanClass());
	}

	@Produces
	@RequestScoped
	public FacesContext produceFacesContext() {
		return FacesContext.getCurrentInstance();
	}

	@Produces
	@Dependent
	@ServiceTimeZone
	public TimeZone produceTimeZone() {
		return TimeZone.getTimeZone("UTC");
	}
}
