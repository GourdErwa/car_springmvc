<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>${applicationScope.projectName}-后台管理客户端</title>
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

    <!--publictitle begin-->
    <%@ include file="/WEB-INF/view/admin_publictitle.jsp" %>
    <!--publictitle end-->
</div>

<div class="container">

    <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
        <h3>${applicationScope.projectName}-后台站点管理流程说明</h3>

        1.转到公司主页
        <br>2.用户配置
        <br>&nbsp;&nbsp;用户管理：新建、修改、删除用户信息
        <br>&nbsp;&nbsp;权限配置：配置用户对后台站点管理的权限

        <br>3.车辆信息管理
        <br>&nbsp;&nbsp;车辆类别管理：对公司租凭的车辆所属类别配置
        <br>&nbsp;&nbsp;车辆明细管理：对公司可租凭的车辆实施增加、修改、下架

        <br>4.车辆出租登记
        <br>&nbsp;&nbsp;对公司已租凭或者用户归还的信息进行登记
        <br>5.车辆出租统计
        <br>&nbsp;&nbsp;统计显示公司车辆的盈利趋势图
        <br>6.用户留言
        <br>&nbsp;&nbsp;查看用户对公司的一些留言及建议

        <br><br> 管理员：${applicationScope.PROJECTBYNAME}

    </div>


    <!--admin_publicfooter begin-->
    <div>
        <%@ include file="/WEB-INF/view/admin_publicfooter.jsp" %>
    </div>
    <!--admin_publicfooter end-->

</div>
<!-- /container -->
</body>
</html>
