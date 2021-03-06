<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="basedata.domain.Item"%>
<%@page import="common.PageModel"%>
<%@page import="basedata.manager.ItemManager"%>
<%@page import="common.BeanFactory"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<% 
	int index = Integer.parseInt(request.getParameter("index"));
	
	String queryStr = request.getParameter("itemNoOrName");
	if (queryStr == null){
		queryStr= "";
	}  

	int pageNo = 1;
	int pageSize = 6;
	String strPageNo = request.getParameter("pageNo");
	if (strPageNo != null && !strPageNo.equals("")) {
		pageNo = Integer.parseInt(strPageNo);
	}
	BeanFactory factory = (BeanFactory)this.getServletContext().getAttribute("beanFactory");
	ItemManager itemManager = (ItemManager)factory.getServiceBean(ItemManager.class);
	PageModel<Item> pageModel = itemManager.findItemList(pageNo, pageSize, queryStr);
%>    
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>ѡ??????</title>
<link rel="stylesheet" href="../style/drp.css">
<script type="text/javascript">
	function topPage() {
		window.self.location = "item_select.jsp?index=<%=index%>&pageNo=<%=pageModel.getTopPage()%>&itemNoOrName=<%=queryStr%>";
	}
	
	function previousPage() {
		window.self.location = "item_select.jsp?index=<%=index%>&pageNo=<%=pageModel.getPreviousPage()%>&itemNoOrName=<%=queryStr%>";
	}
	
	function nextPage() {
		window.self.location = "item_select.jsp?index=<%=index%>&pageNo=<%=pageModel.getNextPage()%>&itemNoOrName=<%=queryStr%>";
	}
	
	function bottomPage() {
		window.self.location = "item_select.jsp?index=<%=index%>&pageNo=<%=pageModel.getBottomPage()%>&itemNoOrName=<%=queryStr%>";
	}

	function queryItem() {
		with(document.getElementById("itemForm")) {
			method = "post";
			action = "item_select.jsp";
			submit();
		}
	}
	
	function doubleclick(itemNo, itemName, spec, pattern, unit) {
		var rowLength = window.opener.document.all.tblFlowCardDetail.rows.length;
		if (rowLength == 2) {
			window.opener.document.all.itemNo.value = itemNo;
			window.opener.document.all.itemName.value = itemName;
			window.opener.document.all.spec.value = spec;
			window.opener.document.all.pattern.value = pattern;
			window.opener.document.all.unit.value = unit;
		}else {
			window.opener.document.all.itemNo[<%=index%>].value = itemNo;
			window.opener.document.all.itemName[<%=index%>].value = itemName;
			window.opener.document.all.spec[<%=index%>].value = spec;
			window.opener.document.all.pattern[<%=index%>].value = pattern;
			window.opener.document.all.unit[<%=index%>].value = unit;
		}
		window.close();
	}
</script>
</head>

<body  class="body1">
<form name="itemForm" >
  <div align="center">
    <table width="95%" border="0" cellspacing="2" cellpadding="2">
      <tr>
        <td>&nbsp;</td>
      </tr>
    </table>
    <table width="95%" border="0" cellspacing="0" cellpadding="0" height="8">
      <tr>
        <td width="522" class="p1" height="2" nowrap><img src="../images/mark_arrow_02.gif" width="14" height="14">&nbsp;<b>???????ݹ???&gt;&gt;ѡ????????Ϣ</b></td>
      </tr>
    </table>
    <hr width="97%" align="center" size=0>
    <table width="95%" border="0" cellpadding="0" cellspacing="0">
      <tr> 
        <td width="17%" height="29"> <div align="left">???ϴ???/????:</div></td>
        <td width="46%"><input name="itemNoOrName" type="text"  class="text1" id="itemNoOrName" value="<%=queryStr %>" size="50" maxlength="50"> 
        </td>
        <td width="37%"> <div align="left"> 
            <input name="btnQuery" type="button" class="button1" id="btnQuery"  value="??ѯ" onClick="queryItem()">
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
      <td nowrap height="10" class="p2">??????Ϣ</td>
      <td nowrap  height="10" class="p3">&nbsp;</td>
    </tr>
  </table>
  <table width="95%" border="1" cellspacing="0" cellpadding="0" align="center" class="table1">
    <tr> 
      <td width="35" class="rd6">ѡ??</td>
      <td width="170" class="rd6">???ϴ???</td>
      <td width="222" class="rd6">????????</td>
      <td width="195" class="rd6">???Ϲ???</td>
      <td width="293" class="rd6">?????ͺ?</td>
      <td width="293" class="rd6">????</td>
      <td width="293" class="rd6">??????λ</td>
    </tr>
    <%
    	List<Item> itemList = pageModel.getList(); 
    	for (Iterator<Item> iter = itemList.iterator(); iter.hasNext();) {
    		Item item = (Item)iter.next();
    %>	
    <tr> 
      <td class="rd8" ><input type="radio" name="selectFlag" value="radiobutton" ondblClick="doubleclick('<%=item.getNo()%>', '<%=item.getName()%>', '<%=item.getSpec()%>', '<%=item.getPattern()%>', '<%=item.getItemUnit().getNAME()%>')"></td>
      <td width="170" class="rd8" ><%=item.getNo() %></td>
      <td width="222" class="rd8" ><%=item.getName() %></td>
      <td width="195" class="rd8" ><%=item.getSpec() %></td>
      <td width="293" class="rd8" ><%=item.getPattern() %></td>
      <td width="293" class="rd8" ><%=item.getItemCategory().getNAME() %></td>
      <td width="293" class="rd8" ><%=item.getItemUnit().getNAME() %></td>
    </tr>
    <%
    	}
     %>

  </table>
  <table width="95%" height="30" border="0" align="center" cellpadding="0" cellspacing="0" class="rd1">
    <tr> 
      <td  nowrap class="rd19" height="2" width="36%"> <div align="left">&nbsp;??&nbsp;<font color="red"><%=pageModel.getTotalPages() %></font>&nbsp;ҳ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;??ǰ??&nbsp;<font color="red"><%=pageModel.getPageNo() %></font>&nbsp;ҳ</div>
      <td  nowrap class="rd19" width="64%"> <div align="right">
        <input name="btnTopPage" class="button1" type="button" id="btnTopPage" value="|&lt;&lt; "  title="??ҳ" onClick="topPage()">
        <input name="btnPreviousPage" class="button1" type="button" id="btnPreviousPage" value=" &lt;  "  title="??ҳ" onClick="previousPage()">
        <input name="btnNext" class="button1" type="button" id="btnNext" value="  &gt; "  title="??ҳ" onClick="nextPage()">
        <input name="btnBottomPage" class="button1" type="button" id="btnBottomPage" value=" &gt;&gt;|"  title="βҳ" onClick="bottomPage()">
          <input name="btnOk" class="button1" type="button" id="btnOk" value="ȷ??" onclick="selectOk()">
          <input name="btnClose" class="button1" type="button" id="btnClose" value="?ر?" onClick="window.close()">
      </div></td>
    </tr>
  </table>
</form>
</body>
</html>