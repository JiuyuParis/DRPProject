<%@page import="java.util.Iterator"%>
<%@page import="basedata.manager.ClientManager"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<html>
	<head>
		<base href="${pageContext.request.contextPath }/">
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>分销商级别分布图</title>
		<link rel="stylesheet" href="style/drp.css">
		<script type="text/javascript">
			function selectProvince(field){
				var xmlHttp;
				if(window.XMLHttpRequest) 
				{
					xmlHttp = new XMLHttpRequest();//表示当前浏览器不是ie
				} 
				else if (window.ActiveXObject) 
				{
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");//是ie
				}
				var url="servlet/statreport/SelectProvinceServlet?regionId="+field.value+"&time="+new Date().getTime();//传递time参数是为了防止浏览器缓存对Ajax验证造成影响！！
				//初始化一个新的Http请求
				xmlHttp.open("get",url,true);
				//将callback地址给onreadystatechange属性，拿到响应去验证
				xmlHttp.onreadystatechange=function()
				{
					if(xmlHttp.readyState==4)
					{
						if(xmlHttp.status==200)
							{
								var doc=xmlHttp.responseXML;//让ajax返回XML
								var itemElements=doc.getElementsByTagName("item");//取得每个省份的条目
								var provinceSelect=document.getElementById("province");//取得省份下拉列表
								provinceSelect.options.length=0;//清除省份下拉列表
								var all=new Option("--全部--",0);
								provinceSelect.add(all);
								for(var i=0;i<itemElements.length;i++){
										var id=itemElements[i].childNodes[0].firstChild.nodeValue;
										var name=itemElements[i].childNodes[1].firstChild.nodeValue;
										var o=new Option(name,id);//构建一个Option选项
										provinceSelect.add(o);//将Option选项添加到下拉列表中
								}
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

	<body class="body1">
		<form name="clientLevelChartForm" target="_self"
			id="clientLevelChartForm">
			<div align="center">
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="35">
					<tr>
						<td class="p1" height="18" nowrap>&nbsp;
							
					  </td>
					</tr>
					<tr>
						<td width="522" class="p1" height="17" nowrap>
							<img src="images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>统计/报表管理&gt;&gt;分销商级别分布图</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				<table width="95%" height="40" border="0" cellpadding="0"
					cellspacing="0">
					<tr>
						<td width="14%" height="40">
							<div align="right">
								分销大区:&nbsp;							</div>						</td>
						<td width="13%">
							<select name="region" class="select1" id="region" onchange="selectProvince(this)">
								<option value="0" >--全部--</option>
							<%
								Map<Integer,String> areaMap=ClientManager.getInstance().getRegion();
								for(Iterator<Map.Entry<Integer, String>> iterator=areaMap.entrySet().iterator();iterator.hasNext();) {
									Map.Entry<Integer, String> areaEntry=iterator.next();
							%>
								<option value="<%=areaEntry.getKey()%>"><%=areaEntry.getValue() %></option>
							<%
								}
							%>					
							</select>
						</td>
						<td width="13%">
							<div align="right">
								分销省:&nbsp;							</div>						</td>
						<td width="16%">
							<select name="province" class="select1" id="province">
								<option value="0">--全部--</option>
							</select>						</td>
						<td width="16%"><input name="radiobutton" type="radio" value="radiobutton" checked>
饼图 
  <input name="radiobutton" type="radio" value="radiobutton">
柱状图 </td>
					    <td width="28%"><input name="btnQuery" type="button" class="button1"
								id="btnQuery" value="查询"></td>
					</tr>
			  </table>
				<hr width="100%" align="center" size=0>
			  <div align="center"></div>
			</div>
			<table width="95%" border="0" cellpadding="0"
					cellspacing="0">
              <tr>
                <td align="center">
				 <iframe scrolling="auto"  name="pageFrame" src="servlet/statreport/ChartDemoServlet"  frameborder="0" width="450" height="400" ></iframe> 
				</td>
              </tr>
            </table>
			<p>&nbsp;			</p>
		</form>
	</body>
</html>
