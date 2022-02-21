<%@page import="systemFiles.Constants"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
		+ request.getContextPath() + "/";
	String info = request.getParameter("info");//��ȡ��ʾ��Ϣ
%>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>����ά��</title>
<link rel="stylesheet" href="style/drp.css">
<script src="script/windows.js"></script>
<script type="text/javascript">
	var selectFlags = document.getElementsByName("selectFlag");//�õ�checkbox
	function addItem() {
		window.self.location = "servlet/item/ShowAddItemServlet";
	}

	//�ж�ѡ����Ϣ�����Ƿ�Ϸ�
	function modifyItem() {
		var count=0;
		var j=0;
		for (var i = 0; i < selectFlags.length; i++)
				if(selectFlags[i].checked)
					{
						j=i;
						count++;
					}
		if(count>1)
			{
				alert("ֻ��ѡ��һ����Ϣ�޸ģ�");
			}
		else if(count<1)
			{
				alert("��ѡ��һ���޸���Ϣ��");
			}
		else
			{
				window.self.location = "servlet/item/ShowModifyItemServlet?itemNo="+selectFlags[j].value;
			}
	}
	
	function topPage() {
		window.self.location="servlet/item/SearchItemServlet?pageNo=${pageModel.topPage}&itemNoOrName=${param.itemNoOrName}";
	}

	function previousPage() {
		window.self.location="servlet/item/SearchItemServlet?pageNo=${pageModel.previousPage}&itemNoOrName=${param.itemNoOrName}";
	}

	function nextPage() {
		window.self.location="servlet/item/SearchItemServlet?pageNo=${pageModel.nextPage}&itemNoOrName=${param.itemNoOrName}";
	}

	function bottomPage() {
		window.self.location="servlet/item/SearchItemServlet?pageNo=${pageModel.bottomPage}&itemNoOrName=${param.itemNoOrName}";
	}

	function checkAll() {

	}

	function uploadPic4Item() {
		var count=0;
		var j=0;
		for (var i = 0; i < selectFlags.length; i++)
				if(selectFlags[i].checked)
					{
						j=i;
						count++;
					}
		if(count>1)
			{
				alert("ֻ��ѡ��һ�������ϴ�ͼƬ��");
			}
		else if(count<1)
			{
				alert("��ѡ��Ҫ�ϴ�ͼƬ�����ϣ�");
			}
		else
			{
				window.self.location = "servlet/item/ShowItemUploadServlet?itemNo="+selectFlags[j].value;
			}
	}
	
	//�ж��û��Ƿ�ȷ��ɾ������
 	function validateForm(field){
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
				return false;
			}
		else if(window.confirm("�Ƿ�ȷ��ɾ��ѡ��������Ϣ��"))
				return true;
		return false;
	}
</script>
</head>

