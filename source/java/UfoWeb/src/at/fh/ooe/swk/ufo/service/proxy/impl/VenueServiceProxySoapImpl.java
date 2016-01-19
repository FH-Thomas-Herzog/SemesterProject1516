package at.fh.ooe.swk.ufo.service.proxy.impl;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Instance;
import javax.inject.Inject;

import at.fh.ooe.swk.ufo.service.proxy.api.VenueServiceProxy;
import at.fh.ooe.swk.ufo.service.proxy.api.model.PerformanceFilter;
import at.fh.ooe.swk.ufo.service.proxy.api.model.ResultModel;
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
	private transient VenueServiceSoap soapService;
	@Inject
	private Instance<VenueViewModel> venueInstance;

	@Inject
	private Instance<PerformanceViewModel> perforamnceModelInstance;

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
						.map(model -> venueToviewModel(model, venueInstance.get(), perforamnceModelInstance))
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
				result.setResult(Arrays.asList(soapResult.getResult()).parallelStream()
						.map(model -> venueToviewModel(model, venueInstance.get(), perforamnceModelInstance))
						.collect(Collectors.toList()));
			}
		} catch (Exception e) {
			result.setInternalError("Could not invoke web service");
			result.setException(e);
		}

		return result;
	}

	private static VenueViewModel venueToviewModel(VenueModel model, VenueViewModel viewModel,
			Instance<PerformanceViewModel> performanceViewModelInstance) {
		VenueViewModel result = null;
		if (model != null) {
			result = viewModel;
			List<PerformanceViewModel> performanceViewModels = null;
			if (model.getPerformances() != null) {
				performanceViewModels = Arrays.asList(model.getPerformances())
						.parallelStream().map(performance -> PerformanceServiceProxySoapImpl
								.performanceToViewModel(performance, performanceViewModelInstance.get()))
						.sorted(new Comparator<PerformanceViewModel>() {
							@Override
							public int compare(PerformanceViewModel o1, PerformanceViewModel o2) {
								return o1.getStartDate().compareTo(o2.getStartDate());
							}
						}).collect(Collectors.toList());
			}
			viewModel.init(model.getId(), model.getName(), model.getFullAddress(), model.getGpsCoordinates(),
					performanceViewModels);
		}

		return result;

	}
}
