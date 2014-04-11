<%--
  Created by IntelliJ IDEA.
  User: LiWei
  Date: 14-3-27
  Time: 19:28
  To change this template use File | Settings | File Templates.
  联系我们
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>人才招聘 - ${applicationScope.projectName}</title>
    <link href="<%=basePath%>public/dist/css/bootstrap.css" rel="stylesheet">
    <script src="<%=basePath%>public/js/jquery-1.8.0.min.js"></script>
    <script src="<%=basePath%>public/dist/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>public/layer/layer.min.js"></script>
    <style>

        body {
            padding-top: 70px;
        }

    </style>
</head>
<body>

<!--publictitle begin-->
<%@ include file="/WEB-INF/view/reception/receptiontitle.jsp" %>
<!--publictitle end-->

<div class="container">
    <img width="1150px" height="200px" src="<%=basePath%>public/image/banner.jpg">
    <br><br>
    <!-- Main component for a primary marketing message or call to action -->

    <h4>${applicationScope.projectName}-人才招聘</h4>
    <br><br>岗位要求:<br>
    1、有1年以上从事SEO实操经验;
    <br>2、了解百度、谷歌、搜狗等搜索引擎排名规则,熟练掌握网站关键词的评估、分析和应用对降权网站有一定的解决思路;
    <br>3、思维敏捷,有一定的软文撰写能力,文字表达流畅;
    <br>4、精通百度旗下各大产品操作如:百度百科、百度知道、百度文库、百度帖吧、百度经验以及其他搜索引擎的优化工作
    <br>5、熟悉通过站内、站外的各种技术手段,关键字分析,网络各种渠道途径来宣传本公司;
    <br>6、熟练掌握搜索引擎营销(SEM)、Email营销、QQ群营销、博客营销、微博营销、论坛营销等;
    <br><br>任职职责:
    <br>1、负责公网站SEO优化、关键词提炼、关键词排名优化工作,努力提升网站在搜索引擎的排名;
    <br>2、负责利用搜索引擎、行业网络媒体、论坛等方式对本公司产品进行宣传和推广;
    <br>3、维护本公司网络平台、定时监控访问浏览情况;
    <br>4、撰写宣传稿、软文利用论坛、博客、百度知道、人才网站等平台进行推广;
    <br><br>薪资待遇:
    <br>底薪+任务完成奖+年终奖(兼职和全职各3名,具体待遇面议)我们不看学历,只看能力,只要你有一颗上进的心,爱好学习,你就我们公司要找的人。
    <br>
    <br><br>
    地 址:山西省太原市迎泽大街华通大厦A座后院
    <br>传 &nbsp;&nbsp;真：0351-62364001
    <br>
    E-&nbsp;Mail: liweityut@163.com
    <br>
    网 &nbsp;&nbsp;址: www.liwei.com


    <!--admin_publicfooter begin-->
    <div>
        <%@ include file="/WEB-INF/view/admin_publicfooter.jsp" %>
    </div>
    <!--admin_publicfooter end-->

</div>
<!-- /container -->

</body>
</html>

