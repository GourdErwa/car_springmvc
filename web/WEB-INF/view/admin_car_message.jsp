<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>车辆明细管理-${applicationScope.projectName}</title>

    <link href="<%=basePath%>public/dist/css/bootstrap.css" rel="stylesheet">
    <script src="<%=basePath%>public/js/jquery-1.8.0.min.js"></script>
    <script src="<%=basePath%>public/dist/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>public/layer/layer.min.js"></script>
</head>

<style>

    body {
        padding-top: 70px;
    }

</style>
<script>
    $(function ($) {
        layer.msg('加载数据中...', 1, -1);
        init(1);
    });


    /**
     * 页面初始化，分页查询数据
     * */
    function init(thisPage) {

        var search = $("#search").val();
        $.ajax({
            type: "post",
            url: "<%=basePath%>getCar_categorys.admin.do",
            data: {
                "thisPage": thisPage,
                "pageShowSize": $("#pageShowSize").val(),
                "pageMethodName": 'init',
                "search": search
            },
            async: false,
            cache: false,
            success: function (msg) {
                setBodyStr(msg);
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("获取车辆类别信息中，数据解析出错！");
            }
        });
    }

    //返回的分页数据，解析填充数据
    function setBodyStr(msg) {

        //接受返回内容，解析
        var pageBody = msg.pageBody;
        var str = "";
        var data;

        var CATEGORYNAME;//类别名称
        var ISSHOW;//是否显示,0默认显示，1为不显示（则停用所有改类别的车）
        var CATEGORYPICTURE;//类别首页图片
        var CATEGORYMESSAGE;//类别介绍


        for (var i = 0; i < pageBody.length; i++) {

            data = pageBody[i];
            CATEGORYNAME = data.CATEGORYNAME;
            ISSHOW = data.ISSHOW;
            CATEGORYPICTURE = data.CATEGORYPICTURE;
            CATEGORYMESSAGE = data.CATEGORYMESSAGE;

            if (CATEGORYNAME == null) {
                CATEGORYNAME = '获取类别名称出错';
            }
            if (ISSHOW == null) {
                ISSHOW = '否';
            }
            var isshow;
            if (ISSHOW == '否') {
                isshow = '已隐藏';
            } else {
                isshow = '展示中';
            }
            if (CATEGORYPICTURE == null) {
                CATEGORYPICTURE = '';//默认图片
            }
            if (CATEGORYMESSAGE == null) {
                CATEGORYMESSAGE = '暂无类别介绍';
            }
            str += " <div class=\"row\">" +
                    "<div class=\"col-sm-6 col-md-3\">" +
                    "<div class=\"thumbnail\">" +
                    "<img  width=\"230px\" height=\"250px\" src=\"<%=basePath%>" + CATEGORYPICTURE + "\">" +
                    "<div class=\"caption\">" +
                    "<h3>" + CATEGORYNAME + "</h3>" +
                    "<p><br>" + CATEGORYMESSAGE + "</p>" +
                    "<br><a class=\"btn btn-danger btn-sm\" role=\"button\" onclick=\"setCar_Message('" + CATEGORYNAME + "')\">管理此类别下车辆</a> </p>" +
                    "</div></div></div>";

        }

        if (str == "") {
            str += "<br><div class=\"jumbotron\"><p> 无结果集,请核实条件后查询！ </p></div>";
        }
        //填充页面分页内容
        $("#bodystr").empty();
        $("#bodystr").append(str);

        //填充分页工具条
        $("#pageToolStr").empty();
        $("#pageToolStr").append(msg.pageToolStr);

        //设置隐藏域-当前页
        $("#thisPage").val(msg.thisPage);

    }

    function addCar_Message() {
        window.location.href = "<%=basePath%>addCar_Message_Go.admin.do";
    }
    function setCar_Message(categoryname) {
        categoryname = encodeURI(categoryname);
        categoryname = encodeURI(categoryname);
        var url = "<%=basePath%>setCar_Message.admin.do?categoryname=" + categoryname;
        window.location.href = url;
    }

    // 刷新页面
    function F5() {
        init($("#thisPage").val());
    }

</script>
<body>

<!-- Fixed navbar -->
<div class="navbar navbar-default navbar-fixed-top" role="navigation">

    <!--publictitle begin-->
    <%@ include file="/WEB-INF/view/admin_publictitle.jsp" %>
    <!--publictitle end-->
</div>
<input type="hidden" id="thisPage" name="thisPage" value="1"/>

<div class="container">

    <input type="hidden" id="pageShowSize" name="pageShowSize" value="4"/>
    <!-- Main component for a primary marketing message or call to action -->

    <form class="form-inline" role="form">
        <div class="form-group">
            <label class="sr-only" for="search">search</label>
            <input type="text" class="form-control" id="search" placeholder="search">
        </div>
        <button type="button" class="btn btn-primary btn-sm" onclick="init(1);">搜索</button>
        &nbsp;
        <button type="button" class="btn btn-primary btn-sm" onclick="$('#search').val('');init(1);">刷新</button>
        &nbsp;
        <div class="form-group">
            <a class="btn btn-primary btn-sm" onclick="addCar_Message()" role="button">新建车辆&raquo;</a>
        </div>
    </form>

    <div style="text-align: center;">
        <div class="bs-example">
            <br>
            <div id="bodystr"></div>
        </div>
        <!--分页start-->
        <div id="pageToolStr"></div>
        <!--分页end-->
    </div>

    <input type="hidden" id="searchbody" name="searchbody" value="">

    <!--admin_publicfooter begin-->
    <%--<div>
        <%@ include file="/WEB-INF/view/admin_publicfooter.jsp" %>
    </div>--%>
    <!--admin_publicfooter end-->
</div>
<!-- /container -->
</body>
</html>