package at.fh.ooe.swk.ufo.web.performances.model;

import java.util.List;

import javax.enterprise.context.Dependent;

import at.fh.ooe.swk.ufo.web.application.model.AbstractIdHolderModel;

/**
 * The venue view model. CDI Dependent scoped bean because we want to use
 * injection here. No problem is still a strong referenced bean, not part of an
 * context at all.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
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

	/**
	 * Initializes this view model.
	 * 
	 * @param id
	 * @param name
	 * @param address
	 * @param location
	 * @param performances
	 */
	public void init(Long id, String name, String address, String location, List<PerformanceViewModel> performances) {
		this.id = id;
		this.name = name;
		this.address = address;
		this.location = location;
		this.performances = performances;
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
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
