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
		out.print("修改密码成功！");
	}
	
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>修改密码</title>
		<script src="../script/client_validate.js"></script>
		<link rel="stylesheet" href="../style/drp.css">
		<script type="text/javascript">
		var checkOldPw=true;
	//相应修改按钮
	function modifyPasword() {
		if(document.getElementById("oldPassword").value=="")
			{
				alert("原密码不能为空！");
				return;
			}
		else if(!checkOldPw)
			{
			alert("原密码不正确！");
			return;
			}
		else if(document.getElementById("newPassword").value=="")
			{
				alert("密码不能为空！");
				password.focus();
				return;
			}
		else if(document.getElementById("newPassword").value.length<6)
		{
			alert("密码至少6位！");
			password.focus();
			return;
		}
		else if(document.getElementById("affirmNewPassowrd").value!=document.getElementById("newPassword").value)
			{
				alert("两次密码不一致！");
				return;
			}
		with (document.getElementById("userForm"))
		{
			method="post";
			action="password_modify.jsp";
			submit();
		}
	}
	//判断输入原密码是否正确
	function judgeOldPassword(field)
	{
		if(field.value=="")
			{
				document.getElementById("checkOld").innerHTML="<font color=\"red\">原密码不能为空！</font>";
			}
		else
		{
			//构建XMLHttpRequest对象
			var xmlHttp;
			if(window.XMLHttpRequest) 
			{
				xmlHttp = new XMLHttpRequest();//表示当前浏览器不是ie
			} 
			else if (window.ActiveXObject) 
			{
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");//是ie
			}
			var url="checkPassword.jsp?password="+field.value+"&time="+new Date().getTime();
			//初始化一个新的Http请求
			xmlHttp.open("get",url,true);
			//将callback地址给onreadystatechange属性，拿到响应去验证
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
							alert("请求失败！错误码："+xmlHttp.status);
				}	
			};
			//发送HTTP请求
			xmlHttp.send(null);
		}
	}
	//检验新密码是否合法
	function judgeNewPassword(field)
	{
		if(field.value=="")
			document.getElementById("checkNewOne").innerHTML="<font color=\"red\">密码不能为空！</font>";
		else if(field.value.length<6)
				document.getElementById("checkNewOne").innerHTML="<font color=\"red\">密码至少6位！</font>";
		else
			document.getElementById("checkNewOne").innerHTML="<font color=\"red\"></font>";
	}
	//确认两次密码一致
	function configPassword(field)
	{
		if(field.value!=document.getElementById("newPassword").value)
			document.getElementById("checkNewTwo").innerHTML="<font color=\"red\">两次输入密码不一致！</font>";
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
							<b><strong>系统管理&gt;&gt;</strong>修改密码</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				<table width="50%" height="91" border="0" cellpadding="0"
					cellspacing="0">
					<tr>
						<td height="30" width="22%">
							<div align="right">
								<font color="#FF0000">*</font>原密码:
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
								<font color="#FF0000">*</font>新密码:
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
								<font color="#FF0000">*</font>确认密码:
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
						id="btnModify" value="修改" onClick="modifyPasword()">
					&nbsp; &nbsp;&nbsp;
				</p>
			</div>
		</form>
	</body>
</html>
