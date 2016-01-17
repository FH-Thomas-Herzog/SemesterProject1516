package at.fh.ooe.swk.ufo.service.proxy.api;

import java.io.Serializable;
import java.util.List;

import at.fh.ooe.swk.ufo.service.proxy.model.PerformanceFilter;
import at.fh.ooe.swk.ufo.service.proxy.model.ResultModel;
import at.fh.ooe.swk.ufo.web.performances.model.VenueViewModel;

public interface VenueServiceProxy extends Serializable {

	ResultModel<List<VenueViewModel>> getVenues();

	ResultModel<List<VenueViewModel>> getVenuesForPerformances(PerformanceFilter filter);

	ResultModel<List<VenueViewModel>> getVenueForPerformances(long id, PerformanceFilter filter);

}
