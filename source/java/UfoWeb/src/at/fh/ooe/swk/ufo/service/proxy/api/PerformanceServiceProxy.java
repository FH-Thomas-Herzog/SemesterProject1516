package at.fh.ooe.swk.ufo.service.proxy.api;

import java.io.Serializable;
import java.util.List;

import at.fh.ooe.swk.ufo.service.proxy.model.PerformanceFilter;
import at.fh.ooe.swk.ufo.service.proxy.model.PerformanceModel;
import at.fh.ooe.swk.ufo.service.proxy.model.ResultModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;

public interface PerformanceServiceProxy extends Serializable {

	public ResultModel<List<PerformanceViewModel>> getPerforamnces(PerformanceFilter filter);

	public ResultModel<PerformanceViewModel> save(PerformanceModel model);
	
	public ResultModel<Boolean> delete(PerformanceModel model);
}
