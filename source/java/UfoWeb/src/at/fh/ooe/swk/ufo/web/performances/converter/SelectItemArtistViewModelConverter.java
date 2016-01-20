package at.fh.ooe.swk.ufo.web.performances.converter;

import java.util.List;

import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.ConverterException;
import javax.faces.model.SelectItem;

import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;
import at.fh.ooe.swk.ufo.web.application.model.IdMapperModel;
import at.fh.ooe.swk.ufo.web.performances.model.ArtistViewModel;

/**
 * Converter for {@link SelectItem} which hold {@link ArtistViewModel} as value.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
public class SelectItemArtistViewModelConverter implements Converter {

	private final MessagesBundle bundle;
	private final List<SelectItem> items;

	public SelectItemArtistViewModelConverter(List<SelectItem> items, MessagesBundle bundle) {
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
				final Enum<?> object = (Enum<?>) selectItem.getValue();
				if (object.name().equals(value)) {
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
		return ((Enum<?>) value).name();
	}

}
