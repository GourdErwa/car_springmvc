<%--
  Created by IntelliJ IDEA.
  User: LiWei
  Date: 14-3-27
  Time: 19:28
  To change this template use File | Settings | File Templates.
  联系我们
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>联系我们 - ${applicationScope.projectName}</title>
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
    <!-- Main component for a primary marketing message or call to action -->
        <h4>${applicationScope.projectName}-联系方式说明</h4>
        <br>
        地 址:山西省太原市迎泽大街华通大厦A座后院
        <br><br>
        行车路线：
        <br>

        1.迎泽大桥西往东第一个十字路口左拐停车即到华通大厦停车场出口
        <br>
        2.公交车27路; 1路; 168路; 迎泽大桥西下车即到
        <br>
        <br>
        华通大厦A座后院
        <br>
        24小时租车热线：0351-62055466 / 62895506 / 62780901 / 1300-118-6149
        <br>
        传 &nbsp;&nbsp;真：0351-62364001
        <br>
        E-&nbsp;Mail: liweityut@163.com
        <br>
        网 &nbsp;&nbsp;址: www.liwei.com



    <!--admin_publicfooter begin-->
    <div>
        <%@ include file="/WEB-INF/view/admin_publicfooter.jsp" %>
    </div>
    <!--admin_publicfooter end-->

</div>
<!-- /container -->

</body>
</html>

