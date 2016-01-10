package at.fh.ooe.swk.ufo.web.application.model;

public class IdLabelModel<T> {

	public final T id;
	public final String label;

	public IdLabelModel(T id, String label) {
		super();
		this.id = id;
		this.label = label;
	}

	public T getId() {
		return id;
	}

	public String getLabel() {
		return label;
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
		IdLabelModel<T> other = (IdLabelModel<T>) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
}
