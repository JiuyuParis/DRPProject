<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="sysMgr.manager.*" import="java.util.List"  import="sysMgr.domain.User"%>
<%
	User user=(User)session.getAttribute("userInfo");
	if(!(request.getParameter("password").equals(user.getPASSWORD())))
		out.print("ÃÜÂë²»ÕýÈ·");
%>