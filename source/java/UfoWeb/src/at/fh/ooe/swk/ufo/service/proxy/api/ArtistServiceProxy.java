package at.fh.ooe.swk.ufo.service.proxy.api;

import java.io.Serializable;
import java.util.List;

import at.fh.ooe.swk.ufo.service.proxy.model.ResultModel;
import at.fh.ooe.swk.ufo.web.performances.model.ArtistViewModel;

public interface ArtistServiceProxy extends Serializable {

	ResultModel<List<ArtistViewModel>> getSimpleArtists();
	
	ResultModel<ArtistViewModel> getArtist(long id);
}
