package at.fh.ooe.swk.ufo.service.api.converter;

import java.io.Serializable;

public interface ServiceModelConverter<R, V> extends Serializable {

	V convert(R model);
}
