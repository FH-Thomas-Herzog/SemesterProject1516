package at.fh.ooe.swk.ufo.web.application.converter;

import java.util.List;

import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.ConverterException;
import javax.faces.model.SelectItem;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;
import at.fh.ooe.swk.ufo.web.application.model.IdHolder;

/**
 * Base implementation for {@link IdHolder} types.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
public abstract class AbstractSelectItemIdHolderConverter<T> implements Converter {

	private final MessagesBundle bundle;
	private final List<SelectItem> items;

	private static final Logger log = LogManager.getLogger(SelectItemEnumConverter.class);

	public AbstractSelectItemIdHolderConverter(List<SelectItem> items, MessagesBundle bundle) {
		super();
		this.items = items;
		this.bundle = bundle;
	}

	@Override
	public Object getAsObject(FacesContext context, UIComponent component, String value) throws ConverterException {
		if ((value == null) || (value.isEmpty())) {
			return null;
		}
		try {
			for (SelectItem selectItem : items) {
				final IdHolder<T> object = (IdHolder<T>) selectItem.getValue();
				if ((object != null) && (object.getId().equals(getIdAsObject(value)))) {
					return object;
				}
			}
		} catch (Exception e) {
			log.error("Conversionof id holder value failed with an exception", e);
			throw new ConverterException(
					new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getErrorUnexpected(), ""));
		}

		throw new ConverterException(
				new FacesMessage(FacesMessage.SEVERITY_ERROR, bundle.getErrorConvertNotFound(), ""));
	}

	@Override
	public String getAsString(FacesContext context, UIComponent component, Object value) throws ConverterException {
		if (value == null) {
			return "";
		}
		return getIdAsString(((IdHolder<T>) value).getId());
	}

	/**
	 * Gets the id as a string representation.
	 * 
	 * @param id
	 *            the id to get string representation for.
	 * @return the string representation of the id
	 */
	protected abstract String getIdAsString(T id);

	/**
	 * Gets the id from the string representation.
	 * 
	 * @param value
	 *            the string value to convert to id instance
	 * @return the created id instance
	 */
	protected abstract T getIdAsObject(String value);
}
