package at.fh.ooe.swk.ufo.web.application.model;

import java.io.Serializable;

public interface IdHolder<T> extends Serializable {

	T getId();
}
