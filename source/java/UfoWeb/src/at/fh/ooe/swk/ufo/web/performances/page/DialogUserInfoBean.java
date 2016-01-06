package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.Serializable;
import java.math.BigInteger;
import java.util.Base64;

import javax.annotation.PostConstruct;
import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.ServletContext;

import org.apache.deltaspike.core.api.common.DeltaSpike;
import org.apache.logging.log4j.Logger;
import org.primefaces.event.CloseEvent;
import org.primefaces.model.DefaultStreamedContent;
import org.primefaces.model.StreamedContent;

import at.fh.ooe.swk.ufo.webservice.ArtistModel;
import at.fh.ooe.swk.ufo.webservice.ArtistServiceSoap;
import at.fh.ooe.swk.ufo.webservice.model.UserModel;

@RequestScoped
@Named("userInfoDialog")
public class DialogUserInfoBean implements Serializable {

	private static final long serialVersionUID = -5532729555560855764L;

	@Inject
	private PerformancesPage page;
	@Inject
	@DeltaSpike
	private transient ServletContext servletContext;
	@Inject
	private ArtistServiceSoap artistWebservice;
	@Inject
	private Logger log;

	private UserModel user;
	private StreamedContent streamedContent;

	private static final String DEFAULT_IMAGE = "/images/no-profile-img.gif";
	private static final String DEFAULT_IMAGE_MIME_TYPE = "image/gif";

	@PostConstruct
	public void postConstruct() {
		try {
			ArtistModel model = artistWebservice.getDetails(1);
			log.info(model.getFirstName());
		} catch (Exception e) {
			log.error("Could not load artist model", e);
		}
		user = new UserModel();
		user.setFirstName("Thomas");
		user.setLastName("Herzog");
		user.setEmail("t.herzog@curecomp.com");
		streamedContent = createStreamedContentForImage(user);
	}

	// ##################################################
	// Event Listener
	// ##################################################
	public void onClose(CloseEvent event) {
		// page.setSelectedUser(null);
	}

	// ##################################################
	// Helper
	// ##################################################
	private StreamedContent createStreamedContentForImage(UserModel model) {
		String mimeType = "image/";
		BufferedInputStream bips;
		try {
			if ((model != null) && (model.getImage() != null)) {
				mimeType += model.getImageType();
				byte[] buf = new byte[1024];
				bips = new BufferedInputStream(new ByteArrayInputStream(buf));
				bips.read(Base64.getDecoder().decode(model.getImage()));
			} else {
				mimeType = DEFAULT_IMAGE_MIME_TYPE;
				bips = new BufferedInputStream(servletContext.getResourceAsStream(DEFAULT_IMAGE));
			}
		} catch (Exception e) {
			return null;
		}

		return new DefaultStreamedContent(bips, mimeType, "defaultImage");
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public StreamedContent getStreamedContent() {
		return streamedContent;
	}

	public UserModel getUser() {
		return user;
	}

	public void setUser(UserModel user) {
		this.user = user;
	}
}
