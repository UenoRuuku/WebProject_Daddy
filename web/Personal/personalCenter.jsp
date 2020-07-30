<%@ page import="JDBC.JdbcUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Domain.PictureSketchy" %>
<%@ page import="Domain.Track" %>
<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2020/7/21
  Time: 18:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        boolean isFriend = false;
        boolean privacy = false;
        final JdbcUtil jdbcUtil = new JdbcUtil();
        String username = request.getParameter("username");
        if (username == null) {
            response.sendRedirect("../index.jsp");
        }
        List<String> friends = new ArrayList<>();
        List<PictureSketchy> pics = new ArrayList<>();
        Connection connection = jdbcUtil.getConnection();
        Connection connection2 = jdbcUtil.getConnection();
        Connection connection3 = jdbcUtil.getConnection();
        Connection connection4 = jdbcUtil.getConnection();
        String sql = "SELECT * FROM friend where mainUser='" + username + "';";
        String sql2 = "SELECT * FROM collection where user='" + username + "';";
        String sql3 = "SELECT * FROM user where username='" + username + "';";
        try {
            Statement stmt = connection.createStatement();
            ResultSet resultSet = stmt.executeQuery(sql);
            Statement stmt2 = connection2.createStatement();
            ResultSet resultSet2 = stmt2.executeQuery(sql2);
            Statement stmt3 = connection4.createStatement();
            ResultSet resultSet3 = stmt3.executeQuery(sql3);
            while (resultSet.next()) {
                friends.add(resultSet.getString("sideUser"));
            }
            while (resultSet2.next()) {
                pics.add(new PictureSketchy(resultSet2.getString("title"), resultSet2.getInt("ID"), resultSet2.getString("url")));
            }
            while (resultSet3.next()) {
                privacy = (resultSet3.getInt("privacy") == 1);
            }
            stmt.close();
            stmt2.close();
            resultSet.close();
            resultSet2.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        String currentUser = "";
        String userlogin = "";
        boolean judge = false;
        Cookie[] cookies = request.getCookies();
        if (cookies.length > 0) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("username")) {
                    judge = cookie.getValue().equals(username);
                    userlogin = cookie.getValue();
                }
            }
        }

        if (!judge) {
            currentUser = username + "'s";
            Statement stmt3 = null;
            try {
                stmt3 = connection3.createStatement();
                ResultSet resultSet3 = stmt3.executeQuery("SELECT * from friend where mainUser='" + userlogin + "' AND sideUser='" + username + "';");
                while (resultSet3.next()) {
                    isFriend = true;
                }
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        } else {
            currentUser = "Your";
        }

        try {
            connection.close();
            connection2.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        List<Track> tl = new ArrayList<>();
        //浏览记录，仅在查看自己的记录时显示
        Connection c = jdbcUtil.getConnection();
        String sql4 = "Select * from track where user = '" + userlogin + "' LIMIT 10;";
        try {
            Statement s = c.createStatement();
            ResultSet r = s.executeQuery(sql4);
            while (r.next()) {
                tl.add(new Track(r.getString("user"), r.getString("title"), r.getInt("id")));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

    %>
    <title>个人主页</title>
    <script src="../static/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://unpkg.com/animate.css@3.5.2/animate.min.css">
    <link href="../static/bootstrap-4.5.0-dist/css/bootstrap.css" rel="stylesheet">
    <script src="../static/bootstrap-4.5.0-dist/js/bootstrap.js"></script>
    <link rel="stylesheet" href="../CSS/Common_CSS/Common_CSS.css">
    <link rel="stylesheet" href="../CSS/Personal_CSS/Common_CSS.css">
    <script src="../JS/Personal_JS/Center_JS.js"></script>
</head>
<body>
<script>
    window.onload = function () {
        initial(<%=isFriend%>, <%=privacy%>);
    }
</script>
<jsp:include page="../Common_Web_Component/NavBar.jsp" flush="true"/>
<br/>

<br/>
<div class="container">
    <div class="row">
        <div class="col-8">
            <h2 style="color:whitesmoke" class="animated fadeInUp"><%=currentUser%> Collection
                <%
                    if (judge) {
                        out.print("\n" +
                                "                    <a href=\"personalPic.jsp?username=");
                        out.print(username);
                        out.print("\">\n" +
                                "                 <p1>       前往你上传的图片>>>\n" +
                                "                    </p1>\n" +
                                "                </a>");
                    } else if(!userlogin.equals("")) {
                        //生成添加好友按钮
                        out.print("<button id=\"addFriend\" onclick=\"addFriend('" +
                                userlogin + "','" + username +
                                "')\" type=\"button\" class=\"btn btn-outline-success\">\n" +
                                "                    <svg width=\"1em\" height=\"1em\" viewBox=\"0 0 16 16\" class=\"bi bi-person-plus-fill\" fill=\"currentColor\"\n" +
                                "                         xmlns=\"http://www.w3.org/2000/svg\">\n" +
                                "                        <path fill-rule=\"evenodd\"\n" +
                                "                              d=\"M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm7.5-3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z\"/>\n" +
                                "                        <path fill-rule=\"evenodd\"\n" +
                                "                              d=\"M13 7.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0v-2z\"/>\n" +
                                "                    </svg>\n");
                        if (isFriend) {
                            out.print("unfollow");
                        } else {
                            out.print("follow");
                        }
                        out.print("                </button>");
                    }
                %>
            </h2>
            <br>
            <div class="container-fluid">
                <%
                    if (judge) {
                        out.print("<p><p1>您也可以：</p1></p>");
                        if (privacy) {
                            out.print("<button class=\"btn btn-outline-light\"" +
                                    " onclick=\"setPrivacy('" + userlogin + "')\"" +
                                    " id=\"privacy\">设置可以访问</button>");
                        } else {
                            out.print("<button class=\"btn btn-outline-light\"" +
                                    " onclick=\"setPrivacy('" + userlogin + "')\"" +
                                    " id=\"privacy\">设置访问权限</button>");
                        }
                        out.print("<span>       </span>");
                        out.print("<button class=\"btn btn-outline-warning\" onclick=\"window.location.href='/daddy/logout'\" id=\"logout\">登出当前账户</button>");
                    }
                %>
                <br>
                <br>
                <%
                    if ((!privacy) || judge) {
                        if (pics.size() > 0) {
                            for (PictureSketchy pic : pics) {
                                out.println("<div class=\"row animated fadeInUp pic-content\">\n" + "<div class=\"col-4\">");
                                out.println("<img src=\"" + request.getContextPath() + "/assets/picRepo/" + pic.getUrl() + "\" class=\"card-img-top\">\n");
                                out.println("</div><div class=\"col-8 m-auto\">");
                                out.println("<a href=\"../Picture/pictureDetail.jsp?ID=" + pic.getID() + "\">");
                                out.println("<p1>" + pic.getName() + "</p1>");
                                out.println("</a></div></div>");
                            }
                        } else {
                            out.println("<div class=\"animated fadeInUp\"><p1>·还没有收藏画作</p1></div>");
                        }
                    } else {
                        out.println("<div class=\"animated fadeInUp\"><p1>·该用户设置了访问权限，您无法查看其收藏的画作</p1></div>");
                    }
                %>
            </div>
        </div>
        <div class="col-4">
            <h4 style="color:whitesmoke" class="animated fadeInUp"><?=currentUser?> Friend
            </h4>
            <div class="container">
                <%
                    if (friends.size() > 0) {
                        for (String friend : friends) {
                            out.println("<div class=\"row animated fadeInUp\">");
                            out.println("<div class=\"col-12\">");
                            out.println("<a href=\"./personalCenter.jsp?username="
                                    + friend + "\"><p1>· " +
                                    friend +
                                    "</p1></a>");
                            out.println("</div></div>");
                        }
                    } else {
                        out.println("<div class=\"animated fadeInUp\"><p1>·还没有好友</p1></div>");
                    }
                %>
            </div>
            <h4 style="color:whitesmoke" class="animated fadeInUp"><?=currentUser?> Recent Browse</h4>
            <div class="container">
                <%
                    if (judge) {
                        if (tl.size() > 0) {
                            for (Track t : tl) {
                                out.println("<div class=\"row animated fadeInUp\">");
                                out.println("<div class=\"col-12\">");
                                out.println("<a href=\"../Picture/pictureDetail.jsp?ID="
                                        + t.getId() + "\"><p1>· " +
                                        t.getTitle() +
                                        "</p1></a>");
                                out.println("</div></div>");
                            }
                        } else {
                            out.println("<div class=\"animated fadeInUp\"><p1>·还没有浏览记录</p1></div>");
                        }
                    } else {
                        out.println("<div class=\"animated fadeInUp\"><p1>·无权查看他人的浏览记录</p1></div>");
                    }

                %>
            </div>
        </div>
    </div>
</div>

<div style="position:fixed;bottom:50px;right:50px;">

    <a href="#" onclick="backToTop()">
        <p1>
            点我返回上层
        </p1>
    </a>
</div>

<script src="../JS/Common_JS/Common_JS.js"></script>
</body>
</html>
