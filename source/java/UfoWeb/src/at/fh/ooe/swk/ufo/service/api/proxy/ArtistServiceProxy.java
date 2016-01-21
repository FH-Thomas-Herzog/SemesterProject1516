package at.fh.ooe.swk.ufo.service.api.proxy;

import java.io.Serializable;
import java.util.List;

import at.fh.ooe.swk.ufo.service.api.model.ResultModel;
import at.fh.ooe.swk.ufo.web.application.model.SimpleNameViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.ArtistViewModel;

/**
 * The proxy interface for the artist service.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
public interface ArtistServiceProxy extends Serializable {

	/**
	 * Gets all simple artists. Means no meta data loaded such as images.
	 * 
	 * @return the result holding the loaded {@link ArtistViewModel} instances
	 *         or error information
	 */
	ResultModel<List<ArtistViewModel>> getSimpleArtists();

	/**
	 * Gets the artist by its id with full loaded data.
	 * 
	 * @param id
	 *            the artist id
	 * @return the result holding the loaded artist or error information.
	 * @throws NullPointerException
	 *             if the id is null
	 */
	ResultModel<ArtistViewModel> getArtist(long id);

	/**
	 * Gets the simple artist groups by its id with full loaded data.
	 * 
	 * @return the result holding the loaded artist groups or error information.
	 */
	ResultModel<List<SimpleNameViewModel<Long>>> getSimpleArtistGroups();

	/**
	 * Gets the simple artist categories by its id with full loaded data.
	 * 
	 * @return the result holding the loaded artist categories or error
	 *         information.
	 */
	ResultModel<List<SimpleNameViewModel<Long>>> getSimpleArtistCategories();
}
