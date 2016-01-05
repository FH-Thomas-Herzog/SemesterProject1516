package at.fh.ooe.swe.ufo.web.application.security;

import java.io.Serializable;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.Dependent;
import javax.enterprise.inject.Produces;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.xml.soap.SOAPElement;

import org.apache.axis.message.SOAPHeaderElement;
import org.apache.deltaspike.core.api.common.DeltaSpike;
import org.apache.logging.log4j.Logger;

import at.fh_ooe.swk.ufo.ArtistServiceLocator;
import at.fh_ooe.swk.ufo.ArtistServiceSoap;
import at.fh_ooe.swk.ufo.ArtistServiceSoapStub;

@ApplicationScoped
public class WebServiceClientProducer implements Serializable {

	private static final long serialVersionUID = 2842670772849028624L;

	@Inject
	@DeltaSpike
	private ServletContext servletContext;

	@Inject
	private Logger log;

	private static final String WEBSERVICE_USERNAME = "ufo.webservice.username";
	private static final String WEBSERVICE_PASSWORD = "ufo.webservice.password";

	@Produces
	@Dependent
	public ArtistServiceSoap produceArtistService() {
		try {
			ArtistServiceSoapStub service = (ArtistServiceSoapStub) new ArtistServiceLocator().getArtistServiceSoap();
			SOAPHeaderElement authentication = new SOAPHeaderElement("https://ufo.swk.fh-ooe.at/", "Credentials");
			SOAPElement node = authentication.addChildElement("Username");
			node.addTextNode(servletContext.getInitParameter(WEBSERVICE_USERNAME));
			SOAPElement node2 = authentication.addChildElement("Password");
			node2.addTextNode(servletContext.getInitParameter(WEBSERVICE_PASSWORD));
			service.setHeader(authentication);
			return service;
		} catch (Exception e) {
			log.error("Could not produce the ArtistServiceSoap instance", e);
			return null;
		}
	}
}
