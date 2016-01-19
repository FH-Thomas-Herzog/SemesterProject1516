package at.fh.ooe.swk.ufo.service.proxy.api;

import java.io.Serializable;
import java.util.List;

import at.fh.ooe.swk.ufo.service.proxy.api.model.PerformanceFilter;
import at.fh.ooe.swk.ufo.service.proxy.api.model.PerformanceServiceRequestModel;
import at.fh.ooe.swk.ufo.service.proxy.api.model.ResultModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;

/**
 * The performance proxy for the performance service.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
public interface PerformanceServiceProxy extends Serializable {

	/**
	 * Gets the performances for the given filter.
	 * 
	 * @param filter
	 *            the filter for loading the performances
	 * @return the result holding the {@link PerformanceViewModel} instance or
	 *         error information
	 */
	ResultModel<List<PerformanceViewModel>> getPerforamnces(PerformanceFilter filter);

	/**
	 * Saves the given performance.
	 * 
	 * @param model
	 *            the performance holding the data
	 * @return the result holding the {@link PerformanceViewModel} representing
	 *         the saved performance or error information
	 */
	ResultModel<PerformanceViewModel> save(PerformanceServiceRequestModel model);

	/**
	 * Deletes the given performance.
	 * 
	 * @param model
	 *            the performance holding the id and version
	 * @return the result holding the boolean result or error information
	 */
	ResultModel<Boolean> delete(PerformanceServiceRequestModel model);
}
