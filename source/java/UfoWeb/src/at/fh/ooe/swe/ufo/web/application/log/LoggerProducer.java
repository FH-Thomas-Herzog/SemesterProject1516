package at.fh.ooe.swe.ufo.web.application.log;

import java.io.Serializable;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.Dependent;
import javax.enterprise.inject.Produces;
import javax.enterprise.inject.spi.InjectionPoint;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@ApplicationScoped
public class LoggerProducer implements Serializable {

	private static final long serialVersionUID = 2126602113404183470L;

	@Produces
	@Dependent
	public Logger produceLogger(InjectionPoint ip) {
		return LogManager.getLogger(ip.getBean().getBeanClass());
	}
}
