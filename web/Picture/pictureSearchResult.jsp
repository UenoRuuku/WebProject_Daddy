<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2020/7/21
  Time: 14:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String searchFor = request.getParameter("searchFor");
    %>
    <title><%=searchFor%>的搜索结果</title>
    <script src="../static/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://unpkg.com/animate.css@3.5.2/animate.min.css">
    <link href="../static/bootstrap-4.5.0-dist/css/bootstrap.css" rel="stylesheet">
    <script src="../static/bootstrap-4.5.0-dist/js/bootstrap.js"></script>
    <link rel="stylesheet" href="../CSS/Common_CSS/Common_CSS.css">
    <link rel="stylesheet" href="../CSS/Picture_CSS/Common_CSS.css">
</head>
<body>
<jsp:include page="../Common_Web_Component/NavBar.jsp" flush="true"/>
<br>
<div class="container">
    <div class="row">
        <div class="col-8">
            <h2 style="color:whitesmoke"><%
                if (searchFor.equals("")) {
                    out.print("搜索结果");
                } else {
                    out.print(searchFor + "的搜索结果");
                }
            %></h2>
            <br/>
            <div id="searchResult"></div>
        </div>
    </div>
</div>

<div style="position:fixed;bottom:50px;right:50px;">
    <p1>当前页数: <span id="currentPage"></span>/</p1>
    <p1>总页数：<span id="totalPage"></span></p1>
    <br>
    <a href="#" onclick="backToTop()">
        <p1>
            点我返回上层
        </p1>
    </a>
</div>

<script src="../JS/Picture_JS/Search_JS.js"></script>
<script>
    window.onload = function () {
        initial('<%=searchFor%>');
    }
</script>
</body>
</html>
