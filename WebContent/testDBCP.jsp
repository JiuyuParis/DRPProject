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
			Context context=new InitialContext();//���Context����
			DataSource ds=(DataSource)context.lookup("java:comp/env/DRPMySQL");//��JNDI�����в���DataSource
			connection=ds.getConnection();//�����ݿ����ӳ��л�ȡConnection
			String sql="select * from user";
			psmt=connection.prepareStatement(sql);
			rs=psmt.executeQuery();
			while(rs.next()){
				out.print(rs.getString("user_name"));
			}
		}finally{
			//JDBCTools.closeSCR(psmt, connection, rs);//�ر�Connectionʵ���ǽ�connection�ͻص����ӳ�
		}
	%>
</body>
</html>