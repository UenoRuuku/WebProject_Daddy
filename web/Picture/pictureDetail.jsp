<%@ page import="JDBC.JdbcUtil" %>
<%@ page import="java.sql.*" %><%--
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
        String username = "";
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("username")) {
                username = cookie.getValue();
                break;
            }
        }
        int id = Integer.parseInt(request.getParameter("ID"));
        String name = "你不该这么做的";
        String user = "你不该这么做的";
        String description = "你不该这么做的";
        String theme = "你不该这么做的";
        String country = "你不该这么做的";
        String city = "你不该这么做的";
        String url = "../assets/login.jpg";
        boolean judge = false;
        Date date = new Date(1999, 12, 21);
        int count = 777;
        final JdbcUtil jdbcUtil = new JdbcUtil();
        Connection c1 = jdbcUtil.getConnection();
        Connection c2 = jdbcUtil.getConnection();
        Statement stmt = null;
        ResultSet resultSet = null;
        try {
            stmt = c1.createStatement();
            resultSet = stmt.executeQuery("SELECT * from picture where picture_ID='" + id + "';");
            while (resultSet.next()) {
                name = resultSet.getString("picture_title");
                user = resultSet.getString("picture_user");
                description = resultSet.getString("picture_detail");
                theme = resultSet.getString("picture_theme");
                date = resultSet.getDate("picture_date");
                country = resultSet.getString("picture_country");
                count = resultSet.getInt("count");
                city = resultSet.getString("picture_city");
                url = resultSet.getString("url");
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        String sql2 = "UPDATE picture SET count = '" + (int) (count + 1) + "' where picture_ID='" + id + "';";
        Statement s = null;
        try {
            s = jdbcUtil.getConnection().createStatement();
            s.execute(sql2);
            s.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        Statement s1 = null;
        try {
            s1 = c2.createStatement();
            ResultSet r2 = s1.executeQuery("SELECT * FROM collection WHERE user='" + username + "' And ID='" + id + "';");
            if (r2.next()) {
                judge = true;
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        //下面的内容只有登录才需要执行（记录）
        if (!username.equals("")) {
            boolean haveTrack = false;
            Connection c = jdbcUtil.getConnection();
            String sql = "SELECT * from track where user = '" + username + "' LIMIT 10;";
            try {
                Statement s3 = c.createStatement();
                ResultSet r3 = s3.executeQuery(sql);
                while (r3.next()) {
                    if (r3.getInt("id") == id) {
                        haveTrack = true;
                    }
                }
                if (!haveTrack) {
                    Connection c5 = jdbcUtil.getConnection();
                    String sql5 = "";
                    Statement s5 = c5.createStatement();
                    s5.execute("INSERT INTO track (user,id,title) values ('" + username + "','" + id + "','" + name + "');");
                }
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }

    %>

    <title>图片详情：<%=name%>
    </title>
    <script src="../static/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://unpkg.com/animate.css@3.5.2/animate.min.css">
    <link rel="stylesheet" href="../CSS/Common_CSS/Common_CSS.css">
    <link rel="stylesheet" href="../CSS/Picture_CSS/Common_CSS.css">
    <link href="../static/bootstrap-4.5.0-dist/css/bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" href="../CSS/zoom/zoomio.css">
    <script src="../static/bootstrap-4.5.0-dist/js/bootstrap.js"></script>
    <script src="../JS/Picture_JS/Detail_JS.js"></script>
    <script src="../JS/Common_JS/Common_JS.js"></script>
    <script>
        window.onload = function () {
            initial(<%=judge%>);
        }
    </script>
</head>
<body>
<jsp:include page="../Common_Web_Component/NavBar.jsp" flush="true"/>
<div class="container">
    <br>
    <h2 style="color:whitesmoke" class="animated fadeIn"><%=name%>
    </h2>
    <br>
    <div class="row">
        <div class="col-7 animated slideInleft">
            <img id="img"
                 src="${pageContext.servletContext.contextPath}/assets/picRepo/<%=url%>"
                 style="width:100%;max-width:800px;"
            />
            <br>
            <br>
            <button type="button" id="collect" class="btn btn-outline-warning" onclick="collect(
                    '<%=username%>','<%=id%>'
                    )">
                <%
                    if (judge) {
                        out.print("<svg width=\"1em\" height=\"1em\" viewBox=\"0 0 16 16\" class=\"bi bi-heart-half\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n" +
                                "  <path fill-rule=\"evenodd\" d=\"M8 1.314C3.562-3.248-7.534 4.735 8 15V1.314z\"/>\n" +
                                "  <path fill-rule=\"evenodd\" d=\"M8 2.748l-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z\"/>\n" +
                                "</svg> 已收藏");
                    } else {
                        //图案
                        if (username != "") {
                            out.print("<svg width=\"1em\" height=\"1em\" viewBox=\"0 0 16 16\" class=\"bi bi-heart-fill\" fill=\"currentColor\"\n" +
                                    "                         xmlns=\"http://www.w3.org/2000/svg\">\n" +
                                    "                        <path fill-rule=\"evenodd\"\n" +
                                    "                              d=\"M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z\"></path>\n" +
                                    "                    </svg>\n" +
                                    "                    收藏");
                        } else {
                            out.print("<svg width=\"1em\" height=\"1em\" viewBox=\"0 0 16 16\" class=\"bi bi-heart-fill\" fill=\"currentColor\"\n" +
                                    "                         xmlns=\"http://www.w3.org/2000/svg\">\n" +
                                    "                        <path fill-rule=\"evenodd\"\n" +
                                    "                              d=\"M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z\"></path>\n" +
                                    "                    </svg>\n" +
                                    "                    登录后方可收藏");
                        }
                    }
                %>
            </button>
            <p1>鼠标浮于图片上方便可局部放大图片</p1>
        </div>
        <div class="col-5 animated slideInRight">
            <div class="container" style="font-size:14px">
                <p style="color:whitesmoke">
                    <%=description%>
                </p>
                <table class="table table-sm" style="color:whitesmoke">
                    <tbody>
                    <tr>
                        <th scope="row">country</th>
                        <td><%=country%>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">city</th>
                        <td><%=city%>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">user</th>
                        <td><a style="color:white" href="../Personal/personalCenter.jsp?username=<%=user%>"><%=user%>
                        </a></td>
                    </tr>
                    <tr>
                        <th scope="row">Date</th>
                        <td><%=date.toString()%>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">theme</th>
                        <td><%=theme%>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%
    try {
        resultSet.close();
        stmt.close();
        c1.close();
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }

%>
<script src="../CSS/zoom/zoomio.js"></script>
<script>
    $(function () {
        $("#img").zoomio({
            scale: '3'
        });
    })
</script>
</body>
</html>
