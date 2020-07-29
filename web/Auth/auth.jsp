<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2020/7/20
  Time: 19:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        Cookie[] cookies = request.getCookies();
        boolean flag = false;
        if (cookies.length > 0) {
            for (Cookie c : cookies) {
                if (!c.getValue().equals("true") && c.getName().equals("register")) {
                    flag = true;
                }
            }
        }
    %>
    <title>确认权限</title>
    <script src="../static/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://unpkg.com/animate.css@3.5.2/animate.min.css">
    <link rel="stylesheet" href="../CSS/Common_CSS/Common_CSS.css">
    <link rel="stylesheet" href="../CSS/Auth_CSS/Common_CSS.css">
    <script src="../JS/Common_JS/Common_JS.js"></script>
    <link href="../static/bootstrap-4.5.0-dist/css/bootstrap.css" rel="stylesheet">
    <script src="../static/bootstrap-4.5.0-dist/js/bootstrap.js"></script>
</head>
<body>

<jsp:include page="../Common_Web_Component/NavBar.jsp" flush="true"/>
<div id="goToRegister" class="link <%
    if(!flag){
        out.print(" animated slideInUp");
    }else{
        out.print("d-see");
    }
%>">
    <div class="m-auto arrow_down">
        <div class="chevron"></div>
        <div class="chevron"></div>
        <div class="chevron"></div>
    </div>
    <br/>
    <br/>
    <a href="#" id="switchToRegister">
        <span style="font-size:14px">还没有账户？点击注册</span>
    </a>
</div>
<div id="goToLogin" class="<%
    if(flag){
        out.print("animated slideInUp");
    }else{
        out.print("d-see");
    }
%> link">
    <div class="m-auto arrow_down">
        <div class="chevron"></div>
        <div class="chevron"></div>
        <div class="chevron"></div>
    </div>
    <br/>
    <br/>
    <a href="#" id="switchToLogin">
        <span style="font-size:14px">已经有了账户？点击登录</span>
    </a>
</div>
<div class="container">
    <div id="login" class="
    <%
        if(!flag){
            out.print("animated slideInDown");
        }else{
            out.print("d-see");
        }
    %>
    ">
        <jsp:include page="login.jsp" flush="true"/>
    </div>
    <div id="register" class="<%
        if(flag){
            out.print("animated slideInDown");
        }else{
            out.print("d-see");
        }
    %>">
        <jsp:include page="register.jsp" flush="true"/>
    </div>
</div>
<script src="../JS/Auth_JS/Switch.js"></script>
</body>
</html>
