<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="sysMgr.domain.User"%>
<%
	User user=(User)session.getAttribute("userInfo");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="GB18030">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="viewport" content="width=device-width,initial-scale=1" />
		<title>DRP����ϵͳ</title>
		<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css" />
	</head>
	<style>
		.dropbtn {
			background-color: blueviolet;
			color: lightgrey;
			cursor: pointer;
		}
		
		.counter {
			background-color: limegreen;
			color: lightgrey;
			cursor: pointer;
			color:red
		}
		
		.dropdown {
			position: relative;
			display: inline-block;
		}

		.dropdown-content {
			display: none;
			/* position: absolute; */
			background-color: blue;
			min-width: 100%;
			box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
		}

		.dropdown-content a {
			color: lightgrey;
			text-decoration: none;
			display: block;
		}

		/* �������ȥ���޸������˵�������ɫ */
		.dropdown-content a:hover {
			background-color: #f1f1f1
		}

		/* ���������ȥ����ʾ�����˵� */
		.dropdown:hover .dropdown-content {
			display: block;
		}

		/* ������������ʾ���޸�������ť�ı�����ɫ */
		.dropdown:hover .dropbtn {
			background-color: #aaaaff;
		}
	</style>
	<body>
		<div class="container">
			<div class="row">
				<!-- ������ -->
				<div class="col-md-2" style="background-color: mediumblue;text-align: center;height: 100%;position: fixed;background-image: url(img/����������.png);">
					<!-- ��ҳ����չʾ -->
					<div><img src="img/maintop.png" style="width: 100%;" /></div>
					<!-- ����������ť�� -->
					<div class="dropdown">
						<button class="counter" style="width: 100%;">��ǰ�û�:<%=user.getUSER_NAME() %></button>
						<button class="counter" style="width: 100%;">��������:${sum }</button>
					</div>
					<div class="dropdown">
						<button class="dropbtn" style="width: 150px;">�����̿�����</button>
						<div class="dropdown-content">
							<a href="servlet/flowcard/FlowCardServlet" style="border:1px solid white;">����ά��</a>
						</div>
					</div>
					<div class="dropdown">
						<button class="dropbtn" style="width: 150px;">�����ѹ���</button>
						<div class="dropdown-content">
						</div>
					</div>
					<div class="dropdown">
						<button class="dropbtn" style="width: 150px;">���˹���</button>
						<div class="dropdown-content">
						</div>
					</div>
					<div class="dropdown">
						<button class="dropbtn" style="width: 150px;">����������</button>
						<div class="dropdown-content">
						</div>
					</div>
					<div class="dropdown">
						<button class="dropbtn" style="width: 150px;">ͳ�Ʊ������</button>
						<div class="dropdown-content">
							<a href="statreport/client_level_chart.jsp" style="border:1px solid white;">�����̼���ֲ�ͼ</a>
						</div>
					</div>
					<div class="dropdown">
						<button class="dropbtn" style="width: 150px;">�������ݹ���</button>
						<div class="dropdown-content" style="width:150px">
							<a href="basedata/fiscal_year_period_maint.jsp" style="border:1px solid white;">��ƺ����ڼ�ά��</a>
							<a href="servlet/item/SearchItemServlet" style="border:1px solid white;">����ά��</a>
							<a href="basedata/client_maint.html" style="border:1px solid white;">������ά��</a>
							<a href="#" style="border:1px solid white;">�ն˿ͻ�ά����ҽԺ��</a>
						</div>
					</div>
					<div class="dropdown">
						<button class="dropbtn" style="width: 150px;">ϵͳ����</button>
						<div class="dropdown-content">
							<a href="sysmgr/user_maint.jsp" style="border:1px solid white;">�û�ά��</a>
							<a href="sysmgr/password_modify.jsp" style="border:1px solid white;">�޸�����</a>
						</div>
					</div>
				</div>
				<div class="col-md-10" style="margin-left: 250px;background-image: url(img/�����¸���·.jpg);color: lightgrey;text-align: center;">
					<p>
						�����ڵ��㡷<p>
						������<p>
						�Ҳز�ס���ܣ�Ҳ�ز�ס���ˣ�<p>
						�����Ҳز�ס�����ϲ�ã�<p>
						�ز�ס����ʱ�����塣<p>
						�Ҿ�������̹Ȼ��<p>
						������ˣ����ˡ�<p>
						�����һ�죬��Ҫ�뿪�ң�<p>
						�Ҳ������㣬��֪������������ɣ�<p>
						�����һ�죬��˵�����ң�<p>
						�һ�����㣬��ʵ��һֱ�ڵ��㣻<p>
						�����һ�죬���ǲ��������<p>
						�һ�ͣס�Ų���������Զȥ�ı�Ӱ��<p>
						�����Լ��Ǹ���������������<p>
						������һ�����԰��ܶ�Σ�<p>
						Ȼ������һ���ˣ�<p>
						����������Ц������ã�<p>
						�޵���͸������������С�<p>
						�������ˣ������ſڵ��㡣<p>
						Ϧ�����ˣ�����ɽ�ߵ��㡣<p>
						Ҷ�ӻ��ˣ��������µ��㡣<p>
						�¶����ˣ�����ʮ����㡣<p>
						ϸ�����ˣ�����ɡ�µ��㡣<p>
						��ˮ���ˣ����ں��ϵ��㡣<p>
						�������ˣ��������õ��㡣<p>
						�������ˣ������������㡣
					</p>
				</div>
			</div>
		</div>
	</body>
</html>
