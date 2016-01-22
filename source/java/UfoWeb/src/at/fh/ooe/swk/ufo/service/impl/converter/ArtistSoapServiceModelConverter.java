package at.fh.ooe.swk.ufo.service.impl.converter;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Instance;
import javax.inject.Inject;

import at.fh.ooe.swk.ufo.service.api.converter.ServiceModelConverter;
import at.fh.ooe.swk.ufo.web.performances.model.ArtistViewModel;
import at.fh.ooe.swk.ufo.webservice.ArtistModel;

/**
 * The soap model converter for artist soap models.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 22, 2016
 */
@ApplicationScoped
public class ArtistSoapServiceModelConverter implements ServiceModelConverter<ArtistModel, ArtistViewModel> {

	private static final long serialVersionUID = 6827704517739152291L;

	@Inject
	private Instance<ArtistViewModel> artistViewModelInstance;

	@Override
	public ArtistViewModel convert(ArtistModel model) {
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
