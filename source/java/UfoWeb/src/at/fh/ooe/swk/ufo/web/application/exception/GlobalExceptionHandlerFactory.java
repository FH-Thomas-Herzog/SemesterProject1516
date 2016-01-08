package at.fh.ooe.swk.ufo.web.application.exception;

import javax.faces.context.ExceptionHandlerFactory;

public class GlobalExceptionHandlerFactory extends ExceptionHandlerFactory {

	private final ExceptionHandlerFactory parent;

	public GlobalExceptionHandlerFactory(ExceptionHandlerFactory parent) {
		this.parent = parent;
	}

	@Override
	public javax.faces.context.ExceptionHandler getExceptionHandler() {
		return new GlobalExceptionHandler(parent.getExceptionHandler());
	}

}
