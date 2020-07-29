<%@ page import="java.text.CollationKey" %><%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2020/7/20
  Time: 19:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>上传照片</title>
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
<form method="post" action="/daddy/picUpload" enctype="multipart/form-data">
    <div class="container">
        <div class="row">
            <div class="col-1"></div>
            <div class="col-5 animated slideInLeft">
                <p1 style="font-size:20px">上传照片</p1>
                <br/>
                <br/>
                <span style="color:red">
                    <%
                        Cookie[] cookies = request.getCookies();
                        if (cookies.length > 0) {
                            for (Cookie c : cookies) {
                                if (c.getName().equals("upload")) {
                                    if (!c.getValue().equals("true")) {
                                        out.print(c.getValue());
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
                    />
                </div>
                <div class="form-group">
                    <span for="city">description</span>
                    <br/>
                    <textarea
                            type="text"
                            class="text-input"
                            id="detail"
                            name="detail"
                            placeholder="enter your pic description here"
                            required></textarea>
                </div>
            </div>
            <div class="col-6 animated slideInRight">
                <div class="form-container">

                    <div class="form-container">
                        <div class="form-group">
                            <span for="file">file</span>
                            <br/>
                            <input allowedFileTypes="['jpg','png','jpeg']" id="f_upload" type="file" name="file"
                                   class="file"/>
                        </div>
                        <br/>
                        <button data-toggle="modal" data-target="#myModal" class="btn btn-success" style="width:100%">
                            Upload
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">确认提交</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                </div>
                <div class="modal-body">提交之后，您上传的图片将无法更改(仅能对标题等进行修改)</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">提交更改</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
</form>

<script src="../JS/Auth_JS/Switch.js"></script>

</body>
</html>
