package at.fh.ooe.swe.ufo.page.view;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;

import at.fh.ooe.swe.ufo.page.model.Stats;
import at.fh.ooe.swe.ufo.page.model.Team;

@SessionScoped
@ManagedBean(name = "dtSubTableView")
public class SubTableView {

	private List<Team> teams;

	@PostConstruct
	public void init() {
		teams = new ArrayList<Team>();
		Team lakers = new Team("Los Angeles Lakers");
		lakers.getStats().add(new Stats("2005-2006", 50, 32));
		lakers.getStats().add(new Stats("2006-2007", 44, 38));
		lakers.getStats().add(new Stats("2007-2008", 40, 42));
		lakers.getStats().add(new Stats("2008-2009", 45, 37));
		lakers.getStats().add(new Stats("2009-2010", 48, 34));
		lakers.getStats().add(new Stats("2010-2011", 42, 42));
		teams.add(lakers);

		Team celtics = new Team("Boston Celtics");
		celtics.getStats().add(new Stats("2005-2006", 46, 36));
		celtics.getStats().add(new Stats("2006-2007", 50, 32));
		celtics.getStats().add(new Stats("2007-2008", 41, 41));
		celtics.getStats().add(new Stats("2008-2009", 45, 37));
		celtics.getStats().add(new Stats("2009-2010", 38, 44));
		celtics.getStats().add(new Stats("2010-2011", 35, 47));
		teams.add(celtics);
	}

	public List<Team> getTeams() {
		return teams;
	}
}