<body class="body1">
	<div align="center">
		<table width="95%" border="0" cellspacing="2" cellpadding="2">
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			height="8">
			<tr>
				<td width="522" class="p1" height="2" nowrap><img
					src="images/mark_arrow_02.gif" alt="��" width="14" height="14">
					&nbsp; <b>�������ݹ���&gt;&gt;����ά��</b></td>
			</tr>
		</table>
		<hr width="97%" align="center" size=0>
		<form name="itemForm" action="servlet/item/SearchItemServlet"
			method="post">
			<table width="95%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="17%" height="29">
						<div align="left">���ϴ���/����:</div>
					</td>
					<td width="57%"><input name="itemNoOrName" type="text"
						class="text1" id="clientId4" size="50" maxlength="50"
						value="${param.itemNoOrName }"></td>
					<td width="26%">
						<div align="left">
							<input name="btnQuery" type="submit" class="button1"
								id="btnQuery" value="��ѯ">
						</div>
					</td>
				</tr>
				<tr>
					<td height="16">
						<div align="right"></div>
					</td>
					<td>&nbsp;</td>
					<td>
						<div align="right"></div>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<form action="servlet/item/DeleteItemServlet" onsubmit="return validateForm(this)">
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			class="rd1" align="center">
			<tr>
				<td nowrap height="10" class="p2">������Ϣ</td>
				<td nowrap height="10" class="p3">&nbsp;<font color="red"><%=request.getParameter("errorMessage") == null ? "" : request.getParameter("errorMessage")%></font>
				</td>
			</tr>
		</table>
		<table width="95%" border="1" cellspacing="0" cellpadding="0"
			align="center" class="table1">
			<tr>
				<td width="35" class="rd6"><input type="checkbox" name="ifAll"
					onClick="checkAll()"></td>
				<td width="155" class="rd6">���ϴ���</td>
				<td width="155" class="rd6">��������</td>
				<td width="155" class="rd6">���Ϲ��</td>
				<td width="155" class="rd6">�����ͺ�</td>
				<td width="138" class="rd6">���</td>
				<td width="101" class="rd6">������λ</td>
			</tr>
			<c:forEach items="${pageModel.list }" var="item">
				<tr>
					<td class="rd8"><input type="checkbox" name="selectFlag"
						class="checkbox1" value="${item.no}"></td>
					<td class="rd8"><a href="#"
						onClick="window.open('item_detail.html', '������ϸ��Ϣ', 'width=400, height=400, scrollbars=no')">${item.no}</a>
					</td>
					<td class="rd8">${item.name}</td>
					<td class="rd8">${item.spec}</td>
					<td class="rd8">${item.pattern}</td>
					<td class="rd8">${item.itemCategory.NAME}</td>
					<td class="rd8">${item.itemUnit.NAME}</td>
				</tr>
			</c:forEach>
		</table>
		<table width="95%" height="30" border="0" align="center"
			cellpadding="0" cellspacing="0" class="rd1">
			<tr>
				<td nowrap class="rd19" height="2" width="36%">
					<div align="left">
						<font>&nbsp;��&nbsp;</font><font color="red">${pageModel.totalPages}&nbsp;</font><font>ҳ</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<font>��ǰ��</font>&nbsp; <font color="red">${pageModel.pageNo}</font>&nbsp;
						<font>ҳ</font>
					</div>
				</td>
				<td nowrap class="rd19" width="64%">
					<div align="right">
						<input name="btnTopPage" class="button1" type="button"
							id="btnTopPage" value="|&lt;&lt; " title="��ҳ" onClick="topPage()">
						<input name="btnPreviousPage" class="button1" type="button"
							id="btnPreviousPage" value=" &lt;  " title="��ҳ"
							onClick="previousPage()"> <input name="btnNextPage"
							class="button1" type="button" id="btnNextPage" value="  &gt; "
							title="��ҳ" onClick="nextPage()"> <input
							name="btnBottomPage" class="button1" type="button"
							id="btnBottomPage" value=" &gt;&gt;|" title="βҳ"
							onClick="bottomPage()"> <input name="btnAdd"
							type="button" class="button1" id="btnAdd" value="���"
							onClick="addItem()"> <input name="btnDelete"
							class="button1" type="submit" id="btnDelete" value="ɾ��"> 
							<input name="btnModify"
							class="button1" type="button" id="btnModify" value="�޸�"
							onClick="modifyItem()"> <input name="btnUpload"
							class="button1" type="button" id="btnUpload" value="�ϴ�ͼƬ"
							onClick="uploadPic4Item()">
					</div>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
<%
	if (info.equals(Constants.ADD)) {
%>
<script type="text/javascript">
	alert("������ϳɹ���");
</script>
<%
	} else if (info.equals(Constants.MODIFY)) {
%>
<script type="text/javascript">
	alert("�޸����ϳɹ���");
</script>
<%
	} else if(info.equals(Constants.DEL)){
%>
<script type="text/javascript">
	alert("ɾ�����ϳɹ���");
</script>
<%
	}else if(info.equals(Constants.UPLOAD)){
%>
<script type="text/javascript">
	alert("�ϴ�����ͼƬ�ɹ���");
</script>
<%
	}
%>