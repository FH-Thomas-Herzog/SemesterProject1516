package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.Serializable;

import javax.enterprise.context.SessionScoped;
import javax.enterprise.inject.Instance;
import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.ServletContext;

import org.apache.deltaspike.core.api.common.DeltaSpike;
import org.apache.logging.log4j.Logger;
import org.primefaces.event.CloseEvent;
import org.primefaces.model.DefaultStreamedContent;
import org.primefaces.model.StreamedContent;

import at.fh.ooe.swk.ufo.web.performances.model.ArtistViewModel;
import at.fh.ooe.swk.ufo.webservice.ArtistServiceSoap;

/**
 * This class is the handler for the artist information which gets diaplyed in
 * an dialog. Is session scoped because primefaces has problems with view scoped
 * beans during resource loading which would try to access this bean which
 * couldn't be resolved from the current context, because no context would be
 * active.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 7, 2016
 */
@SessionScoped
@Named("artistInfoDialog")
public class ArtistInfoDialogBean implements Serializable {

	private static final long serialVersionUID = -5532729555560855764L;

	@Inject
	private PerformancesPage page;
	@Inject
	@DeltaSpike
	private transient ServletContext servletContext;
	@Inject
	private transient ArtistServiceSoap artistWebservice;
	@Inject
	private Logger log;
	@Inject
	private Instance<ArtistViewModel> artistInstance;

	private ArtistViewModel artist;
	private static final String DEFAULT_IMAGE = "/images/no-profile-img.gif";
	private static final String DEFAULT_IMAGE_MIME_TYPE = "image/gif";

	/**
	 * Initializes with the given artist id
	 * 
	 * @param id
	 */
	public void init(long id) {
		reset();
		try {
			artist = artistInstance.get();
			artist.init(artistWebservice.getDetails(id));
		} catch (Exception e) {
			log.error("Could not load artist model", e);
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
		page.setSelectedModel(null);
		reset();
	}

	// ##################################################
	// Helper
	// ##################################################
	/**
	 * Creates the StreamedContet for the GraphicImage
	 * 
	 */
	private StreamedContent createStreamedContentForImage() {
		InputStream ips;
		String mimeType;
		try {
			if ((artist != null) && (artist.getImageData() != null)) {
				ips = new ByteArrayInputStream(artist.getImageData());
				mimeType = "image/" + artist.getImageType();
			} else {
				mimeType = DEFAULT_IMAGE_MIME_TYPE;
				ips = new BufferedInputStream(servletContext.getResourceAsStream(DEFAULT_IMAGE));
			}
		} catch (Exception e) {
			log.error("Error during creation of StreamdContent", e);
			return null;
		}

		return new DefaultStreamedContent(ips, mimeType, "defaultImage");
	}

	/**
	 * Resets the bean held states
	 */
	public void reset() {
		artist = null;
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public StreamedContent getStreamedContent() {
		return createStreamedContentForImage();
	}

	public ArtistViewModel getArtist() {
		return artist;
	}
}
