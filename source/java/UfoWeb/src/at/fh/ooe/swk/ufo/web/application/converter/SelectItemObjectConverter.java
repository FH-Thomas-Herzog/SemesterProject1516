package at.fh.ooe.swk.ufo.web.application.converter;

import java.util.List;
import java.util.Objects;

import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.ConverterException;
import javax.faces.model.SelectItem;

import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;

/**
 * Converter for {@link SelectItem} which hold object values
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
public class SelectItemObjectConverter implements Converter {

	private final MessagesBundle bundle;
	private final List<SelectItem> items;

	public SelectItemObjectConverter(List<SelectItem> items, MessagesBundle bundle) {
		super();
		Objects.requireNonNull(items);
		Objects.requireNonNull(bundle);
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
				final Object object = selectItem.getValue();
				if ((object != null) && (object.toString().equals(value))) {
					return object;
				}
			}
		} catch (Exception e) {
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
		return value.toString();
	}

}
