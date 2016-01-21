package at.fh.ooe.swk.ufo.web.application.model;

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
