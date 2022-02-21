package systemFiles;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbcTools.JDBCTools;

/**
 * id生成器
 * @author cx998
 *
 */
public class IdGenerator {
	/**
	 * 根据表明返回生成的id
	 * @param tableName 表名
	 * @return 生成的id序列
	 */
	public static int generate(String tableName) {
		//使用MySQL悲观锁方法查询数据库（提交事务之前，此行的增删改查都将被阻塞）
		String sql="select value from table_id where table_name=? for update";
		Connection conn=JDBCTools.Connect();
		//开始事务,设置手动提交将添加节点与修改叶子节点两次执行合并成一个提交，保证同时回滚
		JDBCTools.handTransaction(conn);
		PreparedStatement prmt=null;
		ResultSet rs=null;
		int value=0;
		try {
			prmt=conn.prepareStatement(sql);
			prmt.setString(1, tableName);
			rs=prmt.executeQuery();
			if(!rs.next())
				throw new RuntimeException("结果集为空！");
			value=rs.getInt("value");
			value++;
			JDBCTools.commitTransaction(conn);
			IdGenerator.modifyValueField(conn, tableName, value);
			JDBCTools.commitTransaction(conn);
			//提交事务
		} catch (SQLException e) {
			e.printStackTrace();
			//回滚事务
			JDBCTools.rollBackTransaction(conn);
			throw new RuntimeException("生成id方法异常！");
		}finally {
			//重置提交事务的状态
			JDBCTools.autoTransaction(conn);
		}
		return value;
	}
	/**
	 * 修改id的值，使之加1
	 * @param conn
	 * @param tablename
	 * @param value
	 */
	public static void modifyValueField(Connection conn,String tablename,int value) {
		String sql="update table_id set value=? where table_name=?";
		JDBCTools.ZSG(sql, value,tablename);
	}
	public static void main(String[] args) {
		int id=IdGenerator.generate("client");
		System.out.println(id);
	}
}
