package at.fh.ooe.swk.ufo.web.performances.model;

import java.io.Serializable;
import java.util.List;

import javax.enterprise.context.Dependent;

@Dependent
public class VenueViewModel implements Serializable {

	private static final long serialVersionUID = -677421592574262160L;

	private Long id;
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
