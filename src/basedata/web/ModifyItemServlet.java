package basedata.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import basedata.domain.Item;
import dataDict.domain.ItemCategory;
import dataDict.domain.ItemUnit;
import systemFiles.Constants;
/**
 * 修改物料信息
 * @author Jiuyu
 *
 */
public class ModifyItemServlet extends AbstractItemServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//取得表单数据
		String itemNo=request.getParameter("itemNo");
		String itemName=request.getParameter("itemName");
		String spec=request.getParameter("spec");
		String pattern=request.getParameter("pattern");
		String category=request.getParameter("category");
		String unit=request.getParameter("unit");
		
		//构造Item对象
		Item item=new Item();
		item.setNo(itemNo);
		item.setName(itemName);
		item.setSpec(spec);
		item.setPattern(pattern);
		
		//构造itemCategory物料类别
		ItemCategory itemCategory=new ItemCategory();
		itemCategory.setDICT_ID(category);
		item.setItemCategory(itemCategory);
		
		//构造ItemUnit物料计量单位
		ItemUnit itemUnit=new ItemUnit();
		itemUnit.setDICT_ID(unit);
		item.setItemUnit(itemUnit);
		
		itemManager.modifyItem(item);
		response.sendRedirect(request.getContextPath()+"/servlet/item/SearchItemServlet?info="+Constants.MODIFY);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
