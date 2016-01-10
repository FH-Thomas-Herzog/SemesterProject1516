package at.fh.ooe.swk.ufo.web.application.producer;

import java.io.Serializable;
import java.util.TimeZone;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.Dependent;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.inject.Produces;
import javax.enterprise.inject.spi.InjectionPoint;
import javax.faces.context.FacesContext;
import javax.inject.Named;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@ApplicationScoped
public class CommonProducer implements Serializable {

	private static final long serialVersionUID = 2126602113404183470L;

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
	@Named("defaultTimeZone")
	public TimeZone produceTimeZone(){
		return TimeZone.getTimeZone("UTC");
	}
}
