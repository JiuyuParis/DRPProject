<%@ page language="java" contentType="text/html; charset=GB18030"
pageEncoding="GB18030"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
	<head>
		<base href="${pageContext.request.contextPath }/">
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>����ά��</title>
		<link rel="stylesheet" href="style/drp.css" type=text/css>
		<link href="style/JSCalendar.css" rel=stylesheet type=text/css>
		<script src="script/JSCalendar.js"></script>
		<script src="script/client_validate.js"></script>
		<script type="text/javascript">
		var selectFlags = document.getElementsByName("selectFlag");
	function addFlowCard() {
		window.self.location = "servlet/flowcard/FlowCardServlet?command=${SHOW_ADD}";
	}
	
	function modifyFlowCard() {
		window.self.location = "flow_card_modify.html";
	}
	
	function deleteFlowCard() {
	}
	
	function topPage() {
		window.self.location = "servlet/flowcard/FlowCardServlet?clientId=${param.clientId}&clientName=${param.clientName}&beginDate=${param.beginDate}&endDate=${param.endDate}&pageNo=${pageModel.topPage}";
	}
	
	function previousPage() {
		window.self.location = "servlet/flowcard/FlowCardServlet?clientId=${param.clientId}&clientName=${param.clientName}&beginDate=${param.beginDate}&endDate=${param.endDate}&pageNo=${pageModel.previousPage}";
	}
	
	function nextPage() {
		
		window.self.location = "servlet/flowcard/FlowCardServlet?clientId=${param.clientId}&clientName=${param.clientName}&beginDate=${param.beginDate}&endDate=${param.endDate}&pageNo=${pageModel.nextPage}";
	}
	
	function bottomPage() {
		window.self.location = "servlet/flowcard/FlowCardServlet?clientId=${param.clientId}&clientName=${param.clientName}&beginDate=${param.beginDate}&endDate=${param.endDate}&pageNo=${pageModel.bottomPage}";
	}
	
	function auditFlowCard() {
		document.forms[1].action="servlet/flowcard/FlowCardServlet?command=${AUDIT}";
		document.forms[1].method="post";
		document.forms[1].submit();
	}
	
	function delFlowCard(){
		//�ж�ѡ����Ϣ�����Ƿ�Ϸ�
		var selected=false;
		for (var i = 0; i < selectFlags.length; i++)
				if(selectFlags[i].checked)
					{
						selected=true;
						break;
					}
		if(selected==false)
			{
				alert("������ѡ��һ����Ϣɾ����");
				return;
			}
		document.forms[1].action="servlet/flowcard/FlowCardServlet?command=${DEL}";
		document.forms[1].method="post";
		document.forms[1].submit();
	}
