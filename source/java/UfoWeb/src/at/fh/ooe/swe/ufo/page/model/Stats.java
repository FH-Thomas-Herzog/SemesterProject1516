package at.fh.ooe.swe.ufo.page.model;

import java.io.Serializable;

public class Stats implements Serializable {

	private String season;

	private int win;

	private int loss;

	public Stats() {
	}

	public Stats(String season, int win, int loss) {
		this.season = season;
		this.win = win;
		this.loss = loss;
	}

	public int getWin() {
		return win;
	}

	public void setWin(int win) {
		this.win = win;
	}

	public int getLoss() {
		return loss;
	}

	public void setLoss(int loss) {
		this.loss = loss;
	}

	public String getSeason() {
		return season;
	}

	public void setSeason(String season) {
		this.season = season;
	}
}