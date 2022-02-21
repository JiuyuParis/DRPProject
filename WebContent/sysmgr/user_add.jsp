<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="sysMgr.domain.User" import="sysMgr.manager.UserManager" import="java.sql.Timestamp" import="java.util.Date" %>
<%
//	����û�����
	//request.setCharacterEncoding("GB18030");
	String save=request.getParameter("save");
		String userId="";
		String userName="";
		String contactTel="";
		String email="";
		Boolean flag=false;
	if("add".equals(save))
	{
		User user=new User();
		user.setUSER_ID(request.getParameter("userId"));
		if(UserManager.getInstance().Query(user)!=null)
		{
			flag=false;
			out.print("���û�"+userId+"�Ѵ��ڣ����ʧ�ܣ�!");
		}
		else
		{
			flag=true;
			user.setUSER_NAME(request.getParameter("userName"));
			user.setPASSWORD(request.getParameter("password"));
			user.setCONTACT_TEL(request.getParameter("contactTel"));
			user.setEMAIL(request.getParameter("email"));
			user.setCREATE_DATE(new Timestamp(new Date().getTime()));
			UserManager.getInstance().addUser(user);
			out.print("�û���ӳɹ���");
		}
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>����û�</title>
		<link rel="stylesheet" href="../style/drp.css">
		<script src="../script/client_validate.js"></script>
		<script type="text/javascript">
			function goBack() {
				window.self.location = "user_maint.jsp"
			}

			function addUser() {
				var userID=document.getElementById("userId");
				var userName=document.getElementById("userName");
				var password=document.getElementById("password");
				var contactTel=document.getElementById("contactTel");
				var email=document.getElementById("email");
				//�жϵ�¼�û������Ƿ�Ϸ�
				if(userID.value=="")
					{
						alert("�û����벻��Ϊ�գ�");
						userID.focus();
						return;
					}
				else if(!(/^[0-9A-Za-z]{4,6}$/.test(userID.value)))
					{
						alert("�û����뺬�зǷ��ַ����򳤶Ȳ���4-6���ַ��ڣ�");
						userID.focus();
						return;
					}
				else if((userID.value.charAt(0)>'Z' && userID.value.charAt(0)<'a') || (userID.value.charAt(0)<'A') || userID.value.charAt(0)>"z")
					{
						alert("�û������������ĸ��ͷ��");
						userID.focus();
						return;
					}
				else if(userID.value.length<4 || userID.value.length>6)
					{
						alert("�û�����Ӧ����4-6���ַ���");
						userID.focus();
						return;
					}
				else if(userName.value=="")
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
				with (document.getElementById("userForm")){
					action="user_add.jsp";
					method="post";
					submit();
				}
			}
			function focus(){
				document.getElementById("userId").focus();
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
			//�ж��û������Ƿ�Ϸ�
			function checkuserId(field)
			{
				if(field.value=="")
					{
						document.getElementById("checkuerId").innerHTML="<font color=\"red\">�û����벻��Ϊ�գ�</font>";
						return;
					}
				else if(!(/^[0-9A-Za-z]{4,6}$/.test(field.value)))
					{
						document.getElementById("checkuerId").innerHTML="<font color=\"red\">�û����뺬�зǷ��ַ��򳤶Ȳ���4-6���ַ��ڣ�</font>";
						return;
					}
				else if((field.value.charAt(0)>'Z' && field.value.charAt(0)<'a') || (field.value.charAt(0)<'A') || field.value.charAt(0)>"z")
					{
						document.getElementById("checkuerId").innerHTML="<font color=\"red\">�û������������ĸ��ͷ��</font>";
						return;
					}
				else
				document.getElementById("checkuerId").innerHTML="<font color=\"red\"></font>";
				var xmlHttp;
				if(window.XMLHttpRequest) 
				{
					xmlHttp = new XMLHttpRequest();//��ʾ��ǰ���������ie
				} 
				else if (window.ActiveXObject) 
				{
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");//��ie
				}
				var url="userIDcheckRegular.jsp?userId="+field.value+"&time="+new Date().getTime();//����time������Ϊ�˷�ֹ����������Ajax��֤���Ӱ�죡��
				//��ʼ��һ���µ�Http����
				xmlHttp.open("get",url,true);
				//��callback��ַ��onreadystatechange���ԣ��õ���Ӧȥ��֤
				xmlHttp.onreadystatechange=function()
				{
					if(xmlHttp.readyState==4)
					{
						if(xmlHttp.status==200)
							{
							if(trim(xmlHttp.responseText)!="")
								document.getElementById("checkuerId").innerHTML="<font color=\"red\">"+xmlHttp.responseText+"!</font>";
							else
								document.getElementById("checkuerId").innerHTML="<font color=\"green\">��</font>";
									
							}
						else
								alert("����ʧ�ܣ������룺"+xmlHttp.status);
					}	
				};
				//����HTTP����
				xmlHttp.send(null);
			}
		</script>
	</head>

	<body class="body1" onload="focus()">
<% 
	if(flag==false)
		{
%>
		<form name="userForm" target="_self" id="userForm">
			<div align="center">
				<table width="95%" border="0" cellspacing="2" cellpadding="2">
					<tr>
						<td>&nbsp;

						</td>
					</tr>
				</table>
				<table width="95%" border="0" cellspacing="0" cellpadding="0" height="25">
					<tr>
						<td width="522" class="p1" height="25" nowrap>
							<img src="../images/mark_arrow_03.gif" width="14" height="14">
							&nbsp;
							<b>ϵͳ����&gt;&gt;�û�ά��&gt;&gt;���</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="22%" height="29">
							<div align="right">
								<font color="#FF0000">*</font>�û�����:&nbsp;
							</div>
						</td>
						<td width="78%">
							<input name="userId" type="text" class="text1" id="userId" size="10" maxlength="10" onkeypress="userIDonkeypress()" value="<%=userId %>" onblur="checkuserId(this)" >
							<span id="checkuerId"></span>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								<font color="#FF0000">*</font>�û�����:&nbsp;
							</div>
						</td>
						<td>
							<input name="userName" type="text" class="text1" id="userName" size="20" maxlength="20" value="<%=userName %>" onblur="checkuserName(this)" >
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
								<input name="password" type="password" class="text1" id="password" size="20" maxlength="20" onblur="checkpassword(this)" >
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
							<input name="contactTel" type="text" class="text1" id="contactTel" size="20" maxlength="20" value="<%=contactTel %>" onblur="checkcontactTel(this)" >
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
							<input name="email" type="text" class="text1" id="email" size="20" maxlength="20" value="<%=email %>" onblur="checkemail(this)" >
							<span id="checkemail"></span>
						</td>
						<td>
							<input type="hidden" name="save" value="add"  >
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="button" id="btnAdd" value="���" onClick="addUser()">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack" value="����" onClick="goBack()" />
				</div>
			</div>
		</form>
<%
		}
	else
	{
%>
		<form name="userForm" target="_self" id="userForm">
			<div align="center">
				<table width="95%" border="0" cellspacing="2" cellpadding="2">
					<tr>
						<td>&nbsp;

						</td>
					</tr>
				</table>
				<table width="95%" border="0" cellspacing="0" cellpadding="0" height="25">
					<tr>
						<td width="522" class="p1" height="25" nowrap>
							<img src="../images/mark_arrow_03.gif" width="14" height="14">
							&nbsp;
							<b>ϵͳ����&gt;&gt;�û�ά��&gt;&gt;���</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="22%" height="29">
							<div align="right">
								<font color="#FF0000">*</font>�û�����:&nbsp;
							</div>
						</td>
						<td width="78%">
							<input name="userId" type="text" class="text1" id="userId" size="10" maxlength="10" onkeypress="userIDonkeypress()" onblur="checkuserId(this)" >
							<span id="checkuerId"></span>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								<font color="#FF0000">*</font>�û�����:&nbsp;
							</div>
						</td>
						<td>
							<input name="userName" type="text" class="text1" id="userName" size="20" maxlength="20" onblur="checkuserName(this)" >
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
								<input name="password" type="password" class="text1" id="password" size="20" maxlength="20" onblur="checkpassword(this)" >
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
							<input name="contactTel" type="text" class="text1" id="contactTel" size="20" maxlength="20" onblur="checkcontactTel(this)" >
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
							<input name="email" type="text" class="text1" id="email" size="20" maxlength="20" onblur="checkemail(this)" >
							<span id="checkemail"></span>
						</td>
						<td>
							<input type="hidden" name="save" value="add"  >
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="button" id="btnAdd" value="���" onClick="addUser()">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack" value="����" onClick="goBack()" />
				</div>
			</div>
		</form>
<%
		} 
%>
	</body>
</html>
