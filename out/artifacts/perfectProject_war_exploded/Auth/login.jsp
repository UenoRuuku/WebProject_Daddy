<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2020/7/20
  Time: 20:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<br/>
<div class="row">
    <div class="col-1"></div>
    <div class="col-5">
        <div
                class="card text-white mb-3"
                style="max-width: 22rem ; background:transparent; border:none"
        >
            <div class="card-body">
                <h5 class="card-title">为什么加入Daddy</h5>
                <span class="card-text">
              In the Age of Ancients,
              <br/>The world was unformed,shrouded by fog.
              <br/>A land of grey crags,archtrees,and everlasting dragons
              <br/>But then there was Fire.
              <br/>And with Fire came Disparity.
            </span>
                <br/>
                <br/>
                <img src="../assets/login.jpg" class="d-block w-100" alt="..."/>
            </div>
        </div>
    </div>
    <div class="col-6">
        <div class="form-container">
            <form method="post" action="/daddy/login">
                <p1 style="font-size:20px">登录</p1>
                <br/>
                <br/>
                <span style="color:red">
                    <%
                        String userLoginName = "";
                        Cookie[] cookies = request.getCookies();
                        if (cookies.length>0){
                            for (Cookie c : cookies){
                                if(c.getName().equals("login")){
                                    if(c.getValue().equals("false")){
                                        out.print("用户名或密码错误");
                                    }
                                }
                                if(c.getName().equals("loginUser")){
                                    userLoginName = c.getValue();
                                    System.out.println(c.getValue());
                                }
                            }
                        }
                    %>
                </span>
                <div class="form-group">

                    <span for="username">用户名称</span>
                    <br/>
                    <input
                            type="text"
                            class="text-input"
                            id="username"
                            name="username"
                            placeholder="enter your name here"
                            value="<%=userLoginName%>"
                            required
                    />
                </div>
                <div class="form-group">
                    <span for="password">密码</span>
                    <br/>
                    <input
                            type="password"
                            class="text-input"
                            id="password"
                            name="password"
                            placeholder="enter your password here"
                            required
                    />
                </div>
                <br/>
                <button type="submit" class="btn btn-success" style="width:70%">Login</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
