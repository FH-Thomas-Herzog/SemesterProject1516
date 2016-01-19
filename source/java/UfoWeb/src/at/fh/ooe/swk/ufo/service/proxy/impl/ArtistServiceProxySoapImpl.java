package at.fh.ooe.swk.ufo.service.proxy.impl;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Instance;
import javax.inject.Inject;

import at.fh.ooe.swk.ufo.service.proxy.api.ArtistServiceProxy;
import at.fh.ooe.swk.ufo.service.proxy.api.model.ResultModel;
import at.fh.ooe.swk.ufo.web.performances.model.ArtistViewModel;
import at.fh.ooe.swk.ufo.webservice.ArtistModel;
import at.fh.ooe.swk.ufo.webservice.ArtistServiceSoap;
import at.fh.ooe.swk.ufo.webservice.ListResultModelOfArtistModel;
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
	private transient ArtistServiceSoap soapService;
	@Inject
	private Instance<ArtistViewModel> artistViewModelInstance;

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
					return artistToViewModel(model);
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
				result.setResult(artistToViewModel(soapResult.getResult()));
			}
		} catch (Exception e) {
			result.setInternalError("Could not invoke web service");
			result.setException(e);
		}

		return result;
	}

	private ArtistViewModel artistToViewModel(ArtistModel model) {
		ArtistViewModel viewModel = null;
		if (model != null) {
			viewModel = artistViewModelInstance.get();
			viewModel.init(model.getId(), model.getFirstName(), model.getLastName(), model.getEmail(),
					model.getCountryCode(), model.getUrl(), model.getArtistGroup(), model.getArtistCategory(),
					model.getImage(), model.getImageType());
		}

		return viewModel;
	}
}
