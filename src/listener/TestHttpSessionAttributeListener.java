package listener;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

/**
 * HttpSessionAttributeListener测试
 * @author Jiuyu
 *
 */
public class TestHttpSessionAttributeListener implements HttpSessionAttributeListener {

	/**
	 * 有session atrribute创建会调用此方法
	 */
	@Override
	public void attributeAdded(HttpSessionBindingEvent se) {
//		System.out.println("-----------------------TestHttpSessionAttributeListener.attributeAdded");
		
		//获得session中的键值对
		System.out.println("name="+se.getName());
		System.out.println("value+"+se.getValue());
		Integer sumInteger=(Integer)se.getSession().getServletContext().getAttribute("sum");//count键的初始状态为null
		if(sumInteger==null) {
			System.out.println("countInteger is null");
			sumInteger=1;
		}else {
			sumInteger++;
		}
		se.getSession().getServletContext().setAttribute("sum", sumInteger);
	}

	/**
	 * 有session arrtibute删除调用此方法
	 */
	@Override
	public void attributeRemoved(HttpSessionBindingEvent se) {
		System.out.println("-----------------------TestHttpSessionAttributeListener.attributeRemoved");
	}

	/**
	 * 有session arrtibute修改调用此方法
	 */
	@Override
	public void attributeReplaced(HttpSessionBindingEvent se) {
		System.out.println("-----------------------TestHttpSessionAttributeListener.attributeReplaced");
	}

}
