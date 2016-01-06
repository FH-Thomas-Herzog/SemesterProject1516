package at.fh.ooe.swk.ufo.web.performances.model;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.message.LoggerNameAwareMessage;

public class PerformanceRowModel {

	private final IdLabelModel venue;
	private final Map<Calendar, List<PerformanceViewModel>> map;

	public PerformanceRowModel(IdLabelModel venue, Map<Calendar, List<PerformanceViewModel>> map) {
		super();
		this.venue = venue;
		this.map = map;
	}

	public IdLabelModel getVenue() {
		return venue;
	}

	public List<PerformanceViewModel> getModelForColumn(final Calendar calendar) {
		return map.get(calendar);
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((venue == null) ? 0 : venue.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PerformanceRowModel other = (PerformanceRowModel) obj;
		if (venue == null) {
			if (other.venue != null)
				return false;
		} else if (!venue.equals(other.venue))
			return false;
		return true;
	}

}
