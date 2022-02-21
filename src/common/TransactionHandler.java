package common;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.sql.Connection;

import jdbcTools.JDBCToolsThreadLocal;

/**
 * 采用动态代理封装事务
 * @author Jiuyu
 *
 */
public class TransactionHandler implements InvocationHandler {
	
	private Object targetObject;
	/**
	 * 实例化代理对象
	 * @param targetObject
	 * @return
	 */
	public Object newProxyInstance(Object targetObject) {
		this.targetObject=targetObject;
		return Proxy.newProxyInstance(targetObject.getClass().getClassLoader(), targetObject.getClass().getInterfaces(), this);//返回使用代理封装好的实例化对象
	}
	@Override
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
		Connection conn=null;
		Object retObject=null;
		try {
			conn = JDBCToolsThreadLocal.Connect();
			if (method.getName().startsWith("add")||method.getName().startsWith("del")||method.getName().startsWith("modify")) {
				JDBCToolsThreadLocal.handTransaction(conn);//设置手动提交事务
			}
			retObject=method.invoke(targetObject, args);//调用事务方法
			if(!conn.getAutoCommit()) {
				JDBCToolsThreadLocal.commitTransaction(conn);
			}
			
		}catch (ApplicationException e) {
			JDBCToolsThreadLocal.rollBackTransaction(conn);//回滚事务
			throw e;
		} catch (Exception e) {
			
			//如果发生异常事务会被封装成InvocationTargetException，以下将原异常从封装的异常InvocationTargetException中的属性中取出
			if(e instanceof InvocationTargetException) {
				InvocationTargetException eNew=(InvocationTargetException)e;
				throw eNew.getTargetException();
			}
			e.printStackTrace();
			JDBCToolsThreadLocal.rollBackTransaction(conn);
		}finally {
			JDBCToolsThreadLocal.autoTransaction(conn);//重置事务提交状态
			JDBCToolsThreadLocal.closeSCR(null, conn, null);
		}
		return retObject;
	}

}
