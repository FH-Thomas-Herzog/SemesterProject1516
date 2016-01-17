package at.fh.ooe.swk.ufo.web.performances.constants;

public enum VenueSearchOption {
	NAME, ADDRESS;

	public boolean isName() {
		return this.equals(NAME);
	}

	public boolean isAddress() {
		return this.equals(ADDRESS);
	}
}
