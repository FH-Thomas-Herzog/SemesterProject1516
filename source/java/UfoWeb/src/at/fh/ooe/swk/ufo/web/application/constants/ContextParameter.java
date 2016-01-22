package at.fh.ooe.swk.ufo.web.application.constants;

/**
 * Specifies the used context parameters in the web.xml.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
public enum ContextParameter {
	WEBSERVICE_USERNAME("ufo.webservice.username"),
	WEBSERVICE_PASSWORD("ufo.webservice.password"),
	WEBSERVICE_ARTIST_SERVICE("ufo.webservice.artistService"),
	WEBSERVICE_PERFORMANCE_SERVICE("ufo.webservice.performanceService"),
	WEBSERVICE_VENUE_SERVICE("ufo.webservice.venueService"),
	WEBSERVICE_SECURITY_SERVICE("ufo.webservice.securityService"),
	GOOGLE_MAP_API_KEY("google.map.api.key"),
	LOCALE("Locale"),
	SERVICE_TIMEZONE_KEY("service.timezone");

	public final String key;

	private ContextParameter(String key) {
		this.key = key;
	}
}
