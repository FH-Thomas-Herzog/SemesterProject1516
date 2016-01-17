package at.fh.ooe.swk.ufo.service.proxy.api;

import java.io.Serializable;

import at.fh.ooe.swk.ufo.service.proxy.model.ResultModel;

public interface SecurityServiceProxy extends Serializable {

	ResultModel<Boolean> login(String username, String password);
}
