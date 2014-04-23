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
    init(1);
});

// 弹出-添加用户-每次弹出时清空密码框，防止浏览器记录
function showAddUserInfo() {

    $('#password').val('');
    $('#showAddUserInfo').modal('show');
}

// 弹出-修改用户-每次弹出时清空密码框，防止浏览器记录
function showUpdateUserInfo(username, email, age, sex, phone, address) {

    $("#updateusername").val(username);
    $('#updatepassword').val('');

    $("#updateemail").val(email);
    $("#updatesex").attr("value", sex);
    $("#updateage").val(age);
    $("#updatephone").val(phone);
    $("#updateaddress").val(address);

    $('#showUpdateUserInfo').modal('show');
}

// 弹出-删除用户
function showDeleteUserInfo(username) {

    $('#delusername').val('');
    $('#showDeleteUserInfo').modal('show');
    $('#delusername').val(username);
    $('#delbody').empty();
    $('#delbody').append("<h4>确定要删除 [ " + username + " ] 用户及该用户的所有配置信息吗？</h4>");

}

//弹出层关闭回调函数
$('#showAddUserInfo').on('hide.bs.modal', function () {
    alert(11);
});

/**
 * 页面初始化，分页查询数据
 * */
function init(thisPage) {
    layer.msg('加载数据中...', 1, -1);
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
    var str = '';
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

        str += "<tr><th> <a style='color:#4876FF;text-decoration:underline;cursor:pointer;'" +
                "onclick=\"showUpdateUserInfo('" + USERNAME + "','" + USEREMAIL + "','" + USERAGE + "','" + USERSEX + "','" + USERPHONE + "','" + USERADDRESS + "');\">" + USERNAME + "</a></th>"
                + "<th>" + USERSEX + "</th>"
                + "<th>" + USERAGE + "</th>"
                + "<th>" + USERPHONE + "</th>"
                + "<th>" + USEREMAIL + "</th>"
                + "<th>" + USERADDRESS + "</th>" +
                "<th><span class=\"label label-danger\" title=\"删除" + USERNAME + "用户\" style=\"cursor:pointer;\" onclick=\"showDeleteUserInfo('" + USERNAME + "')\">删除</span></th></tr>";

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
 *添加用户，判断用户名是否重复
 */
function addUser() {

    var username = $("#username").val();
    if (username == '') {
        $("#username").css({backgroundColor: "#FF0000" });
        return false;
    }

    $.ajax({
        type: "post",
        url: "<%=basePath%>isHavaThisUserName.admin.do",
        data: {"username": username
        },
        async: false,
        cache: false,
        success: function (msg) {

            if (msg == '1') {
                layer.msg('用户名重复,请重新输入...', 1, -1);
                $("#username").css({backgroundColor: "#FF0000" });
                return false;
            } else {
                addUserInfo(username);
            }
        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("数据解析出错！");
        }
    });
}

//添加用户，，判断数据完整性
function addUserInfo(username) {

    var password = $("#password").val();
    var email = $("#email").val();
    var sex = $("#sex").val();
    var age = $("#age").val();
    var phone = $("#phone").val();
    var address = $("#address").val();

    if (password == '') {
        $("#password").css({backgroundColor: "#FF0000" });
        return false;
    }
    if (email == '') {
        $("#email").css({backgroundColor: "#FF0000" });
        return false;
    }


    layer.msg('添加用户信息中...', 1, -1);
    $.ajax({
        type: "post",
        url: "<%=basePath%>addUserInfo.admin.do",
        data: {"username": username,
            "password": password,
            "email": email,
            "sex": sex,
            "age": age,
            "phone": phone,
            "address": address
        },
        async: false,
        cache: false,
        success: function (msg) {
            if (msg == '1') {
                $('#showAddUserInfo').modal('hide');
                F5();
            } else {
                alert("添加用户过程中出错！");
            }
        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("JSON数据解析出错！");
        }
    });
}

//修改用户，，判断数据完整性
function updateUser() {

    var username = $("#updateusername").val();
    var password = $("#updatepassword").val();
    var email = $("#updateemail").val();
    var sex = $("#updatesex").val();
    var age = $("#updateage").val();
    var phone = $("#updatephone").val();
    var address = $("#updateaddress").val();

    if (password == '') {
        $("#updatepassword").css({backgroundColor: "#FF0000" });
        return false;
    }
    if (email == '') {
        $("#updateemail").css({backgroundColor: "#FF0000" });
        return false;
    }
	
    layer.msg('修改用户信息中...', 1, -1);
    $.ajax({
        type: "post",
        url: "<%=basePath%>updateUserInfo.admin.do",
        data: {"username": username,
            "password": password,
            "email": email,
            "sex": sex,
            "age": age,
            "phone": phone,
            "address": address
        },
        async: false,
        cache: false,
        success: function (msg) {
            if (msg == '1') {
                $('#showUpdateUserInfo').modal('hide');
                F5();
            } else {
                alert("修改用户过程中出错！");
            }
        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("JSON数据解析出错！");
        }
    });
}

//删除用户，，判断数据完整性
function deleteUser() {

    var username = $("#delusername").val();

    if (username == '') {
        layer.msg('获取删除数据失败...', 1, -1);
        return false;
    }

    $.ajax({
        type: "post",
        url: "<%=basePath%>delUserInfo.admin.do",
        data: {"username": username
        },
        async: false,
        cache: false,
        success: function (msg) {
            if (msg == '0') {
                layer.msg('删除用户信息成功，刷新页面中...', 1, -1);
                $('#showDeleteUserInfo').modal('hide');
                F5();
            } else {
                alert("删除用户过程中出错！");
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

<input type="hidden" id="pageShowSize" name="pageShowSize" value="10"/>

<div class="container">

<!-- Main component for a primary marketing message or call to action -->
<form class="form-inline" role="form">
    <div class="form-group">
        <label class="sr-only" for="search">search</label>
        <input type="text" class="form-control" id="search" placeholder="search">
    </div>

    <button type="button" class="btn btn-primary btn-sm" onclick="init(1);">搜索</button>
    &nbsp; &nbsp;
    <button type="button" class="btn btn-primary btn-sm" onclick="$('#search').val('');init(1);">刷新</button>
    &nbsp;
    <div class="form-group">
        <a class="btn btn-primary btn-sm" onclick="showAddUserInfo()" role="button">新建用户 &raquo;</a>
    </div>

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

<!--弹出层 start 新建用户-->

<div class="modal fade" id="showAddUserInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                <h4 class="modal-title" id="myModalLabel">新建用户</h4></div>

            <div class="modal-body">

                <form class="form-horizontal" role="form" id="addUserInfo">
                    <div class="form-group">
                        <label for="username" class="col-sm-2 control-label">用户名</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="username" placeholder="用户名"
                                   onfocus="$(this).css('backgroundColor','#FFFFFF');">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">密码</label>

                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="password" placeholder="密码"
                                   onfocus="$(this).css('backgroundColor','#FFFFFF');">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">邮箱</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email" placeholder="邮箱"
                                   onfocus="$(this).css('backgroundColor','#FFFFFF');">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>

                        <div class="col-sm-10">
                            <select id="sex" class="form-control">
                                <option id="0">男</option>
                                <option id="1">女</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="age" class="col-sm-2 control-label">年龄</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="age" placeholder="年龄"
                                   onkeyup="this.value=this.value.replace(/\D/g,'')"
                                   onafterpaste="this.value=this.value.replace(/\D/g,'')"
                                   maxlength="2">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="phone" class="col-sm-2 control-label">电话号码</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="phone" placeholder="电话号码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="address" class="col-sm-2 control-label">住址</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="address" placeholder="住址">
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="addUser()">添加用户</button>
            </div>
        </div>
    </div>
</div>
<!--弹出层end  新建用户-->


<!--弹出层 start 修改用户-->
<div class="modal fade" id="showUpdateUserInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                <h4 class="modal-title" id="myUpdateModalLabel">修改用户</h4></div>

            <div class="modal-body">

                <form class="form-horizontal" role="form" id="UpdateUserInfo">
                    <div class="form-group">
                        <label for="username" class="col-sm-2 control-label">用户名</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="updateusername" placeholder="用户名"
                                   disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">密码</label>

                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="updatepassword" placeholder="密码"
                                   onfocus="$(this).css('backgroundColor','#FFFFFF');" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">邮箱</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="updateemail" placeholder="邮箱"
                                   onfocus="$(this).css('backgroundColor','#FFFFFF');" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>

                        <div class="col-sm-10">
                            <select id="updatesex" class="form-control">
                                <option id="2">男</option>
                                <option id="3">女</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="age" class="col-sm-2 control-label">年龄</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="updateage" placeholder="年龄"
                                   onkeyup="this.value=this.value.replace(/\D/g,'')"
                                   onafterpaste="this.value=this.value.replace(/\D/g,'')"
                                   maxlength="2" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="phone" class="col-sm-2 control-label">电话号码</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="updatephone" placeholder="电话号码" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="address" class="col-sm-2 control-label">住址</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="updateaddress" placeholder="住址">
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="updateUser()">确认修改用户</button>
            </div>
        </div>
    </div>
</div>
<!--弹出层end  修改用户-->

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