package basedata.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import basedata.domain.Item;

/**
 * 物料图片上传页面信息显示
 * @author Jiuyu
 *
 */

public class ShowItemUploadServlet extends AbstractItemServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 169779873079485393L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String itemNo=req.getParameter("itemNo");
		Item item=itemManager.findItemById(itemNo);
		req.setAttribute("item", item);
		req.getRequestDispatcher("/basedata/item_upload.jsp").forward(req, resp);
	}
	

}
