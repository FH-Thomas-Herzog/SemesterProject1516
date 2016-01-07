package at.fh.ooe.swk.ufo.web.application.bean;

import java.io.Serializable;
import java.util.Locale;

import javax.annotation.PostConstruct;
import javax.enterprise.context.SessionScoped;
import javax.inject.Named;

@SessionScoped
@Named("languageBean")
public class LanguageBean implements Serializable {

	private static final long serialVersionUID = -2187088910675901499L;

	private Locale locale;

	@PostConstruct
	public void postConstruct() {
		locale = Locale.US;
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public Locale getLocale() {
		return locale;
	}

	public void setLocale(Locale locale) {
		this.locale = locale;
	}
}
