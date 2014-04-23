<%--
  Created by IntelliJ IDEA.
  Date: 14-3-27
  Time: 19:28
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
    <title>公司简介 - ${applicationScope.projectName}</title>
    <link href="<%=basePath%>public/dist/css/bootstrap.css" rel="stylesheet">
    <script src="<%=basePath%>public/js/jquery-1.8.0.min.js"></script>
    <script src="<%=basePath%>public/dist/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>public/layer/layer.min.js"></script>
    <style>

        body {
            padding-top: 70px;
        }

    </style>
</head>
<body>

<!--publictitle begin-->
<%@ include file="/WEB-INF/view/reception/receptiontitle.jsp" %>
<!--publictitle end-->

<div class="container">
    <img width="1150px" height="200px" src="<%=basePath%>public/image/banner.jpg">
    <br><br>
    ${applicationScope.projectName}主要为外籍人士和公司提供汽车的租赁服务。
    <br><br>主要经营各种中、高档汽车的租赁业务.
    <br><br>根据租赁时间和类型可分为：长期租车﹑年租车﹑月租车﹑日租车﹑旅游租车和婚庆租车.
    <br> <br>同时可以为客户量身定制租车计划。
    <br><br> 公司技术力量雄厚，经营租赁车辆种类齐全<br><br>具有别克商务仓、奥迪A6、奥迪A6L、本田、帕萨特、伊兰特、金龙大巴等等一系列中高档车辆
    <br><br>根据客户不同需求提供各种优质车辆。
    <br> <br>可为各大企事业单位、机关部门及社会团体、院校及个人提供旅游线路的往返车辆业务、机场接送、商务用车、会务用车及旅游包车长期或短期的汽车租赁业务……

    <br><br>
    <!--admin_publicfooter begin-->
    <div>
        <%@ include file="/WEB-INF/view/admin_publicfooter.jsp" %>
    </div>
    <!--admin_publicfooter end-->

</div>
<!-- /container -->

</body>
</html>

