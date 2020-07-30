<%@ page import="JDBC.JdbcUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="Domain.PictureSketchy" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2020/7/20
  Time: 18:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        final JdbcUtil jdbcUtil = new JdbcUtil();
        Connection connection = jdbcUtil.getConnection();
        Connection connection1 = jdbcUtil.getConnection();
        List<PictureSketchy> hp = new ArrayList<>();
        List<PictureSketchy> lp = new ArrayList<>();
        String sql = "SELECT * FROM picture ORDER BY count desc LIMIT 3;";
        String sql2 = "SELECT * FROM picture ORDER BY picture_date desc, picture_ID desc LIMIT 5;";
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            Statement statement1 = connection1.createStatement();
            ResultSet resultSet1 = statement1.executeQuery(sql2);
            while (resultSet.next()) {
                hp.add(new PictureSketchy(resultSet.getString("picture_title"),
                        resultSet.getInt("picture_ID"), resultSet.getString("url"),
                        resultSet.getInt("count")));
            }
            while (resultSet1.next()) {
                lp.add(new PictureSketchy(resultSet1.getString("picture_title"),
                        resultSet1.getInt("picture_ID"), resultSet1.getString("url"),
                        resultSet1.getDate("picture_date")));
            }
            connection.close();
            connection1.close();
            resultSet.close();
            resultSet1.close();
            statement.close();
            statement1.close();

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    %>
    <title>Daddy</title>
    <script src="static/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://unpkg.com/animate.css@3.5.2/animate.min.css">
    <link rel="stylesheet" href="CSS/Common_CSS/Common_CSS.css">
    <link rel="stylesheet" href="CSS/Home_CSS/Home_CSS.css">
    <link href="static/bootstrap-4.5.0-dist/css/bootstrap.css" rel="stylesheet">
    <script src="static/bootstrap-4.5.0-dist/js/bootstrap.js"></script>

</head>
<body>
<!--导航栏-->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark animated slideInDown" style="z-index:99">
    <a class="navbar-brand" href="#">Daddy</a>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="index.jsp">
                    Home
                    <span class="sr-only">(current)</span>
                </a>
            </li>
            <form class="form-inline" action="./Picture/pictureSearchResult.jsp" method="GET">
                <input
                        class="form-control mr-sm-2"
                        type="search"
                        placeholder="Search"
                        aria-label="Search"
                        name="searchFor"
                />
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">
                    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-search" fill="currentColor"
                         xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd"
                              d="M10.442 10.442a1 1 0 0 1 1.415 0l3.85 3.85a1 1 0 0 1-1.414 1.415l-3.85-3.85a1 1 0 0 1 0-1.415z"/>
                        <path fill-rule="evenodd"
                              d="M6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11zM13 6.5a6.5 6.5 0 1 1-13 0 6.5 6.5 0 0 1 13 0z"/>
                    </svg>
                </button>
            </form>
        </ul>
    </div>
    <%
        boolean judge = false;
        String name = "<a href=\"Auth/auth.jsp\" class=\"navbar-text inverse-a\">log in timeout</a>";
        Cookie[] cookies = request.getCookies();
        if (cookies != null && cookies.length > 0) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("login")) {
                    if (cookie.getValue().equals("true")) {
                        judge = true;
                        break;
                    }
                }
            }
        }
        if (judge) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("username")) {
                    name = "<a href=\"Personal/personalCenter.jsp?username=" + cookie.getValue() + "\" class=\"navbar-text inverse-a\">"
                            + cookie.getValue()
                            + "</a>";
                }
            }
        } else {
            name = "<a href=\"Auth/auth.jsp\" class=\"navbar-text inverse-a\">log in timeout</a>";
        }

    %>
    <%
        out.print(name);
    %>
</nav>
<div class="container">
    <div class="row">
        <div class="col-4 animated slideInLeft">
            <br/>
            <p1>最新上传</p1>
            <br/><br/>
            <div class="container">
                <%
                    if (lp.size() > 0) {
                        for (PictureSketchy ps : lp) {
                            out.println("<div class=\"card mb-3 img-container\">");
                            out.println("<img src=\"" + request.getContextPath() + "/assets/picRepo/" + ps.getUrl() + "\" class=\"card-img-top\" alt=\"...\"/>");
                            out.println("<div class=\"card-body\">");
                            out.println("<div class=\"card-body\"><h5 class=\"card-title\">");
                            out.println("<a class=\"common-a\" href=\"Picture/pictureDetail.jsp?ID=" + ps.getID() + "\">");
                            out.print(ps.getName());
                            out.println("</a></h5><p class=\"card-text\"><small class=\"text-muted\">");
                            out.println("Upload time:" + ps.getDate());
                            out.println("</small></p></div></div></div>");
                        }
                    }
                %>
            </div>
        </div>
        <div class="col-1"></div>
        <div class="col-7 animated slideInRight">
            <br/>
            <br/>
            <div id="home-nav" class="container">
                <div class="row">
                    <div onclick="window.location.href='Chat/Chat.jsp'" class="col-2 home-tab">
                        <span>聊天室</span>
                    </div>
                    <div onclick="window.location.href='Picture/pictureSearchResult.jsp?searchFor='" class="col-2 home-tab">
                        <span>最热门</span>
                    </div>
                    <div class="col-2 home-tab">
                        <span></span>
                    </div>
                    <div class="col-4 home-tab-disabled"></div>
                    <div id="logout-button" class="col-2 home-tab-disabled"></div>
                </div>
            </div>
            <br/>
            <br/>
            <p1>精选和推荐</p1>
            <br/><br/>
            <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
                    <%
                        for (int i = 0; i < hp.size(); i++) {
                            out.print("<li data-target=\"#carouselExampleCaptions\" data-slide-to=\"" + i + "\"");
                            if (i == 0) {
                                out.print(" class=\"active\"");
                            }
                            out.print("></li>");
                        }
                    %>
                </ol>
                <div class="carousel-inner">
                    <%
                        for (int i = 0; i < hp.size(); i++) {
                            out.print("<div class=\"carousel-item ");
                            if (i == 0) {
                                out.print("active");
                            }
                            out.println("\">");
                            out.println("<img src=\"" + request.getContextPath() + "/assets/picRepo/" + hp.get(i).getUrl() + "\" class=\"d-block w-100\" alt=\"...\"/>");
                            out.println("<div class=\"carousel-caption d-none d-md-block\">");
                            out.println("<h5>");
                            out.println("<a class=\"common-a\" href=\"Picture/pictureDetail.jsp?ID=" + hp.get(i).getID() + "\">");
                            out.println(hp.get(i).getName() + "</a></h5>");
                            out.println(" <p>当前热度" + hp.get(i).getCount() + "</p></div></div>\n");
                        }
                    %>
                </div>
                <a
                        class="carousel-control-prev"
                        href="#carouselExampleCaptions"
                        role="button"
                        data-slide="prev"
                >
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a
                        class="carousel-control-next"
                        href="#carouselExampleCaptions"
                        role="button"
                        data-slide="next"
                >
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>
    </div>
</div>
<script src="JS/Common_JS/Common_JS.js"></script>
</body>
</html>
