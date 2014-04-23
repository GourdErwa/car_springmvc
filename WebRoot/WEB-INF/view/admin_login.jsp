<%--
  Created by IntelliJ IDEA.
  User: lw
  Date: 14-3-21
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>登录-${applicationScope.projectName}后台管理端</title>

    <link href="<%=basePath%>public/dist/css/bootstrap.css" rel="stylesheet">

    <link href="<%=basePath%>public/css/signin.css" rel="stylesheet">

    <script src="<%=basePath%>public/js/jquery-1.8.0.min.js"></script>
</head>
<body>
<div class="container">
    <div style="text-align: center;" >
        <br>

        <h2 class="form-signin-heading">${applicationScope.projectName}-后台管理端</h2>
        <br>
    </div>
    <div>
        <form class="form-signin" role="form" action="<%=basePath%>welcome.admin.do" method="POST">

            <input type="text" id="username" name="username" class="form-control" placeholder="请输入用户名" value="admin" required
                   autofocus>
            <input type="password" id="passowrd" name="password" onfocus="$('#error').empty();" class="form-control" value="admin"
                   placeholder="输入密码" required>
            <label class="checkbox">
                <input type="checkbox" value="remember-me"> 记住用户名
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span id="error">${error}</span>
            </label>
            <button class="btn btn-lg btn-primary btn-block" data-loading-text="登录中..." type="submit">登录到后台</button>
        </form>
    </div>

</div>
<!-- /container -->

</body>
</html>
