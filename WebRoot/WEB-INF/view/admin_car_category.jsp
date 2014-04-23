<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>车辆类别管理-${applicationScope.projectName}</title>
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
$(function () {
    layer.msg('加载数据中...', 1, -1);
    init(1);
});

// 弹出-新建车辆类别
function showAddCar_category() {
    $('#categorypicture').val('');
    $('#showAddCar_category').modal('show');
}

// 弹出-修改车辆类别
function showUpdateCar_Category(updatecategoryname, updateisshow, updatecategorymessage) {
    $('#updatecategoryname').val(updatecategoryname);
    $('#updateisshow').attr("value", updateisshow);
    $('#updatecategorymessage').val(updatecategorymessage);
    $('#updatecategorypicture').val('');

    $('#categoryname_').val(updatecategoryname);
    $('#showUpdateCar_Category').modal('show');
}

// 弹出-删除车辆类别
function showDeleteCar_Category(ID) {

    $("#delname").val('');
    $("#delname").val(ID);

    $("#delbody").empty();
    $("#delbody").append("删除 [ " + ID + " ] 类别，所有属于此类别的车辆将被删除<br>您确定要删除吗？");

    $('#showDeleteCar_Category').modal('show');
}


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
                "<p><br><a class=\"btn btn-warning btn-sm\" role=\"button\" onclick=\"setState('" + CATEGORYNAME + "')\">" + isshow + "</a>" +
                "&nbsp;&nbsp;<a class=\"btn btn-primary btn-sm\" role=\"button\" onclick=\"showUpdateCar_Category('" + CATEGORYNAME + "','" + ISSHOW + "','" + CATEGORYMESSAGE + "')\">修改信息</a>" +
                "&nbsp;&nbsp;<a class=\"btn btn-danger btn-sm\" role=\"button\" onclick=\"showDeleteCar_Category('" + CATEGORYNAME + "')\">删除此类别</a> </p>" +
                "</div></div></div>";

    }

    if (str == "") {
        str += "<br><div class=\"jumbotron\"><p> 无结果集,请核实条件后查询！</p></div>";
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


//添加车辆类别前，，判断数据完整性
function addCar_Category() {

    var categoryname = $("#categoryname").val();
    if (categoryname == '') {
        $("#categoryname").css({backgroundColor: "#FF0000" });
        return false;
    }
    if ($("#categorypicture").val() == '') {
        layer.msg('请选择图片...', 1, -1);
        return false;
    }

    $.ajax({
        type: "post",
        url: "<%=basePath%>isHavaThisCar_Category.admin.do",
        data: {"categoryname": categoryname
        },
        async: false,
        cache: false,
        success: function (msg) {
            if (msg == '1') {
                layer.msg('车辆类别名重复,请重新输入...', 1, -1);
                $("#categoryname").css({backgroundColor: "#FF0000" });
                return false;
            } else {
                layer.msg('添加车辆类别信息中...', 1, -1);
                $("#AddCar_category").submit();
            }
        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("数据解析出错！");
        }
    });


}

//修改车辆类别前，，判断数据完整性
function updatecar_category() {

    var categoryname = $("#updatecategoryname").val();
    if (categoryname == '') {
        $("#updatecategoryname").css({backgroundColor: "#FF0000" });
        return false;
    }
    if ($("#updatecategorypicture").val() == '') {
        layer.msg('请选择图片...', 1, -1);
        return false;
    }
    layer.msg('修改车辆类别信息中...', 1, -1);
    $("#updateCar_Category").submit();
}

//删除车辆类别，判断数据完整性
function deletecar_category() {

    var delname = $("#delname").val();

    if (delname == '') {
        layer.msg('获取删除数据失败...', 1, -1);
        return false;
    }

    $.ajax({
        type: "post",
        url: "<%=basePath%>delCar_categoryForId.admin.do",
        data: {"ID": delname
        },
        async: false,
        cache: false,
        success: function (msg) {
            if (msg == '1') {
                layer.msg('删除车辆类别信息成功，刷新页面中...', 1, -1);
                $('#showDeleteCar_Category').modal('hide');
                F5();
            } else {
                alert("删除车辆类别过程中出错！");
            }
        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("JSON数据解析出错！");
        }
    });
}

//设置车辆显示状态
function setState(categoryname) {

    $.ajax({
        type: "post",
        url: "<%=basePath%>setState.admin.do",
        data: {"categoryname": categoryname
        },
        async: false,
        cache: false,
        success: function (msg) {
            if (msg == '1') {
                layer.msg('设置车辆显示状态成功，刷新页面中...', 1, -1);
                F5();
            } else {
                alert("设置车辆显示状态过程中出错！");
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
        <a class="btn btn-primary btn-sm" onclick="showAddCar_category()" role="button">新建车辆类别 &raquo;</a>
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


<!--弹出层 start 新建车辆类别-->
<div class="modal fade" id="showAddCar_category" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                <h4 class="modal-title" id="myAddModalLabel">新建车辆类别</h4></div>

            <div class="modal-body">

                <form class="form-horizontal" method="post" action="<%=basePath%>addCar_Category.admin.do"
                      enctype="multipart/form-data" role="form"
                      name="AddCar_category" id="AddCar_category">
                    <div class="form-group">
                        <label for="categoryname" class="col-sm-2 control-label">类别名称</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="categoryname" name="categoryname"
                                   placeholder="车辆类别名称" maxlength="10"
                                   onfocus="$(this).css('backgroundColor','#FFFFFF');" required>
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="categorypicture" class="col-sm-2 control-label">展示图片</label>

                        <div class="col-sm-10">
                            <input type="file" id="categorypicture" name="categorypicture">
                            支持 png、jpg、gjf 格式&nbsp;默认250*280&nbsp;最大支持5M
                        </div>


                    </div>
                    <div class="form-group">
                        <label for="categorymessage" class="col-sm-2 control-label">类别介绍</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="categorymessage" name="categorymessage"
                                   placeholder="类别介绍"
                                   maxlength="15">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">是否展示</label>

                        <div class="col-sm-10">
                            <select id="isshow" name="isshow" class="form-control">
                                <option id="0">是</option>
                                <option id="1">否</option>
                            </select>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="addCar_Category()">确认添加</button>
            </div>
        </div>
    </div>
</div>
<!--弹出层end  新建车辆类别-->


<!--弹出层 start 车辆类别修改-->
<div class="modal fade" id="showUpdateCar_Category" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                <h4 class="modal-title" id="myUpdateModalLabel">修改车辆类别信息</h4></div>

            <div class="modal-body">


                <form class="form-horizontal" role="form" method="post" id="updateCar_Category"
                      name="updateCar_Category"
                      action="<%=basePath%>updateCar_category.admin.do"
                      enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="updatecategoryname" class="col-sm-2 control-label">类别名称</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="updatecategoryname"
                                   name="updatecategoryname" placeholder="车辆类别名称" disabled
                                   maxlength="10">
                            <input type="hidden" id="categoryname_" name="categoryname_">
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="updatecategorypicture" class="col-sm-2 control-label">展示图片</label>

                        <div class="col-sm-10">
                            <input type="file" id="updatecategorypicture" name="updatecategorypicture">
                            支持 png、jpg、gjf 格式&nbsp;默认250*280&nbsp;最大支持5M
                        </div>

                    </div>
                    <div class="form-group">
                        <label for="updatecategorymessage" class="col-sm-2 control-label">类别介绍</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="updatecategorymessage"
                                   name="updatecategorymessage" placeholder="类别介绍"
                                   maxlength="15">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">是否展示</label>

                        <div class="col-sm-10">
                            <select id="updateisshow" name="updateisshow" class="form-control">
                                <option id="2">是</option>
                                <option id="3">否</option>
                            </select>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="updatecar_category()">确认修改</button>
            </div>
        </div>
    </div>
</div>
<!--弹出层end  车辆类别修改-->


<!--弹出层 start 删除车辆类别-->
<div class="modal fade" id="showDeleteCar_Category" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                <h4 class="modal-title" id="myDeleteModalLabel">删除车辆类别信息</h4></div>

            <div class="modal-body" style="text-align: center;">
                <span id="delbody"></span>
                <input type="hidden" id="delname" name="delname">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="deletecar_category()">确认删除</button>
            </div>
        </div>
    </div>
</div>
<!--弹出层end  删除车辆类别-->

<!--admin_publicfooter begin-->
<%--<div>
    <%@ include file="/WEB-INF/view/admin_publicfooter.jsp" %>
</div>--%>
<!--admin_publicfooter end-->
</div>
<!-- /container -->
</body>
</html>