package basedata.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dataDict.domain.ItemCategory;
import dataDict.domain.ItemUnit;
import dataDict.manager.DataDictManager;
/**
 * 显示物料添加页面
 * @author Jiuyu
 *
 */
public class ShowAddItemServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -9155213898348558939L;
	String basePath=null;
	/**
	 * 注意本方法不能调用父类构造函数
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<ItemCategory> itemCategories=DataDictManager.getInstance().findItemCateGoryList();//拿到物料类别列表
		List<ItemUnit> itemUnits=DataDictManager.getInstance().findItemUnitList();//获得物料计量单位列表
		//将列表信息以map的形式设置到request中
		req.setAttribute("itemCategories", itemCategories);
		req.setAttribute("itemUnits", itemUnits);
		try {
			req.getRequestDispatcher("/basedata/item_add.jsp").forward(req, resp);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
}
