<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="sysMgr.domain.User" import="sysMgr.manager.UserManager" import="java.sql.Timestamp" import="java.util.Date" %>
<%
//	添加用户功能
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
			out.print("该用户"+userId+"已存在，添加失败！!");
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
			out.print("用户添加成功！");
		}
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>添加用户</title>
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
				//判断登录用户输入是否合法
				if(userID.value=="")
					{
						alert("用户代码不能为空！");
						userID.focus();
						return;
					}
				else if(!(/^[0-9A-Za-z]{4,6}$/.test(userID.value)))
					{
						alert("用户代码含有非法字符！或长度不在4-6个字符内！");
						userID.focus();
						return;
					}
				else if((userID.value.charAt(0)>'Z' && userID.value.charAt(0)<'a') || (userID.value.charAt(0)<'A') || userID.value.charAt(0)>"z")
					{
						alert("用户代码必须以字母开头！");
						userID.focus();
						return;
					}
				else if(userID.value.length<4 || userID.value.length>6)
					{
						alert("用户代码应该在4-6个字符！");
						userID.focus();
						return;
					}
				else if(userName.value=="")
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
				with (document.getElementById("userForm")){
					action="user_add.jsp";
					method="post";
					submit();
				}
			}
			function focus(){
				document.getElementById("userId").focus();
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
			//判断用户代码是否合法
			function checkuserId(field)
			{
				if(field.value=="")
					{
						document.getElementById("checkuerId").innerHTML="<font color=\"red\">用户代码不能为空！</font>";
						return;
					}
				else if(!(/^[0-9A-Za-z]{4,6}$/.test(field.value)))
					{
						document.getElementById("checkuerId").innerHTML="<font color=\"red\">用户代码含有非法字符或长度不在4-6个字符内！</font>";
						return;
					}
				else if((field.value.charAt(0)>'Z' && field.value.charAt(0)<'a') || (field.value.charAt(0)<'A') || field.value.charAt(0)>"z")
					{
						document.getElementById("checkuerId").innerHTML="<font color=\"red\">用户代码必须以字母开头！</font>";
						return;
					}
				else
				document.getElementById("checkuerId").innerHTML="<font color=\"red\"></font>";
				var xmlHttp;
				if(window.XMLHttpRequest) 
				{
					xmlHttp = new XMLHttpRequest();//表示当前浏览器不是ie
				} 
				else if (window.ActiveXObject) 
				{
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");//是ie
				}
				var url="userIDcheckRegular.jsp?userId="+field.value+"&time="+new Date().getTime();//传递time参数是为了防止浏览器缓存对Ajax验证造成影响！！
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
								document.getElementById("checkuerId").innerHTML="<font color=\"red\">"+xmlHttp.responseText+"!</font>";
							else
								document.getElementById("checkuerId").innerHTML="<font color=\"green\">√</font>";
									
							}
						else
								alert("请求失败！错误码："+xmlHttp.status);
					}	
				};
				//发送HTTP请求
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
							<b>系统管理&gt;&gt;用户维护&gt;&gt;添加</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="22%" height="29">
							<div align="right">
								<font color="#FF0000">*</font>用户代码:&nbsp;
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
								<font color="#FF0000">*</font>用户名称:&nbsp;
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
								<font color="#FF0000">*</font>密码:&nbsp;
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
								联系电话:&nbsp;
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
					<input name="btnAdd" class="button1" type="button" id="btnAdd" value="添加" onClick="addUser()">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack" value="返回" onClick="goBack()" />
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
							<b>系统管理&gt;&gt;用户维护&gt;&gt;添加</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="22%" height="29">
							<div align="right">
								<font color="#FF0000">*</font>用户代码:&nbsp;
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
								<font color="#FF0000">*</font>用户名称:&nbsp;
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
								<font color="#FF0000">*</font>密码:&nbsp;
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
								联系电话:&nbsp;
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
					<input name="btnAdd" class="button1" type="button" id="btnAdd" value="添加" onClick="addUser()">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack" value="返回" onClick="goBack()" />
				</div>
			</div>
		</form>
<%
		} 
%>
	</body>
</html>
