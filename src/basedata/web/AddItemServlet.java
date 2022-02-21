package basedata.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import basedata.domain.Item;
import dataDict.domain.ItemCategory;
import dataDict.domain.ItemUnit;
import systemFiles.Constants;

public class AddItemServlet extends AbstractItemServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1101975341345329068L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//取得参数
		String itemNo=req.getParameter("itemNo");
		String itemName=req.getParameter("itemName");
		String spec=req.getParameter("spec");
		String pattern=req.getParameter("pattern");
		String category=req.getParameter("category");
		String unit=req.getParameter("unit");
		
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
		
//		String errorMessageString=null;
//		try {
//			impl.addItem(item);
//		} catch (ApplicationException e) {
//			errorMessageString=e.getMessage();
//		}
//		resp.sendRedirect(req.getContextPath()+"/basedata/item_maint.jsp?errorMessage="+URLEncoder.encode(errorMessageString,"GB18030"));
		itemManager.addItem(item);//采用声明式异常
		resp.sendRedirect(req.getContextPath()+"/servlet/item/SearchItemServlet?info="+Constants.ADD);
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
}
