<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
    后台管理客户端头部信息栏
  权限控制，单一控制，include方式引入其它页面。如对功能做修改，修改此处权限控制方式即可。
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <!-- <a class="navbar-brand" href="#">${applicationScope.projectName}</a>-->
    </div>
    <div class="navbar-collapse collapse">
        <ul class="nav navbar-nav">
            <li><a href="<%=basePath%>">转到公司主页</a></li>
            <c:if test="${not empty sessionScope.userinfo || not empty sessionScope.function }">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">用户配置 <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <c:if test="${not empty sessionScope.userinfo}">
                            <li><a href="<%=basePath%>url.admin.do?function=userinfo">用户管理</a></li>
                        </c:if>

                        <c:if test="${not empty sessionScope.function}">
                            <li><a href="<%=basePath%>url.admin.do?function=function">权限管理</a></li>
                        </c:if>
                    </ul>
                </li>
            </c:if>

            <c:if test="${not empty sessionScope.car_category || not empty sessionScope.car_message }">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">车辆信息管理 <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <c:if test="${not empty sessionScope.car_category}">
                            <li><a href="<%=basePath%>url.admin.do?function=car_category">车辆类别管理</a></li>
                        </c:if>
                        <c:if test="${not empty sessionScope.car_message}">
                            <li><a href="<%=basePath%>url.admin.do?function=car_message">车辆明细管理</a></li>
                        </c:if>
                    </ul>
                </li>
            </c:if>

            <c:if test="${not empty sessionScope.car_rental_registration}">
                <li><a href="<%=basePath%>url.admin.do?function=car_rental_registration">车辆出租登记</a></li>
            </c:if>
            <c:if test="${not empty sessionScope.car_chart}">
                <li><a href="<%=basePath%>url.admin.do?function=car_chart">车辆出租统计图</a></li>
            </c:if>
            <c:if test="${not empty sessionScope.message}">
                <li><a href="<%=basePath%>url.admin.do?function=message">用户留言</a></li>
            </c:if>

        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a>${sessionScope.userName}</a></li>
            <li><a href="<%=basePath%>loginout.admin.do">注销</a></li>
            <li><a onclick="window.scrollTo(0,0);return false;" href="#top"> 返回顶部</a></li>
        </ul>
    </div>
    <!--/.nav-collapse -->
</div>