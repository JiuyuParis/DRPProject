<%@page import="systemFiles.Constants"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="basedata.manager.ClientManager" import="basedata.domain.Client"%>
<%
	int id=Integer.parseInt(request.getParameter("id"));
	Client client=ClientManager.getInstance().findClientOrAreaById(id);
	if(Constants.DEL.equals(request.getParameter("del"))){
		ClientManager.getInstance().delClientOrRegion(id);
%>
<script type="text/javascript">
	alert("ɾ���ɹ���");
	window.parent.clientTreeFrame.location.reload();
</script>
<%
	}
%>
<html>
	<head>
		<link rel="stylesheet" href="../style/drp.css" />
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030" />
		<title>������ά��</title>
		<script type="text/javascript">

	function addRegion() {
		window.self.location = "client_node_add.jsp?pid=<%=id%>";	
	}
	
	function modifyRegion() {
		window.self.location = "client_node_modify.jsp?id=<%=id%>";
	}
	
	function deleteRegion() {
		if(window.confirm("ȷ��ɾ��<%=client.getName()%>������������ͷ������𣿸ò������ɻָ���")){
			with(document.forms[0]){
				action="client_node_crud.jsp";
				submit();
			}
		}
	}
	
	function addClient() {
		window.self.location = "client_add.jsp?pid=<%=id%>";
	}
	
</script>
	</head>

	<body class="body1">
		<form id="clientForm" name="clientForm" method="post" action="">
			<input type="hidden" name="del" value="<%=Constants.DEL%>">
			<input type="hidden" name="id" value="<%=id%>">
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="8">
				<tr>
					<td width="522" class="p1" height="2" nowrap="nowrap">
						<img src="../images/mark_arrow_02.gif" width="14" height="14" />
						&nbsp;
						<b>�������ݹ���&gt;&gt;������ά��</b>
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
							��ǰ�������ƣ�
						</div>
					</td>
					<td width="410">
						<label>
							<input name="name" type="text" class="text1" id="name" readonly="true" value="<%=client.getName() %>" />
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
				<input name="btnAddRegion" type="button" class="button1"
					id="btnAddRegion" onClick="addRegion()" value="�������" />
				&nbsp;
				<input name="btnDeleteRegion" type="button" class="button1"
					id="btnDeleteRegion" value="ɾ������" onClick="deleteRegion()" />
				&nbsp;
				<input name="btnModifyRegion" type="button" class="button1"
					id="btnModifyRegion" onClick="modifyRegion()" value="�޸�����" />
				&nbsp;
				<input name="btnAddClient" type="button" class="button1"
					id="btnAddClient" onClick="addClient()" value="��ӷ�����" />
			</p>
		</form>
	</body>
</html>
