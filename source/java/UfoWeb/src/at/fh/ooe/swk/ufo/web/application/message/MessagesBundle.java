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
	
	@MessageTemplate("{VENUE}")
	String getVenue();
}
