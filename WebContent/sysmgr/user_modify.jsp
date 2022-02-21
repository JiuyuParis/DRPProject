<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="sysMgr.manager.UserManager" import="java.util.List" import="sysMgr.domain.User" import="java.sql.Timestamp" import="java.util.Date" %>
<%
	//request.setCharacterEncoding("GB18030");
	String command=request.getParameter("command");
	String userId=request.getParameter("userId");//��user_maint.jsp���õ�userId
	User user=new User();
	user.setUSER_ID(userId);
	if("modify".equals(command))
	{
		user.setUSER_NAME(request.getParameter("userName"));
		user.setPASSWORD(request.getParameter("password"));
		user.setCONTACT_TEL(request.getParameter("contactTel"));
		user.setEMAIL(request.getParameter("email"));
		user.setCREATE_DATE(new Timestamp(new Date().getTime()));
		UserManager.getInstance().modifyUser(user);
		out.println("�޸ĳɹ���");
	}
	List<User> userList=UserManager.getInstance().Query(user);//���޸ĵ��û���ѯ����
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>�޸��û�</title>
		<link rel="stylesheet" href="../style/drp.css">
		<script src="../script/client_validate.js"></script>
		<script type="text/javascript">
	function goBack() {
		window.self.location ="user_maint.jsp";
	}
	//�ж��û������Ƿ�Ϸ�
	function checkuserName(field)
	{
		if(field.value=="")
			document.getElementById("checkuserName").innerHTML="<font color=\"red\">�û����Ʋ���Ϊ�գ�</font>";
		else
			document.getElementById("checkuserName").innerHTML="<font color=\"red\"></font>";	
	}
	//�ж������Ƿ�Ϸ�
	function checkpassword(field)
	{
		if(field.value=="")
				document.getElementById("checkpassword").innerHTML="<font color=\"red\">���벻��Ϊ�գ�</font>";
		else if(field.value.length<6)
				document.getElementById("checkpassword").innerHTML="<font color=\"red\">��������6λ��</font>";
		else
			document.getElementById("checkpassword").innerHTML="<font color=\"red\"></font>";
	}
	//�ж��ֻ����Ƿ�Ϸ�
	function checkcontactTel(field)
	{
		if(field.value!="")
		{
			if(!(/^[0-9]{11}$/.test(field.value)))
					document.getElementById("checkcontactTel").innerHTML="<font color=\"red\">��������ȷ���ֻ��ţ�</font>";
			else
				document.getElementById("checkcontactTel").innerHTML="<font color=\"red\"></font>";
		}
	}
	//�ж������Ƿ�Ϸ�
	function checkemail(field)
	{
		if(field.value.length!=0)
		{
			if(!(/[0-9A-Za-z]+@[0-9A-Za-z]+[.]com/.test(field.value)))
					document.getElementById("checkemail").innerHTML="<font color=\"red\">��������ȷ�����䣡</font>";
			else
					document.getElementById("checkemail").innerHTML="<font color=\"red\"></font>";
		}
	}
 	function modifyUser() {
		var userName=document.getElementById("userName");
		var password=document.getElementById("password");
		var contactTel=document.getElementById("contactTel");
		var email=document.getElementById("email");
		//�жϵ�¼�û������Ƿ�Ϸ�
		if(userName.value=="")
			{
				alert("�û����Ʋ���Ϊ�գ�");
				userName.focus();
				return;
			}
		else if(password.value=="")
			{
				alert("���벻��Ϊ�գ�");
				password.focus();
				return;
			}
		else if(password.value.length<6)
			{
				alert("��������6λ��");
				password.focus();
				return;
			}
		else if(contactTel.value!="")
			{
				if(!(/^[0-9]{11}$/.test(contactTel.value)))
					{
						alert("��������ȷ���ֻ��ţ�");
						contactTel.focus();
						return;
					}
			}
		if(email.value.length!=0)
			{
				if(!(/[0-9A-Za-z]+@[0-9A-Za-z]+[.]com/.test(email.value)))
					{
						alert("��������ȷ�����䣡");
						email.focus();
						return;
					}
			}
 		with (document.getElementById("userForm"))
 		{
 			action="user_modify.jsp?command=modify";
 			method="post";
 			submit();
 		}
	} 
</script>

	</head>

	<body class="body1">
		<form name="userForm" id="userForm">
			<div align="center">
				<table width="95%" border="0" cellspacing="2" cellpadding="2">
					<tr>
						<td>&nbsp;
							
						</td>
					</tr>
				</table>
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="25">
					<tr>
						<td width="522" class="p1" height="25" nowrap>
							<img src="../images/mark_arrow_03.gif" width="14" height="14">
							&nbsp;
							<b>ϵͳ����&gt;&gt;�û�ά��&gt;&gt;�޸�</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="22%" height="29">
							<div align="right">
								�û�����:&nbsp;
							</div>
						</td>
						<td width="78%">
							<input name="userId" type="text" class="text1" id="userId"
								size="10" maxlength="10" readonly="true" value="<%=userList.get(0).getUSER_ID() %>">
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								<font color="#FF0000">*</font>�û�����:&nbsp;
							</div>
						</td>
						<td>
							<input name="userName" type="text" class="text1" id="userName" value="<%=userList.get(0).getUSER_NAME() %>"
								size="20" maxlength="20" onblur="checkuserName(this)">
								<span id="checkuserName"></span>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								<font color="#FF0000">*</font>����:&nbsp;
							</div>
						</td>
						<td>
							<label>
								<input name="password" type="password" class="text1"
									id="password" size="20" maxlength="20" value="<%=userList.get(0).getPASSWORD() %>" onblur="checkpassword(this)" >
									<span id="checkpassword"></span>
							</label>
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
								id="contactTel" size="20" maxlength="20" value="<%=userList.get(0).getCONTACT_TEL() %>" onblur="checkcontactTel(this)" >
								<span id="checkcontactTel"></span>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								email:&nbsp;
							</div>
						</td>
						<td>
							<input name="email" type="text" class="text1" id="email"
								size="20" maxlength="20" value="<%=userList.get(0).getEMAIL() %>" onblur="checkemail(this)" >
								<span id="checkemail"></span>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnModify" class="button1" type="button"
						id="btnModify" value="�޸�" onClick="modifyUser()">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="����" onClick="goBack()" />
				</div>
			</div>
		</form>
	</body>
</html>
