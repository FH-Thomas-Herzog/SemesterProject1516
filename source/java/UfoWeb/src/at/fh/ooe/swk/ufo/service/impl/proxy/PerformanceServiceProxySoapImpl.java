package at.fh.ooe.swk.ufo.service.impl.proxy;

import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.TimeZone;
import java.util.stream.Collectors;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Instance;
import javax.inject.Inject;

import at.fh.ooe.swk.ufo.service.api.converter.ServiceModelConverter;
import at.fh.ooe.swk.ufo.service.api.model.PerformanceFilter;
import at.fh.ooe.swk.ufo.service.api.model.PerformanceServiceRequestModel;
import at.fh.ooe.swk.ufo.service.api.model.ResultModel;
import at.fh.ooe.swk.ufo.service.api.proxy.PerformanceServiceProxy;
import at.fh.ooe.swk.ufo.web.application.annotation.ServiceTimeZone;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;
import at.fh.ooe.swk.ufo.webservice.ListResultModelOfPerformanceModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceFilterRequest;
import at.fh.ooe.swk.ufo.webservice.PerformanceModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceRequestModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoap;
import at.fh.ooe.swk.ufo.webservice.SingleResultModelOfNullableOfBoolean;
import at.fh.ooe.swk.ufo.webservice.SingleResultModelOfPerformanceModel;

/**
 * The perforamnce proxy implementation for the soap service.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
@ApplicationScoped
public class PerformanceServiceProxySoapImpl implements PerformanceServiceProxy {

	private static final long serialVersionUID = 3140505551983271806L;

	@Inject
	private ServiceModelConverter<PerformanceModel, PerformanceViewModel> modelConverter;

	@Inject
	private transient PerformanceServiceSoap soapService;

	public PerformanceServiceProxySoapImpl() {
		super();
	}

	@Override
	public ResultModel<List<PerformanceViewModel>> getPerforamnces(PerformanceFilter filter) {
		final ResultModel<List<PerformanceViewModel>> result = new ResultModel<>();
		try {
			final ListResultModelOfPerformanceModel soapResult = soapService
					.getPerformances(new PerformanceFilterRequest(filter.getFromDate(), filter.getToDate(),
							filter.getArtistIds().toArray(new Long[filter.getArtistIds().size()]),
							filter.getVenueIds().toArray(new Long[filter.getVenueIds().size()]),
							filter.getArtistGroupIds().toArray(new Long[filter.getArtistGroupIds().size()]),
							filter.getArtistCategoryIds().toArray(new Long[filter.getArtistCategoryIds().size()]),
							filter.getCountries().toArray(new String[filter.getCountries().size()]),
							filter.getMoved()));

			if (soapResult.getErrorCode() != null) {
				result.setInternalError("Webservice returned error code: " + soapResult.getErrorCode() + " / error: "
						+ result.getError());
			}
			if (soapResult.getServiceErrorCode() != null) {
				result.setError(soapResult.getError());
			}
			if (soapResult.getResult() != null) {
				// Load performances depending on set filter
				result.setResult(Arrays.asList(soapResult.getResult()).parallelStream()
						.map(model -> modelConverter.convert(model)).collect(Collectors.toList()));
			}
		} catch (Exception e) {
			result.setInternalError("Could not invoke web service");
			result.setException(e);
		}

		return result;
	}

	@Override
	public ResultModel<PerformanceViewModel> save(PerformanceServiceRequestModel model) {
		final ResultModel<PerformanceViewModel> result = new ResultModel<>();
		try {
			final PerformanceRequestModel request = new PerformanceRequestModel();
			request.setId(model.getId());
			request.setVersion(model.getVersion());
			request.setUsername(model.getUsername());
			request.setPassword(model.getPassword());
			request.setLanguage(model.getLanguageCode());
			request.setArtistId(model.getArtistId());
			request.setVenueId(model.getVenueId());
			request.setStartDate(model.getStartDate());

			final SingleResultModelOfPerformanceModel soapResult = soapService.save(request);
			if (soapResult.getErrorCode() != null) {
				result.setInternalError("Webservice returned error code: " + soapResult.getErrorCode() + " / error: "
						+ result.getError());
			}
			if (soapResult.getServiceErrorCode() != null) {
				result.setError(soapResult.getError());
			}
			if (soapResult.getResult() != null) {
				result.setResult(modelConverter.convert(soapResult.getResult()));
			}
		} catch (Exception e) {
			result.setInternalError("Could not invoke web service");
			result.setException(e);
		}

		return result;
	}

	@Override
	public ResultModel<Boolean> delete(PerformanceServiceRequestModel model) {
		final ResultModel<Boolean> result = new ResultModel<>();
		try {
			final PerformanceRequestModel request = new PerformanceRequestModel();
			request.setId(model.getId());
			request.setVersion(model.getVersion());
			request.setUsername(model.getUsername());
			request.setPassword(model.getPassword());
			request.setLanguage(model.getLanguageCode());

			final SingleResultModelOfNullableOfBoolean soapResult = soapService.delete(request);
			if (soapResult.getErrorCode() != null) {
				result.setInternalError("Webservice returned error code: " + soapResult.getErrorCode() + " / error: "
						+ result.getError());
			}
			if (soapResult.getServiceErrorCode() != null) {
				result.setError(soapResult.getError());
			} else {
				result.setResult(soapResult.getResult());
			}
		} catch (Exception e) {
			result.setInternalError("Could not invoke web service");
			result.setException(e);
		}

		return result;
	}
}
