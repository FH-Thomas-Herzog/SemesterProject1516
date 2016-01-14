package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;

import javax.enterprise.context.SessionScoped;
import javax.enterprise.inject.Instance;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.inject.Inject;
import javax.inject.Named;

import org.apache.logging.log4j.Logger;
import org.primefaces.context.RequestContext;
import org.primefaces.event.CloseEvent;

import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;
import at.fh.ooe.swk.ufo.web.performances.model.ArtistViewModel;
import at.fh.ooe.swk.ufo.webservice.ArtistServiceSoap;
import at.fh.ooe.swk.ufo.webservice.SingleResultModelOfArtistModel;

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
	private Logger log;
	@Inject
	private FacesContext fc;
	@Inject
	private MessagesBundle bundle;

	@Inject
	private transient ArtistServiceSoap artistWebservice;

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
			final SingleResultModelOfArtistModel result = artistWebservice.getDetails(id);
			if (result.getErrorCode() != null) {
				artist = null;
				log.error(
						"Webservice returned error code: " + result.getErrorCode() + " / error: " + result.getError());
				fc.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getUnexpectedError(), ""));
			} else {
				artist.init(result.getResult());
				RequestContext.getCurrentInstance().execute("PF('artistInfoDialog').show();");
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
