<%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">

<title>${applicationScope.projectName}</title>
<link href="<%=basePath%>public/dist/css/bootstrap.css" rel="stylesheet">
<link href="<%=basePath%>public/css/offcancas.css" rel="stylesheet">

<script src="<%=basePath%>public/js/jquery-1.8.0.min.js"></script>
<script src="<%=basePath%>public/dist/js/bootstrap.min.js"></script>

<script>
    $(document).ready(function () {
        $('[data-toggle=offcanvas]').click(function () {
            $('.row-offcanvas').toggleClass('active');
        });
        initCategoryNames();
        init(1);
    });

    function initCategoryNames() {

        /**
         * 页面初始化，填充车辆类别到下拉框
         * */

        $.ajax({
            type: "get",
            url: "<%=basePath%>getCar_categorysIna.do",
            data: {
                "categoryname": $("#categoryname").val()

            },
            async: false,
            cache: false,
            success: function (msg) {

                $("#searchcategoryname").empty();
                $("#searchcategoryname").append(msg);

            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("填充车辆类别到下拉框中，数据解析出错！");
            }
        });
    }

    function setcategoryname(categoryname) {
        $("#categoryname").val(categoryname);
        $("#money").attr("value","全部");
        initCategoryNames();
        init(1);
    }

    /**
     * 页面初始化，分页查询数据
     * */
    function init(thisPage) {

        var search = $("#money").val();
        $.ajax({
            type: "post",
            url: "<%=basePath%>getCar_Messages.do",
            data: {
                "thisPage": thisPage,
                "pageShowSize": $("#pageShowSize").val(),
                "pageMethodName": 'init',
                "categoryname": $("#categoryname").val(),
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
                    "><img  width=\"230px\" height=\"250px\"  src=\"<%=basePath%>" + CARPICTURE + "\"></a>" +
                    "<div class=\"caption\">" +
                    "<h4>" + CARNAME + "</h4>" +
                    "<p>类别：" + CARCATEGORY + "</p>" +
                    "<p>日租价钱：" + ONEDAY + " 元" + "</p>" +
                    "<p>百里价格：" + BAIGONGLI + " 元" + "</p>" +
                    "<p>车辆油耗：" + CARFUEL + " L" + "</p>" +
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
    function F5() {
        initCategoryNames();
        init(1);
    }

</script>
</head>
<body>

<!--publictitle begin-->
<%@ include file="/WEB-INF/view/reception/receptiontitle.jsp" %>
<!--publictitle end-->

<div class="container">
    <input type="hidden" id="categoryname" name="categoryname" value="">
    <input type="hidden" id="searchbody" name="searchbody" value="">
    <input type="hidden" id="thisPage" name="thisPage" value="1"/>
    <input type="hidden" id="pageShowSize" name="pageShowSize" value="4"/>

    <div class="row row-offcanvas row-offcanvas-right">

        <div class="col-xs-12 col-sm-9">
            <img width="900px" height="200px" src="<%=basePath%>public/image/banner.jpg">

            <div class="row" ID="show">
                <div style="text-align: center;">
                    <div class="bs-example">
                        <br>

                        <div id="bodystr"></div>
                    </div>

                    <!--分页start-->
                    <div id="pageToolStr"></div>
                    <!--分页end-->
                </div>
            </div>
            <!--/row-->
        </div>
        <!--/span-->

        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar" role="navigation" style="overflow:scroll; ">
            <div class="list-group" id="searchcategoryname">
            </div>
            <div class="list-group" id="sad">


                <div class="form-group">
                    <label class="col-sm-2 control-label">价格</label>

                    <div class="col-sm-10">
                        <select id="money" name="money" class="form-control" style="width: 120px;" onchange="F5()">
                            <option id="全部">全部</option>
                            <option id="500以下">500以下</option>
                            <option id="1000-2000">1000-2000</option>
                            <option id="2000-5000">2000-5000</option>
                            <option id="5000-10000">5000-10000</option>
                            <option id="10000以上">10000以上</option>
                        </select>
                    </div>
                </div>

            </div>
        </div>
        <!--/span-->
    </div>
    <!--/row-->

    <!--publictitle begin-->
    <div>
        <%@ include file="/WEB-INF/view/admin_publicfooter.jsp" %>
    </div>
    <!--publictitle end-->
</div>

<!--/.container-->

</body>
</html>
