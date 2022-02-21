<%@page import="java.util.Iterator"%>
<%@page import="basedata.manager.ClientManager"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<html>
	<head>
		<base href="${pageContext.request.contextPath }/">
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>�����̼���ֲ�ͼ</title>
		<link rel="stylesheet" href="style/drp.css">
		<script type="text/javascript">
			function selectProvince(field){
				var xmlHttp;
				if(window.XMLHttpRequest) 
				{
					xmlHttp = new XMLHttpRequest();//��ʾ��ǰ���������ie
				} 
				else if (window.ActiveXObject) 
				{
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");//��ie
				}
				var url="servlet/statreport/SelectProvinceServlet?regionId="+field.value+"&time="+new Date().getTime();//����time������Ϊ�˷�ֹ����������Ajax��֤���Ӱ�죡��
				//��ʼ��һ���µ�Http����
				xmlHttp.open("get",url,true);
				//��callback��ַ��onreadystatechange���ԣ��õ���Ӧȥ��֤
				xmlHttp.onreadystatechange=function()
				{
					if(xmlHttp.readyState==4)
					{
						if(xmlHttp.status==200)
							{
								var doc=xmlHttp.responseXML;//��ajax����XML
								var itemElements=doc.getElementsByTagName("item");//ȡ��ÿ��ʡ�ݵ���Ŀ
								var provinceSelect=document.getElementById("province");//ȡ��ʡ�������б�
								provinceSelect.options.length=0;//���ʡ�������б�
								var all=new Option("--ȫ��--",0);
								provinceSelect.add(all);
								for(var i=0;i<itemElements.length;i++){
										var id=itemElements[i].childNodes[0].firstChild.nodeValue;
										var name=itemElements[i].childNodes[1].firstChild.nodeValue;
										var o=new Option(name,id);//����һ��Optionѡ��
										provinceSelect.add(o);//��Optionѡ����ӵ������б���
								}
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
							<b>ͳ��/�������&gt;&gt;�����̼���ֲ�ͼ</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				<table width="95%" height="40" border="0" cellpadding="0"
					cellspacing="0">
					<tr>
						<td width="14%" height="40">
							<div align="right">
								��������:&nbsp;							</div>						</td>
						<td width="13%">
							<select name="region" class="select1" id="region" onchange="selectProvince(this)">
								<option value="0" >--ȫ��--</option>
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
								����ʡ:&nbsp;							</div>						</td>
						<td width="16%">
							<select name="province" class="select1" id="province">
								<option value="0">--ȫ��--</option>
							</select>						</td>
						<td width="16%"><input name="radiobutton" type="radio" value="radiobutton" checked>
��ͼ 
  <input name="radiobutton" type="radio" value="radiobutton">
��״ͼ </td>
					    <td width="28%"><input name="btnQuery" type="button" class="button1"
								id="btnQuery" value="��ѯ"></td>
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
