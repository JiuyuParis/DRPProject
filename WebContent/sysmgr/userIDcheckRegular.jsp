<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="sysMgr.domain.User" import="sysMgr.manager.UserManager" %>
<%
	User user=new User();
	String userId=request.getParameter("userId");
	user.setUSER_ID(userId);
	if(UserManager.getInstance().Query(user)!=null)
		out.print("���û�"+userId+"�Ѵ��ڣ����ʧ�ܣ�");
%> 