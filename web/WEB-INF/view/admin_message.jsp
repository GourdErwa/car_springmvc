<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>留言管理-${applicationScope.projectName}</title>

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

        var searchbody = $('#searchbody').val();

        $.ajax({
            type: "post",
            url: "<%=basePath%>getMessages.admin.do",
            data: {
                "search": searchbody,
                "pageShowSize":$("#pageShowSize").val(),
                "thisPage": thisPage,
                "pageMethodName": 'init'
            },
            async: false,
            cache: false,
            success: function (msg) {
                setBodyStr(msg);
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("获取留言信息中，数据解析出错！");
            }
        });
    }

    //返回的分页数据，解析填充数据
    function setBodyStr(msg) {

        //接受返回内容，解析
        var pageBody = msg.pageBody;
        var str = "";
        var data;

        var ID;
        var IP;
        var ADDRESS;
        var MESSAGEDATE;
        var MESSAGES;
        var ISSHOW;


        for (var i = 0; i < pageBody.length; i++) {

            data = pageBody[i];
            ID = data.ID;
            IP = data.IP;
            ADDRESS = data.ADDRESS;
            MESSAGEDATE = data.MESSAGEDATE;
            MESSAGES = data.MESSAGES;
            ISSHOW = data.ISSHOW;

            if (IP == null) {
                IP = '未知识别IP';
            }
            if (ADDRESS == null) {
                ADDRESS = '未识别的地址';
            }
            if (MESSAGEDATE == null) {
                MESSAGEDATE = '';
            }
            if (MESSAGES == null) {
                MESSAGES = '';
            }
            if (ISSHOW == null) {
                ISSHOW = '';
            }

            str += "<br><div class=\"jumbotron\"><p>" + MESSAGES + "<br></p>";

            str += "<blockquote class=\"pull-right\"> <p class=\"text-info\" style=\"font-size: 15px;\">" + IP + "  &nbsp; - &nbsp;" + ADDRESS + "&nbsp;&nbsp;&nbsp;&nbsp;" + MESSAGEDATE + "";
            str += "&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"label label-danger\" title=\"删除此留言记录\" style=\"cursor:pointer;\" onclick=\"delMessageForId(" + ID + ")\">删除</span>";
            str += "</p></blockquote></div>";
        }

        if (str == "") {
            str += "<br><div class=\"jumbotron\"><p> 无结果集,请核实条件后查询！ <a style=\"cursor:pointer;\" onclick='history.go(-1);'>返回&raquo;</a></p></div>";
        }

        //填充页面分页内容
        $("#message").empty();
        $("#message").append(str);

        //填充分页工具条
        $("#pageToolStr").empty();
        $("#pageToolStr").append(msg.pageToolStr);

        //设置隐藏域-当前页
        $("#thisPage").val(msg.thisPage);

    }


    //删除留言
    function delMessageForId(ID) {

        if (ID == '') {
            return false;
        }

        if (!confirm("您确定要删除此条留言吗？")) {
            return false;
        }

        $.ajax({
            type: "post",
            url: "<%=basePath%>delMessageForId.admin.do",
            data: {"ID": ID
            },
            async: false,
            cache: false,
            success: function (msg) {
                if (msg == '1') {
                    layer.msg('删除成功，刷新留言数据中...', 1, -1);
                    F5();
                } else {
                    alert("删除留言过程中出错！");
                }
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("JSON数据解析出错！");
            }
        });
    }

    //按条件查找
    function search(searchbody) {
        $("#searchbody").val(searchbody);

        init(1);
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
    <input type="hidden" id="pageShowSize" name="pageShowSize" value="10"/>
    <!-- Main component for a primary marketing message or call to action -->
    <form class="form-inline" role="form">

        <p>
            <button type="button" class="btn btn-primary btn-sm" onclick="search('oneweek')">查看一星期留言</button>
            <button type="button" class="btn btn-primary btn-sm" onclick="search('onemonth')">查看一个月留言</button>
            <button type="button" class="btn btn-primary btn-sm" onclick="search('threemonth')">查看近三个月留言</button>
            <button type="button" class="btn btn-primary btn-sm" onclick="search('halfyear')">查看近半年留言</button>
            <button type="button" class="btn btn-primary btn-sm" onclick="search('')">显示全部</button>
        </p>

    </form>

    <div style="text-align: center;">
        <div class="bs-example">

            <!--查询数据-->
            <div id="message"></div>

            <!--分页start-->
            <div id="pageToolStr"></div>
            <!--分页end-->


        </div>
    </div>
    <input type="hidden" id="searchbody" name="searchbody" value="">
    <!--admin_publicfooter begin-->
   <%-- <div>
        <%@ include file="/WEB-INF/view/admin_publicfooter.jsp" %>
    </div>--%>
    <!--admin_publicfooter end-->
</div>
<!-- /container -->
</body>
</html>