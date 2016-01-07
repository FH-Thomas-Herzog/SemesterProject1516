package at.fh.ooe.swk.ufo.web.performances.model;

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
