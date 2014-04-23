<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>权限管理-${applicationScope.projectName}</title>

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
    initFunctions();
});

// 弹出-用户权限设置层
function showFunctionUserInfo(username) {
    $("#username").val('');
    $("#username").val(username);
    getFunctionForUserInfo(username);
}

//获取此用户权限。在权限中默认选中
function getFunctionForUserInfo(username) {
    $.ajax({
        type: "post",
        url: "<%=basePath%>getFunctionForUserInfo.admin.do",
        data: {
            "username": username
        },
        async: false,
        cache: false,
        success: function (msg) {

            //循环将有权限的进行勾选
            var functions = document.getElementById("functions");
            for (var i = 0; i < functions.options.length; i++) {
                var c = functions.options[i].value;
                var codes = msg.split(",");
                var bl = false;
                for (var j = 0; j < codes.length; j++) {
                    if (c == codes[j]) {
                        bl = true;
                        functions.options[i].selected = true;
                        break;
                    }
                }
                if (!bl) {
                    functions.options[i].selected = false;
                }
            }

            $('#showFunctionUserInfo').modal('show');
        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("获取用户权限过程中，数据解析出错！");
        }
    });
}

//弹出层关闭回调函数
$('#showAddUserInfo').on('hide.bs.modal', function () {
    alert(11);
});

/**
 * 页面初始化，分页查询数据
 * */
function init(thisPage) {

    var search = $('#search').val();
    $.ajax({
        type: "post",
        url: "<%=basePath%>getUserInfos.admin.do",
        data: {
            "search": search,
            "pageShowSize": $("#pageShowSize").val(),
            "thisPage": thisPage,
            "pageMethodName": 'init'
        },
        async: false,
        cache: false,
        success: function (msg) {
            setBodyStr(msg);
        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("获取用户信息中，数据解析出错！");
        }
    });
}

//返回的分页数据，解析填充数据
function setBodyStr(msg) {

    //接受返回内容，解析
    var pageBody = msg.pageBody;
    var str = "";
    var data;

    var USERNAME;
    var USERSEX;
    var USERAGE;
    var USERPHONE;
    var USEREMAIL;
    var USERADDRESS;

    for (var i = 0; i < pageBody.length; i++) {

        data = pageBody[i];
        USERNAME = data.USERNAME;
        USERSEX = data.USERSEX;
        USERAGE = data.USERAGE;
        USERPHONE = data.USERPHONE;
        USEREMAIL = data.USEREMAIL;
        USERADDRESS = data.USERADDRESS;

        if (USERADDRESS == null) {
            USERADDRESS = '';
        }
        if (USERSEX == null) {
            USERSEX = '';
        }
        if (USERAGE == null) {
            USERAGE = '';
        }
        if (USERPHONE == null) {
            USERPHONE = '';
        }
        if (USERADDRESS == null) {
            USERADDRESS = '';
        }

        str += "<tr><th>" + USERNAME + "</th>"
                + "<th>" + USERSEX + "</th>"
                + "<th>" + USERAGE + "</th>"
                + "<th>" + USERPHONE + "</th>"
                + "<th>" + USEREMAIL + "</th>"
                + "<th>" + USERADDRESS + "</th>" +
                "<th><span class=\"label label-success\" title=\"对" + USERNAME + "用户的权限配置\" style=\"cursor:pointer;\" onclick=\"showFunctionUserInfo('" + USERNAME + "')\">权限配置</span></th></tr>";

    }
    if (str == "") {
        str += "<th colspan='7'><br><div class=\"jumbotron\"><p> 无结果集,请核实条件后查询！ </p></div></th>";
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


/**
 * 页面初始化，获取所有权限写成下拉框
 * */
function initFunctions() {

    $.ajax({
        type: "get",
        url: "<%=basePath%>getFunctions.admin.do?onchangeName=isHavaClean()&idName=functions",
        async: false,
        cache: false,
        success: function (msg) {
            $("#functionbody").empty();
            $("#functionbody").append(msg);
        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("页面初始化，获取所有权限写成下拉框中，数据解析出错！");
        }
    });
}

//保存用户权限
function saveFunctionForUserInfo() {

    var username = $("#username").val();

    var data = '';
    var id;
    var functions = document.getElementById("functions");
    for (var i = 0; i < functions.options.length; i++) {
        var c = functions.options[i];
        if (c.selected) {
            id = c.id;
            if (id == '0') {
                if (!confirm("您选择了清空所有权限，确定继续吗？")) {
                    return false;
                }
            }
            data += c.id + ",";
        }
    }

    if (username == '') {
        return false;
    }
    layer.msg('保存用户权限数据中...', 1, -1);
    $.ajax({
        type: "post",
        url: "<%=basePath%>saveFunctionUserInfo.admin.do",
        data: {"username": username,
            data: data
        },
        async: false,
        cache: false,
        success: function (msg) {
            if (msg == '1') {
                $('#showFunctionUserInfo').modal('hide');
            } else {
                alert("保存用户权限过程中出错！");
            }
        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("JSON数据解析出错！");
        }
    });
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
        <div class="form-group">
            <label class="sr-only" for="search">search</label>
            <input type="text" class="form-control" id="search" placeholder="search">
        </div>

        <button type="button" class="btn btn-primary btn-sm" onclick="init(1);">搜索</button>
        &nbsp; &nbsp;
        <button type="button" class="btn btn-primary btn-sm" onclick="$('#search').val('');init(1);">刷新</button>

    </form>

    <div style="text-align: center;">
        <div class="bs-example">
            <br>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>用户名</th>
                    <th>性别</th>
                    <th>年龄</th>
                    <th>电话</th>
                    <th>邮箱</th>
                    <th>住址</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="tbody" style="font-size: 14px;font-weight: 100;">

                </tbody>
            </table>
            <!--分页start-->
            <div id="pageToolStr"></div>
            <!--分页end-->

        </div>
    </div>


    <!--弹出层 start 用户权限配置-->
    <div class="modal fade" id="showFunctionUserInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                    <h4 class="modal-title" id="myFunctionModalLabel">用户权限配置</h4></div>

                <div class="modal-body">
                    <center>
                        <span id="functionbody">
                        </span>
                    </center>
                    <input type="hidden" id="username" name="username">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="saveFunctionForUserInfo()">保存配置</button>
                </div>
            </div>
        </div>
    </div>
    <!--弹出层end  用户权限配置-->

    <!--publictitle begin-->
    <%--<div>
        <%@ include file="/WEB-INF/view/admin_publicfooter.jsp" %>
    </div>--%>
    <!--publictitle end-->
</div>
<!-- /container -->
</body>
</html>