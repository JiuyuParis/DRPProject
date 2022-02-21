<%@page import="jdbcTools.JDBCTools"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>Insert title here</title>
</head>
<body>
	<%
		Connection connection=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		try{
			Context context=new InitialContext();//获得Context对象
			DataSource ds=(DataSource)context.lookup("java:comp/env/DRPMySQL");//在JNDI服务中查找DataSource
			connection=ds.getConnection();//从数据库连接池中获取Connection
			String sql="select * from user";
			psmt=connection.prepareStatement(sql);
			rs=psmt.executeQuery();
			while(rs.next()){
				out.print(rs.getString("user_name"));
			}
		}finally{
			//JDBCTools.closeSCR(psmt, connection, rs);//关闭Connection实际是将connection送回到连接池
		}
	%>
</body>
</html>