<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>[${requestScope.categoryname}]类别-车辆明细管理-${applicationScope.projectName}</title>
    <link href="<%=basePath%>public/dist/css/bootstrap.css" rel="stylesheet">
    <script src="<%=basePath%>public/js/jquery-1.8.0.min.js"></script>
    <script src="<%=basePath%>public/dist/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>public/layer/layer.min.js"></script>
</head>

<style>

    body {
        padding-top: 70px;
    }

    H4 {
        line-height: 180%;
    }

</style>
<script>
$(function () {
    layer.msg('加载数据中...', 1, -1);
    init(1);
});

// 弹出-查看车辆明细
function showCar_Message(CARNAME, CARMESSAGE, CARCATEGORY, CARLEVEL, isshow, ONEDAY, BAIGONGLI, CARFUEL, FAVORABLEDAY, FAVORABLERATIO, CARRENTDAYS, CARFREE, STARTDATE) {
    var str = "";

    str += "<h4>车辆名称： " + CARNAME;//车名字
    str += "</h4><h4>所属类别： " + CARCATEGORY;//车类别
    str += "</h4><h4>车辆介绍： " + CARMESSAGE;//车介绍
    str += "</h4><h4>车辆级别： " + CARLEVEL;//车级别信息
    str += "</h4><h4>是否显示： " + isshow;//是否显示，0默认显示，1为不显示，即停用此业务车型
    str += "</h4><h4>日租价格： " + ONEDAY + " 元";//日租价钱
    str += "</h4><h4>百里价格： " + BAIGONGLI + " 元";//百公里出租价钱
    str += "</h4><h4>优惠条件： 每租" + FAVORABLEDAY + "天，递减" + FAVORABLERATIO + " 元";//优惠天数

    str += "</h4><h4>车辆油耗： " + CARFUEL + " L";//车耗油量
    str += "</h4><h4>空闲车数： " + CARFREE;//空闲車数
    str += "</h4><h4>累计被租： " + CARRENTDAYS + " 次";//被租用天数
    str += "</h4><h4>发布时间： " + getDataForTime(STARTDATE) + "</h4>";//上架时间

    $('#messageBody').empty().append(str);
    $('#showCar_Message').modal('show');
}

// 弹出-删除车辆类别
function showDeleteCar_Message(carname, carcategory) {

    $("#delcarname").val('');
    $("#delcarname").val(carname);
    $("#delcarcategory").val('');
    $("#delcarcategory").val(carcategory);


    $("#delbody").empty();
    $("#delbody").append("确认要删除 [ " + carcategory + " ] 类别下 [ " + carname + " ] 车辆明细吗？");

    $('#showDeleteCar_Category').modal('show');
}


/**
 * 页面初始化，分页查询数据
 * */
function init(thisPage) {

    var search = $("#search").val();

    $.ajax({
        type: "post",
        url: "<%=basePath%>getCar_Messages.admin.do",
        data: {
            "thisPage": thisPage,
            "pageShowSize": $("#pageShowSize").val(),
            "pageMethodName": 'init',
            "categoryname": "${requestScope.categoryname}",
            "search": search
        },
        async: false,
        cache: false,
        success: function (msg) {
            setBodyStr(msg);
        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("获取车辆信息中，数据解析出错！");
        }
    });
}

