<%--
  Created by IntelliJ IDEA.
  Date: 14-3-27
  Time: 19:25
  To change this template use File | Settings | File Templates.
  前台首页头部公共信息
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="navbar navbar-fixed-top navbar-inverse" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"> ${applicationScope.projectName}</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">网站首页</a></li>
                <li class="active"><a href="<%=basePath%>my.do">公司简介</a></li>
                <li class="active"><a href="<%=basePath%>help.do">租车指南</a></li>
                <li class="active"><a href="<%=basePath%>advertise.do">人才招聘</a></li>
                <li class="active"><a href="<%=basePath%>contact_us.do">联系我们</a></li>
                <li class="active"><a href="<%=basePath%>message.do">在线留言</a></li>
                <li class="active"><a href="<%=basePath%>login.admin.do">进入后台</a></li>
            </ul>
        </div>
        <!-- /.nav-collapse -->
    </div>
    <!-- /.container -->
</div>
<!-- /.navbar -->
