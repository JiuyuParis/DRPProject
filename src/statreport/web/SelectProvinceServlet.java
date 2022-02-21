package statreport.web;

import java.io.IOException;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import basedata.manager.ClientManager;

/**
 * 生成大区省份xml文件Servlet
 * @author Jiuyu
 *
 */
public class SelectProvinceServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8937387894393933517L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/xml;charset=UTF-8");
		Integer regionId=Integer.parseInt(req.getParameter("regionId"));
		if(regionId!=0) {
			Map<Integer, String> provinceMap=ClientManager.getInstance().getProvince(regionId);//根据区域id取得省份Map
			Document document=DocumentHelper.createDocument();//创建document对象
			Element itemsElement=document.addElement("items");
			//循环给xml添加元素并设置文本
			for(Iterator<Map.Entry<Integer, String>> iterator=provinceMap.entrySet().iterator();iterator.hasNext();) {
				Map.Entry<Integer, String> entry=iterator.next();
				Element itemElement=itemsElement.addElement("item");
				Element idElement=itemElement.addElement("id");
				idElement.setText(String.valueOf(entry.getKey()));
				Element nameElement=itemElement.addElement("name");
				nameElement.setText(entry.getValue());
				
			}
			String xmlString=document.asXML();//将xml转换成字符串
			resp.getWriter().print(xmlString);
		}
	}
	
}
