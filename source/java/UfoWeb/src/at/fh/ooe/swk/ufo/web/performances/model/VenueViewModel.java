package at.fh.ooe.swk.ufo.web.performances.model;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import javax.enterprise.context.Dependent;
import javax.enterprise.inject.Instance;
import javax.inject.Inject;

import at.fh.ooe.swk.ufo.webservice.VenueModel;

@Dependent
public class VenueViewModel implements Serializable {

	private static final long serialVersionUID = -677421592574262160L;

	@Inject
	private Instance<PerformanceViewModel> perforamnceModelInstance;

	private Long id;
	private String name;
	private String address;
	private String location;
	private boolean fromAddress = Boolean.FALSE;
	private List<PerformanceViewModel> filteredPerformances;
	private List<PerformanceViewModel> performances;

	public VenueViewModel() {
		super();
	}

	public void init(VenueModel model) {
		id = model.getId();
		name = model.getName();
		address = model.getFullAddress();
		location = model.getGpsCoordinates();
		if (model.getPerformances() != null) {
			performances = Arrays.asList(model.getPerformances()).parallelStream().map(performance -> {
				final PerformanceViewModel viewModel = perforamnceModelInstance.get();
				viewModel.init(performance);
				return viewModel;
			}).sorted(new Comparator<PerformanceViewModel>() {
				@Override
				public int compare(PerformanceViewModel o1, PerformanceViewModel o2) {
					return o1.getStartDate().compareTo(o2.getStartDate());
				}
			}).collect(Collectors.toList());
		}
	}

	public Long getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getAddress() {
		return address;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		fromAddress = Boolean.TRUE;
		this.location = location;
	}

	public List<PerformanceViewModel> getPerformances() {
		return performances;
	}

	public boolean isFromAddress() {
		return fromAddress;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
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
		VenueViewModel other = (VenueViewModel) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
}
