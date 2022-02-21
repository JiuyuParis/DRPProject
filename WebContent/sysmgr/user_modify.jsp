<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="sysMgr.manager.UserManager" import="java.util.List" import="sysMgr.domain.User" import="java.sql.Timestamp" import="java.util.Date" %>
<%
	//request.setCharacterEncoding("GB18030");
	String command=request.getParameter("command");
	String userId=request.getParameter("userId");//从user_maint.jsp中拿到userId
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
		out.println("修改成功！");
	}
	List<User> userList=UserManager.getInstance().Query(user);//将修改的用户查询出来
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>修改用户</title>
		<link rel="stylesheet" href="../style/drp.css">
		<script src="../script/client_validate.js"></script>
		<script type="text/javascript">
	function goBack() {
		window.self.location ="user_maint.jsp";
	}
	//判断用户名称是否合法
	function checkuserName(field)
	{
		if(field.value=="")
			document.getElementById("checkuserName").innerHTML="<font color=\"red\">用户名称不能为空！</font>";
		else
			document.getElementById("checkuserName").innerHTML="<font color=\"red\"></font>";	
	}
	//判断密码是否合法
	function checkpassword(field)
	{
		if(field.value=="")
				document.getElementById("checkpassword").innerHTML="<font color=\"red\">密码不能为空！</font>";
		else if(field.value.length<6)
				document.getElementById("checkpassword").innerHTML="<font color=\"red\">密码至少6位！</font>";
		else
			document.getElementById("checkpassword").innerHTML="<font color=\"red\"></font>";
	}
	//判断手机号是否合法
	function checkcontactTel(field)
	{
		if(field.value!="")
		{
			if(!(/^[0-9]{11}$/.test(field.value)))
					document.getElementById("checkcontactTel").innerHTML="<font color=\"red\">请输入正确的手机号！</font>";
			else
				document.getElementById("checkcontactTel").innerHTML="<font color=\"red\"></font>";
		}
	}
	//判断邮箱是否合法
	function checkemail(field)
	{
		if(field.value.length!=0)
		{
			if(!(/[0-9A-Za-z]+@[0-9A-Za-z]+[.]com/.test(field.value)))
					document.getElementById("checkemail").innerHTML="<font color=\"red\">请输入正确的邮箱！</font>";
			else
					document.getElementById("checkemail").innerHTML="<font color=\"red\"></font>";
		}
	}
 	function modifyUser() {
		var userName=document.getElementById("userName");
		var password=document.getElementById("password");
		var contactTel=document.getElementById("contactTel");
		var email=document.getElementById("email");
		//判断登录用户输入是否合法
		if(userName.value=="")
			{
				alert("用户名称不能为空！");
				userName.focus();
				return;
			}
		else if(password.value=="")
			{
				alert("密码不能为空！");
				password.focus();
				return;
			}
		else if(password.value.length<6)
			{
				alert("密码至少6位！");
				password.focus();
				return;
			}
		else if(contactTel.value!="")
			{
				if(!(/^[0-9]{11}$/.test(contactTel.value)))
					{
						alert("请输入正确的手机号！");
						contactTel.focus();
						return;
					}
			}
		if(email.value.length!=0)
			{
				if(!(/[0-9A-Za-z]+@[0-9A-Za-z]+[.]com/.test(email.value)))
					{
						alert("请输入正确的邮箱！");
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
							<b>系统管理&gt;&gt;用户维护&gt;&gt;修改</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="22%" height="29">
							<div align="right">
								用户代码:&nbsp;
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
								<font color="#FF0000">*</font>用户名称:&nbsp;
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
								<font color="#FF0000">*</font>密码:&nbsp;
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
								联系电话:&nbsp;
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
						id="btnModify" value="修改" onClick="modifyUser()">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="返回" onClick="goBack()" />
				</div>
			</div>
		</form>
	</body>
</html>
