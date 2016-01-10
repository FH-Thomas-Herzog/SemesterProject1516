package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;

import javax.enterprise.context.SessionScoped;
import javax.enterprise.inject.Instance;
import javax.inject.Inject;
import javax.inject.Named;

import org.apache.logging.log4j.Logger;
import org.primefaces.event.CloseEvent;

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
	private transient ArtistServiceSoap artistWebservice;
	@Inject
	private Logger log;
	@Inject
	private Instance<ArtistViewModel> artistInstance;

	private ArtistViewModel artist;

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
		reset();
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
	public ArtistViewModel getArtist() {
		return artist;
	}
}