</script>
	</head>

	<body class="body1">
		<div align="center">
			<form name="flowCardForm" action="servlet/flowcard/FlowCardServlet" method="post">
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
							<img src="images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>�����̿�����&gt;&gt;����ά��</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="15%" height="29">
							<div align="right">
								���������̴���:&nbsp;
							</div>
						</td>
						<td width="23%">
							<input name="clientId" type="text" class="text1" id="clientId"
								size="10" maxlength="10" readonly value="${param.clientId }">
							<input name="btnSelectClient" type="button" id="btnSelectClient"
								value="..." class="button1"
								onClick="window.open('flowcard/client_select.jsp', 'ѡ�������', 'width=700, height=400, scrollbars=no')">
						</td>
						<td width="14%">
							<div align="right">
								��������������:&nbsp;
							</div>
						</td>
						<td width="37%">
							<input name="clientName" type="text" class="text1"
								id="clientName" size="40" maxlength="40" readonly value="${param.clientName }">
						</td>
						<td width="11%">
							<input name="btnQuery" type="submit" class="button1"
								id="btnQuery" value="��ѯ" onClick="queryFlowCard()">
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								��ʼ����:&nbsp;
							</div>
						</td>
						<td>
							<input type="text" name="beginDate" size="10" maxlength="10"
								value="<fmt:formatDate value="${formatBeginDate }" pattern="yyyy-MM-dd" />" >
						</td>
						<td>
							<div align="right">
								��������:&nbsp;
							</div>
						</td>
						<td>
							<input type="text" name="endDate" size="10" maxlength="10"
								value="<fmt:formatDate value="${formatEndDate }" pattern="yyyy-MM-dd" />">
						</td>
						<td>
							<input name="btnReset" type="reset" class="button1"
								id="btnReset" value="����" onClick="resetFlowCard()">
						</td>
					</tr>
				</table>
			</form>
			<form action="servlet/flowcard/FlowCardServlet">
				<table height=8 width="95%">
					<tr>
						<td height=3></td>
					</tr>
				</table>
				<table width="95%" height="20" border="0" cellspacing="0"
					id="toolbar" class="rd1">
					<tr>
						<td class="rd19" width="434">
							<font color="#FFFFFF">��ѯ�б�</font>
						</td>
						<td nowrap class="rd16" width="489">
							<div align="right"></div>
						</td>
					</tr>
				</table>
				<table width="95%" border="1" cellspacing="0" cellpadding="0"
					align="center" class="table1" title="���ѡ�е����ݲ鿴��ϸ��Ϣ...">
					<tr>
						<td class="rd6">
							<input type="checkbox" name="ifAll" onClick="checkAll()">
						</td>
						<td class="rd6">
							���򵥺�
						</td>
						<td class="rd6">
							���������̴���
						</td>
						<td class="rd6">
							��������������
						</td>
						<td class="rd6">
							¼����
						</td>
						<td class="rd6">
							¼������
						</td>
					</tr>
					<c:choose>
						<c:when test="${empty pageModel or empty pageModel.list or fn:length(pageModel.list) eq 0}">
							<tr><td colspan="6" class="rd8">û�з�������������</td></tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${pageModel.list }" var="flowCard">
								<tr>
									<td width="37" class="rd8">
										<input name="selectFlag" type="checkbox" class="checkbox1"
											id="selectFlag" value="${flowCard.flowCardNo }">
									</td>
									<td width="88" class="rd8">
										<a href="#"
											onClick="window.open('flowcard/flow_card_detail.html', '������ϸ��Ϣ', 'width=800, height=400, scrollbars=no')">
											${flowCard.flowCardNo }</a>
									</td>
									<td width="158" class="rd8">
										${flowCard.client.clientId }
									</td>
									<td width="211" class="rd8">
										${flowCard.client.name }
									</td>
									<td width="198" class="rd8">
										${flowCard.recorder.USER_NAME }
									</td>
									<td width="197" class="rd8">
										<fmt:formatDate value="${flowCard.optDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
							</tr>
						</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="30" class="rd1">
					<tr>
						<td nowrap class="rd19" height="2" width="36%">
							<div align="left">
								&nbsp;��&nbsp;<font color="red">${pageModel.totalPages }</font>&nbsp;ҳ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								��ǰ��&nbsp;
								<font color="red">${pageModel.pageNo }</font>&nbsp;
								ҳ
							</div>
						</td>
						<td nowrap class="rd19" width="64%">
							<div align="right">
								<input name="btnTopPage" class="button1" type="button"
									id="btnTopPage" value="|&lt;&lt; " title="��ҳ"
									onClick="topPage()">
								<input name="btnPreviousPage" class="button1" type="button"
									id="btnPreviousPage" value=" &lt;  " title="��ҳ"
									onClick="previousPage()">
								<input name="btnNextPage" class="button1" type="button"
									id="btnNextPage" value="  &gt; " title="��ҳ"
									onClick="nextPage()">
								<input name="btnBottomPage" class="button1" type="button"
									id="btnBottomPage" value=" &gt;&gt;|" title="βҳ"
									onClick="bottomPage()">
								<input name="btnAdd" type="button" class="button1" id="btnAdd"
									value="���" onClick="addFlowCard()">
								<input name="btnDelete" class="button1" type="button"
									id="btnDelete" value="ɾ��" onclick="delFlowCard()">
								<input name="btnModify" class="button1" type="button"
									id="btnModify" value="�޸�">
								<input name="btnAudit" class="button1" type="button"
									id="btnAudit" value="����" onClick="auditFlowCard()">
							</div>
						</td>
					</tr>
				</table>
			</form>
			</div>
	</body>
</html>
