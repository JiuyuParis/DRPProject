<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="basedata.manager.ClientManager" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<link rel="stylesheet" href="../style/drp.css">
		<style type="text/css">

a:link {
	text-decoration: none;
	color: #000000;
	font-size: 9pt;
	font-family: ����;
}
a:visited {
	text-decoration: none;
	color: #000000;
	font-size: 9pt;
	font-family: ����;
	
}
a:hover {
	text-decoration: none;
	color: #000000;
	font-size: 9pt;
	font-family: ����;

}
a:active {
	text-decoration: none;
	color: #000000;
	font-size: 9pt;
	font-family: ����;
}

</style>

		<script type="text/JavaScript">

  function display(id) {
	 eval("var div=div"+id);
	 eval("var img=img"+id);
	 eval("var im=im"+id);
	 div.style.display=div.style.display=="block"?"none":"block";
	 img.src=div.style.display=="block"?"../images/minus.gif":"../images/plus.gif";
	 im.src=div.style.display=="block"?"../images/openfold.gif":"../images/closedfold.gif";
	 img.alt=div.style.display=="block"?"�ر�":"չ��";
}  

</script>
	</head>
	<body class="body1">
		<table>
			<tr>
				<td valign="top" nowrap="nowrap">
					<!-- <div>
						<img alt="չ��" style="cursor:hand;" onClick="display('1');"
							id="img1" src="../images/plus.gif">
						<img id="im1" src="../images/closedfold.gif">
						<a href="client_node_crud.html" target="clientDispAreaFrame">���з�����</a>
						<div style="display:none;" id="div1">
							<div>
								<img src="../images/white.gif">
								<img alt="չ��" style="cursor:hand;" onClick="display('2');"
									id="img2" src="../images/plus.gif">
								<img id="im2" src="../images/closedfold.gif">
								<a href="client_node_crud.html" target="clientDispAreaFrame">������</a>
								<div style="display:none;" id="div2">
									<div>
										<img src="../images/white.gif">
										<img src="../images/white.gif">
										<img alt="չ��" style="cursor:hand;" onClick="display('3');"
											id="img3" src="../images/plus.gif">
										<img id="im3" src="../images/closedfold.gif">
										<a href="client_node_crud.html" target="clientDispAreaFrame">������</a>
										<div style="display:none;" id="div3">
											<div>
												<img src="../images/white.gif">
												<img src="../images/white.gif">
												<img src="../images/white.gif">
												<img src="../images/minus.gif">
												<img src="../images/openfold.gif">
												<a href="client_crud.html" target="clientDispAreaFrame">����ҽҩ�ɷ����޹�˾</a>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div>
								<img src="../images/white.gif">
								<img src="../images/minus.gif">
								<img src="../images/openfold.gif">
								<a href="client_node_crud.html" target="clientDispAreaFrame">������</a>
							</div>
							<div>
								<img src="../images/white.gif">
								<img src="../images/minus.gif">
								<img src="../images/openfold.gif">
								<a href="client_node_crud.html" target="clientDispAreaFrame">������</a>
							</div>
						</div>
					</div> -->
					<%=ClientManager.getInstance().getClientTreeHTMLString() %>
				</td>
			</tr>
		</table>
	</body>
</html>
