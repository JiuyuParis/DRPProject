<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ include file="/commonPackage.jsp" %>
<%
	int index = Integer.parseInt(request.getParameter("index"));
	
	String queryStr = request.getParameter("aimclientIdOrName");
	if (queryStr == null){
		queryStr= "";
	}
 
	int pageNo = 1;
	int pageSize = 10;
	String strPageNo = request.getParameter("pageNo");
	if (strPageNo != null && !strPageNo.equals("")) {
		pageNo = Integer.parseInt(strPageNo);
	}
	PageModel<AimClient> pageModel = ClientManager.getInstance().findAllAimClient(pageNo, pageSize, queryStr);
%>            
<html>
<meta charset="GB18030">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>请选择需方客户</title>
<link rel="stylesheet" href="../style/drp.css">
<script src="../script/client_validate.js"></script>
<script type="text/javascript">
	function topPage() {
		window.self.location = "aim_client_select.jsp?index=<%=index%>&pageNo=<%=pageModel.getTopPage()%>";
	}
	
	function previousPage() {
		window.self.location = "aim_client_select.jsp?index=<%=index%>&pageNo=<%=pageModel.getPreviousPage()%>";
	}
	
	function nextPage() {
		window.self.location = "aim_client_select.jsp?index=<%=index%>&pageNo=<%=pageModel.getNextPage()%>";
	}
	
	function bottomPage() {
		window.self.location = "aim_client_select.jsp?index=<%=index%>&pageNo=<%=pageModel.getBottomPage()%>";
	}
	
	function queryClient() {
		with(document.getElementById("clientForm")) {
			method = "post";
			action = "aim_client_select.jsp";
			submit();
		}
	}
	

 	function doubleclick(aimInnerId, aimId, aimName) {
		var rowLength = window.opener.document.all.tblFlowCardDetail.rows.length
		//alert("rowLength=" + rowLength);
		if (rowLength == 2) {
			window.opener.document.all.aimInnerId.value = aimInnerId;
			window.opener.document.all.aimId.value = aimId;
			window.opener.document.all.aimName.value = aimName;
		} else {
			window.opener.document.all.aimInnerId[<%=index%>].value = aimInnerId;
			window.opener.document.all.aimId[<%=index%>].value = aimId;
			window.opener.document.all.aimName[<%=index%>].value = aimName;
		}
		window.close();
	}


<%--   	function doubleclick(aimInnerId, aimId, aimName) {
		window.opener.document.getElementsByName("aimInnerId")[<%=index%>].value = aimInnerId;
		window.opener.document.getElementsByName("aimId")[<%=index%>].value = aimId;
		window.opener.document.getElementsByName("aimName")[<%=index%>].value = aimName;
		window.close();
	} --%>
	
	function selectOk(clientId, clientName) {
		window.close();
	}
	
</script>	
</head>

<body  class="body1">
<form name="clientForm" >
  <div align="center"> 
    <table width="95%" border="0" cellspacing="0" cellpadding="0" height="34">
      <tr> 
        <td width="522" class="p1" height="34" nowrap><img src="../images/search.gif" width="32" height="32">&nbsp;<b>请选择分销商</b></td>
      </tr>
    </table>
    <hr width="100%" align="center" size=0>
    <table width="95%" border="0" cellpadding="0" cellspacing="0">
      <tr> 
        <td width="17%" height="29"> <div align="left">需方客户代码/名称:</div></td>
        <td width="57%"><input name="aimclientIdOrName" type="text"  class="text1" id="aimclientIdOrName" value="<%=queryStr %>" size="50" maxlength="50"> 
        </td>
        <td width="26%"> <div align="left"> 
            <input name="btnQuery" type="button" class="button1" id="btnQuery"  value="查询" onclick="queryClient()">
          </div></td>
      </tr>
      <tr> 
        <td height="16"> 
          <div align="right"></div></td>
        <td>&nbsp; </td>
        <td><div align="right"></div></td>
      </tr>
    </table>
    
  </div>
  <table width="95%" border="0" cellspacing="0" cellpadding="0"  class="rd1" align="center">
    <tr> 
      <td nowrap height="10" class="p2">需方客户信息</td>
      <td nowrap  height="10" class="p3">&nbsp;</td>
    </tr>
  </table>
  <table width="95%" border="1" cellspacing="0" cellpadding="0" align="center" class="table1">
    <tr> 
      <td class="rd6">选择</td>
      <td  class="rd6">需方客户代码</td>
      <td  class="rd6">需方客户名称</td>
      <td  class="rd6">需方客户类型</td>
    </tr>
    <%
    	List<AimClient> clientList = pageModel.getList();
    	for (Iterator<AimClient> iter = clientList.iterator(); iter.hasNext();) {
    		AimClient aimClient = (AimClient)iter.next();    		
    %>
    <tr > 
      <td class="rd8" ><input type="radio" name="selectFlag" value="radiobutton" ondblclick="doubleclick('<%=aimClient.getID() %>', '<%=aimClient.getCLIENT_TEMI_ID()%>', '<%=aimClient.getNAME()%>')"></td>
      <td  class="rd8" ><%=aimClient.getCLIENT_TEMI_ID() %></td>
      <td  class="rd8" ><%=aimClient.getNAME() %></td>
      <td  class="rd8" ><%=aimClient.getCLIENT_TEMI_LEVEL_NAME() %></td>
    </tr>
    <%
    	}
    %>
  </table>
  <table width="95%" height="30" border="0" align="center" cellpadding="0" cellspacing="0" class="rd1">
    <tr> 
      <td  nowrap class="rd19" height="2" width="36%"> 
	      <div align="left">共&nbsp;<font color="red"><%=pageModel.getTotalPages() %></font>&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前第&nbsp;<font color="red"><%=pageModel.getPageNo() %></font>&nbsp;页</div>
      </td>
      <td  nowrap class="rd19" width="64%"> <div align="right"> 
        <input name="btnTopPage" class="button1" type="button" id="btnTopPage" value="|&lt;&lt; "  title="首页" onClick="topPage()">
        <input name="btnPreviousPage" class="button1" type="button" id="btnPreviousPage" value=" &lt;  "  title="上页" onClick="previousPage()">
        <input name="btnNext" class="button1" type="button" id="btnNext" value="  &gt; "  title="下页" onClick="nextPage()">
        <input name="btnBottomPage" class="button1" type="button" id="btnBottomPage" value=" &gt;&gt;|"  title="尾页" onClick="bottomPage()">
          <input name="btnOk" class="button1" type="button" id="btnOk" value="确定" onclick="selectOk()">
          <input name="btnClose" class="button1" type="button" id="btnClose" value="关闭" onClick="window.close()">
        </div></td>
    </tr>
  </table>
</form>
</body>
</html>