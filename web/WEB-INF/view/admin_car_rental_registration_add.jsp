<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>车辆出租登记-${applicationScope.projectName}</title>

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

                addCarNameForSelect();
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("填充车辆类别到下拉框中，数据解析出错！");
            }
        });
    });

    //获取车辆类别后，按选中的类别动态填充类别下车辆
    function addCarNameForSelect() {
        var carcategory = $("#carcategory").val();

        $.ajax({
            type: "POST",
            url: "<%=basePath%>getCar_NameInSelect.admin.do",
            data:{
              "carcategory":carcategory
            },
            async: false,
            cache: false,
            success: function (msg) {

                $("#carname").empty();
                $("#carname").append(msg);

            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("填充某车辆类别下的车辆到下拉框中，数据解析出错！");
            }
        });
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
    <form class="form-inline" role="form" style="margin-right: 200px;">
        <p>
            <button type="button" class="btn btn-primary" onclick="window.location.href='<%=basePath%>'+'url.admin.do?function=car_rental_registration'">返回车辆出租登记</button>
        </p>
    </form>

    <div style="width: 50%;margin-left: 300px; text-align: center;">

        <form class="form-horizontal" method="post" action="<%=basePath%>addCar_Take.admin.do"
              enctype="multipart/form-data" role="form"
              >

            <h3>车辆出租登记</h3>
            <br>

            <div class="form-group">
                <label for="carcategory" class="col-sm-2 control-label">所属类别</label>

                <div class="col-sm-10">
                    <select id="carcategory" name="carcategory" class="form-control" onchange="addCarNameForSelect()">
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="carname" class="col-sm-2 control-label">车辆名称</label>

                <div class="col-sm-10">
                    <select id="carname" name="carname" class="form-control" required>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="money" class="col-sm-2 control-label">实付价格</label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="money" name="money"
                           placeholder="实付价格" maxlength="10" onkeyup="this.value=this.value.replace(/\D/g,'')"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')"
                           required>
                </div>
            </div>

            <div class="form-group">
                <label for="takename" class="col-sm-2 control-label">登记人姓名</label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="takename" name="takename"
                           placeholder="登记人姓名" maxlength="10"
                           required>
                </div>
            </div>


            <div class="form-group">
                <label for="takelicence" class="col-sm-2 control-label">身份证号码</label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="takelicence" name="takelicence"
                           placeholder="身份证号码"
                           maxlength="18" required>
                </div>
            </div>


            <div class="form-group">
                <label for="moremessage" class="col-sm-2 control-label">更多信息</label>

                <div class="col-sm-10">
                    <textarea class="form-control" id="moremessage" name="moremessage" rows="3"></textarea>
                </div>
            </div>


            <button class="btn btn-lg btn-primary " data-loading-text="提交中..." type="submit">提交登记明细</button>
        </form>
    </div>

    <!--admin_publicfooter begin-->
    <div>
        <%@ include file="/WEB-INF/view/admin_publicfooter.jsp" %>
    </div>
    <!--admin_publicfooter end-->
</div>
<!-- /container -->
</body>
</html>