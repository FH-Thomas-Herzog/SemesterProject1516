package at.fh.ooe.swk.ufo.service.api.model;

/**
 * The result model for the service results.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 19, 2016
 * @param <T>
 */
public class ResultModel<T> {

	public String error;
	public String internalError;
	public Exception exception;

	public T result;

	public ResultModel() {
		super();
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public String getInternalError() {
		return internalError;
	}

	public void setInternalError(String internalError) {
		this.internalError = internalError;
	}

	public T getResult() {
		return result;
	}

	public void setResult(T result) {
		this.result = result;
	}

	public Exception getException() {
		return exception;
	}

	public void setException(Exception exception) {
		this.exception = exception;
	}

}
