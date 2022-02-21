package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
/**
 * 设置字符集的filter类
 * @author cx998
 *
 */
public class CharSetEncodingFilter implements Filter {
	String code;
	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		request.setCharacterEncoding(code);//设置字符集
		chain.doFilter(request, response);//使代码继续执行
	}

	@Override
	public void init(FilterConfig filter) throws ServletException {
		code=filter.getInitParameter("encoding");
	}

}
