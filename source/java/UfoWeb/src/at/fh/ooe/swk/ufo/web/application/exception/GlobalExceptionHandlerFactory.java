package at.fh.ooe.swk.ufo.web.application.exception;

import javax.faces.context.ExceptionHandlerFactory;

/**
 * Factory which provides our custom exception handler.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 */
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
