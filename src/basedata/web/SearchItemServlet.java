package basedata.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import basedata.domain.Item;
import common.PageModel;
/**
 * 分页显示物料单
 * @author Jiuyu
 *
 */
public class SearchItemServlet extends AbstractItemServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6448953154775057613L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int pageNo=1;
//		int pageSize=Integer.parseInt(this.getServletConfig().getInitParameter("page-size"));//从init-param里取得参数，该方法只适用于该servlet
		int pageSize=Integer.parseInt(this.getServletContext().getInitParameter("pageSize"));//从context-param获取页面大小参数
		String pageNoString=req.getParameter("pageNo");
		if(pageNoString!=null&&pageNoString!="") {
			pageNo=Integer.parseInt(pageNoString);
		}
		String itemNoOrName=req.getParameter("itemNoOrName");//取得条件
		System.out.println(itemNoOrName);
		PageModel<Item> pageModel=itemManager.findItemList(pageNo, pageSize, itemNoOrName);//查询分页物料信息
		req.setAttribute("pageModel", pageModel);//将pageModel设置到键值对
		String info=req.getParameter("info");
		req.getRequestDispatcher("/basedata/item_maint.jsp?info="+info).forward(req, resp);//转发至jsp
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
}
