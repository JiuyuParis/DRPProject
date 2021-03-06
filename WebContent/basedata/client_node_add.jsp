<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="systemFiles.Constants" import="basedata.domain.Client" import="basedata.manager.ClientManager"%>
<%
	boolean sucess=false;//添加结果提示框标志位
	String name=request.getParameter("name");
	int pid=Integer.parseInt(request.getParameter("pid"));//拿到从client_node_crud.jsp中的id
	if(Constants.ADD.equals(request.getParameter("add"))){
		Client client=new Client();
		client.setName(name);
		client.setPid(pid);
		client.setIsLeaf(Constants.YES);
		client.setIsClient(Constants.NO);
		ClientManager.getInstance().addClientOrRegion(client);//添加区域
		sucess=true;
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link rel="stylesheet" href="../style/drp.css" />
		<script src="../script/client_validate.js"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030" />
		<title>添加区域节点</title>
		<script type="text/javascript">
			//检查输入合法性
			function validateForm(form){
				if(form.name.value==""){
					alert("请输入区域名称！");
					return false;
				}
				return true;
			}
		</script>
	</head>

	<body class="body1">
		<form name="regionForm" method="post" action="client_node_add.jsp" onsubmit="return validateForm(this)">
			<input type="hidden" name="add" value="<%=Constants.ADD %>"/>
			<input type="hidden" name="pid" value="<%=pid%>"/>
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="8">
				<tr>
					<td width="522" class="p1" height="2" nowrap="nowrap">
						<img src="../images/mark_arrow_03.gif" width="14" height="14" />
						&nbsp;
						<b>基础数据管理&gt;&gt;分销商维护&gt;&gt;添加区域节点</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size="0" />
			<p></p>
			<p></p>
			<table width="95%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="213">
						<div align="right">
							<font color="#FF0000">*</font>区域名称：
						</div>
					</td>
					<td width="410">
						<label>
							<input name="name" type="text" class="text1" id="name" />
						</label>
					</td>
				</tr>
			</table>
			<p></p>
			<label>
				<br />
			</label>
			<hr />
			<p align="center">
				<input name="btnAdd" class="button1" type="submit" value="添加" />
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" value="返回"
					onclick="history.go(-1)" />
			</p>
		</form>
	</body>
</html>
<%
	if(sucess){
%>
<script type="text/javascript">
	alert("添加区域成功！");
	window.parent.clientTreeFrame.location.reload();
</script>
<%
	}
%>