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
    <title>租赁指南 - ${applicationScope.projectName}</title>
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
    <h4>关于费用</h4>
    <br><br>Q：时租的用车费用是如何计算的？
    <br>A：时租基本费用按照【用车时长】和【行驶公里数】共同核算，具体费用依据不同城市选择的不同车型而定。1小时起租，半小时计价。服务过程中产生的高速费、机场服务费、过路过桥费、停车费、夜间服务费及长途空驶费等需要客户额外支付。服务结束后，我们会将具体的费用明细以短信或提示信息的方式通知您，您也可以在手机APP或网站上查询订单的支付费用明细。
    <br><br>Q：接机或送机服务的费用是怎么计算的？
    <br>A：接/送机服务费是指，根据不同的城市，如果消费者用车范围在1小时或30公里至2小时或50公里之间的行程，易到按照一口价方式供您优惠购买。如果您的行程超出包含的时间和里程，将额外产生“超时费”、“超公里费”。超时费及超公里费用，将按照该车型的时租价格进行支付；高速费、停车费费用须按实际消费金额与订单一起支付。
    接机或者送机服务仅限城区使用
    <br><br>Q：预订时租或日租等服务，也可以接机或送机么？
    <br>A：当然可以，但预订时租及其它非接送机类服务，如果途径机场，会收取【机场服务费】。我们建议您往来机场时，预订接送机服务，价格更优惠，服务更专业。
    <br><br>Q：什么是“机场服务费”？
    <br>A：使用非接送机类服务时，当车辆途径机场范围，需加收机场服务费。如在服务中，用户多次途径机场，需按照途径次数收取机场服务费。经济车型、舒适车型、商务车型、豪华车型按50元/次收取，土豪车型按200元/次收取（其中威海地区所有车型的机场服务费均按80元/次收取）；香港地区的所有车型均按120/次收取。
    2013年5月10日起，山西太原地区的经济车型与舒适车型取消50元/次的机场服务费；商务车型、豪华车型仍按50元/次收取，土豪车型按200元/次收取。
    <br> Q：什么是“夜间服务费”？
    <br> A：23：00至次日6：00之间的用车，需加收夜间服务费。经济车型、舒适车型、商务车型、豪华车型按50元/次收取，土豪车型按200元/次收取（其中深圳地区的土豪车型按240元/次收取）；香港地区的所有车型均按220元/次收取。
    2013年5月10日起，山西太原地区经济车型、舒适车型、商务车型、豪华车型的夜间服务费由50元/次下调为30元/次，土豪车型仍按200元/次收取。
    <br><br>Q：什么是“空驶费”，是怎么计算的？
    <br>A：上车地点或下车地点位于城郊或超出服务城市行政区划的，在标准时租的基础上，加收长途空驶费，空驶费规则如下：
    <br>&nbsp;&nbsp;&nbsp;&nbsp;1）起点在市区范围内的，终点超出市区到达郊区范围的，空驶费以服务结束点至服务起点的行驶距离为准。
    <br>&nbsp;&nbsp;&nbsp;&nbsp;2）起点超出市区在郊区范围内，终点在市区范围的，空驶费以起点至服务城市中心参考点的最近距离为准。
    <br>&nbsp;&nbsp;&nbsp;&nbsp;3）起点和终点均超出市区范围在郊区范围的，收取两部分空驶费：起点距离服务城市市中心参考点行驶里程 + 终点距离服务城市市中心参考点的行驶里程。
    <br><br>Q：什么是“高速费”？
    <br>A：在高速公路（包括机场高速）行驶所产生的费用，由各地高速路管理部门收取。
    <br><br>Q：什么是“停车费”？
    <br>A：司机按约定时间到达后或服务中因等待乘客而产生的泊车费用，按实际发生费用收取。
    <br><br>Q：什么是“车辆清洁费”？
    <br>A：当用户在用车时发生呕吐、踩蹬等情况而造成车辆脏乱的，需加收车辆清洁费。经济车型按50元/次收取，舒适车型按100元/次收取，商务车型与豪华车型按150元/次收取，土豪车型按200元/次收取。
    <br><br>Q：半日租的费用是怎么计算的？
    <br>A：半日租服务费是指，根据不同的城市，如果消费者用车范围在4小时或50公里内的行程，易到按照一口价方式供您优惠购买。如果您的行程不足包含的时间和里程，将按半日租一口价支付；如果您的行程超出包含的时间和里程，将额外产生“超时费”、“超公里费”。超时费及超公里费用，将按照该车型的时租价格进行支付；高速费、停车费费用须按实际消费金额与订单一起支付。
    <br><br>Q：日租的费用是怎么计算的？
    <br> A：日租服务费是指，根据不同的城市，如果消费者用车范围在8小时或100公里内的行程，易到按照一口价方式供您优惠购买。如果您的行程不足包含的时间和里程，将按日租一口价支付；如果您的行程超出包含的时间和里程，将额外产生“超时费”、“超公里费”。超时费及超公里费用，将按照该车型的时租价格进行支付；高速费、停车费费用须按实际消费金额与订单一起支付。
    <br><br> Q：取消订单时费用是怎么计算的？
    <br>A：1.时租、接机、送机、随叫随到等服务取消规则：取消订单，不收取任何费用。
    <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.半日租、日租取消规则：距服务开始1小时之前（包括1小时）取消订单，不收取任何费用；距服务开始1小时之内取消订单，扣除订单最低消费额。
    <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.热门线路服务取消规则：距服务开始8小时之前（包括8小时）取消订单，不收取任何费用；距服务开始8小时之内取消订单，扣除订单最低消费额，最多不高于500元。


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

