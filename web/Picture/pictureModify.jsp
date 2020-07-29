<%@ page import="java.text.CollationKey" %>
<%@ page import="static java.lang.Integer.parseInt" %>
<%@ page import="JDBC.JdbcUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="Domain.Picture" %><%--
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
        int ID = Integer.parseInt(request.getParameter("ID"));
        final JdbcUtil jdbcUtil = new JdbcUtil();
        Connection c = jdbcUtil.getConnection();
        ResultSet r = null;
        String sql = "SELECT * FROM picture where picture_ID='" + ID + "';";
        Picture p = new Picture();
        try {
            Statement s = c.createStatement();
            r = s.executeQuery(sql);
            while (r.next()) {
                p = new Picture(r.getString("picture_title"), ID, r.getString("url"), r.getString("picture_city"), r.getString("picture_country"), r.getString("picture_detail"), r.getDate("picture_date"), r.getInt("count"), r.getString("picture_theme"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    %>
    <title>修改照片</title>
    <script src="../static/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://unpkg.com/animate.css@3.5.2/animate.min.css">
    <link rel="stylesheet" href="../CSS/Common_CSS/Common_CSS.css">
    <link rel="stylesheet" href="../CSS/Picture_CSS/Upload_CSS.css">
    <link href="../static/bootstrap-4.5.0-dist/css/bootstrap.css" rel="stylesheet">
    <script src="../static/bootstrap-4.5.0-dist/js/bootstrap.js"></script>
    <script src="../bootstrap-fileinput/js/fileinput.js"></script>
    <link rel="stylesheet" href="../bootstrap-fileinput/css/fileinput.css">
    <script src="../JS/Common_JS/Common_JS.js"></script>
</head>
<body>

<jsp:include page="../Common_Web_Component/NavBar.jsp" flush="true"/>
<br><br>
<form method="post" action="/daddy/picModify" >
    <div class="container">
        <div class="row">
            <div class="col-1"></div>
            <div class="col-5 animated slideInLeft">
                <p1 style="font-size:20px">修改照片</p1>
                <br/>
                <br/>
                <span style="color:red">
                    <%
                        Cookie[] cookies = request.getCookies();
                        if (cookies.length > 0) {
                            for (Cookie c1 : cookies) {
                                if (c1.getName().equals("modify")) {
                                    if (!c1.getValue().equals("true")) {
                                        out.print(c1.getValue());
                                    }
                                }
                            }
                        }
                    %>
                </span>
                <div class="form-group">
                    <span for="name">照片名称</span>
                    <br/>
                    <input
                            type="text"
                            class="text-input"
                            id="name"
                            name="name"
                            placeholder="enter your Picname here"
                            required
                            value="<%=p.getName()%>"
                    />
                </div>
                <div class="form-group">
                    <span for="theme">主题</span>
                    <br/>
                    <input
                            type="text"
                            class="text-input"
                            id="theme"
                            name="theme"
                            placeholder="enter your theme here"
                            required
                            value="<%=p.getTheme()%>"
                    />
                </div>

                <div class="form-group">
                    <span for="country">国家</span>
                    <br/>
                    <input
                            type="text"
                            class="text-input"
                            id="country"
                            name="country"
                            placeholder="enter your pic country here"
                            required
                            value="<%=p.getCountry()%>"

                    />
                </div>

                <div class="form-group">
                    <span for="city">城市</span>
                    <br/>
                    <input
                            type="text"
                            class="text-input"
                            id="city"
                            name="city"
                            placeholder="enter your pic city here"
                            required
                            value="<%=p.getCity()%>"

                    />
                </div>

            </div>
            <div class="col-6 animated slideInRight">
                <div class="form-group">
                    <span for="city">description</span>
                    <br/>
                    <textarea
                            type="text"
                            class="text-input"
                            id="detail"
                            name="detail"
                            placeholder="enter your pic description here"
                            required
                            style="height:50%"
                    ><%=p.getDetail()%></textarea>
                </div>

                <div class="form-group">
                    <span for="city">图片ID（无法修改）</span>
                    <br/>
                    <input
                            type="text"
                            class="text-input"
                            id="id"
                            name="ID"
                            disabled
                            placeholder="enter your pic city here"
                            required
                            value="<%=p.getID()%>"
                    />
                </div>
                <button type="submit" class="btn btn-success" style="width:100%">Upload</button>
            </div>
        </div>
    </div>
    </div>
</form>
<script src="../JS/Auth_JS/Switch.js"></script>
</body>
</html>
