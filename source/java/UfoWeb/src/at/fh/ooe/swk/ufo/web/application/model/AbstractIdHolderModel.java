package at.fh.ooe.swk.ufo.web.application.model;

/**
 * The abstract implementation of the {@link IdHolder} interface and provides
 * proper implementation of hash and equals.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 22, 2016
 * @param <T>
 *            the id holder type
 */
public abstract class AbstractIdHolderModel<T> implements IdHolder<T> {

	private static final long serialVersionUID = -5802365979985934316L;

	protected T id;

	public AbstractIdHolderModel() {
		super();
	}

	public AbstractIdHolderModel(T id) {
		super();
		this.id = id;
	}

	public T getId() {
		return id;
	}

	public void setId(T id) {
		this.id = id;
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
		AbstractIdHolderModel<T> other = (AbstractIdHolderModel<T>) obj;
		if (id == null) {
			if (other.id != null) {
				return false;
			}
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

}
