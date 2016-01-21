package at.fh.ooe.swk.ufo.service.impl.proxy;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.TimeZone;
import java.util.stream.Collectors;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Instance;
import javax.inject.Inject;

import at.fh.ooe.swk.ufo.service.api.converter.ServiceModelConverter;
import at.fh.ooe.swk.ufo.service.api.model.PerformanceFilter;
import at.fh.ooe.swk.ufo.service.api.model.ResultModel;
import at.fh.ooe.swk.ufo.service.api.proxy.VenueServiceProxy;
import at.fh.ooe.swk.ufo.web.application.annotation.ServiceTimeZone;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.VenueViewModel;
import at.fh.ooe.swk.ufo.webservice.ListResultModelOfVenueModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceFilterRequest;
import at.fh.ooe.swk.ufo.webservice.VenueModel;
import at.fh.ooe.swk.ufo.webservice.VenueServiceSoap;

/**
 * The venue proxy implementation for the soap service.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
@ApplicationScoped
public class VenueServiceProxySoapImpl implements VenueServiceProxy {

	private static final long serialVersionUID = -749857516452830218L;

	@Inject
	private ServiceModelConverter<VenueModel, VenueViewModel> venueConverter;

	@Inject
	private transient VenueServiceSoap soapService;

	@Override
	public ResultModel<List<VenueViewModel>> getVenues() {
		final ResultModel<List<VenueViewModel>> result = new ResultModel<>();
		try {
			final ListResultModelOfVenueModel soapResult = soapService.getVenues();
			if (soapResult.getErrorCode() != null) {
				result.setInternalError("Webservice returned error code: " + soapResult.getErrorCode() + " / error: "
						+ soapResult.getError());
			}
			if (soapResult.getServiceErrorCode() != null) {
				result.setInternalError("Webservice returned logical error code: " + soapResult.getServiceErrorCode()
						+ " / error: " + soapResult.getError());
			}
			if (soapResult.getResult() != null) {
				result.setResult(Arrays.asList(soapResult.getResult()).parallelStream()
						.map(model -> venueConverter.convert(model))
						.sorted((o1, o2) -> o1.getName().compareTo(o2.getName())).collect(Collectors.toList()));
			}
		} catch (Exception e) {
			result.setInternalError("Could not invoke web service");
			result.setException(e);
		}

		return result;
	}

	@Override
	public ResultModel<List<VenueViewModel>> getVenuesForPerformances(PerformanceFilter filter) {
		ResultModel<List<VenueViewModel>> result = new ResultModel<>();
		try {
			result = loadVenues(soapService.getVenuesForPerformances(new PerformanceFilterRequest(filter.getFromDate(),
					filter.getToDate(), filter.getArtistIds().toArray(new Long[filter.getArtistIds().size()]),
					filter.getVenueIds().toArray(new Long[filter.getVenueIds().size()]),
					filter.getArtistGroupIds().toArray(new Long[filter.getArtistGroupIds().size()]),
					filter.getArtistCategoryIds().toArray(new Long[filter.getArtistCategoryIds().size()]),
					filter.getCountries().toArray(new String[filter.getCountries().size()]), filter.getMoved())));
		} catch (Exception e) {
			result.setInternalError("Could not invoke web service");
			result.setException(e);
		}

		return result;
	}

	@Override
	public ResultModel<List<VenueViewModel>> getVenueForPerformances(long id, PerformanceFilter filter) {
		ResultModel<List<VenueViewModel>> result = new ResultModel<>();
		try {
			result = loadVenues(soapService.getVenueForPerformances(id,
					new PerformanceFilterRequest(filter.getFromDate(), filter.getToDate(),
							filter.getArtistIds().toArray(new Long[filter.getArtistIds().size()]),
							filter.getVenueIds().toArray(new Long[filter.getVenueIds().size()]),
							filter.getArtistGroupIds().toArray(new Long[filter.getArtistGroupIds().size()]),
							filter.getArtistCategoryIds().toArray(new Long[filter.getArtistCategoryIds().size()]),
							filter.getCountries().toArray(new String[filter.getCountries().size()]),
							filter.getMoved())));
		} catch (Exception e) {
			result.setInternalError("Could not invoke web service");
			result.setException(e);
		}

		return result;
	}

	private ResultModel<List<VenueViewModel>> loadVenues(ListResultModelOfVenueModel soapResult) {
		final ResultModel<List<VenueViewModel>> result = new ResultModel<>();
		try {
			if (soapResult.getErrorCode() != null) {
				result.setInternalError("Webservice returned error code: " + soapResult.getErrorCode() + " / error: "
						+ soapResult.getError());
			}
			if (soapResult.getServiceErrorCode() != null) {
				result.setInternalError("Webservice returned logical error code: " + soapResult.getServiceErrorCode()
						+ " / error: " + soapResult.getError());
			}
			if (soapResult.getResult() != null) {
				result.setResult(Arrays.asList(soapResult.getResult()).parallelStream()
						.map(model -> venueConverter.convert(model)).collect(Collectors.toList()));
			}
		} catch (Exception e) {
			result.setInternalError("Could not invoke web service");
			result.setException(e);
		}

		return result;
	}
}
