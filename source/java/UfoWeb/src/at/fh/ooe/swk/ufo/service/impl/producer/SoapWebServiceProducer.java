package at.fh.ooe.swk.ufo.service.impl.producer;

import java.io.Serializable;
import java.net.URL;
import java.util.TimeZone;

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

import at.fh.ooe.swk.ufo.service.api.annotation.ServiceTimeZone;
import at.fh.ooe.swk.ufo.web.application.constants.ContextParameter;
import at.fh.ooe.swk.ufo.webservice.ArtistServiceLocator;
import at.fh.ooe.swk.ufo.webservice.ArtistServiceSoap;
import at.fh.ooe.swk.ufo.webservice.ArtistServiceSoapStub;
import at.fh.ooe.swk.ufo.webservice.PerformanceServiceLocator;
import at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoap;
import at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoapStub;
import at.fh.ooe.swk.ufo.webservice.SecurityServiceLocator;
import at.fh.ooe.swk.ufo.webservice.SecurityServiceSoap;
import at.fh.ooe.swk.ufo.webservice.SecurityServiceSoapStub;
import at.fh.ooe.swk.ufo.webservice.VenueServiceLocator;
import at.fh.ooe.swk.ufo.webservice.VenueServiceSoap;
import at.fh.ooe.swk.ufo.webservice.VenueServiceSoapStub;

/**
 * The cdi producer for producing the soap service instances and its related
 * resources. It depends on a injectable {@link ServletContext}.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 9, 2016
 */
@ApplicationScoped
public class SoapWebServiceProducer implements Serializable {

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
	private URL securityServiceURL;

	private String serviceTimeZone;
	private ArtistServiceLocator artistServiceLocator;
	private PerformanceServiceLocator performanceServiceLocator;
	private VenueServiceLocator venueServiceLocator;
	private SecurityServiceLocator securityServiceLocator;

	/**
	 * Initializes the producer by retrieving the service urls from the servlet
	 * context.
	 */
	@PostConstruct
	public void postContruct() {
		// Get authentication data from web.xml
		username = servletContext.getInitParameter(ContextParameter.WEBSERVICE_USERNAME.key);
		password = servletContext.getInitParameter(ContextParameter.WEBSERVICE_PASSWORD.key);

		if ((username == null) || (password == null)) {
			throw new IllegalStateException("Username and password need to be provided via web.xml");
		}

		// Get set service timezone
		serviceTimeZone = servletContext.getInitParameter(ContextParameter.SERVICE_TIMEZONE_KEY.key);
		// Assume UTC time zone
		if (serviceTimeZone == null) {
			serviceTimeZone = "UTC";
		}

		// Get webservice-urls from web.xml
		try {
			artistServiceURL = new URL(servletContext.getInitParameter(ContextParameter.WEBSERVICE_ARTIST_SERVICE.key));
			performanceServiceURL = new URL(
					servletContext.getInitParameter(ContextParameter.WEBSERVICE_PERFORMANCE_SERVICE.key));
			venueServiceURL = new URL(servletContext.getInitParameter(ContextParameter.WEBSERVICE_VENUE_SERVICE.key));
			securityServiceURL = new URL(
					servletContext.getInitParameter(ContextParameter.WEBSERVICE_SECURITY_SERVICE.key));
		} catch (Exception e) {
			log.error("Error during creation of service URL instances");
			throw new IllegalStateException("One of the service urls was invalid. ", e);
		}

		// create locator instances once
		artistServiceLocator = new ArtistServiceLocator();
		performanceServiceLocator = new PerformanceServiceLocator();
		venueServiceLocator = new VenueServiceLocator();
		securityServiceLocator = new SecurityServiceLocator();
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

	@Produces
	@Dependent
	public SecurityServiceSoap produceSecurityService() {
		try {
			SecurityServiceSoapStub service = (SecurityServiceSoapStub) securityServiceLocator
					.getSecurityServiceSoap(securityServiceURL);
			service.setHeader(createSoapHeader());
			return service;
		} catch (Exception e) {
			log.error("Could not produce the '" + SecurityServiceSoap.class.getName() + "' instance", e);
			return null;
		}
	}

	@Produces
	@Dependent
	@ServiceTimeZone
	public TimeZone produceTimeZone() {
		return TimeZone.getTimeZone(serviceTimeZone);
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
