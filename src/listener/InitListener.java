package listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import common.BeanFactory;
import systemFiles.Constants;

/**
 * 采用ServletContextListener完成初始化
 * @author Jiuyu
 *
 */
public class InitListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		BeanFactory beanFactory=BeanFactory.getInstance();//创建工厂
		sce.getServletContext().setAttribute("beanFactory", beanFactory);//将工厂设置到ServletContext中
		sce.getServletContext().setAttribute("NO", Constants.NO);
		sce.getServletContext().setAttribute("YES", Constants.YES);
		sce.getServletContext().setAttribute("MODIFY", Constants.MODIFY);
		sce.getServletContext().setAttribute("ADD", Constants.ADD);
		sce.getServletContext().setAttribute("DEL", Constants.DEL);
		sce.getServletContext().setAttribute("UPLOAD", Constants.UPLOAD);
		sce.getServletContext().setAttribute("SHOW_ADD", Constants.SHOW_ADD);
		sce.getServletContext().setAttribute("QUERY", Constants.QUERY);
		sce.getServletContext().setAttribute("AUDIT", Constants.AUDIT);
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		
	}
	
}
