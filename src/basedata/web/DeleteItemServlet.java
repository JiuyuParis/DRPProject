package basedata.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import systemFiles.Constants;
/**
 * 删除物料
 * @author Jiuyu
 *
 */
public class DeleteItemServlet extends AbstractItemServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6592918707299764429L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String[] itemNos=req.getParameterValues("selectFlag");
		itemManager.delItem(itemNos);
		resp.sendRedirect(req.getContextPath()+"/servlet/item/SearchItemServlet?info="+Constants.DEL);
	}

}
