package at.fh.ooe.swk.ufo.web.application.message;

import java.io.Serializable;

import javax.inject.Named;

import org.apache.deltaspike.core.api.message.MessageBundle;
import org.apache.deltaspike.core.api.message.MessageTemplate;

/**
 * This interface specifies the localized messages available to the application.
 * Thanks to deltaspike this bean is available to the EL as well if annotated
 * with "@Named"
 * 
 * @author Thomas
 *
 */
@MessageBundle
@Named("msg")
public interface MessagesBundle extends Serializable {

	@MessageTemplate("{NAME}")
	String getName();

	@MessageTemplate("{FIRST_NAME}")
	String getFirstName();

	@MessageTemplate("{LAST_NAME}")
	String getLastName();

	@MessageTemplate("{EMAIL}")
	String getEmail();

	@MessageTemplate("{URL}")
	String getUrl();

	@MessageTemplate("{ARTIST}")
	String getArtist();

	@MessageTemplate("{ARTISTS}")
	String getArtists();

	@MessageTemplate("{ARTIST_GROUP}")
	String getArtistGroup();

	@MessageTemplate("{ARTIST_CATEGORY}")
	String getArtistCategory();

	@MessageTemplate("{VENUE}")
	String getVenue();

	@MessageTemplate("{VENUES}")
	String getVenues();

	@MessageTemplate("{COUNTRY}")
	String getCountry();

	@MessageTemplate("{TRIGGER_SEARCH_ON_ENTER}")
	String getTriggerSearchOnEnter();

	@MessageTemplate("{OPEN_VENUE_DIALOG}")
	String getOpenVenueDialog();

	@MessageTemplate("{FILTER}")
	String getFilter();

	@MessageTemplate("{RESET}")
	String getReset();

	@MessageTemplate("{OPTIONS}")
	String getOptions();

	@MessageTemplate("{PERFORMANCE}")
	String getPerformance();

	@MessageTemplate("{PERFORMANCES}")
	String getPerformances();

	@MessageTemplate("{PLEASE_CHOOSE}")
	String getPleaseChoose();

	@MessageTemplate("{FROM}")
	String getFrom();

	@MessageTemplate("{TO}")
	String getTo();

	@MessageTemplate("{DATE}")
	String getDate();

	@MessageTemplate("{DAY}")
	String getDay();

	@MessageTemplate("{LOGIN}")
	String getLogin();

	@MessageTemplate("{LOGOUT}")
	String getLogout();

	@MessageTemplate("UNEXPECTED_ERROR")
	String getUnexpectedError();

	@MessageTemplate("{USERNAME}")
	String getUsername();

	@MessageTemplate("{PASSWORD}")
	String getPassword();

	@MessageTemplate("{TIME}")
	String getTime();

	@MessageTemplate("{SAVE}")
	String getSave();

	@MessageTemplate("{CREATE}")
	String getCreate();

	@MessageTemplate("{CLOSE}")
	String getClose();

	@MessageTemplate("{DELETE}")
	String getDelete();

	@MessageTemplate("{NEW_ENTRY}")
	String getNewEntry();

	@MessageTemplate("{AT}")
	String getAt();

	@MessageTemplate("{REFRESH}")
	String getRefresh();

	@MessageTemplate("{Search}")
	String getSearch();

	@MessageTemplate("{ADDRESS}")
	String getAddress();

	@MessageTemplate("{WARNING_PERFORMANCE_MOVED}")
	String getWarningPerformanceMoved();

	@MessageTemplate("{NO_PERFORMANCES_AVAILABLE}")
	String getNoPerformancesAvialable();

	@MessageTemplate("{NO_ARTISTS_AVAILABLE}")
	String getNoArtistsAvialable();

	@MessageTemplate("{NO_VENUES_AVAILABLE}")
	String getNoVenuesAvialable();

	@MessageTemplate("{CLICK_CREATE_PERFORMANCE}")
	String getClickCreatePerformance();

	@MessageTemplate("{CLICK_EDIT_PERFORMANCE}")
	String getClickEditPerformance();

	@MessageTemplate("{CLICK_OPEN_ARTIST_DETAILS}")
	String getClickOpenArtistDetails();

	@MessageTemplate("{CLICK_OPEN_VENUE_DETAILS}")
	String getClickOpenVenueDetails();

	@MessageTemplate("{ERROR_CONVERT_NOT_FOUND}")
	String getErrorConvertNotFound();

	@MessageTemplate("{ERROR_LOGN_FAILED}")
	String getErrorLoginFailed();

	@MessageTemplate("{ERROR_VENUE_NOT_FOUND}")
	String getVenueNotFound();
}
