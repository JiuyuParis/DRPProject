package statreport.manager.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import jdbcTools.JDBCToolsThreadLocal;
import statreport.manager.StatReportManager;

/**
 * 统计报表管理接口实现类
 * @author Jiuyu
 *
 */
public class StatReportManagerImpl implements StatReportManager {

	@Override
	public Map<String, Integer> getClientLevelCount() {
		String sqlString="select a.name,count(b.client_level)  c from data_dict a left join client b on a.DICT_ID=b.CLIENT_LEVEL where a.CATEGORY='A' group by a.NAME";
		Connection connection=JDBCToolsThreadLocal.Connect();
		PreparedStatement psmt=null;
		ResultSet rs=null;
		Map<String, Integer> map=new HashMap<String, Integer>();//存放分销商等级数量
		try {
			psmt=connection.prepareStatement(sqlString);
			rs=psmt.executeQuery();
			while(rs.next()) {
				map.put(rs.getString("name"), rs.getInt("c"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCToolsThreadLocal.closeSCR(psmt, null, rs);
		}
		return map;
	}

}
