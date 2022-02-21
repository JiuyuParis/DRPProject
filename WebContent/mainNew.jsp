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
		<title>DRP分销系统</title>
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

		/* 鼠标移上去后修改下拉菜单链接颜色 */
		.dropdown-content a:hover {
			background-color: #f1f1f1
		}

		/* 在鼠标移上去后显示下拉菜单 */
		.dropdown:hover .dropdown-content {
			display: block;
		}

		/* 当下拉内容显示后修改下拉按钮的背景颜色 */
		.dropdown:hover .dropbtn {
			background-color: #aaaaff;
		}
	</style>
	<body>
		<div class="container">
			<div class="row">
				<!-- 导航栏 -->
				<div class="col-md-2" style="background-color: mediumblue;text-align: center;height: 100%;position: fixed;background-image: url(img/导航条背景.png);">
					<!-- 网页主题展示 -->
					<div><img src="img/maintop.png" style="width: 100%;" /></div>
					<!-- 导航栏（按钮） -->
					<div class="dropdown">
						<button class="counter" style="width: 100%;">当前用户:<%=user.getUSER_NAME() %></button>
						<button class="counter" style="width: 100%;">在线人数:${sum }</button>
					</div>
					<div class="dropdown">
						<button class="dropbtn" style="width: 150px;">分销商库存管理</button>
						<div class="dropdown-content">
							<a href="servlet/flowcard/FlowCardServlet" style="border:1px solid white;">流向单维护</a>
						</div>
					</div>
					<div class="dropdown">
						<button class="dropbtn" style="width: 150px;">分消费管理</button>
						<div class="dropdown-content">
						</div>
					</div>
					<div class="dropdown">
						<button class="dropbtn" style="width: 150px;">结账管理</button>
						<div class="dropdown-content">
						</div>
					</div>
					<div class="dropdown">
						<button class="dropbtn" style="width: 150px;">付款结算管理</button>
						<div class="dropdown-content">
						</div>
					</div>
					<div class="dropdown">
						<button class="dropbtn" style="width: 150px;">统计报表管理</button>
						<div class="dropdown-content">
							<a href="statreport/client_level_chart.jsp" style="border:1px solid white;">分销商级别分布图</a>
						</div>
					</div>
					<div class="dropdown">
						<button class="dropbtn" style="width: 150px;">基础数据管理</button>
						<div class="dropdown-content" style="width:150px">
							<a href="basedata/fiscal_year_period_maint.jsp" style="border:1px solid white;">会计核算期间维护</a>
							<a href="servlet/item/SearchItemServlet" style="border:1px solid white;">物料维护</a>
							<a href="basedata/client_maint.html" style="border:1px solid white;">分销商维护</a>
							<a href="#" style="border:1px solid white;">终端客户维护（医院）</a>
						</div>
					</div>
					<div class="dropdown">
						<button class="dropbtn" style="width: 150px;">系统管理</button>
						<div class="dropdown-content">
							<a href="sysmgr/user_maint.jsp" style="border:1px solid white;">用户维护</a>
							<a href="sysmgr/password_modify.jsp" style="border:1px solid white;">修改密码</a>
						</div>
					</div>
				</div>
				<div class="col-md-10" style="margin-left: 250px;background-image: url(img/布兰德福德路.jpg);color: lightgrey;text-align: center;">
					<p>
						《我在等你》<p>
						余秋雨<p>
						我藏不住秘密，也藏不住忧伤，<p>
						正如我藏不住爱你的喜悦，<p>
						藏不住分离时的彷徨。<p>
						我就是这样坦然，<p>
						你舍得伤，就伤。<p>
						如果有一天，你要离开我，<p>
						我不会留你，我知道你有你的理由；<p>
						如果有一天，你说还爱我，<p>
						我会告诉你，其实我一直在等你；<p>
						如果有一天，我们擦肩而过，<p>
						我会停住脚步，凝视你远去的背影，<p>
						告诉自己那个人我曾经爱过。<p>
						或许人一生可以爱很多次，<p>
						然而总有一个人，<p>
						可以让我们笑得最灿烂，<p>
						哭得最透彻，想得最深切。<p>
						炊烟起了，我在门口等你。<p>
						夕阳下了，我在山边等你。<p>
						叶子黄了，我在树下等你。<p>
						月儿弯了，我在十五等你。<p>
						细雨来了，我在伞下等你。<p>
						流水冻了，我在河畔等你。<p>
						生命累了，我在天堂等你。<p>
						我们老了，我在来生等你。
					</p>
				</div>
			</div>
		</div>
	</body>
</html>
