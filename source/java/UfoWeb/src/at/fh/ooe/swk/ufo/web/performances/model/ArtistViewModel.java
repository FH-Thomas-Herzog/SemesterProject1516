package at.fh.ooe.swk.ufo.web.performances.model;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.Base64;
import java.util.Locale;

import javax.enterprise.context.Dependent;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.apache.deltaspike.core.api.common.DeltaSpike;
import org.apache.logging.log4j.Logger;
import org.primefaces.model.DefaultStreamedContent;
import org.primefaces.model.StreamedContent;

import at.fh.ooe.swk.ufo.web.application.model.AbstractIdHolderModel;

/**
 * The artist view model. CDI Dependent scoped bean because we want to use
 * injection here. No problem is still a strong referenced bean, not part of an
 * context at all.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
@Dependent
public class ArtistViewModel extends AbstractIdHolderModel<Long> {

	private static final long serialVersionUID = -8103911126863772972L;

	@Inject
	@DeltaSpike
	private transient ServletContext servletContext;
	@Inject
	private Logger log;

	private String fullName;
	private String firstName;
	private String lastName;
	private String email;
	private Locale locale;
	private URL url;
	private String artistGroup;
	private String artistCategory;
	private byte[] imageData;
	private String imageType;

	private static final String DEFAULT_IMAGE = "/images/no-profile-img.gif";
	private static final String DEFAULT_IMAGE_MIME_TYPE = "image/gif";

	public ArtistViewModel() {
		super();
	}

	/**
	 * Initializes this model.
	 * 
	 * @param id
	 * @param firstName
	 * @param lastName
	 * @param email
	 * @param countryCode
	 * @param url
	 * @param artistGroup
	 * @param artistCategory
	 * @param imageBase64
	 * @param imageType
	 */
	public void init(Long id, String firstName, String lastName, String email, String countryCode, String url,
			String artistGroup, String artistCategory, String imageBase64, String imageType) {
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.fullName = new StringBuilder().append((lastName == null) ? "" : lastName).append(", ")
				.append((firstName == null) ? "" : firstName).toString();
		this.email = email;
		if (countryCode != null) {
			this.locale = new Locale("", countryCode);
		}
		if ((url != null) && (!url.isEmpty())) {
			try {
				this.url = new URL(url);
			} catch (Exception e) {
				log.error("Artist with id: " + id + " has invalid url: " + url);
			}
		}
		this.artistGroup = artistGroup;
		this.artistCategory = artistCategory;
		if ((imageBase64 != null) && (!imageBase64.isEmpty())) {
			this.imageData = Base64.getDecoder().decode(imageBase64);
			this.imageType = imageType;
		}
	}

	private StreamedContent createStreamedContentForImage() {
		InputStream ips;
		String mimeType;
		try {
			if (imageData != null) {
				ips = new ByteArrayInputStream(imageData);
				mimeType = "image/" + imageType;
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

	// ##################################################
	// Getter and Setter
	// ##################################################
	public StreamedContent getStreamedContent() {
		return createStreamedContentForImage();
	}

	public String getFullName() {
		return fullName;
	}

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public String getEmail() {
		return email;
	}

	/**
	 * Got ContextNotActiveExceptions during conversion therefore locale must be
	 * provided and cannot be retrieved from language bean.
	 * 
	 * @param locale
	 *            the locale for localization
	 * @return the localized country display name
	 */
	public String getCountryName(final Locale locale) {
		return (this.locale != null) ? this.locale.getDisplayCountry(locale) : null;
	}

	public String getUrl() {
		return (url != null) ? url.toString() : null;
	}

	public String getArtistGroup() {
		return artistGroup;
	}

	public String getArtistCategory() {
		return artistCategory;
	}

	public byte[] getImageData() {
		return imageData;
	}

	public String getImageType() {
		return imageType;
	}
}
