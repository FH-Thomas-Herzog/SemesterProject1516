package at.fh.ooe.swk.ufo.web.performances.model;

import java.util.List;

import javax.enterprise.context.Dependent;

import at.fh.ooe.swk.ufo.web.application.model.AbstractIdHolderModel;

@Dependent
public class VenueViewModel extends AbstractIdHolderModel<Long> {

	private static final long serialVersionUID = -677421592574262160L;

	private String name;
	private String address;
	private String location;
	private boolean fromAddress = Boolean.FALSE;
	private List<PerformanceViewModel> performances;

	public VenueViewModel() {
		super();
	}

	public void init(Long id, String name, String address, String location, List<PerformanceViewModel> performances) {
		this.id = id;
		this.name = name;
		this.address = address;
		this.location = location;
		this.performances = performances;
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
}
