<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="systemFiles.Constants" import="basedata.domain.Client" import="basedata.manager.ClientManager"%>
<%
	boolean sucess=false;//��ӽ����ʾ���־λ
	String name=request.getParameter("name");
	int pid=Integer.parseInt(request.getParameter("pid"));//�õ���client_node_crud.jsp�е�id
	if(Constants.ADD.equals(request.getParameter("add"))){
		Client client=new Client();
		client.setName(name);
		client.setPid(pid);
		client.setIsLeaf(Constants.YES);
		client.setIsClient(Constants.NO);
		ClientManager.getInstance().addClientOrRegion(client);//�������
		sucess=true;
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link rel="stylesheet" href="../style/drp.css" />
		<script src="../script/client_validate.js"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030" />
		<title>�������ڵ�</title>
		<script type="text/javascript">
			//�������Ϸ���
			function validateForm(form){
				if(form.name.value==""){
					alert("�������������ƣ�");
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
						<b>�������ݹ���&gt;&gt;������ά��&gt;&gt;�������ڵ�</b>
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
							<font color="#FF0000">*</font>�������ƣ�
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
				<input name="btnAdd" class="button1" type="submit" value="���" />
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" value="����"
					onclick="history.go(-1)" />
			</p>
		</form>
	</body>
</html>
<%
	if(sucess){
%>
<script type="text/javascript">
	alert("�������ɹ���");
	window.parent.clientTreeFrame.location.reload();
</script>
<%
	}
%>