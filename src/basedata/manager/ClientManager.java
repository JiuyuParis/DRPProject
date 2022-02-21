package basedata.manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import basedata.domain.AimClient;
import basedata.domain.Client;
import common.PageModel;
import dataDict.domain.ClientLevel;
import jdbcTools.JDBCTools;
import systemFiles.Constants;
import systemFiles.IdGenerator;

/**
 * 分销商管理类（单例模式实现）
 * @author cx998
 *
 */
public class ClientManager {
	private static ClientManager instance=null;
	/**
	 * 返回分销商HTML字符串
	 * @return
	 */
	public String getClientTreeHTMLString()
	{
		return new ClientTreeReader().getClientTreeHTMLString();
	}
	public static synchronized ClientManager getInstance()
	{
		if(instance==null)
		{
			instance=new ClientManager();
		}
		return instance;
	}
	/**
	 * 查找分销商或区域
	 * @param id
	 * @return
	 */
	public Client findClientOrAreaById(int id)
	{
		String sql="select * from client c left join data_dict d on c.CLIENT_LEVEL=d.DICT_ID where c.id=?";
		Connection conn=JDBCTools.Connect();
		PreparedStatement psmt=null;
		ResultSet rs=null;
		Client c=null;
		ClientLevel cl=null;
		try {
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, id);
			rs=psmt.executeQuery();
			while(rs.next())
			{
				c=new Client();
				c.setId(rs.getInt("id"));
				c.setPid(rs.getInt("pid"));
				c.setName(rs.getString("name"));
				c.setClientId(rs.getString("client_id"));
				c.setBankNo(rs.getString("bank_no"));
				c.setAddress(rs.getString("address"));
				c.setTel(rs.getString("tel"));
				c.setEms(rs.getString("ems"));
				c.setIsLeaf(rs.getString("is_leaf"));
				c.setIsClient(rs.getString("is_client"));
				//建立分销商等级对象
				cl=new ClientLevel();
				cl.setDICT_ID(rs.getString("dict_id"));
				cl.setNAME("name");
				c.setClientLevel(cl);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTools.closeSCR(psmt, conn, rs);
		}
		return c;
	}
	/**
	 * 修改区域或分销商信息
	 * @param clientOrRegion
	 */
	public void modifyClientOrRegion(Client clientOrRegion)
	{
		String sql="update client set client_level=?,name=?,tel=?,address=?,ems=? where id=?";
		JDBCTools.ZSG(sql, clientOrRegion.getClientLevel().getDICT_ID(),clientOrRegion.getName(),clientOrRegion.getTel(),clientOrRegion.getAddress(),clientOrRegion.getEms(),clientOrRegion.getId());
	}
	/**
	 * 添加分销商或区域
	 * @param clientOrRegion
	 */
	public void addClientOrRegion(Client clientOrRegion) {
		String sql="insert into client values(?,?,?,?,?,?,?,?,?,?,?)";
		Connection conn=null;
		PreparedStatement prmt=null;
		conn=JDBCTools.Connect();
		try {
			JDBCTools.handTransaction(conn);//设置手动提交事务，将添加节点与修改叶子节点两次执行合并成一个提交，保证同时回滚
			prmt=conn.prepareStatement(sql);
			//赋值
			prmt.setInt(1, IdGenerator.generate("client"));
			prmt.setInt(2, clientOrRegion.getPid());
			prmt.setString(3, clientOrRegion.getClientLevel().getDICT_ID());
			prmt.setString(4, clientOrRegion.getName());
			prmt.setString(5, clientOrRegion.getClientId());
			prmt.setString(6, clientOrRegion.getBankNo());
			prmt.setString(7, clientOrRegion.getTel());
			prmt.setString(8, clientOrRegion.getAddress());
			prmt.setString(9, clientOrRegion.getEms());
			prmt.setString(10, clientOrRegion.getIsLeaf());
			prmt.setString(11, clientOrRegion.getIsClient());
			prmt.executeUpdate();
			//如果是叶子节点则修改为非叶子节点
			Client parentClient=findClientOrAreaById(clientOrRegion.getPid());//将父节点信息查出来
			if(Constants.YES.equals(parentClient.getIsLeaf()))
			{
				modifyIsLeafField(conn, parentClient.getId(), Constants.NO);
			}
			JDBCTools.commitTransaction(conn);//提交事务
		} catch (SQLException e) {
			e.printStackTrace();
			JDBCTools.rollBackTransaction(conn);//回滚事务
		}finally {
			JDBCTools.autoTransaction(conn);//重置事务为自动提交
			JDBCTools.closeSCR(prmt, conn, null);
		}
		
	}
	/**
	 * 修改is_leaf字段
	 * @param conn
	 * @param id
	 * @param leaf Y/N
	 * @throws SQLException 此处需将异常抛出不能捕捉，
	 * 因为如果捕捉了添加分销商或区addClientOrRegion中的两个事务就不能同步回滚
	 *
	 */
	private void modifyIsLeafField(Connection conn,int id,String leaf) throws SQLException{
		String sql="update client set is_leaf=? where id=?";
		PreparedStatement psmt=null;
		try {
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, leaf);
			psmt.setInt(2, id);
			psmt.executeUpdate();
		} finally {
			JDBCTools.closeSCR(psmt, null, null);
		}
	}
	/**
	 * 验证分销商代码是否已存在
	 * @param ClientId
	 * @return
	 */
	public boolean findClientOrRegion(String clientId) {
		String sql="select count(*) from client where client_id=?";
		Connection conn=JDBCTools.Connect();
		PreparedStatement psmt=null;
		ResultSet rs=null;
		boolean flag=false;
		try {
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, clientId);
			rs=psmt.executeQuery();
			rs.next();
			return rs.getInt(1)>0?true:false;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}
	/**
	 * 删除分销商或区域
	 * @param id
	 */
	public void delClientOrRegion(int id) {
		Connection conn=null;
		try {
			conn=JDBCTools.Connect();
			JDBCTools.handTransaction(conn);//设置手动提交事务
			Client currentClient=findClientOrAreaById(id);//保存当前节点
			recursionDelNode(conn, id);//递归删除
			//如果子节点个数为零，修改叶子节点状态为Y
			if(getChildren(conn, currentClient.getPid())==0) {
				modifyIsLeafField(conn, currentClient.getPid(), Constants.YES);
			}
			JDBCTools.commitTransaction(conn);//提交事务
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTools.autoTransaction(conn);//重置事务状态
			JDBCTools.closeSCR(null, conn, null);
		}
	}
	/**
	 * 递归删除节点
	 * @param conn
	 * @param id
	 * @throws SQLException 该异常必须抛出否则调用方法不知道被调用方法是否出问题了，导致回滚出问题
	 */
	private void recursionDelNode(Connection conn,int id) throws SQLException {
		String sql="select * from client where pid=?";
		PreparedStatement prmt=null;
		ResultSet rs=null;
		try {
			prmt=conn.prepareStatement(sql);
			prmt.setInt(1, id);
			rs=prmt.executeQuery();
			//循环找子节点
			while(rs.next()) {
				//如果不是叶子节点则继续递归调用
				if(Constants.NO.equals(rs.getString("is_leaf"))) {
					recursionDelNode(conn, rs.getInt("id"));
				}
				delNode(conn, rs.getInt("id"));//删除子节点
			}
			delNode(conn, id);//删除自身
		}finally {
			JDBCTools.closeSCR(prmt, null, rs);
		}
	}
	/**
	 * 删除节点
	 * @param conn
	 * @param id
	 * @throws SQLException 该异常必须抛出否则调用方法不知道被调用方法是否出问题了，导致回滚出问题
	 */
	private void delNode(Connection conn,int id) throws SQLException {
		String sql="delete from client where id=?";
		PreparedStatement prmt=null;
		try {
			prmt=conn.prepareStatement(sql);
			prmt.setInt(1, id);
			prmt.executeUpdate();
		} finally{
			JDBCTools.closeSCR(null, null, null);
		}
	}
	/**
	 * 查找给定节点的子节点
	 * @param conn
	 * @param id
	 * @return
	 * @throws SQLException 该异常必须抛出否则调用方法不知道被调用方法是否出问题了，导致回滚出问题
	 */
	private int getChildren(Connection conn,int id) throws SQLException {
		String sql="select count(*) as c from client where pid=?";
		PreparedStatement prmt=null;
		ResultSet rs=null;
		try {
			prmt=conn.prepareStatement(sql);
			prmt.setInt(1, id);
			rs=prmt.executeQuery();
			rs.next();
			return rs.getInt("c");
		} finally {
			JDBCTools.closeSCR(prmt, null, null);
		}
	}
	/**
	 * 查询所有的供方分销商
	 * @param pageNo 页号
	 * @param pageSize 每页大小
	 * @param sql 查询语句
	 * @return 分页对象
	 */
	public PageModel<Client> findAllClient(int pageNo,int pageSize,String queryStr){
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select a.id, a.pid, a.name, a.client_id, b.dict_id as client_level_id, b.name as client_level_name, ")
		.append("a.bank_no, a.tel, a.address, a.ems, a.is_leaf, a.is_client ")
		.append("from client a, data_dict b where a.client_level=b.dict_id and a.is_client='Y' ")
		.append("and (a.client_id like '" + queryStr + "%' or ")
		.append("a.name like '" + queryStr + "%')  order by a.id ")
		.append("limit ").append((pageNo - 1) * pageSize).append(", ")
		.append(pageSize);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PageModel<Client> pageModel = null;
		try {
			conn = JDBCTools.Connect();
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			List<Client> clientList = new ArrayList<Client>();
			while (rs.next()) {
				Client client = new Client();
				client.setId(rs.getInt(1));
				client.setPid(rs.getInt(2));
				client.setName(rs.getString(3));
				client.setClientId(rs.getString(4));
				ClientLevel cl = new ClientLevel();
				cl.setDICT_ID(rs.getString(5));
				cl.setNAME(rs.getString(6));
				client.setClientLevel(cl);
				client.setBankNo(rs.getString(7));
				client.setTel(rs.getString(8));
				client.setAddress(rs.getString(9));
				client.setEms(rs.getString(10));
				client.setIsLeaf(rs.getString(11));
				client.setIsClient(rs.getString(12));
				clientList.add(client);
			}
			pageModel = new PageModel<Client>();
			pageModel.setPageNo(pageNo);
			pageModel.setPageSize(pageSize);
			pageModel.setList(clientList);
			pageModel.setTotalRecords(getTotalClientRecords(conn, queryStr));

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTools.closeSCR(pstmt, conn, rs);
		}
		return pageModel;
	}
	/**
	 * 
	 * 查询所有的需方客户
	 * 操作aim_client视图
	 * @param pageNo 页号
	 * @param pageSize 每页大小
	 * @param sql 查询语句
	 * @return 分页对象
	 */
	public PageModel<AimClient> findAllAimClient(int pageNo,int pageSize,String queryStr){
		String sql = "select id, name,client_temi_id, client_temi_level_id, client_temi_level_name from aim_client "
		+ "where (id like '" + queryStr + "%' or name like '"
		+ queryStr + "%') " + " order by id " + "limit " + (pageNo - 1)
		* pageSize + ", " + pageSize;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PageModel<AimClient> pageModel = null;
		try {
			conn = JDBCTools.Connect();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			List<AimClient> aimClientList = new ArrayList<AimClient>();
			while (rs.next()) {
				AimClient aimClient = new AimClient();
				aimClient.setID(rs.getInt("id"));
				aimClient.setCLIENT_TEMI_ID(rs.getString("client_temi_id"));
				aimClient.setNAME(rs.getString("name"));
				aimClient.setCLIENT_TEMI_ID(rs.getString("client_temi_level_id"));
				aimClient.setCLIENT_TEMI_LEVEL_NAME(rs.getString("client_temi_level_name"));
				aimClientList.add(aimClient);
			}
			pageModel = new PageModel<AimClient>();
			pageModel.setPageNo(pageNo);
			pageModel.setPageSize(pageSize);
			pageModel.setList(aimClientList);
			pageModel.setTotalRecords(getTotalAimRecords(conn, queryStr));
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTools.closeSCR(pstmt, conn, rs);
		}
		return pageModel;
	}
	
	/**
	 * 根据条件取得供方分销商的记录数
	 * @param conn
	 * @param queryStr 条件
	 * @return 记录数
	 */
	private int getTotalClientRecords(Connection conn, String queryStr) {
		String sql = "select count(*) from client where is_client='Y' and "
				+ "(client_id like '" + queryStr + "%' or name like '"
				+ queryStr + "%')";
		int totalRecords = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalRecords = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTools.closeSCR(pstmt, conn, rs);
		}
		return totalRecords;
	}
	
	/**
	 * 根据条件取得需方客户的记录数
	 * @param conn
	 * @param queryStr 条件
	 * @return 记录数
	 */
	 private int getTotalAimRecords(Connection conn, String queryStr) {
			String sql = "select count(*) from aim_client " +
			"where client_temi_id like '" + queryStr + "%' or name like '" + queryStr + "%' ";
		int totalRecords = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalRecords = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTools.closeSCR(pstmt, conn, rs);
		}
		return totalRecords;	 
	}
	 
	 /**
	  * 取得分销区域（大区）
	  * @return
	  */
	 public Map<Integer, String> getRegion(){
		 return getProvince(10000);
	 }
	 
	 /**
	  * 取得分销省份
	  * @param id
	  * @return
	  */
	 public Map<Integer, String> getProvince(int id){
		 String sqlString="select id,name from client where pid=?";
		 Connection connection=null;
		 PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 Map<Integer, String> map=new HashMap<Integer, String>();
		try {
			connection=JDBCTools.Connect();
			pstmt = connection.prepareStatement(sqlString);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				map.put(rs.getInt("id"), rs.getString("name"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTools.closeSCR(pstmt, connection, rs);
		}
		return map;
	 }
}
