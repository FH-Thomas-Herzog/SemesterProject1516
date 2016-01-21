package at.fh.ooe.swk.ufo.service.api.model;

/**
 * The base class for the service operation request models which require
 * authentication.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
public abstract class AbstractAuthenticationServiceRequestModel {

	private String username;
	private String password;
	private String languageCode;

	public AbstractAuthenticationServiceRequestModel() {
		super();
	}

	public AbstractAuthenticationServiceRequestModel(String username, String password, String languageCode) {
		super();
		this.username = username;
		this.password = password;
		this.languageCode = languageCode;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getLanguageCode() {
		return languageCode;
	}

	public void setLanguageCode(String languageCode) {
		this.languageCode = languageCode;
	}

}
