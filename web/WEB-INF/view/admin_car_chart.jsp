<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>车辆出租统计图-${applicationScope.projectName}</title>

    <link href="<%=basePath%>public/dist/css/bootstrap.css" rel="stylesheet">
    <link href="<%=basePath%>public/ichartjs/css/style.css" rel="stylesheet">

    <script src="<%=basePath%>public/js/jquery-1.8.0.min.js"></script>
    <script src="<%=basePath%>public/dist/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>public/layer/layer.min.js"></script>
    <script src="<%=basePath%>public/ichartjs/jq-ui/ichart.1.2.min.js"></script>
    <script src="<%=basePath%>public/js/my_ichart.js"></script>

</head>
<style>

    body {
        padding-top: 70px;
    }

</style>
<script>

    $(function ($) {

        /**
         * 页面初始化，填充车辆类别到下拉框
         * */

        $.ajax({
            type: "get",
            url: "<%=basePath%>getCar_categorysInSelect.admin.do",
            async: false,
            cache: false,
            success: function (msg) {

                $("#carcategory").empty();
                $("#carcategory").append(msg);

            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("填充车辆类别到下拉框中，数据解析出错！");
            }
        });

    });

    //按车辆明细生成统计图
    function initForIchartCar_Name() {
        var mouth = $("#mouth").val();
        var year = $("#year").val();
        var carcategory = $("#carcategory").val();
        $.ajax({
            type: "POST",
            url: "<%=basePath%>initForIchartCar_Name.admin.do",
            data: {"carcategory": carcategory,
                "year": year,
                "mouth": mouth
            },
            async: false,
            cache: false,
            success: function (msgs) {

                if (msgs.length > 5) {

                    var data = eval(msgs);

                    if (mouth != '全年') {
                        mouth = mouth + " 月份";
                    }

                    var title = +year + "年" + mouth + "-车辆类别" + carcategory + "-所有车辆累计销售额";
                    show(data, title);
                } else {
                    layer.msg('该查询条件下无任何返回信息...', 2, -1);
                }

            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("查看某类别下所有车辆中，数据解析出错！");
            }
        });
    }

    //按车辆类别生成统计图
    function initForIchart() {
        var mouth = $("#mouth").val();
        var year = $("#year").val();
        $.ajax({
            type: "POST",
            url: "<%=basePath%>initForIchart.admin.do",
            data: {
                "year": year,
                "mouth": mouth
            },
            async: false,
            cache: false,
            success: function (msgs) {
                if (msgs.length > 5) {

                    var data = eval(msgs);

                    if (mouth != '全年') {
                        mouth = mouth + " 月份";
                    }
                    var title = +year + "年" + mouth + "-每个车辆类别累计销售额";
                    show(data, title);
                } else {
                    layer.msg('该查询条件下无任何返回信息...', 2, -1);
                }

            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("对比所有车辆类别中，数据解析出错！");
            }
        });
    }

</script>
<body onload="initForIchart()">

<!-- Fixed navbar -->
<div class="navbar navbar-default navbar-fixed-top" role="navigation">

    <!--publictitle begin-->
    <%@ include file="/WEB-INF/view/admin_publictitle.jsp" %>
    <!--publictitle end-->
</div>
<input type="hidden" id="thisPage" name="thisPage" value="1"/>

<input type="hidden" id="pageShowSize" name="pageShowSize" value="10"/>

<div class="container">

    <!-- Main component for a primary marketing message or call to action -->
    <form class="form-inline" role="form">
        <div class="form-group">
            车辆所属类别：
            <select id="carcategory" name="carcategory" class="form-control"
                    style="width: 200px;">
            </select>
            &nbsp; &nbsp; 显示年份：
            <select id="year" name="year" class="form-control" style="width: 70px;" required>
                <option id="2014">2014</option>
                <option id="2013">2013</option>
            </select>
            &nbsp; &nbsp; 显示月份：
            <select id="mouth" name="mouth" class="form-control" style="width: 70px;" required>
                <option id="全年">全年</option>
                <option id="01">01</option>
                <option id="02">02</option>
                <option id="03">03</option>
                <option id="04">05</option>
                <option id="07">06</option>
                <option id="08">08</option>
                <option id="09">09</option>
                <option id="10">10</option>
                <option id="11">11</option>
                <option id="12">12</option>
            </select>

            &nbsp; &nbsp;<a class="btn btn-primary " onclick="initForIchart()" role="button">对比所有车辆类别 &raquo;</a>
            &nbsp; <a class="btn btn-primary " onclick="initForIchartCar_Name()"
                      role="button">查看某类别下所有车辆 &raquo;</a>
        </div>
    </form>
    <br>

    <div style="text-align: center;">
        <div id="canvasDiv" style="text-align: center;">

        </div>
    </div>
    <!--publictitle begin-->
    <%--<div>
        <%@ include file="/WEB-INF/view/admin_publicfooter.jsp" %>
    </div>--%>
    <!--publictitle end-->
</div>
<!-- /container -->
</body>
</html>