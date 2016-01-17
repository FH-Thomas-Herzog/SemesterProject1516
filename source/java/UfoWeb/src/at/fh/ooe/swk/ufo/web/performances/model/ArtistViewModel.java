package at.fh.ooe.swk.ufo.web.performances.model;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.Serializable;
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

import at.fh.ooe.swk.ufo.webservice.ArtistModel;

@Dependent
public class ArtistViewModel implements Serializable {

	private static final long serialVersionUID = -8103911126863772972L;

	@Inject
	@DeltaSpike
	private transient ServletContext servletContext;
	@Inject
	private Logger log;

	private Long id;
	private String fullName;
	private String firstName;
	private String lastName;
	private String email;
	private Locale locale;
	private URL url;
	private String artistGroup;
	private byte[] imageData;
	private String imageType;

	private static final String DEFAULT_IMAGE = "/images/no-profile-img.gif";
	private static final String DEFAULT_IMAGE_MIME_TYPE = "image/gif";

	public ArtistViewModel() {
		super();
	}

	public void init(ArtistModel model) {
		id = model.getId();
		firstName = model.getFirstName();
		lastName = model.getLastName();
		fullName = new StringBuilder().append((lastName == null) ? "" : lastName).append(", ")
				.append((firstName == null) ? "" : firstName).toString();
		email = model.getEmail();
		locale = new Locale("", model.getCountryCode());
		artistGroup = model.getArtistGroup();
		URL url = null;
		if ((model.getUrl() != null) && (!model.getUrl().isEmpty())) {
			try {
				url = new URL(model.getUrl());
			} catch (Exception e) {
				log.error("Artist with id: " + model.getId() + " has invalid url: " + model.getUrl());
			}
		}
		this.url = url;
		if ((model.getImage() != null) && (!model.getImage().isEmpty())) {
			imageData = Base64.getDecoder().decode(model.getImage());
			imageType = model.getImageType();
		} else {
			imageData = null;
			imageType = null;
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

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public String getCountryName(Locale locale) {
		return (this.locale != null) ? this.locale.getDisplayCountry(locale) : null;
	}

	public String getUrl() {
		return (url != null) ? url.toString() : null;
	}

	public String getArtistGroup() {
		return artistGroup;
	}

	public byte[] getImageData() {
		return imageData;
	}

	public String getImageType() {
		return imageType;
	}
}