//返回的分页数据，解析填充数据
function setBodyStr(msg) {

    //接受返回内容，解析
    var pageBody = msg.pageBody;
    var str = "";
    var data;

    var CARNAME;//车名字
    var CARCATEGORY;//车类别
    var ONEDAY;//日租价钱
    var BAIGONGLI;//百公里出租价钱
    var FAVORABLEDAY;//优惠天数
    var FAVORABLERATIO;//优惠比例
    var CARMESSAGE;//车介绍
    var CARPICTURE;//车首页展示图片
    var CARLEVEL;//车级别信息
    var CARFUEL;//车耗油量
    var CARFREE;//空闲車数
    var CARRENTDAYS;//被租用天数
    var STARTDATE;//上架时间
    var ISSHOW;//是否显示，0默认显示，1为不显示，即停用此业务车型


    for (var i = 0; i < pageBody.length; i++) {

        data = pageBody[i];

        CARNAME = data.CARNAME;//车名字
        CARCATEGORY = data.CARCATEGORY;//车类别
        ONEDAY = data.ONEDAY;//日租价钱
        BAIGONGLI = data.BAIGONGLI;//百公里出租价钱
        FAVORABLEDAY = data.FAVORABLEDAY;//优惠天数
        FAVORABLERATIO = data.FAVORABLERATIO;//优惠比例
        CARMESSAGE = data.CARMESSAGE;//车介绍
        CARPICTURE = data.CARPICTURE;//车首页展示图片
        CARLEVEL = data.CARLEVEL;//车级别信息
        CARFUEL = data.CARFUEL;//车耗油量
        CARFREE = data.CARFREE;//空闲車数
        CARRENTDAYS = data.CARRENTDAYS;//被租用天数
        STARTDATE = data.STARTDATE;//上架时间
        ISSHOW = data.ISSHOW;//是否显示，0默认显示，1为不显示，即停用此业务车型


        if (CARNAME == null) {
            CARNAME = '获取车名称出错';
        }

        if (CARPICTURE == null) {
            CARPICTURE = '';
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
        if (CARFUEL == null) {
            CARFUEL = '暂无信息';
        }
        if (ONEDAY == null) {
            ONEDAY = '暂无价格';
        }

        if (BAIGONGLI == null) {
            BAIGONGLI = '暂无价格';
        }

        if (FAVORABLEDAY == null) {
            FAVORABLEDAY = '暂无信息';
        }
        if (FAVORABLERATIO == null) {
            FAVORABLERATIO = '暂无信息';
        }
        if (CARFREE == null) {
            CARFREE = '获取信息失败';
        }
        if (CARRENTDAYS == null) {
            CARRENTDAYS = '0';
        }
        if (STARTDATE == null) {
            STARTDATE = '暂无介绍';
        }

        str += " <div class=\"row\">" +
                "<div class=\"col-sm-6 col-md-3\">" +
                "<div class=\"thumbnail\">" +
                "<a class=\"thumbnail\" style=\"cursor:pointer;\"  " +
                "onclick=\"showCar_Message('" + CARNAME + "','" + CARMESSAGE + "','" + CARCATEGORY + "','" + CARLEVEL + "','" + isshow + "','" + ONEDAY + "','" + BAIGONGLI + "','" + CARFUEL + "','" + FAVORABLEDAY + "','" + FAVORABLERATIO + "','" + CARRENTDAYS + "','" + CARFREE + "','" + STARTDATE + "')\"" +
                "><img  width=\"230px\" height=\"250px\" title='点击查看更多明细' src=\"<%=basePath%>" + CARPICTURE + "\"></a>" +
                "<div class=\"caption\">" +
                "<h3>" + CARNAME + "</h3>" +
                "<p><br>类别：" + CARCATEGORY + "</p>" +
                "<p><br><a class=\"btn btn-warning btn-sm\" role=\"button\" onclick=\"setState('" + CARNAME + "','" + CARCATEGORY + "')\">" + isshow + "</a>" +
                "&nbsp;&nbsp;<a class=\"btn btn-primary btn-sm\" role=\"button\" onclick=\"updateCar_Message_Go('" + CARNAME + "','" + CARCATEGORY + "')\">修改明细</a>" +
                "&nbsp;&nbsp;<a class=\"btn btn-danger btn-sm\" role=\"button\" onclick=\"showDeleteCar_Message('" + CARNAME + "','" + CARCATEGORY + "')\">删除此车辆</a> </p>" +
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


//删除某类别下的某车辆信息
function deletecar_message() {

    var delcarname = $("#delcarname").val();
    var delcarcategory = $("#delcarcategory").val();
    if (delcarname == '' || delcarcategory == '') {
        layer.msg('获取删除数据失败...', 1, -1);
        return false;
    }
    alert(delcarname);
    $.ajax({
        type: "post",
        url: "<%=basePath%>deleteCar_MessageForId.admin.do",
        data: {"carname": delcarname,
            "carcategory": delcarcategory
        },
        async: false,
        cache: false,
        success: function (msg) {
            if (msg == '1') {
                layer.msg('删除车辆信息成功，刷新页面中...', 1, -1);
                $('#showDeleteCar_Category').modal('hide');
                F5();
            } else {
                alert("删除车辆过程中出错！");
            }
        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("JSON数据解析出错！");
        }
    });
}

//设置车辆显示状态
function setState(carname, carcategory) {

    $.ajax({
        type: "post",
        url: "<%=basePath%>setStateForCar_Message.admin.do",
        data: {"carname": carname,
            "carcategory": carcategory
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

//跳转到添加车辆明细界面
function addCar_Message() {
    window.location.href = "<%=basePath%>addCar_Message_Go.admin.do";
}

//跳转到修改车辆明细界面
function updateCar_Message_Go(carname, carcategory) {
    carname = encodeURI(carname);
    carname = encodeURI(carname);
    carcategory = encodeURI(carcategory);
    carcategory = encodeURI(carcategory);
    window.location.href = "<%=basePath%>updateCar_Message_Go.admin.do?carname=" + carname + "&carcategory=" + carcategory;
}


//将time 毫秒转换为日期-数据库中转换时候出现bug，因此在js中转
function getDataForTime(time) {

    var d = new Date(time);
    d.setTime(time);
    var year = d.getFullYear();
    var month = d.getMonth() + 1;
    var day = d.getDate();

    return year + "年" + month + "月" + day + "日";

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


<div class="container">
    <input type="hidden" id="thisPage" name="thisPage" value="1"/>
    <input type="hidden" id="pageShowSize" name="pageShowSize" value="4"/>
    <!-- Main component for a primary marketing message or call to action -->
    <form class="form-inline" role="form">
        <div class="form-group">
            <label class="sr-only" for="search">search</label>
            <input type="text" class="form-control" id="search" placeholder="类别 - ${requestScope.categoryname}">
        </div>

        <button type="button" class="btn btn-primary btn-sm" onclick="init(1);">搜索</button>
        &nbsp;
        <button type="button" class="btn btn-primary btn-sm" onclick="$('#search').val('');init(1);">刷新</button>
        &nbsp;
        <div class="form-group">
            <a class="btn btn-primary btn-sm" onclick="addCar_Message()" role="button">添加车辆明细&raquo;</a>
        </div>
        &nbsp; <a class="btn btn-primary btn-sm"
                  onclick="window.location.href = '<%=basePath%>url.admin.do?function=car_message';"
                  role="button">返回车辆明细管理&raquo;</a>
        &nbsp; <a>点击图片查看更多明细&raquo;</a>

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

    <!--弹出层 start 车辆明细查看-->
    <div class="modal fade" id="showCar_Message" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                    <h4 class="modal-title" id="showCar_MessageLabel">车辆明细查看</h4></div>

                <div class="modal-body" style="text-align: left;">
                    <div class="panel panel-default">
                        <div class="panel-body" id="messageBody" style="line-height:inherit;">
                        </div>
                    </div>
                    <div class="control-label"></div>
                </div>
            </div>
        </div>
    </div>
    <!--弹出层 end  车辆明细查看-->

    <!--弹出层 start 删除车辆信息-->
    <div class="modal fade" id="showDeleteCar_Category" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                    <h4 class="modal-title" id="myDeleteModalLabel">删除车辆信息</h4></div>

                <div class="modal-body" style="text-align: center;">
                    <span id="delbody"></span>
                    <input type="hidden" id="delcarname" name="delcarname">
                    <input type="hidden" id="delcarcategory" name="delcarcategory">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="deletecar_message()">确认删除</button>
                </div>
            </div>
        </div>
    </div>
    <!--弹出层end  删除车辆信息-->

    <!--admin_publicfooter begin-->
    <%--<div>
        <%@ include file="/WEB-INF/view/admin_publicfooter.jsp" %>
    </div>--%>
    <!--admin_publicfooter end-->
</div>
<!-- /container -->
</body>
</html>