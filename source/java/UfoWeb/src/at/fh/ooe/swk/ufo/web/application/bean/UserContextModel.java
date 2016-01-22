package at.fh.ooe.swk.ufo.web.application.bean;

import java.io.Serializable;

import javax.enterprise.context.SessionScoped;
import javax.inject.Named;

/**
 * Represents the current user. If logged in then this bean will hold the
 * authentication data.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
@SessionScoped
@Named("utxModel")
public class UserContextModel implements Serializable {

	private static final long serialVersionUID = 5255973393885888667L;

	private String username;
	private String password;
	private boolean logged = Boolean.FALSE;

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

	public boolean isLogged() {
		return logged;
	}

	public void setLogged(boolean logged) {
		this.logged = logged;
	}
}
