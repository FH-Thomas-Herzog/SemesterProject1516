package at.fh.ooe.swk.ufo.service.api.proxy;

import java.io.Serializable;
import java.util.List;

import at.fh.ooe.swk.ufo.service.api.model.PerformanceFilter;
import at.fh.ooe.swk.ufo.service.api.model.ResultModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.VenueViewModel;

/**
 * The proxa for the venue service.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
public interface VenueServiceProxy extends Serializable {

	/**
	 * Gets all of the venues
	 * 
	 * @return the result holding the loaded {@link VenueViewModel} instance or
	 *         error information
	 */
	ResultModel<List<VenueViewModel>> getVenues();

	/**
	 * Gets the venues for the given filter with its fetched related
	 * performances.
	 * 
	 * @param filter
	 *            the filter for the loading
	 * @return the result holding the {@link VenueViewModel} instance which hold
	 *         their related {@link PerformanceViewModel} collection or error
	 *         information
	 */
	ResultModel<List<VenueViewModel>> getVenuesForPerformances(PerformanceFilter filter);

	/**
	 * Gets a single venue for the given id and filter.
	 * 
	 * @param id
	 *            the venue filter
	 * @param filter
	 *            the filter for the loading
	 * @return the result holding the {@link VenueViewModel} instance or error
	 *         information
	 */
	ResultModel<List<VenueViewModel>> getVenueForPerformances(long id, PerformanceFilter filter);
}
