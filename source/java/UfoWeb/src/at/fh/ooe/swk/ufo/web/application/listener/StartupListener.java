package at.fh.ooe.swk.ufo.web.application.listener;

import java.util.Locale;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.apache.commons.lang3.LocaleUtils;

import at.fh.ooe.swk.ufo.web.application.constants.ContextParameter;

/**
 * Prepares the application on servlet context started
 */
@WebListener
public class StartupListener implements ServletContextListener {

	private static final Locale FALLBACK_LOCALE = Locale.GERMAN;

	/**
	 * Default constructor.
	 */
	public StartupListener() {
	}

	/**
	 * @see ServletContextListener#contextDestroyed(ServletContextEvent)
	 */
	public void contextDestroyed(ServletContextEvent arg0) {
	}

	/**
	 * @see ServletContextListener#contextInitialized(ServletContextEvent)
	 */
	public void contextInitialized(ServletContextEvent arg0) {
		// Sets the default locale defined by web.xml
		final String localeString = arg0.getServletContext().getInitParameter(ContextParameter.LOCALE.key);
		if (localeString == null) {
			Locale.setDefault(LocaleUtils.toLocale(localeString));
		} else {
			Locale.setDefault(FALLBACK_LOCALE);
		}

		// Set truststore here because arguments didn't work. Shouldn't be here
		System.setProperty("javax.net.ssl.trustStore",
				"C:\\Users\\herzo\\Applications\\apache-tomcat-8.0.27\\truststore.jks");
		System.setProperty("javax.net.ssl.trustStorePassword", "ufo");
	}
}
