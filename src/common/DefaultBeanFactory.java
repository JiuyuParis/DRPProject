package common;

import java.io.File;
import java.io.InputStream;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 * 系统缺省实现
 * @author Jiuyu
 *
 */
public class DefaultBeanFactory{
	private Document doc=null;
	private Map<String, Object> beansMap=new HashMap<String, Object>();//key-bean的id,value-bean的class
/*	
	@Override
	public Object getBean(String beanId) {
		if(beansMap.containsKey(beanId))
			return beansMap.get(beanId);
		Element beanElement=(Element)doc.selectSingleNode("//bean[@id=\""+beanId+"\"]");
		String className=beanElement.attributeValue("class");//获得class属性
		Object beanObject=null;
		try {
			beanObject=Class.forName(className);//反射创建实例
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	return beanObject;
	}
*/
	private String beanConfigFile="jdbcTools/beans-config.xml";
	
	public DefaultBeanFactory() {
		loadConfigFile();
		System.out.println("构造成功");
	};
	public DefaultBeanFactory(String beanConfigFile) {
		throw new RuntimeException("此构造方法不支持！");
	}
	public DefaultBeanFactory(URL beanConfigFile) {
		throw new RuntimeException("此构造方法不支持！");
	}
	public DefaultBeanFactory(File beanConfigFile) {
		throw new RuntimeException("此构造方法不支持！");
	}
	public DefaultBeanFactory(InputStream beanConfigFile) {
		throw new RuntimeException("此构造方法不支持！");
	}
	
	private void loadConfigFile() {
		try {
			doc=new SAXReader().read(Thread.currentThread().getContextClassLoader().getResourceAsStream(beanConfigFile));
		} catch (DocumentException e) {
			e.printStackTrace();
		}
	}
}
