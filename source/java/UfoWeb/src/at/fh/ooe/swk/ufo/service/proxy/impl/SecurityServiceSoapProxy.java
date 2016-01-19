package at.fh.ooe.swk.ufo.service.proxy.impl;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

import at.fh.ooe.swk.ufo.service.proxy.api.SecurityServiceProxy;
import at.fh.ooe.swk.ufo.service.proxy.api.model.ResultModel;
import at.fh.ooe.swk.ufo.webservice.SecurityServiceSoap;
import at.fh.ooe.swk.ufo.webservice.SingleResultModelOfNullableOfBoolean;

/**
 * The service proxy implementation for the soap service.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
@ApplicationScoped
public class SecurityServiceSoapProxy implements SecurityServiceProxy {

	private static final long serialVersionUID = -8916005118750990362L;

	@Inject
	private transient SecurityServiceSoap soapService;

	@Override
	public ResultModel<Boolean> login(String username, String password) {
		final ResultModel<Boolean> result = new ResultModel<>();
		try {
			final SingleResultModelOfNullableOfBoolean soapResult = soapService.validateUserCredentials(username,
					password);
			if (soapResult.getErrorCode() != null) {
				result.setInternalError("Webservice returned error code: " + soapResult.getErrorCode() + " / error: "
						+ soapResult.getError());
			}
			if (soapResult.getServiceErrorCode() != null) {
				result.setInternalError("Webservice returned logical error code: " + soapResult.getServiceErrorCode()
						+ " / error: " + soapResult.getError());
			}
			result.setResult(soapResult.getResult());
		} catch (Exception e) {
			result.setInternalError("Could not invoke web service");
			result.setException(e);
		}

		return result;
	}

}
