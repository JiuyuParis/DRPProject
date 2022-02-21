<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="dataDict.domain.ClientLevel" import="systemFiles.Constants" import="basedata.domain.Client" import="basedata.manager.ClientManager" import="dataDict.manager.DataDictManager" import="java.util.List"%>
<%@ page import="java.util.Date" %>
<%
	boolean sucess=false;//��ӽ����ʾ���־λ
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	int pid=Integer.parseInt(request.getParameter("pid"));
	if(Constants.ADD.equals(request.getParameter("add"))){
		Client client=new Client();
		client.setPid(pid);
		client.setName(request.getParameter("clientName"));
		client.setClientId(request.getParameter("clientId"));
		client.setBankNo(request.getParameter("bankAcctNo"));
		client.setTel(request.getParameter("contactTel"));
		client.setEms(request.getParameter("zipCode"));
		client.setIsLeaf(Constants.YES);
		client.setIsClient(Constants.YES);
		ClientLevel cl= new ClientLevel();
		cl.setDICT_ID(request.getParameter("clientLevel"));
		client.setClientLevel(cl);
		ClientManager.getInstance().addClientOrRegion(client);//�������
		sucess=true;
	}
	List<ClientLevel> levelList=DataDictManager.getInstance().findClientLevelList();//��ȡ�����̵ȼ��б�
%>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>��ӷ�����</title>
		<link rel="stylesheet" href="style/drp.css">
		<script src="script/client_validate.js"></script>
		<script type="text/javascript">
			function validateClientId(field){
				var xmlHttp=null
				//��ʾ��ǰ���������ie,��ns,firefox
				if(window.XMLHttpRequest) {
					xmlHttp = new XMLHttpRequest();
				} else if (window.ActiveXObject) {
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				}
				 var url="basedata/clientIdValidate.jsp?clientId="+trim(field.value)+"&time="+new Date().getTime();//Ҫ������֤�ĵ�ַ
				 xmlHttp.open("get",url,true);//������
				 //�ص�����
				 xmlHttp.onreadystatechange=function(){
					 if(xmlHttp.readyState==4){
						 if(xmlHttp.status==200){
							if(trim(xmlHttp.responseText)!="")
								 document.getElementById("clientIdSpan").innerHTML="<font color='red'>"+xmlHttp.responseText+"</font>";
							else
								document.getElementById("clientIdSpan").innerHTML="<font color='green'>��</font>";
						 }
						 else
							 alert("����ʧ�ܣ������롾"+xmlHttp.status+"��");
					 }
				 };
				 xmlHttp.send(null);  //��������
			}
			function validateClientName(field){
				if(field.value==""){
					document.getElementById("clientNameSpan").innerHTML="<font color='red'>���������Ʋ���Ϊ��</font>";
				}
				else{
					document.getElementById("clientNameSpan").innerHTML="<font color='green'>��</font>";
				}
			}
			function validateForm(field){
				if(document.getElementById("clientId").value==""){
					alert("�����̴��벻��Ϊ�գ�");
					return false;
				}
				if(document.getElementById("clientName").value==""){
					alert("���������Ʋ���Ϊ�գ�");
					return false;
				}
				return true;
			}
		</script>
	</head>

	<body class="body1">
		<form name="form1" action="basedata/client_add.jsp" onsubmit="return validateForm(this)" method="post">
			<div align="center">
			<input type="hidden" name="pid" value="<%=pid%>">
			<input type="hidden" name="add" value="<%=Constants.ADD %>"/>
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
							<b>�������ݹ���&gt;&gt;������ά��&gt;&gt;��ӷ�����</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="22%" height="29">
							<div align="right">
								<font color="#FF0000">*</font>�����̴���:&nbsp;
							</div>
						</td>
						<td width="78%">
							<input name="clientId" type="text" class="text1" id="clientId"
								size="10" maxlength="10" onblur="validateClientId(this)">
							<span id="clientIdSpan"></span>
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
								id="clientName" size="40" maxlength="40" onblur="validateClientName(this)">
							<span id="clientNameSpan"></span>
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
									for(int i=0;i<levelList.size();i++){
										ClientLevel cle=levelList.get(i);
								%>
								<option value="<%=cle.getDICT_ID()%>"><%=cle.getNAME() %></option>
								<%
									}
								%>
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
								id="bankAcctNo" size="10" maxlength="10">
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
								id="contactTel" size="10" maxlength="10">
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
								size="10" maxlength="10">
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
								size="10" maxlength="10">
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="submit" id="btnAdd"
						value="���">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="����" onclick="history.go(-1)" />
				</div>
			</div>
		</form>
	</body>
</html>
<%
	if(sucess){
%>
<script type="text/javascript">
	alert("��ӷ����̳ɹ���");
	window.parent.clientTreeFrame.location.reload();
</script>
<%
	}
%>