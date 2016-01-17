package at.fh.ooe.swk.ufo.service.proxy.model;

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
