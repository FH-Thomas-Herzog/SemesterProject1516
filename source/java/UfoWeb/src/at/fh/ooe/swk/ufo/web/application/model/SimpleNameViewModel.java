package at.fh.ooe.swk.ufo.web.application.model;

/**
 * A simple model which holds an id and a name.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 22, 2016
 * @param <T>
 */
public class SimpleNameViewModel<T> extends AbstractIdHolderModel<T> {

	private static final long serialVersionUID = -480885086603066192L;

	private final String name;

	public SimpleNameViewModel(T id, String name) {
		super(id);
		this.name = name;
	}

	public String getName() {
		return name;
	}

}
