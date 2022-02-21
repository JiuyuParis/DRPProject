package listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * HttpSessionListener测试类
 * @author Jiuyu
 *
 */
public class TestHttpSessionListener implements HttpSessionListener {

	/**
	 * 有session创建会调用此方法
	 */
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		System.out.println("-------------------------TestHttpSessionListener.sessionCreated");
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
	}

}
