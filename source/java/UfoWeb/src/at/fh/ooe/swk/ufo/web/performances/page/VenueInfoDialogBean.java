package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.function.Consumer;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;
import javax.enterprise.context.SessionScoped;
import javax.enterprise.inject.Instance;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.ServletContext;

import org.apache.deltaspike.core.api.common.DeltaSpike;
import org.apache.logging.log4j.Logger;
import org.primefaces.context.RequestContext;
import org.primefaces.event.CloseEvent;
import org.primefaces.event.map.OverlaySelectEvent;
import org.primefaces.model.map.DefaultMapModel;
import org.primefaces.model.map.LatLng;
import org.primefaces.model.map.MapModel;
import org.primefaces.model.map.Marker;

import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.model.GeocodingResult;

import at.fh.ooe.swk.ufo.web.application.constants.ContextParameter;
import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.VenueViewModel;
import at.fh.ooe.swk.ufo.webservice.ListResultModelOfVenueModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoap;
import at.fh.ooe.swk.ufo.webservice.ResultModelOfListOfVenueModel;
import at.fh.ooe.swk.ufo.webservice.VenueServiceSoap;

/**
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 9, 2016
 */
@SessionScoped
@Named("venueInfoDialog")
public class VenueInfoDialogBean implements Serializable {

	private static final long serialVersionUID = -5532729555560855764L;

	@Inject
	@DeltaSpike
	private transient ServletContext servletContext;
	@Inject
	private Logger log;
	@Inject
	private MessagesBundle bundle;
	@Inject
	private FacesContext fc;

	@Inject
	private PerformanceFilterBean filterBean;

	@Inject
	private transient VenueServiceSoap venueWebservice;

	@Inject
	private Instance<VenueViewModel> venueInstance;

	private String defaultLocation;
	private MapModel map;
	private List<VenueViewModel> venues;

	private String apiKey;

	public VenueInfoDialogBean() {
		super();
	}

	@PostConstruct
	public void postConstruct() {
		apiKey = servletContext.getInitParameter(ContextParameter.GOOGLE_MAP_API_KEY.key);
	}

	/**
	 * Initializes with the given artist id
	 * 
	 * @param id
	 */
	public void init(Long id) {
		reset();
		try {
			ListResultModelOfVenueModel result = ((id == null)
					? venueWebservice.getVenuesForPerformances(filterBean.createRequestModel())
					: venueWebservice.getVenueForPerformances(id, filterBean.createRequestModel()));
			if (result.getErrorCode() != null) {
				venues = new ArrayList<>();
				map = new DefaultMapModel();
				log.error(
						"Webservice returned error code: " + result.getErrorCode() + " / error: " + result.getError());
				fc.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getUnexpectedError(), ""));
			} else {
				venues = Arrays.asList(result.getResult()).parallelStream().map(model -> {
					final VenueViewModel viewModel = venueInstance.get();
					viewModel.init(model);
					return viewModel;
				}).collect(Collectors.toList());
				prepareMap();
			}
		} catch (Exception e) {
			log.error("Could not load artist model", e);
			fc.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getUnexpectedError(), ""));
		}
	}

	// ##################################################
	// Event Listener
	// ##################################################
	/**
	 * Rests this beans and releases all resources on close event.
	 * 
	 * @param event
	 *            the CloseEvent
	 */
	public void onClose(CloseEvent event) {
		reset();
	}

	/**
	 * Invokes the client api for switching the carousel to the proper venue.
	 * 
	 * @param event
	 *            {@link OverlaySelectEvent}
	 */
	public void onMarkerSelect(OverlaySelectEvent event) {
		final Marker marker = (Marker) event.getOverlay();
		int idx = venues.indexOf(marker.getData());
		if (idx < 0) {
			idx = 0;
		}
		RequestContext.getCurrentInstance().execute("PF('venueCarousel').setPage(" + idx + ")");
	}

	// ##################################################
	// Helper
	// ##################################################
	/**
	 * Prepares the primefaces map model.
	 */
	private void prepareMap() {
		map = new DefaultMapModel();
		for (VenueViewModel venue : venues) {
			// Try to get location if coordinates weren't given
			if (venue.getLocation() == null) {
				setLocationFromGeocoding(venue);
			}

			// set marker on map
			if (venue.getLocation() != null) {
				if (defaultLocation == null) {
					defaultLocation = venue.getLocation();
				}
				try {
					final String[] splitLocation = venue.getLocation().split(",");
					final LatLng latLng = new LatLng(Double.valueOf(splitLocation[0].trim()),
							Double.valueOf(splitLocation[1].trim()));
					final String title = new StringBuilder(venue.getName()).append(" (")
							.append(venue.getPerformances().size()).append(" ").append(bundle.getPerformances())
							.append(")").toString();
					final Marker marker = new Marker(latLng, title);
					marker.setData(venue);
					marker.setId("marker_" + venue.getId().toString());
					map.getMarkers().add(marker);
				} catch (Exception e) {
					log.error("Could not create marker for map. venue.location: " + venue.getLocation(), e);
				}
			}
		}
	}

	/**
	 * Tries to get the location from google maps geocoding if venue does not
	 * define location but its address.
	 * 
	 * @param venue
	 *            the venue to get location for
	 */
	private void setLocationFromGeocoding(VenueViewModel venue) {
		try {
			GeoApiContext context = new GeoApiContext().setApiKey(apiKey);
			GeocodingResult[] results = GeocodingApi.geocode(context, venue.getAddress()).await();
			if (results.length > 0) {
				GeocodingResult result = results[0];
				if (result.geometry != null) {
					venue.setLocation(result.geometry.location.toUrlValue());
					log.debug("Location retrieved from google", venue.getLocation());
				}
			}
			System.out.println(results[0].formattedAddress);
		} catch (Exception e) {
			log.error("Could not resolve location for address. address: " + venue.getAddress(), e);
		}
	}

	/**
	 * Resets the bean held states
	 */
	public void reset() {
		venues = null;
		map = null;
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public List<VenueViewModel> getVenues() {
		return venues;
	}

	public MapModel getMap() {
		return map;
	}

	public String getDefaultLocation() {
		return defaultLocation;
	}

}
