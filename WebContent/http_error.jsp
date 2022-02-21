<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>请求错误页面</title>
</head>
<body>
	<%
		Integer errorCode=(Integer)request.getAttribute("javax.servlet.error.status_code");
		if(errorCode==404)
			response.sendRedirect(request.getContextPath()+"/404.html");
		else if(errorCode==500)
			response.sendRedirect(request.getContextPath()+"/500.html");
	%>
</body>
</html>