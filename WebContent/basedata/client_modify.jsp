<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="basedata.manager.ClientManager" import="basedata.domain.Client" import="dataDict.domain.ClientLevel" import="dataDict.manager.DataDictManager" import="java.util.List" import="java.util.Iterator"%>
<%@ page import="systemFiles.Constants" %>
<%
	int id=Integer.parseInt(request.getParameter("id"));
	Client client=ClientManager.getInstance().findClientOrAreaById(id);//����Ҫ�޸ĵķ�����
	List<ClientLevel> levelList=DataDictManager.getInstance().findClientLevelList();//��ȡ�����̵ȼ��б�
	if(Constants.MODIFY.equals(request.getParameter("command")))
	{
		client.setAddress(request.getParameter("address"));
		client.setBankNo(request.getParameter("bankAcctNo"));
		ClientLevel cle=new ClientLevel();
		cle.setDICT_ID(request.getParameter("clientLevel"));
		client.setClientLevel(cle);
		client.setEms(request.getParameter("zipCode"));
		client.setName(request.getParameter("clientName"));
		client.setTel(request.getParameter("contactTel"));
		ClientManager.getInstance().modifyClientOrRegion(client);
		out.print("�޸ĳɹ���");
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>�޸ķ�����</title>
		<link rel="stylesheet" href="../style/drp.css">
		<script type="text/javascript">
			function validateForm(form){
				if(form.clientName.value=="")
					{
						alert("���������Ʋ���Ϊ�գ�");
						return false;
					}
				return true;
			}
		</script>
	</head>

	<body class="body1">
		<form name="clientForm" target="_self" id="clientForm" method="post" onsubmit="return validateForm(this)">
			<input type="hidden" name="command" value="<%=Constants.MODIFY %>" />
			<input type="hidden" name="id" value="<%=id %>" />
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
							<img src="../images/mark_arrow_03.gif" width="14" height="14">
							&nbsp;
							<b>�������ݹ���&gt;&gt;������ά��&gt;&gt;�޸ķ�����</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="22%" height="29">
							<div align="right">
								�����̴���:&nbsp;
							</div>
						</td>
						<td width="78%">
							<input name="clientId" type="text" class="text1" id="clientId"
								size="10" maxlength="10" readonly="true" value="<%=client.getId() %>">
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								<font color="#FF0000">*</font>����������:&nbsp;
							</div>
						</td>
						<td>
							<input name="clientName" type="text" class="text1"
								id="clientName" size="40" maxlength="40" value="<%=client.getName()%>">
						</td>
					</tr>
					<tr>
						<td height="15">
							<div align="right">
								<font color="#FF0000">*</font>����������:&nbsp;
							</div>
						</td>
						<td>
							<select name="clientLevel" class="select1" id="clientLevel">
								<%
									for(Iterator<ClientLevel> iter=levelList.iterator();iter.hasNext();)
									{
										String selectStr="";
										ClientLevel cl=iter.next();
										if(client.getClientLevel().getDICT_ID().equals(cl.getDICT_ID()))
											selectStr="selected";		
								%>
										<option value="<%=cl.getDICT_ID()%>" <%=selectStr %>><%=cl.getNAME() %></option>
								<%} %>
							</select>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								�����ʺ�:&nbsp;
							</div>
						</td>
						<td>
							<input name="bankAcctNo" type="text" class="text1"
								id="bankAcctNo" size="10" maxlength="10" value="<%=client.getBankNo()%>">
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								��ϵ�绰:&nbsp;
							</div>
						</td>
						<td>
							<input name="contactTel" type="text" class="text1"
								id="contactTel" size="10" maxlength="10" value="<%=client.getTel() %>">
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								��ַ:&nbsp;
							</div>
						</td>
						<td>
							<input name="address" type="text" class="text1" id="address"
								size="10" maxlength="10" value="<%=client.getAddress() %>">
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								�ʱ�:&nbsp;
							</div>
						</td>
						<td>
							<input name="zipCode" type="text" class="text1" id="zipCode"
								size="10" maxlength="10" value="<%=client.getEms() %>">
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnModify" class="button1" type="submit"
						id="btnModify" value="�޸�">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="����" onclick="location='client_crud.jsp?id=<%=id %>'" />
				</div>
			</div>
		</form>
	</body>
</html>
