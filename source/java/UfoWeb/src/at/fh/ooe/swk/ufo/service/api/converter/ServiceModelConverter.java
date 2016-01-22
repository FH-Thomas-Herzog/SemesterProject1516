package at.fh.ooe.swk.ufo.service.api.converter;

import java.io.Serializable;

/**
 * Specifies the converter beahviour for service to view model conversion
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 22, 2016
 * @param <R>
 *            the service model type
 * @param <V>
 *            the view model type
 */
public interface ServiceModelConverter<R, V> extends Serializable {

	/**
	 * Converts the service model to the view model representation
	 * 
	 * @param model
	 *            the service model instance
	 * @return the converted service model, may return null
	 */
	V convert(R model);
}
