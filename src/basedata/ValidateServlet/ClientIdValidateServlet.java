package basedata.ValidateServlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import basedata.manager.ClientManager;
/**
 * 验证分销商代码是否已存在的servlet
 * @author cx998
 *
 */
public class ClientIdValidateServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		super.doGet(req, resp);
		resp.setContentType("text/html;charset=GB18030");
		String clientId=req.getParameter("clientId");
		boolean flag=ClientManager.getInstance().findClientOrRegion(clientId);
		if(flag) {
			resp.getWriter().print("该分销商已存在！");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		super.doPost(req, resp);
		resp.setContentType("text/html;charset=GB18030");
		String clientId=req.getParameter("clientId");
		boolean flag=ClientManager.getInstance().findClientOrRegion(clientId);
		if(flag) {
			resp.getWriter().print("该分销商已存在！");
		}
	}
	
}
