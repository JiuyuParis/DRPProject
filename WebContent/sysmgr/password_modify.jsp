<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="sysMgr.manager.*" import="java.util.List"  import="sysMgr.domain.User"%>
<%
	User user=(User)session.getAttribute("userInfo");
	if("modifyPW".equals(request.getParameter("command")))
	{
		user.setPASSWORD(request.getParameter("newPassword"));
		UserManager.getInstance().modifyUser(user);
		session.removeAttribute("userInfo");
		session.setAttribute("userInfo", user);
		out.print("�޸�����ɹ���");
	}
	
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>�޸�����</title>
		<script src="../script/client_validate.js"></script>
		<link rel="stylesheet" href="../style/drp.css">
		<script type="text/javascript">
		var checkOldPw=true;
	//��Ӧ�޸İ�ť
	function modifyPasword() {
		if(document.getElementById("oldPassword").value=="")
			{
				alert("ԭ���벻��Ϊ�գ�");
				return;
			}
		else if(!checkOldPw)
			{
			alert("ԭ���벻��ȷ��");
			return;
			}
		else if(document.getElementById("newPassword").value=="")
			{
				alert("���벻��Ϊ�գ�");
				password.focus();
				return;
			}
		else if(document.getElementById("newPassword").value.length<6)
		{
			alert("��������6λ��");
			password.focus();
			return;
		}
		else if(document.getElementById("affirmNewPassowrd").value!=document.getElementById("newPassword").value)
			{
				alert("�������벻һ�£�");
				return;
			}
		with (document.getElementById("userForm"))
		{
			method="post";
			action="password_modify.jsp";
			submit();
		}
	}
	//�ж�����ԭ�����Ƿ���ȷ
	function judgeOldPassword(field)
	{
		if(field.value=="")
			{
				document.getElementById("checkOld").innerHTML="<font color=\"red\">ԭ���벻��Ϊ�գ�</font>";
			}
		else
		{
			//����XMLHttpRequest����
			var xmlHttp;
			if(window.XMLHttpRequest) 
			{
				xmlHttp = new XMLHttpRequest();//��ʾ��ǰ���������ie
			} 
			else if (window.ActiveXObject) 
			{
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");//��ie
			}
			var url="checkPassword.jsp?password="+field.value+"&time="+new Date().getTime();
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
							{
							document.getElementById("checkOld").innerHTML="<font color=\"red\">"+xmlHttp.responseText+"</font>";
							checkOldPw=false;
							}
						else
							{
							document.getElementById("checkOld").innerHTML="<font color=\"red\"></font>"; 
							checkOldPw=true;
							}
						}
					else
							alert("����ʧ�ܣ������룺"+xmlHttp.status);
				}	
			};
			//����HTTP����
			xmlHttp.send(null);
		}
	}
	//�����������Ƿ�Ϸ�
	function judgeNewPassword(field)
	{
		if(field.value=="")
			document.getElementById("checkNewOne").innerHTML="<font color=\"red\">���벻��Ϊ�գ�</font>";
		else if(field.value.length<6)
				document.getElementById("checkNewOne").innerHTML="<font color=\"red\">��������6λ��</font>";
		else
			document.getElementById("checkNewOne").innerHTML="<font color=\"red\"></font>";
	}
	//ȷ����������һ��
	function configPassword(field)
	{
		if(field.value!=document.getElementById("newPassword").value)
			document.getElementById("checkNewTwo").innerHTML="<font color=\"red\">�����������벻һ�£�</font>";
	}
</script>
	</head>

	<body class="body1">
		<form name="userForm" id="userForm">
			<input type="hidden" name="command" value="modifyPW">
			<div align="center">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					height="51">
					<tr>
						<td class="p1" height="16" nowrap>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td class="p1" height="35" nowrap>
							&nbsp&nbsp
							<img src="../images/mark_arrow_02.gif" width="14" height="14">
							<b><strong>ϵͳ����&gt;&gt;</strong>�޸�����</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				<table width="50%" height="91" border="0" cellpadding="0"
					cellspacing="0">
					<tr>
						<td height="30" width="22%">
							<div align="right">
								<font color="#FF0000">*</font>ԭ����:
							</div>
						</td>
						<td width="78%">
							<input name="oldPassword" type="password" class="text1"
								id="oldPassword" size="25" onblur="judgeOldPassword(this)">
							<span id="checkOld"></span>
						</td>
					</tr>
					<tr>
						<td height="27" width="22%">
							<div align="right">
								<font color="#FF0000">*</font>������:
							</div>
						</td>
						<td width="78%">
							<input name="newPassword" type="password" class="text1"
								id="newPassword" size="25" onblur="judgeNewPassword(this)">
							<span id="checkNewOne"></span>
						</td>
					</tr>
					<tr>
						<td height="34" width="22%">
							<div align="right">
								<font color="#FF0000">*</font>ȷ������:
							</div>
						</td>
						<td width="78%">
							<input name="affirmNewPassowrd" type="password" class="text1"
								id="affirmNewPassowrd" size="25" onblur="configPassword(this)">
							<span id="checkNewTwo"></span>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				<p>
					<input name="btnModify" class="button1" type="button"
						id="btnModify" value="�޸�" onClick="modifyPasword()">
					&nbsp; &nbsp;&nbsp;
				</p>
			</div>
		</form>
	</body>
</html>
