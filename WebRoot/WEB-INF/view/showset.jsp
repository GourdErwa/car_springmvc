<%--
  Created by IntelliJ IDEA.
  User: lw
  Date: 14-3-22
  Time: 14:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Fixed Top Navbar Example for Bootstrap</title>

    <link href="<%=basePath%>public/dist/css/bootstrap.css" rel="stylesheet">

    <script src="<%=basePath%>public/js/jquery-1.8.0.min.js"></script>
    <script src="<%=basePath%>public/dist/js/bootstrap.min.js"></script>

</head>

<style>

    body {
        padding-top: 70px;
    }

</style>
<body>

<!-- Fixed navbar -->
<div class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">${sessionScope.projectName}</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li ><a href="<%=basePath%>showset.admin.do">网站首页显示设置</a></li>

                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">用户管理 <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">用户管理</a></li>
                        <li><a href="#">权限管理</a></li>
                    </ul>
                </li>

                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">车辆信息管理 <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">车辆类别管理</a></li>
                        <li><a href="#">车辆明细管理</a></li>

                        <li class="divider"></li>
                        <li class="dropdown-header">Nav header</li>
                        <li><a href="#">Separated link</a></li>
                        <li><a href="#">One more separated link</a></li>
                    </ul>
                </li>
                <li>  <li><a href="#">车辆出租登记</a></li></li>
                <li>  <li><a href="#">车辆出租统计图</a></li></li>
                <li>  <li><a href="#">用户留言</a></li></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="../navbar/">${sessionScope.userName}</a></li>
                <li><a href="../navbar-static-top/">注销</a></li>
                <li ><a href="./"> 返回顶部↑</a></li>
            </ul>
        </div>
        <!--/.nav-collapse -->
    </div>
</div>

<div class="container">

    <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
        <h1>Navbar example</h1>

        <p>This example is a quick exercise to illustrate how the default, static and fixed to top navbar work. It
            includes the responsive CSS and HTML, so it also adapts to your viewport and device.</p>

        <p>To see the difference between static and fixed top navbars, just scroll.</p>

        <p>
            <a class="btn btn-lg btn-primary" href="../../components/#navbar" role="button">View navbar docs &raquo;</a>
        </p>
    </div>

</div>
<!-- /container -->

</body>
</html>

