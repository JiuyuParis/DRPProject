package common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import sysMgr.domain.User;

/**
 * 基础Servlet用来传递参数
 * @author Jiuyu
 *
 */
public class BaseServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4845623608673290916L;
	private String command;
	private User user;
	private BeanFactory beanFactory;
	@Override
	protected final void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		command=req.getParameter("command");
		user=(User)req.getSession().getAttribute("userInfo");
		super.service(req, resp);
	}
	
	protected String getCommand() {
		return command;
	}
	
	protected User getCurrentUser() {
		return user;
	}
	
	protected BeanFactory getBeanFactory() {
		beanFactory=(BeanFactory)this.getServletContext().getAttribute("beanFactory");
		return beanFactory;
	}
}
