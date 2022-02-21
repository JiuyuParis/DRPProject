package common;

import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 * 抽象工厂，主要创建两个系列的产品
 * 1.Manager系列产品
 * 2.Dao系列产品
 * @author Jiuyu
 *
 */
public class BeanFactory {
	private static BeanFactory beanFactory=null;
	private String beanConfigFile="./common/beans-config.xml";
	/**
	 * 单例模式（懒汉式加载）
	 * @return
	 */
	public static BeanFactory getInstance() {
		if(beanFactory==null)
			beanFactory=new BeanFactory();
		return beanFactory;
	}
	
	private Map<String, Object> serviceMap=new HashMap<String, Object>();
	private Map<String, Object> daoMap=new HashMap<String, Object>();
	
	private Document doc=null;
	
	private BeanFactory() {
		try {
			doc=new SAXReader().read(Thread.currentThread().getContextClassLoader().getResourceAsStream(beanConfigFile));
		} catch (DocumentException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 根据产品编号生产Service(ItemManager)系列产品
	 * @param beanId
	 * @return
	 */
	public Object getServiceBean(Class<?> c) {
		if(serviceMap.containsKey(c.getName()))
			return serviceMap.get(c.getName());
		Element beanElement=(Element)doc.selectSingleNode("//service[@id=\""+c.getName()+"\"]");
		String className=beanElement.attributeValue("class");//获得class属性
		Object service=null;
		try {
			try {
				service=Class.forName(className).getDeclaredConstructor().newInstance();//利用反射构造service实例
				
				//采用动态代理包装事务实体
				TransactionHandler transactionHandler=new TransactionHandler();
				service=transactionHandler.newProxyInstance(service);
				serviceMap.put(c.getName(), service);//将创建的service放入map中
			} catch (InstantiationException | IllegalAccessException | IllegalArgumentException
					| InvocationTargetException | NoSuchMethodException | SecurityException e) {
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	return service;
	};
	
	/**
	 * 根据产品编号生产Dao(ItemDao)系列产品
	 * @param beanId
	 * @return
	 */
	public Object getDaoBean(Class<?> c) {
		if(daoMap.containsKey(c.getName()))
			return daoMap.get(c.getName());
		Element beanElement=(Element)doc.selectSingleNode("//dao[@id=\""+c.getName()+"\"]");
		String className=beanElement.attributeValue("class");//获得class属性
		Object dao=null;
		try {
			try {
				dao=Class.forName(className).getDeclaredConstructor().newInstance();//利用反射构造service实例
				daoMap.put(c.getName(), dao);//将创建的service放入map中
			} catch (InstantiationException | IllegalAccessException | IllegalArgumentException
					| InvocationTargetException | NoSuchMethodException | SecurityException e) {
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	return dao;
	};
}
