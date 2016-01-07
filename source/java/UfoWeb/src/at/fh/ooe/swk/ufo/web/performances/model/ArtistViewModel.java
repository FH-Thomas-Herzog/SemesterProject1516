package at.fh.ooe.swk.ufo.web.performances.model;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.Serializable;
import java.net.URL;
import java.util.Base64;
import java.util.List;
import java.util.Locale;

import org.apache.commons.lang3.LocaleUtils;

import at.fh.ooe.swk.ufo.webservice.ArtistModel;

public class ArtistViewModel implements Serializable {

	private static final long serialVersionUID = -8103911126863772972L;

	private final String firstName;
	private final String lastName;
	private final String email;
	private final Locale locale;
	private final URL url;
	private final String artistGroup;
	private final String imageBase64;
	private final String imageType;

	public ArtistViewModel(ArtistModel model) {
		super();
		firstName = model.getFirstName();
		lastName = model.getLastName();
		email = model.getEmail();
		url = null;
		locale = new Locale("", model.getCountryCode());
		artistGroup = model.getArtistGroup();
		imageBase64 = model.getImage();
		imageType = model.getImageType();
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

	public String getImageBase64() {
		return imageBase64;
	}

	public String getImageType() {
		return imageType;
	}
}
