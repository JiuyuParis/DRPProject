<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="basedata.manager.ClientManager" %>
<%
	//response.setContentType("text/html;charset=GB18030");//����response�����͡�����
	String clientId=request.getParameter("clientId");
	boolean flag=ClientManager.getInstance().findClientOrRegion(clientId);
	if(flag) {
		out.print("�÷������Ѵ��ڣ�");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>��֤�����̴���</title>
</head>
<body>

</body>
</html>