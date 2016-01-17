package at.fh.ooe.swk.ufo.web.application.listener;

import java.util.Locale;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.apache.commons.lang3.LocaleUtils;

import at.fh.ooe.swk.ufo.web.application.constants.ContextParameter;

/**
 * Application Lifecycle Listener implementation class StartupListener
 *
 */
@WebListener
public class StartupListener implements ServletContextListener {

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
		final String localeString = arg0.getServletContext().getInitParameter(ContextParameter.LOCALE.key);
		final Locale locale = LocaleUtils.toLocale(localeString);
		Locale.setDefault(locale);

		// Set truststore
		System.setProperty("javax.net.ssl.trustStore",
				"C:\\Users\\herzo\\Applications\\apache-tomcat-8.0.27\\truststore.jks");
		System.setProperty("javax.net.ssl.trustStorePassword", "ufo");
	}
}
