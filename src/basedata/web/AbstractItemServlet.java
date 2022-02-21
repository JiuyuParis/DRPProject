package basedata.web;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import basedata.manager.ItemManager;
import common.BeanFactory;
/**
 * 物料抽象Servlet
 * @author Jiuyu
 *
 */
public class AbstractItemServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6344304845665466305L;
	protected ItemManager itemManager;
	@Override
	public void init() throws ServletException {
		BeanFactory beanFactory=(BeanFactory)this.getServletContext().getAttribute("beanFactory");//将工厂取出
		itemManager=(ItemManager) beanFactory.getServiceBean(ItemManager.class);//创建ItemManager实例
	}
	
}
