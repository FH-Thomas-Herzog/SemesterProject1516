package at.fh.ooe.swk.ufo.service.proxy.impl;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Instance;
import javax.inject.Inject;

import at.fh.ooe.swk.ufo.service.proxy.api.VenueServiceProxy;
import at.fh.ooe.swk.ufo.service.proxy.model.PerformanceFilter;
import at.fh.ooe.swk.ufo.service.proxy.model.ResultModel;
import at.fh.ooe.swk.ufo.web.performances.model.VenueViewModel;
import at.fh.ooe.swk.ufo.webservice.ListResultModelOfVenueModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceFilterRequest;
import at.fh.ooe.swk.ufo.webservice.VenueServiceSoap;

@ApplicationScoped
public class VenueServiceProxySoapImpl implements VenueServiceProxy {

	private static final long serialVersionUID = -749857516452830218L;

	@Inject
	private transient VenueServiceSoap soapService;
	@Inject
	private Instance<VenueViewModel> venueInstance;

	@Override
	public ResultModel<List<VenueViewModel>> getVenuesForPerformances(PerformanceFilter filter) {
		ResultModel<List<VenueViewModel>> result = new ResultModel<>();
		try {
			result = loadVenues(soapService.getVenuesForPerformances(new PerformanceFilterRequest(filter.getFromDate(),
					filter.getToDate(), filter.getArtistIds().toArray(new Long[filter.getArtistIds().size()]),
					filter.getVenueIds().toArray(new Long[filter.getVenueIds().size()]))));
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
							filter.getVenueIds().toArray(new Long[filter.getVenueIds().size()]))));
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
				result.setResult(Arrays.asList(soapResult.getResult()).parallelStream().map(model -> {
					final VenueViewModel viewModel = venueInstance.get();
					viewModel.init(model);
					return viewModel;
				}).collect(Collectors.toList()));
			}
		} catch (Exception e) {
			result.setInternalError("Could not invoke web service");
			result.setException(e);
		}

		return result;
	}
}
