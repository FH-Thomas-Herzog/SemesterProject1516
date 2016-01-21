package at.fh.ooe.swk.ufo.service.impl.proxy;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

import at.fh.ooe.swk.ufo.service.api.converter.ServiceModelConverter;
import at.fh.ooe.swk.ufo.service.api.model.ResultModel;
import at.fh.ooe.swk.ufo.service.api.proxy.ArtistServiceProxy;
import at.fh.ooe.swk.ufo.web.application.model.SimpleNameViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.ArtistViewModel;
import at.fh.ooe.swk.ufo.webservice.ArtistModel;
import at.fh.ooe.swk.ufo.webservice.ArtistServiceSoap;
import at.fh.ooe.swk.ufo.webservice.ListResultModelOfArtistModel;
import at.fh.ooe.swk.ufo.webservice.ListResultModelOfNameModelOfInt64;
import at.fh.ooe.swk.ufo.webservice.SingleResultModelOfArtistModel;

/**
 * The artist proxy implementation for soap service.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
@ApplicationScoped
public class ArtistServiceProxySoapImpl implements ArtistServiceProxy {

	private static final long serialVersionUID = -7009187978626781712L;

	@Inject
	private ServiceModelConverter<ArtistModel, ArtistViewModel> artistConverter;
	@Inject
	private transient ArtistServiceSoap soapService;

	@Override
	public ResultModel<List<ArtistViewModel>> getSimpleArtists() {
		final ResultModel<List<ArtistViewModel>> result = new ResultModel<>();
		try {
			final ListResultModelOfArtistModel soapResult = soapService.getSimpleArtists();
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
					return artistConverter.convert(model);
				}).sorted((o1, o2) -> o1.getFullName().compareTo(o2.getFullName())).collect(Collectors.toList()));
			}
		} catch (Exception e) {
			result.setInternalError("Could not invoke web service");
			result.setException(e);
		}

		return result;
	}

	@Override
	public ResultModel<ArtistViewModel> getArtist(long id) {
		final ResultModel<ArtistViewModel> result = new ResultModel<>();
		try {
			final SingleResultModelOfArtistModel soapResult = soapService.getDetails(id);
			if (soapResult.getErrorCode() != null) {
				result.setInternalError("Webservice returned error code: " + soapResult.getErrorCode() + " / error: "
						+ soapResult.getError());
			}
			if (soapResult.getServiceErrorCode() != null) {
				result.setInternalError("Webservice returned logical error code: " + soapResult.getServiceErrorCode()
						+ " / error: " + soapResult.getError());
			}
			if (soapResult.getResult() != null) {
				result.setResult(artistConverter.convert(soapResult.getResult()));
			}
		} catch (Exception e) {
			result.setInternalError("Could not invoke web service");
			result.setException(e);
		}

		return result;
	}

	@Override
	public ResultModel<List<SimpleNameViewModel<Long>>> getSimpleArtistGroups() {
		ResultModel<List<SimpleNameViewModel<Long>>> result = new ResultModel<>();
		try {
			try {
				result = handleListSimpleModelLongResult(soapService.getSimpleArtistGroups());
			} catch (Exception e) {
				result.setInternalError("Could not invoke web service");
				result.setException(e);
			}
		} catch (Exception e) {
			result.setInternalError("Could not invoke web service");
			result.setException(e);
		}

		return result;
	}

	@Override
	public ResultModel<List<SimpleNameViewModel<Long>>> getSimpleArtistCategories() {
		ResultModel<List<SimpleNameViewModel<Long>>> result = new ResultModel<>();
		try {
			result = handleListSimpleModelLongResult(soapService.getSimpleArtistCategories());
		} catch (Exception e) {
			result.setInternalError("Could not invoke web service");
			result.setException(e);
		}

		return result;
	}

	private ResultModel<List<SimpleNameViewModel<Long>>> handleListSimpleModelLongResult(
			final ListResultModelOfNameModelOfInt64 soapResult) {
		final ResultModel<List<SimpleNameViewModel<Long>>> result = new ResultModel<>();
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
					.map(model -> new SimpleNameViewModel<Long>(model.getId(), model.getName()))
					.sorted((o1, o2) -> o1.getName().compareTo(o2.getName())).collect(Collectors.toList()));
		}

		return result;
	}
}
