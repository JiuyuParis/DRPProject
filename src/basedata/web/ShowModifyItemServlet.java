package basedata.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import basedata.domain.Item;
import dataDict.domain.ItemCategory;
import dataDict.domain.ItemUnit;
import dataDict.manager.DataDictManager;
/**
 * 展示待修改的物料信息
 * @author Jiuyu
 *
 */
public class ShowModifyItemServlet extends AbstractItemServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1027102001913141247L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//根据取得itemNo进行查询
		String itemNo=req.getParameter("itemNo");
		Item item=itemManager.findItemById(itemNo);
		
		//将相关列表查询出来
		List<ItemCategory> itemCategories=DataDictManager.getInstance().findItemCateGoryList();
		List<ItemUnit> itemUnits=DataDictManager.getInstance().findItemUnitList();
		
		//设置需要的对象request中
		req.setAttribute("item", item);
		req.setAttribute("itemCategories", itemCategories);
		req.setAttribute("itemUnits", itemUnits);
		
		req.getRequestDispatcher("/basedata/item_modify.jsp").forward(req, resp);//转发
	}
	
}
