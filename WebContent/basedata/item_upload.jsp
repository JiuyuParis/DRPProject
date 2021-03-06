<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
	+ request.getContextPath() + "/";
%>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>物料维护</title>
		<link rel="stylesheet" href="style/drp.css">
		<script src="script/client_validate.js"></script>
		<script language="javascript">

</script>
	</head>

	<body class="body1">
		<form name="itemForm" target="_self" id="itemForm" method="post" action="servlet/item/FileUploadServlet" enctype="multipart/form-data">
			<input type="hidden" name="itemNo" value="${item.no}">
			<div align="center">
				<table width="95%" border="0" cellspacing="2" cellpadding="2">
					<tr>
						<td>
							&nbsp;
						</td>
					</tr>
				</table>
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="8">
					<tr>
						<td width="522" class="p1" height="2" nowrap>
							<img src="images/mark_arrow_03.gif" width="14" height="14">
							&nbsp;
							<b>基础数据管理&gt;&gt;物料维护&gt;&gt;上传物料图片</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td height="29">
							<div align="right">
								物料代码:&nbsp;
							</div>
						</td>
						<td>
							${item.no }
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								物料名称:&nbsp;
							</div>
						</td>
						<td>
							${item.name }
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								物料规格:&nbsp;
							</div>
						</td>
						<td>
							${item.spec }
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								物料型号:&nbsp;
							</div>
						</td>
						<td>
							${item.pattern }
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								类别:&nbsp;
							</div>
						</td>
						<td>
							${item.itemCategory.NAME }
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								计量单位:&nbsp;
							</div>
						</td>
						<td>
							${item.itemUnit.NAME }
						</td>
					</tr>
					<tr>
						<td height="74">
							<div align="right">
								图片:&nbsp;
							</div>
						</td>
						<td>
							<img src="upload/${item.fileName}" width="85" height="49">
						</td>
					</tr>
					<tr>
						<td width="22%" height="29">
							<div align="right">
								<font color="#FF0000">*</font>选择图片:&nbsp;
							</div>
						</td>
						<td width="78%">
							<input name="fileName" type="file" class="text1" size="40" maxlength="40">
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btn_upload" class="button1" type="submit"
						id="btn_upload" value="上传">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="返回" onClick="history.go(-1)">
				</div>
			</div>
		</form>
	</body>
</html>
