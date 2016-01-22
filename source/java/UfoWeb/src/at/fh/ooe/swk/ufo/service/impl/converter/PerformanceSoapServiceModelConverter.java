package at.fh.ooe.swk.ufo.service.impl.converter;

import java.util.Calendar;
import java.util.TimeZone;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Instance;
import javax.inject.Inject;

import at.fh.ooe.swk.ufo.service.api.annotation.ServiceTimeZone;
import at.fh.ooe.swk.ufo.service.api.converter.ServiceModelConverter;
import at.fh.ooe.swk.ufo.web.performances.model.ArtistViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.VenueViewModel;
import at.fh.ooe.swk.ufo.webservice.ArtistModel;
import at.fh.ooe.swk.ufo.webservice.PerformanceModel;
import at.fh.ooe.swk.ufo.webservice.VenueModel;

/**
 * The soap model converter for performances models.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 22, 2016
 */
@ApplicationScoped
public class PerformanceSoapServiceModelConverter
		implements ServiceModelConverter<PerformanceModel, PerformanceViewModel> {

	private static final long serialVersionUID = 2456376978256185082L;

	@Inject
	@ServiceTimeZone
	private TimeZone serviceTimeZone;
	@Inject
	private Instance<PerformanceViewModel> perforamnceModelInstance;
	@Inject
	private ServiceModelConverter<VenueModel, VenueViewModel> venueConverter;
	@Inject
	private ServiceModelConverter<ArtistModel, ArtistViewModel> artistConverter;

	@Override
	public PerformanceViewModel convert(PerformanceModel model) {
		PerformanceViewModel result = null;
		if (model != null) {
			result = perforamnceModelInstance.get();
			final Calendar startDate = model.getStartDate();
			final Calendar endDate = model.getEndDate();
			final Calendar formerStartDate = model.getFormerStartDate();
			final Calendar formerEndDate = model.getFormerEndDate();
			startDate.setTimeZone(serviceTimeZone);
			endDate.setTimeZone(serviceTimeZone);
			if (formerStartDate != null) {
				formerStartDate.setTimeZone(serviceTimeZone);
			}
			if (formerEndDate != null) {
				formerEndDate.setTimeZone(serviceTimeZone);
			}
			result.init(model.getId(), model.getVersion(), startDate, formerStartDate, endDate, formerEndDate,
					artistConverter.convert(model.getArtist()), venueConverter.convert(model.getVenue()),
					venueConverter.convert(model.getFormerVenue()));
		}

		return result;
	}

}
