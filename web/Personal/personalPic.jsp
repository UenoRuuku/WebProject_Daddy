<%@ page import="JDBC.JdbcUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="Domain.PictureSketchy" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2020/7/21
  Time: 18:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        boolean login = false;
        final JdbcUtil jdbcUtil = new JdbcUtil();
        Connection connection = jdbcUtil.getConnection();
        String username = request.getParameter("username");
        List<PictureSketchy> pics = new ArrayList<>();
        String sql = "SELECT * FROM picture where picture_user='" + username + "';";
        Cookie[] cookies = request.getCookies();
        if (cookies.length > 0) {
            for (Cookie c : cookies) {
                if (c.getName().equals("login")) {
                    login = c.getValue().equals("true");
                    break;
                }
            }
            if (login) {
                for (Cookie c : cookies) {
                    if (c.getName().equals("username")) {
                        if (!c.getValue().equals(username)) {
                            response.sendRedirect("../index.jsp");
                            break;
                        }
                    }
                }
            } else {
                response.sendRedirect("../Auth/auth.jsp");
            }
        }

        try {
            Statement stmt = connection.createStatement();
            ResultSet resultSet = stmt.executeQuery(sql);
            while (resultSet.next()) {
                pics.add(new PictureSketchy(resultSet.getString("picture_title"), resultSet.getInt("picture_ID"), resultSet.getString("url")));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    %>
    <title>管理画作</title>
    <script src="../static/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://unpkg.com/animate.css@3.5.2/animate.min.css">
    <link rel="stylesheet" href="../CSS/Common_CSS/Common_CSS.css">
    <link rel="stylesheet" href="../CSS/Personal_CSS/Common_CSS.css">
    <link href="../static/bootstrap-4.5.0-dist/css/bootstrap.css" rel="stylesheet">
    <script src="../static/bootstrap-4.5.0-dist/js/bootstrap.js"></script>
    <script src="../JS/Common_JS/Common_JS.js"></script>
    <script src="../JS/Personal_JS/Pic_JS.js"></script>

</head>
<body>
<jsp:include page="../Common_Web_Component/NavBar.jsp" flush="true"/>
<div class="container">
    <div class="row">
        <br>
        <div class="col-8">
            <br>
            <h2 style="color:whitesmoke">
                <%=username%>的旅行图片
            </h2>
            <br>
            <%
                if (pics.size() > 0) {
                    for (PictureSketchy pic : pics) {
                        out.println("<div class=\"row animated fadeInUp pic-content\">\n" + "<div class=\"col-4\">");
                        out.println("<img src=\"" + request.getContextPath() + "/assets/picRepo/" + pic.getUrl() + "\" class=\"img-thumbnail\">\n");
                        out.println("</div><div class=\"col-5 m-auto\">");
                        out.println("<a href=\"../Picture/pictureDetail.jsp?ID=" + pic.getID() + "\">");
                        out.println("<p1>" + pic.getName() + "</p1>");
                        out.println("</a></div>" +
                                "<div id=\"buttonContainer1" + pic.getID() + "\" class=\"col-1.5 m-auto\">" +
                                "<button class=\"btn btn-outline-light\" onclick=\"window.location.href='../Picture/pictureModify.jsp?ID=" + pic.getID() + "'\" id=\"modify\"" + pic.getID() + ">修改</button>" +
                                "</div>" +
                                "<div id=\"buttonContainer2" + pic.getID() + "\" class=\"col-1.5 m-auto\">");
                        out.print("<button class=\"btn btn-outline-warning\" onclick=\"buttonOn(" + pic.getID() + ")\" id=\"delete\"" + pic.getID() + ">删除</button>");
                        out.print("</div></div>");
                    }
                } else {
                    out.print("<p1>·还没有上传过图片</p1>");
                }
            %>
        </div>
        <div class="col-4">
            <a href="../Picture/pictureUpload.jsp">
                <p1>前往上传图片>>></p1>
            </a>
        </div>
    </div>
</div>


</body>
</html>
