package at.fh.ooe.swk.ufo.web.application.converter;

import java.util.List;

import javax.faces.model.SelectItem;

import at.fh.ooe.swk.ufo.web.application.message.MessagesBundle;
import at.fh.ooe.swk.ufo.web.application.model.IdHolder;

/**
 * Converter for {@link SelectItem} which hold {@link IdHolder} instance with
 * type {@link Long}.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
public class SelectItemIdHolderLongConverter extends AbstractSelectItemIdHolderConverter<Long> {

	public SelectItemIdHolderLongConverter(List<SelectItem> items, MessagesBundle bundle) {
		super(items, bundle);
	}

	@Override
	protected String getIdAsString(Long id) {
		return (id != null) ? id.toString() : "";
	}

	@Override
	protected Long getIdAsObject(String value) {
		return (value != null) ? Long.valueOf(value) : null;
	}

}
