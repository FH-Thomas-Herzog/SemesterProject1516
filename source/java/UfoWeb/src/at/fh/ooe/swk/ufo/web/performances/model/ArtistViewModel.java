package at.fh.ooe.swk.ufo.web.performances.model;

import java.io.Serializable;
import java.net.URL;
import java.util.Base64;
import java.util.Locale;

import javax.enterprise.context.Dependent;
import javax.inject.Inject;

import org.apache.logging.log4j.Logger;

import at.fh.ooe.swk.ufo.webservice.ArtistModel;

@Dependent
public class ArtistViewModel implements Serializable {

	private static final long serialVersionUID = -8103911126863772972L;

	@Inject
	private Logger log;

	private String firstName;
	private String lastName;
	private String email;
	private Locale locale;
	private URL url;
	private String artistGroup;
	private byte[] imageData;
	private String imageType;

	public ArtistViewModel() {
		super();
	}

	public void init(ArtistModel model) {
		firstName = model.getFirstName();
		lastName = model.getLastName();
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
