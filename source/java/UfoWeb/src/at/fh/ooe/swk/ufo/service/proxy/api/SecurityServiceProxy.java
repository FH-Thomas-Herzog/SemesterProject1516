package at.fh.ooe.swk.ufo.service.proxy.api;

import java.io.Serializable;

import at.fh.ooe.swk.ufo.service.proxy.api.model.ResultModel;

/**
 * The proxy for the security service;
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
public interface SecurityServiceProxy extends Serializable {

	/**
	 * Logs the user in.
	 * 
	 * @param username
	 *            the users username
	 * @param password
	 *            the users password
	 * @return the result holding the boolean result or error information
	 */
	ResultModel<Boolean> login(String username, String password);
}
