package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 检查用户登陆状态
 * @author Jiuyu
 *
 */
public class AuthFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req=(HttpServletRequest)request;
		HttpServletResponse resp=(HttpServletResponse)response;
		String reqUrl=req.getRequestURI().substring(req.getRequestURI().indexOf("/", 1));//切片获取请求URL
		
		//排除不检查的页面如果用户未登录则重定向到登录页面
		if(!"/login.jsp".equals(reqUrl)&&!"/servlet/AuthImageServlet".equals(reqUrl)) {
			if(req.getSession(false)==null||req.getSession(false).getAttribute("userInfo")==null) {
				resp.sendRedirect(req.getContextPath()+"/login.jsp");
				return;//return必须加，否则出现错误
			}
		}
		chain.doFilter(req, resp);//程序继续向下执行
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
