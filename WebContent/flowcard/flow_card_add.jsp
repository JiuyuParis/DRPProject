<%@ page language="java" contentType="text/html; charset=GB18030"
pageEncoding="GB18030"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
		+ request.getContextPath() + "/";
	String info = request.getParameter("info");//��ȡ��ʾ��Ϣ
%>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>�������ά��</title>
		<link rel="stylesheet" href="style/drp.css">
		<link href="style/JSCalendar.css" rel=stylesheet type=text/css>
		<script src="script/JSCalendar.js"></script>
		<script src="script/client_validate.js"></script>
		<script language="javascript">
    var rowIndex = 0;
    
    
    function selectAimClient(field) {
		window.open('flowcard/aim_client_select.jsp?index=' + field.name, '��ѡ���跽�ͻ�', 'width=700, height=400, scrollbars=no');
    }   
     
    function selectItem(field) {
		window.open('flowcard/item_select.jsp?index=' + field.name, '��ѡ������', 'width=700, height=400, scrollbars=no');
    } 

	function goBack() {
		window.self.location="flow_card_maint.jsp"
	}	

</script>
	</head>

	<body class="body1">
		<div align="center">
			<form name="flowCardAddForm" method="post" action="servlet/flowcard/FlowCardServlet">
				<input type="hidden" name="command" value="${ADD }">
				<table width="95%" border="0" cellspacing="2" cellpadding="2">
					<tr>
						<td>
							&nbsp;
						</td>
					</tr>
				</table>
				<table width="95%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="522" class="p1" height="2" nowrap>
							<img src="images/mark_arrow_03.gif" width="14" height="14">
							&nbsp;
							<b>�����̿�����&gt;&gt;����ά��&gt;&gt;���</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="15%" height="29">
							<div align="right">
								<font color="#FF0000">*</font>���������̴���:&nbsp;
							</div>
						</td>
						<td width="16%">
							<input type="hidden" name="clientInnerId" id="clientInnerId" >
							<input name="clientId" type="text" class="text1" id="clientId"
								size="10" maxlength="10" readonly="true">
							<input name="btnSelectClient" type="button" id="btnSelectClient"
								value="..." class="button1"
								onClick="window.open('flowcard/client_select.jsp', 'ѡ�������', 'width=700, height=400, scrollbars=no')">
						</td>
						<td width="16%">
							<div align="right">
								��������������:&nbsp;
							</div>
						</td>
						<td width="29%">
							<input name="clientName" type="text" class="text1"
								id="clientName" size="40" maxlength="40" readonly="true">
						</td>
						<td width="7%">
							&nbsp;
						</td>
						<td width="17%">
							<label></label>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0"
					name="tblFlowCardDetail" id="tblFlowCardDetail">
					<tr>
						<td nowrap>
								<font color="#FF0000">*</font>�跽�ͻ�����
						</td>
						<td nowrap>
								�跽�ͻ�����
						</td>
						<td nowrap>
								<font color="#FF0000">*</font>���ϴ���
						</td>
						<td nowrap>
								��������
						</td>
						<td nowrap>
							���
						</td>
						<td nowrap>
							�ͺ�
						</td>
						<td nowrap>
							������λ
						</td>
						<td nowrap>
							<font color="#FF0000">*</font>��������
						</td>
					</tr>
				</table>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<%
						for(int i=0;i<10;i++){
					%>
					<tr>
						<td nowrap>
							<input type="hidden" name="aimInnerId" id="aimInnerId"><input readonly maxLength=6 size=6 name="aimId"><input type="button"  value ="..."   name="<%=i %>" onclick="selectAimClient(this)">
						</td>
						<td nowrap>
							<input id="aimName" name="aimName" size=13 readonly>
						</td>
						<td nowrap>
							<input readonly maxLength=4 size=4 name="itemNo"><input type="button"  value ="..."   name="<%=i %>"  onclick="selectItem(this)">
						</td>
						<td nowrap>
							<input id="itemName" name="itemName" size=10 readonly>
						</td>	
						<td nowrap>
							<input id="spec" name="spec" size=4 readonly>
						</td>
						<td nowrap>
							<input id="pattern" name="pattern" size=4 readonly>
						</td>
						<td nowrap>
							<input id="unit" name="unit" size=4 readonly>
						</td>
						<td nowrap>
							<input id="qty" name="qty" size=6>
						</td>
					</tr>
					<%
						}
					%>
				</table>
				<p>
					<input name="btnSave" type="submit" id="btnSave" value="����"
						onClick="addFlowCard()">
					<input name="btnBack" type="button" id="btnBack" onClick="goBack()"
						value="����">
				</p>
				<p>
					&nbsp;<font color="red" size="2">ÿ��������ʮ������!</font>
				</p>
				<p>
					&nbsp;
				</p>
			</form>
			<p>
				&nbsp;
			</p>
		</div>
	</body>
</html>
