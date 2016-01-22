package at.fh.ooe.swk.ufo.web.application.bean;

import java.io.Serializable;
import java.util.Locale;

import javax.annotation.PostConstruct;
import javax.enterprise.context.SessionScoped;
import javax.inject.Named;

/**
 * This beans holds the locale information for the current session.<br>
 * Here we could switch the language if implemented.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
@SessionScoped
@Named("languageBean")
public class LanguageBean implements Serializable {

	private static final long serialVersionUID = -2187088910675901499L;

	private Locale locale;

	@PostConstruct
	public void postConstruct() {
		locale = Locale.getDefault();
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
