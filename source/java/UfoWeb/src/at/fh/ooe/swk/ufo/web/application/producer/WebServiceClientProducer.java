package at.fh.ooe.swk.ufo.web.application.producer;

import java.io.Serializable;
import java.net.URL;

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

import at.fh.ooe.swk.ufo.web.application.constants.ContextParameter;
import at.fh.ooe.swk.ufo.webservice.ArtistServiceLocator;
import at.fh.ooe.swk.ufo.webservice.ArtistServiceSoap;
import at.fh.ooe.swk.ufo.webservice.ArtistServiceSoapStub;
import at.fh.ooe.swk.ufo.webservice.PerformanceServiceLocator;
import at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoap;
import at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoapStub;
import at.fh.ooe.swk.ufo.webservice.VenueServiceLocator;
import at.fh.ooe.swk.ufo.webservice.VenueServiceSoap;
import at.fh.ooe.swk.ufo.webservice.VenueServiceSoapStub;

/**
 * This class represents the producer for the webservice instances. These
 * instances are defined by context-params from the web.xml which defines the
 * authentication data and the urls where the webservice can be reached.
 * 
 * Be aware that the JVM needs a proper truststore available if ssl is used.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 9, 2016
 */
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
	private URL artistServiceURL;
	private URL performanceServiceURL;
	private URL venueServiceURL;

	private ArtistServiceLocator artistServiceLocator;
	private PerformanceServiceLocator performanceServiceLocator;
	private VenueServiceLocator venueServiceLocator;

	@PostConstruct
	public void postContruct() {
		// Get authentication data from web.xml
		username = servletContext.getInitParameter(ContextParameter.WEBSERVICE_USERNAME.key);
		password = servletContext.getInitParameter(ContextParameter.WEBSERVICE_PASSWORD.key);

		// Get webservice-urls from web.xml
		try {
			artistServiceURL = new URL(servletContext.getInitParameter(ContextParameter.WEBSERVICE_ARTIST_SERVICE.key));
			performanceServiceURL = new URL(
					servletContext.getInitParameter(ContextParameter.WEBSERVICE_PERFORMANCE_SERVICE.key));
			venueServiceURL = new URL(servletContext.getInitParameter(ContextParameter.WEBSERVICE_VENUE_SERVICE.key));
		} catch (Exception e) {
			log.error("Error during creation of service URL instances");
			throw new IllegalStateException("One of the service urls was invalid. ", e);
		}

		// create locator instances once
		artistServiceLocator = new ArtistServiceLocator();
		performanceServiceLocator = new PerformanceServiceLocator();
		venueServiceLocator = new VenueServiceLocator();
	}

	@Produces
	@Dependent
	public ArtistServiceSoap produceArtistService() {
		try {
			ArtistServiceSoapStub service = (ArtistServiceSoapStub) artistServiceLocator
					.getArtistServiceSoap(artistServiceURL);
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
			PerformanceServiceSoapStub service = (PerformanceServiceSoapStub) performanceServiceLocator
					.getPerformanceServiceSoap(performanceServiceURL);
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
			VenueServiceSoapStub service = (VenueServiceSoapStub) venueServiceLocator
					.getVenueServiceSoap(venueServiceURL);
			service.setHeader(createSoapHeader());
			return service;
		} catch (Exception e) {
			log.error("Could not produce the '" + VenueServiceSoap.class.getName() + "' instance", e);
			return null;
		}
	}

	/**
	 * Creates the soap header which holds the authentication data.
	 * 
	 * @return the created soap header elements
	 * @throws Exception
	 *             if the header element could not be created
	 */
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
