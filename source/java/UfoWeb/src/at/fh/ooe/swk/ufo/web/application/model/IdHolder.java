package at.fh.ooe.swk.ufo.web.application.model;

import java.io.Serializable;

/**
 * This interfaces specifies an id holder. This means a implemented class is
 * Identifiable by the hold id.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 22, 2016
 * @param <T>
 */
public interface IdHolder<T> extends Serializable {

	/**
	 * The hold id.
	 * 
	 * @return the hold id
	 */
	T getId();
}
