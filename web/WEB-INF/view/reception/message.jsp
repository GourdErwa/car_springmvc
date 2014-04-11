<%--
  Created by IntelliJ IDEA.
  User: LiWei
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
    <title>在线留言 - ${applicationScope.projectName}</title>
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
<script>

    function tijiao() {

        var message = $("#message").val();
        if (message.length >= 200) {
            message = message.substring(0, 200);
        }

        $.ajax({
            type: "post",
            url: "<%=basePath%>add_message.do",
            data: {
                "message": message
            },
            async: false,
            cache: false,
            success: function (msg) {
                if (msg == '1') {
                    layer.msg('提交成功...', 2, -1);
                    $("#message").val('');
                }
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("提交数据中，解析出错！");
            }
        });
    }
</script>
<body>

<!--publictitle begin-->
<%@ include file="/WEB-INF/view/reception/receptiontitle.jsp" %>
<!--publictitle end-->

<div class="container">
    <img width="1150px" height="200px" src="<%=basePath%>public/image/banner.jpg">
    <br><br>

    <div style="width: 80%; text-align: right;">

        <label for="message" class="col-sm-2 control-label">我要留言</label>

        <div class="col-sm-10">
            <textarea class="form-control" id="message" name="message" rows="3"></textarea>
            最多200字<br>
        </div>

        <br><br>
        <button class="btn btn-lg btn-primary " data-loading-text="提交中..." onclick="tijiao()" type="button">提交我的留言
        </button>
    </div>

    <!-- Main component for a primary marketing message or call to action -->
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

