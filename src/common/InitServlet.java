package common;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import systemFiles.Constants;

/**
 * 负责工厂系统在服务器启动时初始化
 * @author Jiuyu
 *
 */
public class InitServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4471907091915799648L;
	@Override
	public void init() throws ServletException {
		BeanFactory beanFactory=BeanFactory.getInstance();//创建工厂
		this.getServletContext().setAttribute("beanFactory", beanFactory);//将工厂设置到ServletContext中
		this.getServletContext().setAttribute("NO", Constants.NO);
		this.getServletContext().setAttribute("YES", Constants.YES);
		this.getServletContext().setAttribute("MODIFY", Constants.MODIFY);
		this.getServletContext().setAttribute("ADD", Constants.ADD);
		this.getServletContext().setAttribute("DEL", Constants.DEL);
		this.getServletContext().setAttribute("UPLOAD", Constants.UPLOAD);
		this.getServletContext().setAttribute("SHOW_ADD", Constants.SHOW_ADD);
		this.getServletContext().setAttribute("QUERY", Constants.QUERY);
		this.getServletContext().setAttribute("AUDIT", Constants.AUDIT);
	}
	
}
