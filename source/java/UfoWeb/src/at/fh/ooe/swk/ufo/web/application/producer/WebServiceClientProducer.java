package at.fh.ooe.swk.ufo.web.application.producer;

import java.io.Serializable;

import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.Dependent;
import javax.enterprise.inject.Produces;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.xml.soap.SOAPElement;

import org.apache.axis.message.SOAPHeaderElement;
import org.apache.deltaspike.core.api.common.DeltaSpike;
import org.apache.logging.log4j.Logger;

import at.fh.ooe.swk.ufo.webservice.ArtistServiceLocator;
import at.fh.ooe.swk.ufo.webservice.ArtistServiceSoap;
import at.fh.ooe.swk.ufo.webservice.ArtistServiceSoapStub;
import at.fh.ooe.swk.ufo.webservice.PerformanceServiceLocator;
import at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoap;
import at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoapStub;
import at.fh.ooe.swk.ufo.webservice.VenueServiceLocator;
import at.fh.ooe.swk.ufo.webservice.VenueServiceSoap;
import at.fh.ooe.swk.ufo.webservice.VenueServiceSoapStub;

@ApplicationScoped
public class WebServiceClientProducer implements Serializable {

	private static final long serialVersionUID = 2842670772849028624L;

	@Inject
	@DeltaSpike
	private ServletContext servletContext;
	@Inject
	private Logger log;

	private String username;
	private String password;

	private static final String CTX_PARAM_WEBSERVICE_USERNAME = "ufo.webservice.username";
	private static final String CTX_PARAM_WEBSERVICE_PASSWORD = "ufo.webservice.password";

	@PostConstruct
	public void postContruct() {
		username = servletContext.getInitParameter(CTX_PARAM_WEBSERVICE_USERNAME);
		password = servletContext.getInitParameter(CTX_PARAM_WEBSERVICE_PASSWORD);
	}

	@Produces
	@Dependent
	public ArtistServiceSoap produceArtistService() {
		try {
			ArtistServiceSoapStub service = (ArtistServiceSoapStub) new ArtistServiceLocator().getArtistServiceSoap();
			service.setHeader(createSoapHeader());
			return service;
		} catch (Exception e) {
			log.error("Could not produce the '" + ArtistServiceSoap.class.getName() + "'  instance", e);
			return null;
		}
	}

	@Produces
	@Dependent
	public PerformanceServiceSoap producePerformanceService() {
		try {
			PerformanceServiceSoapStub service = (PerformanceServiceSoapStub) new PerformanceServiceLocator()
					.getPerformanceServiceSoap();
			service.setHeader(createSoapHeader());
			return service;
		} catch (Exception e) {
			log.error("Could not produce the '" + PerformanceServiceSoap.class.getName() + "' instance", e);
			return null;
		}
	}

	@Produces
	@Dependent
	public VenueServiceSoap produceVenueService() {
		try {
			VenueServiceSoapStub service = (VenueServiceSoapStub) new VenueServiceLocator().getVenueServiceSoap();
			service.setHeader(createSoapHeader());
			return service;
		} catch (Exception e) {
			log.error("Could not produce the '" + VenueServiceSoap.class.getName() + "' instance", e);
			return null;
		}
	}

	private SOAPHeaderElement createSoapHeader() throws Exception {
		SOAPHeaderElement authentication = new SOAPHeaderElement("https://webservice.ufo.swk.ooe.fh.at/",
				"Credentials");
		SOAPElement node = authentication.addChildElement("Username");
		node.addTextNode(username);
		SOAPElement node2 = authentication.addChildElement("Password");
		node2.addTextNode(password);
		return authentication;
	}
}
