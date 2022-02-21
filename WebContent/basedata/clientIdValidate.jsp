<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="basedata.manager.ClientManager" %>
<%
	//response.setContentType("text/html;charset=GB18030");//设置response的类型、编码
	String clientId=request.getParameter("clientId");
	boolean flag=ClientManager.getInstance().findClientOrRegion(clientId);
	if(flag) {
		out.print("该分销商已存在！");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>验证分销商代码</title>
</head>
<body>

</body>
</html>