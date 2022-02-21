<%@page import="common.PageModel"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="sysMgr.manager.UserManager" import="java.util.List" import="sysMgr.domain.User" import="java.util.Iterator" %>
<%
	String command=request.getParameter("command");
	String[] userIds=request.getParameterValues("selectFlag");
	if("delete".equals(command))
	{
		UserManager.getInstance().deleteUser3(userIds);
		out.print("ɾ���ɹ���");
	}
	int pageNo=1,pageSize=4;//����ҳ�ţ�ÿҳ��С
	String toPage=request.getParameter("pageNo");
	if(toPage!=null)
		pageNo=Integer.parseInt(toPage);
	PageModel<User> pageModel=UserManager.getInstance().getUserList(pageNo, pageSize);
	List<User> userList=pageModel.getList();
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>�û�ά��</title>
		<link rel="stylesheet" href="../style/drp.css">
		<script type="text/javascript">
			var selectFlags = document.getElementsByName("selectFlag");
			function addUser() {
				window.self.location = "user_add.jsp";
			}

			function modifyUser() {
				//�ж�ѡ����Ϣ�����Ƿ�Ϸ�
				var count=0;
				var j=0;
				for (var i = 0; i < selectFlags.length; i++)
						if(selectFlags[i].checked)
							{
								j=i
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
						window.self.location = "user_modify.jsp?userId="+selectFlags[j].value;
					}
			}

			function deleteUser() {
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
				else if(window.confirm("ȷ��Ҫɾ����ѡ�û���¼��"))
				{
					with (document.getElementById("userform"))
					{
						method="post";
						action="user_maint.jsp?command=delete";
						submit();
					} 
				}
			}
			
			//ѡ��ȫ����Ϣ��Ŀ
			function checkAll(field) {
				var selectFlags = document.getElementsByName("selectFlag");
				for (var i = 0; i < selectFlags.length; i++)
					selectFlags[i].checked = field.checked;
			}
			var pageNo=<%=pageModel.getPageNo() %>
			function topPage() {
				if(pageNo<=1)
					{
						docmment.getElementById("btnTopPage").disabled;
						docmment.getElementById("btnPreviousPage").disabled;
					}
				else
					window.self.location="user_maint.jsp?pageNo=<%=pageModel.getTopPage() %>";
			}

			function previousPage() {
				if(pageNo<=1)
					{
						docmment.getElementById("btnTopPage").disabled;
						docmment.getElementById("btnPreviousPage").disabled;
					}
				else
					window.self.location="user_maint.jsp?pageNo=<%=pageModel.getPreviousPage() %>";
			}

			function nextPage() {
				if(pageNo>=<%=pageModel.getTotalPages() %>)
					{
						docmment.getElementById("btnNextPage").disabled;
						docmment.getElementById("btnBottomPage").disabled;
					}
				else
					window.self.location="user_maint.jsp?pageNo=<%=pageModel.getNextPage() %>";
			}

			function bottomPage() {
				if(pageNo>=<%=pageModel.getTotalPages() %>)
				{
					docmment.getElementById("btnNextPage").disabled;
					docmment.getElementById("btnBottomPage").disabled;
				}
				else
					window.self.location="user_maint.jsp?pageNo=<%=pageModel.getBottomPage() %>";
			}
			
		</script>
	</head>

	<body class="body1">
		<form name="userform" id="userform">
			<div align="center">
				<table width="95%" border="0" cellspacing="0" cellpadding="0" height="35">
					<tr>
						<td class="p1" height="18" nowrap>&nbsp;

						</td>
					</tr>
					<tr>
						<td width="522" class="p1" height="17" nowrap>
							<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>ϵͳ����&gt;&gt;�û�ά��</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
			</div>
			<table width="95%" height="20" border="0" align="center" cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF">��ѯ�б�</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0" align="center" class="table1">
				<tr>
					<td width="55" class="rd6">
						<input type="checkbox" name="ifAll" onClick="checkAll(this)">
					</td>
					<td width="119" class="rd6">
						�û�����
					</td>
					<td width="152" class="rd6">
						�û�����
					</td>
					<td width="166" class="rd6">
						��ϵ�绰
					</td>
					<td width="150" class="rd6">
						email
					</td>
					<td width="153" class="rd6">
						��������
					</td>
				</tr>
				<%
					if(userList!=null)
						//ѭ�������ж��Ƿ�Ϊroot�˻������Ϊroot�˻����ֹѡ�С�
						for(Iterator<User> iter=userList.iterator();iter.hasNext();)
						{
							User user=(User)iter.next();
							String disabledString="";
							if(user.getUSER_ID().equals("root"))
								disabledString="disabled";
				%>
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" id="selectFlag" class="checkbox1" value="<%=user.getUSER_ID() %>" <%=disabledString %>>
					</td>
					<td class="rd8">
						<%=user.getUSER_ID() %>
					</td>
					<td class="rd8"><%=user.getUSER_NAME() %></td>
					<td class="rd8">
						<%=user.getCONTACT_TEL() %>
					</td>
					<td class="rd8">
						<%=user.getEMAIL() %>
					</td>
					<td class="rd8">
						<%=user.getCREATE_DATE() %>
					</td>
				</tr>
				<%
						}
				%>
			</table>
			<table width="95%" height="30" border="0" align="center" cellpadding="0" cellspacing="0" class="rd1">
				<tr>
					<td nowrap class="rd19" height="2">
						<div align="left">
							<font color="black">��&nbsp;<font color="red"><%=pageModel.getTotalPages() %></font>&nbsp;ҳ&nbsp;&nbsp;</font>
							<font color="black">��ǰ��&nbsp;<font color="red"><%=pageNo %></font>&nbsp;ҳ</font>
						</div>
					</td>
					<td nowrap class="rd19">
						<div align="right">
							<input name="btnTopPage" class="button1" type="button" id="btnTopPage" value="|&lt;&lt; " title="��ҳ" onClick="topPage()">
							<input name="btnPreviousPage" class="button1" type="button" id="btnPreviousPage" value=" &lt;  " title="��ҳ"
							 onClick="previousPage()">
							<input name="btnNextPage" class="button1" type="button" id="btnNextPage" value="  &gt; " title="��ҳ" onClick="nextPage()">
							<input name="btnBottomPage" class="button1" type="button" id="btnBottomPage" value=" &gt;&gt;|" title="βҳ"
							 onClick="bottomPage()">
							<input name="btnAdd" type="button" class="button1" id="btnAdd" value="���" onClick="addUser()">
							<input name="btnDelete" class="button1" type="button" id="btnDelete" value="ɾ��" onClick="deleteUser()">
							<input name="btnModify" class="button1" type="button" id="btnModify" value="�޸�" onClick="modifyUser()">
						</div>
					</td>
				</tr>
			</table>
			<p>&nbsp;

			</p>
		</form>
	</body>
</html>
