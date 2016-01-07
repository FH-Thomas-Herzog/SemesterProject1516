package at.fh.ooe.swk.ufo.web.application.bean;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

import javax.el.ELContext;
import javax.el.ValueExpression;
import javax.faces.application.ResourceHandler;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.primefaces.application.resource.PrimeResourceHandler;
import org.primefaces.model.StreamedContent;

public class DynamicResoruceHandler extends PrimeResourceHandler {

	private final static Logger logger = LogManager.getLogger(DynamicResoruceHandler.class.getName());

	public static final String DYNAMIC_CONTENT_VIEW_ID_KEY = "viewId";
	public static final String DYNAMIC_CONTENT_VALUE_EXPRESSION_KEY = "valueExpression";
	public static final String DYNAMIC_CONTENT_PARAM = "pfdrid";

	public DynamicResoruceHandler(ResourceHandler wrapped) {
		super(wrapped);
	}

	@Override
	public void handleResourceRequest(FacesContext context) throws IOException {
		Map<String, String> params = context.getExternalContext().getRequestParameterMap();
		String library = params.get("ln");
		String dynamicContentId = params.get(DYNAMIC_CONTENT_PARAM);

		if (dynamicContentId != null && library != null && library.equals("primefaces")) {
			Map<String, Object> session = context.getExternalContext().getSessionMap();
			StreamedContent content = null;

			try {
				@SuppressWarnings("unchecked")
				Map<String, String> dynamicContentMap = (Map<String, String>) session.get(dynamicContentId);

				if (dynamicContentMap != null) {
					String viewId = dynamicContentMap.get(DYNAMIC_CONTENT_VIEW_ID_KEY);
					String dynamicContentEL = dynamicContentMap.get(DYNAMIC_CONTENT_VALUE_EXPRESSION_KEY);

					// Workaround for view based scopes
					context.setViewRoot(context.getApplication().getViewHandler().createView(context, viewId));

					ELContext eLContext = context.getELContext();
					ValueExpression ve = context.getApplication().getExpressionFactory()
							.createValueExpression(context.getELContext(), dynamicContentEL, StreamedContent.class);
					content = (StreamedContent) ve.getValue(eLContext);

					ExternalContext externalContext = context.getExternalContext();
					externalContext.setResponseStatus(HttpServletResponse.SC_OK);
					externalContext.setResponseContentType(content.getContentType());

					byte[] buffer = new byte[2048];

					int length;
					InputStream inputStream = content.getStream();

					while ((length = (inputStream.read(buffer))) >= 0) {
						externalContext.getResponseOutputStream().write(buffer, 0, length);
					}

					externalContext.getResponseOutputStream().flush();
					context.responseComplete();
				} else {
					ExternalContext externalContext = context.getExternalContext();
					externalContext.setResponseStatus(HttpServletResponse.SC_NOT_FOUND);
					externalContext.getResponseOutputStream().flush();
					context.responseComplete();
				}
			} catch (Exception e) {
				logger.log(Level.DEBUG, "Error in streaming dynamic resource.", e);
			} finally {
				session.remove(dynamicContentId);

				if (content != null) {
					content.getStream().close();
				}
			}
		} else {
			super.handleResourceRequest(context);
		}
	}
}
