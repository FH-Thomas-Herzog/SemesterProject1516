package at.fh.ooe.swk.ufo.web.performances.constants;

public enum ArtistSearchOption {
	NAME, ARTIST_GROUP, ARTIST_CATEGORY;

	public boolean isName() {
		return this.equals(NAME);
	}

	public boolean isArtistCategory() {
		return this.equals(ARTIST_CATEGORY);
	}

	public boolean isArtistGroup() {
		return this.equals(ARTIST_GROUP);
	}
}
