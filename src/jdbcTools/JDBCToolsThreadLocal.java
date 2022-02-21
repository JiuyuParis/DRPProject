package jdbcTools;

import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 数据库链接工具包，提供增删改查功能（使用ThreadLocal保证线程安全）
 * @author Jiuyu
 *
 */
public class JDBCToolsThreadLocal {
	private static ThreadLocal<Connection> connectionHolder=new ThreadLocal<Connection>();
	/**
	 * 数据库连接方法
	 * @return 返回链接Connection对象
	 */
	public static Connection Connect()
	{
		Connection connection=connectionHolder.get();
		if(connection==null) {
			
			JDBCconfig jdbcconfig=SysconfigXpathReader.getInstance().getJDBCconfig();
			try {
				Class.forName(jdbcconfig.getDriverName());//加载Driver驱动
				connection=DriverManager.getConnection(jdbcconfig.getUrl(), jdbcconfig.getUser(), jdbcconfig.getPassword());//调用getConnection方法连接驱动
				connectionHolder.set(connection);//将connection设置到connectionHolder中
			} catch (ClassNotFoundException e) {
				System.out.println(e.getMessage());
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
//			try {
//				Context context= new InitialContext();//获得Context对象
//				DataSource ds=(DataSource)context.lookup("java:comp/env/DRPMySQL");//在JNDI服务中查找DataSource
//				connection=ds.getConnection();//从数据库连接池中获取Connection
//				connectionHolder.set(connection);//将connection设置到connectionHolder中
//			} catch (NamingException | SQLException e) {
//				e.printStackTrace();
//			}
//		}
		return connection;
	}
	/**
	 * 更新方法1(输入SQL语句)
	 * @param init_sql
	 */
	public static void ZSG(String init_sql)
	{
		//获得数据库连接
		Connection connection=Connect();
		//准备sql语句
		String sql=init_sql;
		//声明对象
		Statement statement=null;
		//执行插入
		try {
			//获取执行SQL语句的操作对象statement
			statement=connection.createStatement();
			//调用
			statement.execute(sql);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			closeSCR(statement, connection,null);
		}
	}
	/**
	 * 更新方法2（占位符）[通用方法]
	 * @param sql
	 * @param objects
	 */
	public static void ZSG(String sql,Object...objects)

	{
		//连接MySQL数据库
		Connection connection=Connect();
		//创建PreparedStatement对象
		PreparedStatement ps=null;
		try {
			ps=connection.prepareStatement(sql);
			for(int i=0;i<objects.length;i++)
			{
				//填补占位符
				ps.setObject(i+1, objects[i]);
			}
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeSCR(ps,connection,null);
		}
	}
	/**
	 * 更新方法3（占位符）[通用方法]
	 * @param sql
	 * @param 
	 */
	public static void ZSG2(String sql,Object[] index)

	{
		//连接MySQL数据库
		Connection connection=Connect();
		//创建PreparedStatement对象
		PreparedStatement ps=null;
		try {
			ps=connection.prepareStatement(sql);
			for(int i=0;i<index.length;i++)
			{
				//填补占位符
				ps.setObject(i+1, index[i]);
			}
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeSCR(ps,connection,null);
		}
	}
	/**
	 * 查询方法1（传入SQL语句直接查询，直接输出结果）
	 * @param sql
	 */
	public static void Query(String sql)
	{
		//连接数据库
		Connection connection=Connect();
		//创建PreparedStatement对象
		Statement statement=null;
		try {
			statement=connection.createStatement();
			ResultSet rs=statement.executeQuery(sql);
			//处理结果集
			if(rs.next()==false)
				System.out.println("无数据");
			else
			{
				//创建ResultSetMetaData获取元数据
				ResultSetMetaData rsmd=rs.getMetaData();
				for(int i=0;i<rsmd.getColumnCount();i++)
					System.out.print(rsmd.getColumnLabel(i+1)+"\t\t");
				System.out.print("\n");
				do
				{
					for(int i=0;i<rsmd.getColumnCount();i++)
						System.out.print(rs.getObject(i+1)+"\t\t");
					System.out.print("\n");
				}while(rs.next());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeSCR(statement,connection,null);
		}
	}
	/**
	 * 查询方法2(占位符，直接输出结果)
	 * @param sql
	 * @param objects
	 */
	public static void Query(String sql,Object...objects)
	{
		//连接数据库
		Connection connection=Connect();
		//创建PreparedStatement对象
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {
			ps=connection.prepareStatement(sql);
			for(int i=0;i<objects.length;i++)
			{
				//填补占位符
				ps.setObject(i+1, objects[i]);
			}
			rs=ps.executeQuery();
			//处理结果集
			if(rs.next()==false)
				System.out.println("无数据");
			else
			{
				//创建ResultSetMetaData获取元数据
				ResultSetMetaData rsmd=rs.getMetaData();
				for(int i=0;i<rsmd.getColumnCount();i++)
					System.out.print(rsmd.getColumnLabel(i+1)+"\t\t");
				System.out.print("\n");
				do
				{
					for(int i=0;i<rsmd.getColumnCount();i++)
						System.out.print(rs.getObject(i+1)+"\t\t");
					System.out.print("\n");
				}while(rs.next());
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			closeSCR(ps,connection,rs);
		}
	}
	/**
	 * 查询方法3[通用]
	 * @param <T>
	 * @param table
	 * @param sql
	 * @param objects
	 * @return
	 */
	public static <T> List<T> Query(Class<T> table,String sql,Object...objects)
	{
		//连接数据库
		Connection connection=Connect();
		//构建结果集
		ResultSet rs=null;
		//创建PreparedStatedment对象
		PreparedStatement ps=null;
		//构造返回列表
		List<T> resultList=new ArrayList<T>();
		try {
			//创建PreparedStatedment对象
			ps=connection.prepareStatement(sql);
			//填补占位符
			for(int i=0;i<objects.length;i++)
			{
				ps.setObject(i+1, objects[i]);
			}
			//执行查询
			rs=ps.executeQuery();
			if(rs.next()==false)
			{
				System.out.println("无数据");
				return null;
			}
			else
			{
				//利用ResultSetMetaData获取元数据
				ResultSetMetaData rsmd=rs.getMetaData();
				//创建需要使用的HashMap
				Map<String,Object> map=new HashMap<String,Object>();
				//向map里添加键值对
				do {
				for(int i=0;i<rsmd.getColumnCount();i++)
				{
					map.put(rsmd.getColumnLabel(i+1), rs.getObject(i+1));
				}
				//利用反射创建对象
				T index=table.getDeclaredConstructor().newInstance();
				//利用反射工具类给index对象属性赋值
				for(Map.Entry<String, Object> point:map.entrySet())
					ReflectionUtils.setFieldValue(index, point.getKey(), point.getValue());
				resultList.add(index);
				}while(rs.next());
				return resultList;
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}finally {
			closeSCR(ps,connection,rs);
		}
		return null;
	}
	/**
	 * 返回该表的元组数量
	 * @param sql
	 * @return 元组数量
	 */
	public static int getTupleNum(String sql)
	{
		//连接数据库
		Connection conn=Connect();
		//创建prepareStatement对象
		PreparedStatement ps=null;
		ResultSet rs=null;
		int count=0;
		try {
				ps=conn.prepareStatement(sql);
				rs=ps.executeQuery();
				rs.next();
				count=rs.getInt("count(*)");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		closeSCR(ps,conn,rs);
		return count;
	}
	/**
	 * 设置手动提交事务（手动或自动）
	 * @param conn
	 */
	public static void handTransaction(Connection conn) {
		if(conn!=null)
		{
			try {
				if(conn.getAutoCommit())
					conn.setAutoCommit(false);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 * 设置自动提交事务（手动或自动）
	 * @param conn
	 */
	public static void autoTransaction(Connection conn) {
		if(conn!=null)
		{
			try {
				if(!conn.getAutoCommit())
					conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 * 手动提交事务
	 * @param conn
	 */
	public static void commitTransaction(Connection conn) {
		if(conn!=null)
		{
			try {
				if(!conn.getAutoCommit())
					conn.commit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 * 回滚事务
	 * @param conn
	 */
	public static void rollBackTransaction(Connection conn) {
		if(conn!=null)
		{
			try {
				if(!conn.getAutoCommit())
					conn.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 * 关闭资源Statement,Connection,ResultSet方法
	 * @param statement
	 * @param connection
	 * @param resultset
	 */
	public static void closeSCR(Statement statement,Connection connection,ResultSet resultset)
	{
		if(resultset!=null)
		{
			try
			{
				resultset.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}finally {
				//关闭statement对象
				try {
					if(statement!=null)
						statement.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				}finally {
					//关闭connection对象
					try {
						if(connection!=null) {
							connection.close();
							connectionHolder.remove();//从connectionHolder中删除已关闭的connection
						}
					} catch (SQLException e) {
						System.out.println(e.getMessage());
					}
				}
			}
		}
	}
}
