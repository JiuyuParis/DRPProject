package basedata.manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbcTools.JDBCTools;
import systemFiles.Constants;

/**
 * 分销商树的递归读取
 * @author cx998
 *
 */
public class ClientTreeReader {
	private StringBuffer sbTreeHTML=new StringBuffer();
	/**
	 * 返回分销商HTML字符串
	 * @return
	 */
	public String getClientTreeHTMLString()
	{
		Connection conn=JDBCTools.Connect();
		readClientTree(conn,0,0);
		JDBCTools.closeSCR(null, conn, null);
		return sbTreeHTML.toString();
	}
	/**
	 * 用最简单的方式读取分销商信息
	 * @param conn
	 * @param id
	 * @param level 控制层次
	 */
	private void readClientTree(Connection conn,int id,int level)
	{
		String sql="select * from client where pid=?";
		PreparedStatement pmst=null;
		ResultSet rs=null;
		try {
			pmst=conn.prepareStatement(sql);
			pmst.setInt(1, id);
			rs=pmst.executeQuery();
			while(rs.next())
			{
				sbTreeHTML.append("<div>");
				//为目录前面添加空格图片增加层次感
				for(int i=0;i<level;i++)
				{
					sbTreeHTML.append("<img src=\"../images/white.gif\">");
				}
				//如果不是叶子节点则递归调用
				if(Constants.NO.equals(rs.getString("is_leaf")))
				{
					sbTreeHTML.append("<img alt=\"展开\" style=\"cursor:hand;\" onClick=\"display('"+rs.getInt("id")+"');\"\r\n"
							+ "									id=\"img"+rs.getInt("id")+"\" src=\"../images/plus.gif\">\r\n"
							+ "								<img id=\"im"+rs.getInt("id")+"\" src=\"../images/closedfold.gif\">\r\n"
							+ "								<a href=\"client_node_crud.jsp?id="+rs.getInt("id")+"\" target=\"clientDispAreaFrame\">"+rs.getString("name")+"</a>\r\n"
							+ "								<div style=\"display:none;\" id=\"div"+rs.getInt("id")+"\">");
					readClientTree(conn,rs.getInt("id"),level+1);
					sbTreeHTML.append("</div>");
				}
				else
				{
					sbTreeHTML.append("<img src=\"../images/minus.gif\">\r\n"
							+ "												<img src=\"../images/openfold.gif\">");
					if(Constants.YES.equals(rs.getString("is_client")))
					{
						sbTreeHTML.append("<a href=\"client_crud.jsp?id="+rs.getInt("id")+"\" target=\"clientDispAreaFrame\">"+rs.getString("name")+"</a>");
					}
					else
					{
						sbTreeHTML.append("<a href=\"client_node_crud.jsp?id="+rs.getInt("id")+"\" target=\"clientDispAreaFrame\">"+rs.getString("name")+"</a>");
					}
				}
				sbTreeHTML.append("</div>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTools.closeSCR(pmst, null, rs);
		}
		
	}
}
