<%@ page contentType="text/html;charset=GB18030"%>
<%@ page isErrorPage="true"%>
<%
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<html>
<head>
<base href="<%=basePath%>">
<title>错误信息!</title>
<meta http-equiv="content-type" content="text/html;charset=gb2312">
<style type="text/css">

.STYLE1 {
	font-size: 24px;
	font-weight: bold;
	color: #FF0000;
}

</style>
</head>
<body>
	<br>
	<br>
	<center>
		<table width="500">
			<tr>
				<td align="center"><p align="left">
						<span class="STYLE1">错误信息：</span></td>
			</tr>
		</table>
		<hr>
		<table width="500">
			<tr>
				<td><%=exception.getMessage()%></td>
			</tr>
			<tr>
				<td align="center" colspan="2">
					<p>
						<input type="button" name="goback" value="返回"
							onClick="javascript:history.go(-1);">
				</td>
			</tr>
			<tr>
				<td align="right" colspan="2"></td>
			</tr>
			<tr>
				<td align="right" colspan="2"></td>
			</tr>
			<img src="img/500.jpeg">
		</table>
	</center>
</body>
</html>
