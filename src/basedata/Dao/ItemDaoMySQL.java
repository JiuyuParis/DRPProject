package basedata.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import basedata.domain.Item;
import common.ApplicationException;
import common.PageModel;
import dataDict.domain.ItemCategory;
import dataDict.domain.ItemUnit;
import jdbcTools.JDBCTools;
/**
 * 物料工厂MySQL类
 * @author Jiuyu
 *
 */
public class ItemDaoMySQL implements ItemDao {

	@Override
	public void addItem(Connection conn, Item item) {
		String sqlString="insert into items(no,name,spec,pattern,category_id,unit_id) values(?,?,?,?,?,?)";
		PreparedStatement psmtPreparedStatement=null;
		try {
			psmtPreparedStatement=conn.prepareStatement(sqlString);
			psmtPreparedStatement.setString(1, item.getNo());
			psmtPreparedStatement.setString(2, item.getName());
			psmtPreparedStatement.setString(3, item.getSpec());
			psmtPreparedStatement.setString(4, item.getPattern());
			psmtPreparedStatement.setString(5, item.getItemCategory().getDICT_ID());
			psmtPreparedStatement.setString(6, item.getItemUnit().getDICT_ID());
			psmtPreparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode()+"\n"+e.getMessage());
			throw new ApplicationException("添加物料失败！");
		}finally {
			JDBCTools.closeSCR(psmtPreparedStatement, null, null);
		}
	}

	@Override
	public void delItem(Connection conn, String[] itemNos) {
		StringBuilder sqlBuilder=new StringBuilder();
		for(int i=0;i<itemNos.length;i++) {
			sqlBuilder.append("?");
			if(i<itemNos.length-1)
				sqlBuilder.append(",");
		}
		String sql="delete from items where no in ("+sqlBuilder.toString()+")";
		PreparedStatement psmtPreparedStatement=null;
		try {
			psmtPreparedStatement=conn.prepareStatement(sql);
			for(int i=0;i<itemNos.length;i++)
				psmtPreparedStatement.setString(i+1, itemNos[i]);
			psmtPreparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode()+"\n"+e.getMessage());
			throw new ApplicationException("删除物料失败！");
		}finally {
			JDBCTools.closeSCR(psmtPreparedStatement, null, null);
		}

	}

	@Override
	public void modifyItem(Connection conn, Item item) {
		String sqlString="update items set name=?,spec=?,pattern=?,category_id=?,unit_id=?,file_name=? where no=?";
		PreparedStatement psmtPreparedStatement=null;
		try {
			psmtPreparedStatement=conn.prepareStatement(sqlString);
			psmtPreparedStatement.setString(1, item.getName());
			psmtPreparedStatement.setString(2, item.getSpec());
			psmtPreparedStatement.setString(3, item.getPattern());
			psmtPreparedStatement.setString(4, item.getItemCategory().getDICT_ID());
			psmtPreparedStatement.setString(5, item.getItemUnit().getDICT_ID());
			psmtPreparedStatement.setString(6, item.getFileName());
			psmtPreparedStatement.setString(7, item.getNo());
			psmtPreparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode()+"\n"+e.getMessage());
			throw new ApplicationException("修改物料失败！");
		}finally {
			JDBCTools.closeSCR(psmtPreparedStatement, null, null);
		}
	}

	@Override
	public Item findItemById(Connection conn, String itemNo) {
		String sqlString="select i.no,i.name,i.spec,i.pattern,i.category_id,d1.name as category_name,i.unit_id,d2.name as unit_name,i.file_name from items i,data_dict d1,data_dict d2 where i.CATEGORY_ID=d1.DICT_ID and i.UNIT_ID=d2.DICT_ID and i.NO=?";
		PreparedStatement psmt=null;
		ResultSet rs=null;
		Item item=null;
		try {
			psmt=conn.prepareStatement(sqlString);
			psmt.setString(1, itemNo);
			rs=psmt.executeQuery();
			while(rs.next()) {
				item=new Item();
				item.setNo(rs.getString("no"));
				item.setName(rs.getString("name"));
				item.setSpec(rs.getString("spec"));
				item.setPattern(rs.getString("pattern"));
				item.setFileName(rs.getString("file_name"));
				
				//创建itemCategory对象
				ItemCategory itemCategory=new ItemCategory();
				itemCategory.setDICT_ID(rs.getString("category_id"));
				itemCategory.setNAME(rs.getString("category_name"));
				
				//创建itemUnit对象
				ItemUnit itemUnit=new ItemUnit();
				itemUnit.setDICT_ID(rs.getString("unit_id"));
				itemUnit.setNAME(rs.getString("unit_name"));
				
				item.setItemCategory(itemCategory);
				item.setItemUnit(itemUnit);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTools.closeSCR(psmt, null, rs);
		}
		return item;
	}
	
	/**
	 * 构建Item的PageModel分页模型
	 */
	@Override
	public PageModel<Item> findItemList(Connection conn, int pageNo, int pageSize, String condition) {
		StringBuilder sql=new StringBuilder("select i.no,i.name,i.spec,i.pattern,i.category_id,d1.name as category_name,i.unit_id,d2.name as unit_name,i.file_name from items i,data_dict d1,data_dict d2 where i.CATEGORY_ID=d1.DICT_ID and i.UNIT_ID=d2.DICT_ID ");
		if(condition!=null&&!"".equals(condition)) {
			sql.append("and (i.no like '"+condition+"%' or i.name like '"+condition+"%') ");
		}
		sql.append("order by i.no limit ?,?");
		PreparedStatement psmt=null;
		ResultSet rs=null;
		List<Item> itemList=new ArrayList<Item>();
		PageModel<Item> pageModel=new PageModel<Item>();//分页模型
		try {
			psmt=conn.prepareStatement(sql.toString());
			psmt.setInt(1, (pageNo-1)*pageSize);
			psmt.setInt(2, pageSize);
			rs=psmt.executeQuery();
			while(rs.next()) {
				Item item=new Item();
				item.setNo(rs.getString("no"));
				item.setName(rs.getString("name"));
				item.setSpec(rs.getString("spec"));
				item.setPattern(rs.getString("pattern"));
				item.setFileName(rs.getString("file_name"));
				
				//创建itemCategory对象
				ItemCategory itemCategory=new ItemCategory();
				itemCategory.setDICT_ID(rs.getString("category_id"));
				itemCategory.setNAME(rs.getString("category_name"));
				
				//创建itemUnit对象
				ItemUnit itemUnit=new ItemUnit();
				itemUnit.setDICT_ID(rs.getString("unit_id"));
				itemUnit.setNAME(rs.getString("unit_name"));
				
				item.setItemCategory(itemCategory);
				item.setItemUnit(itemUnit);
				itemList.add(item);//将item添加到itemList中
				
				//建立并设置PageModel对象
				pageModel.setList(itemList);
				pageModel.setPageNo(pageNo);
				pageModel.setPageSize(pageSize);
				pageModel.setTotalRecords(getTotalRecords(conn, condition));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ApplicationException("分页查询失败");
		}finally {
			JDBCTools.closeSCR(psmt, null, rs);
		}
		return pageModel;
	}
	
	/**
	 * 按条件取得物料列表总数目
	 * @param conn
	 * @param condition
	 * @return
	 * @throws SQLException
	 */
	private int getTotalRecords(Connection conn,String condition) throws SQLException {
		String sqlString="select count(*) from items ";
		if (condition != null && !"".equals(condition)) {
			sqlString+="where no like '"+condition+"%' or name like '"+condition+"%'";
		}
		PreparedStatement psmt=null;
		ResultSet rs=null;
		int total=0;
		try {
			psmt=conn.prepareStatement(sqlString);
			rs=psmt.executeQuery();
			rs.next();
			total=rs.getInt(1);
		}finally {
			JDBCTools.closeSCR(psmt, null, rs);
		}
		return total;
	}

}
