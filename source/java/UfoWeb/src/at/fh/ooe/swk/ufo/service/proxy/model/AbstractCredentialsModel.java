package at.fh.ooe.swk.ufo.service.proxy.model;

public abstract class AbstractCredentialsModel {

	private String username;
	private String password;
	private String languageCode;

	public AbstractCredentialsModel() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AbstractCredentialsModel(String username, String password, String languageCode) {
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
