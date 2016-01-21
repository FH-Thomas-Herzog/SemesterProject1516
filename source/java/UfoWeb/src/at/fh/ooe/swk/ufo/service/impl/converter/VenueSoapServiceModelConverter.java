package at.fh.ooe.swk.ufo.service.impl.converter;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.TimeZone;
import java.util.stream.Collectors;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Instance;
import javax.inject.Inject;

import at.fh.ooe.swk.ufo.service.api.converter.ServiceModelConverter;
import at.fh.ooe.swk.ufo.web.application.annotation.ServiceTimeZone;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.VenueViewModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceModel;
import at.fh.ooe.swk.ufo.webservice.VenueModel;

@ApplicationScoped
public class VenueSoapServiceModelConverter implements ServiceModelConverter<VenueModel, VenueViewModel> {

	private static final long serialVersionUID = 1237928596496084773L;

	@Inject
	@ServiceTimeZone
	private TimeZone serviceTimeZone;
	@Inject
	private Instance<VenueViewModel> venueInstance;
	@Inject
	private ServiceModelConverter<PerformanceModel, PerformanceViewModel> performanceConverter;

	@Override
	public VenueViewModel convert(VenueModel model) {
		VenueViewModel result = null;
		if (model != null) {
			result = venueInstance.get();
			List<PerformanceViewModel> performanceViewModels = null;
			if (model.getPerformances() != null) {
				performanceViewModels = Arrays.asList(model.getPerformances()).parallelStream()
						.map(performance -> performanceConverter.convert(performance))
						.sorted(new Comparator<PerformanceViewModel>() {
							@Override
							public int compare(PerformanceViewModel o1, PerformanceViewModel o2) {
								return o1.getStartDate().compareTo(o2.getStartDate());
							}
						}).collect(Collectors.toList());
			}
			result.init(model.getId(), model.getName(), model.getFullAddress(), model.getGpsCoordinates(),
					performanceViewModels);
		}

		return result;
	}

}
