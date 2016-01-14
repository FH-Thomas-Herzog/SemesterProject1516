package at.fh.ooe.swk.ufo.web.application.constants;

public enum ContextParameter {
	WEBSERVICE_USERNAME("ufo.webservice.username"),
	WEBSERVICE_PASSWORD("ufo.webservice.password"),
	WEBSERVICE_ARTIST_SERVICE("ufo.webservice.artistService"),
	WEBSERVICE_PERFORMANCE_SERVICE("ufo.webservice.performanceService"),
	WEBSERVICE_VENUE_SERVICE("ufo.webservice.venueService"),
	WEBSERVICE_SECURITY_SERVICE("ufo.webservice.securityService"),
	GOOGLE_MAP_API_KEY("google.map.api.key"),
	LOCALE("Locale");

	public final String key;

	private ContextParameter(String key) {
		this.key = key;
	}
}
