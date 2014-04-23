<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>用户管理-${applicationScope.projectName}</title>

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

    // 弹出-添加用户-每次弹出时清空密码框，防止浏览器记录
    function showAddUserInfo() {

        $('#password').val('');
        $('#showAddUserInfo').modal('show');
    }


    /**
     * 页面初始化，分页查询数据
     * */
    function init(thisPage) {

        var search = $('#search').val();
        var isHaveEndTime = $("#isHaveEndTime").attr("checked");
        if (isHaveEndTime == null) {
            isHaveEndTime = '';
        }
        $.ajax({
            type: "post",
            url: "<%=basePath%>getCar_Takes.admin.do",
            data: {
                "search": search,
                "searchBody": $("#searchbody").val(),
                "pageShowSize": $("#pageShowSize").val(),
                "thisPage": thisPage,
                "isHaveEndTime": isHaveEndTime,
                "pageMethodName": 'init'
            },
            async: false,
            cache: false,
            success: function (msg) {
                setBodyStr(msg);
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("获取登记信息中，数据解析出错！");
            }
        });
    }

    //返回的分页数据，解析填充数据
    function setBodyStr(msg) {

        //接受返回内容，解析
        var pageBody = msg.pageBody;
        var str = '';
        var data;

        var CARNAME;// 登记车名字
        var CATEGORY;// 登记车所属类别
        var MONEY;// 出租价格
        var STARTTIME;// 租用开始时间
        var ENDTIME;//  租用结束时间
        var MOREMESSAGE;//  更多信息
        var TAKENAME;//  登记人姓名
        var TAKELICENCE;// 登记人身份证号码


        for (var i = 0; i < pageBody.length; i++) {

            data = pageBody[i];
            CARNAME = data.CARNAME;
            CATEGORY = data.CATEGORY;
            MONEY = data.MONEY;
            STARTTIME = data.STARTTIME;
            ENDTIME = data.ENDTIME;
            MOREMESSAGE = data.MOREMESSAGE;
            TAKENAME = data.TAKENAME;
            TAKELICENCE = data.TAKELICENCE;

            if (CARNAME == null) {
                CARNAME = '获取失败';
            }
            if (CATEGORY == null) {
                CATEGORY = '获取失败';
            }
            if (MONEY == null) {
                MONEY = '获取失败';
            }
            if (STARTTIME == null) {
                STARTTIME = '获取失败';
            }
            if (ENDTIME == null) {
                ENDTIME = "<span class=\"label label-danger\"style=\"cursor:pointer;\" onclick=\"setEndTime('" + CARNAME + "','" + CATEGORY + "','" + STARTTIME + "')\">设为归还</span>";
            }
            if (MOREMESSAGE == null) {
                MOREMESSAGE = '----';
            }
            if (TAKENAME == null) {
                TAKENAME = '获取失败';
            }
            if (TAKELICENCE == null) {
                TAKELICENCE = '获取失败';
            }

            str += "<tr><th>" + CATEGORY + "</th>"
                    + "<th>" + CARNAME + "</th>"
                    + "<th>" + MONEY + "</th>"
                    + "<th>" + TAKENAME + "</th>"
                    + "<th>" + TAKELICENCE + "</th>"
                    + "<th>" + MOREMESSAGE + "</th>"
                    + "<th>" + STARTTIME + "</th>"
                    + "<th>" + ENDTIME + "</th></tr>";

        }

        if (str == "") {
            str += "<th colspan='8'><br><div class=\"jumbotron\"><p> 无结果集,请核实条件后查询！ </p></div></th>";
        }
        //填充表格内容
        $("#tbody").empty();
        $("#tbody").append(str);

        //填充分页工具条
        $("#pageToolStr").empty();
        $("#pageToolStr").append(msg.pageToolStr);

        //设置当前页
        $("#thisPage").val(msg.thisPage);

    }

    //设置归还
    function setEndTime(carname, category, starttime) {

        $.ajax({
            type: "post",
            url: "<%=basePath%>setEndTime.admin.do",
            data: {
                "carname": carname,
                "category": category,
                "starttime": starttime
            },
            async: false,
            cache: false,
            success: function (msg) {
                if (msg == '1') {
                    layer.msg('设置车辆登记为归还状态成功，刷新页面中...', 1, -1);
                    F5();
                } else {
                    alert("设置车辆登记为归还状态过程中出错！");
                }
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("JSON数据解析出错！");
            }
        });

    }
    //按条件查找
    function searchBody(searchbody) {
        $("#searchbody").val(searchbody);
        init(1);
    }

    // 刷新页面
    function F5() {
        init($("#thisPage").val());
    }

    //录入新登记
    function admin_car_rental_registration_GO() {
        window.location.href = "<%=basePath%>admin_car_rental_registration.admin.do";
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

<input type="hidden" id="pageShowSize" name="pageShowSize" value="10"/>
<input type="hidden" id="searchbody" name="searchbody" value="">

<div class="container">

    <!-- Main component for a primary marketing message or call to action -->
    <form class="form-inline" role="form">
        <div class="form-group">
            <label class="sr-only" for="search">search</label>
            <input type="text" class="form-control" id="search" placeholder="search">
        </div>

        <button type="button" class="btn btn-primary btn-sm" onclick="init(1);">搜索</button>
        &nbsp;
        <button type="button" class="btn btn-primary btn-sm" onclick="searchBody('oneweek')">查看一星期内登记</button>
        <button type="button" class="btn btn-primary btn-sm" onclick="searchBody('onemonth')">查看一个月内登记</button>
        <button type="button" class="btn btn-primary btn-sm" onclick="searchBody('threemonth')">查看近三个月内登记</button>
        <button type="button" class="btn btn-primary btn-sm" onclick="searchBody('halfyear')">查看近半年内登记</button>
        <button type="button" class="btn btn-primary btn-sm" onclick="searchBody('')">显示全部</button>
        <button type="button" class="btn btn-primary btn-sm" onclick="admin_car_rental_registration_GO()">
            录入新登记 &raquo;</button>
        <div class="checkbox">
            <label>
                &nbsp;&nbsp; <input type="checkbox" id="isHaveEndTime" value="yes"> 只显示未归还
            </label>
        </div>
    </form>

    <div style="text-align: center;">
        <div class="bs-example">
            <br>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>所属类别</th>
                    <th>车辆名称</th>
                    <th>实付价格</th>
                    <th>登记人姓名</th>
                    <th>登记人身份证号码</th>
                    <th>更多信息</th>
                    <th>租用开始时间</th>
                    <th>租用结束时间</th>
                </tr>
                </thead>
                <tbody id="tbody" style="font-size: 14px;font-weight: 100; text-align: center;">

                </tbody>
            </table>
            <!--分页start-->
            <div id="pageToolStr"></div>
            <!--分页end-->

        </div>
    </div>


    <!--弹出层 start 删除用户-->
    <div class="modal fade" id="showDeleteUserInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                    <h4 class="modal-title" id="myDeleteModalLabel">删除用户</h4></div>

                <div class="modal-body">
                    <center>
                        <span id="delbody"></span>
                    </center>
                    <input type="hidden" id="delusername" name="delusername">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="deleteUser()">确认删除</button>
                </div>
            </div>
        </div>
    </div>
    <!--弹出层end  删除用户-->

    <!--publictitle begin-->
    <%--<div>
        <%@ include file="/WEB-INF/view/admin_publicfooter.jsp" %>
    </div>--%>
    <!--publictitle end-->
</div>
<!-- /container -->
</body>
</html>