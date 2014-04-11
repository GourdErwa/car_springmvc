<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>修改车辆信息-${applicationScope.projectName}</title>

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


            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("填充车辆类别到下拉框中，数据解析出错！");
            }
        });

        //填充车辆类别成功后默认选中要修改车辆所属的类别
        $("#carcategory").attr("value", "${CARCATEGORY}");
        $("#carlevel").attr("value", "${CARLEVEL}");
        $("#isshow").attr("value", "${ISSHOW}");

        var carcategory_ = encodeURI("${CARCATEGORY}");
        carcategory_ = encodeURI(carcategory_);
        $("#carcategory_").val(carcategory_);
    });

    /**
     *验证 所属类别下该车是否重复是否重复
     */
    function isHavaThisCar() {

        var carName = $("#carName").val();
        var carCategory = $("#carCategory").val();
        $.ajax({
            type: "post",
            url: "<%=basePath%>isHavaThisCar.admin.do",
            data: {"carName": carName,
                "carCategory": carCategory
            },
            async: false,
            cache: false,
            success: function (msg) {

                if (msg == '1') {
                    layer.msg('所属类别下该车名称重复,请重新输入...', 1, -1);
                    return false;
                }
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("数据解析出错！");
                return false;
            }
        });
        layer.msg('修改成功,页面跳转中...', 1, -1);
        return true;
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
        <div class="form-group">
            <a style="cursor:pointer;"
               onclick="window.location.href = '<%=basePath%>url.admin.do?function=car_message';"
               role="button">返回车辆明细管理&raquo;</a>
        </div>
    </form>

    <div style="width: 50%;margin-left: 300px; text-align: center;">

        <form class="form-horizontal" method="post" action="<%=basePath%>updateCar_Message.admin.do"
              enctype="multipart/form-data" role="form"
              name="AddCar_category" id="AddCar_category" onsubmit="return isHavaThisCar();">
            <h3>修改车辆明细</h3>
            <br>

            <input type="hidden" id="carname" name="carname" value="${CARNAME}">
            <input type="hidden" id="picture" name="picture" value="${CARPICTURE}">
            <input type="hidden" id="carcategory_" name="carcategory_" value="">


            <div class="form-group">
                <label for="carname_" class="col-sm-2 control-label">车辆名称</label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="carname_" name="carname_"
                           placeholder="车辆名称" maxlength="10" value="${CARNAME}" disabled
                           required>
                </div>
            </div>

            <div class="form-group">
                <label for="carmessage" class="col-sm-2 control-label">车辆介绍</label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="carmessage" name="carmessage"
                           placeholder="车辆介绍" maxlength="15" value="${CARMESSAGE}"
                           required>
                </div>
            </div>

            <div class="form-group">
                <label for="carcategory" class="col-sm-2 control-label">所属类别</label>

                <div id="carCategorySelect"></div>
                <div class="col-sm-10">
                    <select id="carcategory" name="carcategory" class="form-control">
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="carlevel" class="col-sm-2 control-label">车辆级别</label>

                <div class="col-sm-10">
                    <select id="carlevel" name="carlevel" class="form-control">
                        <option id="C">C</option>
                        <option id="B">B</option>
                        <option id="A">A</option>
                        <option id="S">S</option>
                        <option id="S++">S++</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="carfuel" class="col-sm-2 control-label">车辆油耗</label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="carfuel" name="carfuel"
                           placeholder="车辆油耗(格式为1.0、1.3...)" maxlength="3" value="${CARFUEL}"
                           required>
                </div>
            </div>

            <div class="form-group">
                <label for="oneday" class="col-sm-2 control-label">日租价格</label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="oneday" name="oneday"
                           placeholder="日租价格" maxlength="10" onkeyup="this.value=this.value.replace(/\D/g,'')"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')" value="${ONEDAY}"
                           required>
                </div>
            </div>

            <div class="form-group">
                <label for="baigongli" class="col-sm-2 control-label">百公里价格</label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="baigongli" name="baigongli"
                           placeholder="百公里价格" maxlength="10" onkeyup="this.value=this.value.replace(/\D/g,'')"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')" value="${BAIGONGLI}"
                           required>
                </div>
            </div>


            <div class="form-group">
                <label for="favorableday" class="col-sm-2 control-label">优惠天数</label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="favorableday" name="favorableday"
                           placeholder="优惠天数" onkeyup="this.value=this.value.replace(/\D/g,'')"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')" value="${FAVORABLEDAY}"
                           maxlength="3">
                </div>
            </div>

            <div class="form-group">
                <label for="favorableratio" class="col-sm-2 control-label">优惠价格</label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="favorableratio" name="favorableratio"
                           placeholder="达到优惠天数后递减的价格" onkeyup="this.value=this.value.replace(/\D/g,'')"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')" value="${FAVORABLERATIO}"
                           maxlength="8">
                </div>
            </div>

            <div class="form-group">
                <label for="carPicture" class="col-sm-2 control-label">首页展示图片</label>

                <div class="col-sm-10">
                    <input type="file" id="carpicture" name="carpicture">
                    支持 png、jpg、gjf 格式&nbsp;默认250*280&nbsp;最大支持5M
                </div>
            </div>

            <div class="form-group">
                <label for="carfree" class="col-sm-2 control-label">空闲车数</label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="carfree" name="carfree"
                           placeholder="空闲车数" onkeyup="this.value=this.value.replace(/\D/g,'')"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')" value="${CARFREE}"
                           maxlength="4" required>
                </div>
            </div>

            <div class="form-group">
                <label for="isShow" class="col-sm-2 control-label">是否显示</label>

                <div class="col-sm-10">
                    <select id="isshow" name="isshow" class="form-control">
                        <option id="0">是</option>
                        <option id="1">否</option>
                    </select>

                </div>
            </div>

            <button class="btn btn-lg btn-primary " data-loading-text="添加中..." type="submit">修改此车辆明细</button>
        </form>
    </div>
    <!--弹出层end  新建车辆类别-->

    <!--admin_publicfooter begin-->
    <div>
        <%@ include file="/WEB-INF/view/admin_publicfooter.jsp" %>
    </div>
    <!--admin_publicfooter end-->
</div>
<!-- /container -->
</body>
</html>