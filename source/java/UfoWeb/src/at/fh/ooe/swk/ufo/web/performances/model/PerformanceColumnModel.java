package at.fh.ooe.swk.ufo.web.performances.model;

/**
 * The performance column model for lazy data table.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 23, 2016
 */
public class PerformanceColumnModel {

	private final int startHour;
	private final String header;

	public PerformanceColumnModel(int startHour) {
		super();

		this.startHour = startHour;
		this.header = startHour + " - " + (startHour + 1);
	}

	// ####################################################
	// Getter and Setter
	// ####################################################
	public String getHeader() {
		return header;
	}

	public int getStartHour() {
		return startHour;
	}
}
