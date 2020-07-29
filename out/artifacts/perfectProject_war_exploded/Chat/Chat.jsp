<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String username = "";
        Cookie[] cookies = request.getCookies();
        for (Cookie c : cookies) {
            if (c.getName().equals("username")) {
                username = c.getValue();
            }
        }
        if (username.equals("")) {
            response.sendRedirect("../Auth/auth.jsp");
        }
    %>
    <title>聊天室</title>
    <script src="../static/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://unpkg.com/animate.css@3.5.2/animate.min.css">
    <link rel="stylesheet" href="../CSS/Common_CSS/Common_CSS.css">
    <link href="../static/bootstrap-4.5.0-dist/css/bootstrap.css" rel="stylesheet">
    <script src="../static/bootstrap-4.5.0-dist/js/bootstrap.js"></script>
    <script src="../bootstrap-fileinput/js/fileinput.js"></script>
    <link rel="stylesheet" href="../bootstrap-fileinput/css/fileinput.css">
    <script src="../JS/Chat_JS/Chat_JS.js"></script>
    <script src="../JS/Common_JS/Common_JS.js"></script>
</head>
<body>
<jsp:include page="../Common_Web_Component/NavBar.jsp" flush="true"/>
<div class="container">
    <h4 style="color:whitesmoke">聊天室</h4>
    <br>
    <div class="row">

        <div class="col-8">
            <div id="chat" style="overflow: scroll;border: whitesmoke solid 1px;height: 400px;"></div>
        </div>
        <div class="col-4">
            <textarea class="text-input" placeholder="enter your content" id="enter"></textarea>
            <button class="btn btn-outline-success" style="width: 100%" onclick="put('<%=username%>')">发送</button>
        </div>
    </div>
</div>
<style>
    .text-input {
        background-color: rgba(0, 0, 0, 0.2);
        color: #fff;
        border: 1px solid #000;
        border-radius: 3px;
        box-shadow: 1px 1px 0px #45556c;
        padding: 5px;
        margin: 4px 0;
        width: 100%;
        height: 50%;
    }
</style>


<script>
    window.onload = function () {
        initial()
    }
</script>
</body>
</html>