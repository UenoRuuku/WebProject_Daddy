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
<div class="row">
    <div class="col-1"></div>
    <div class="col-5">
        <div
                class="card text-white mb-3"
                style="max-width: 22rem ; background:transparent; border:none"
        >
            <div class="card-body">
                <h5 class="card-title">Daddy提供的服务</h5>
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
            <form method="post" action="/daddy/register">
                <p1 style="font-size:20px">注册</p1>
                <br/>
                <br/>
                <span style="color:red">
                    <%
                        Cookie[] cookies = request.getCookies();
                        if (cookies.length > 0) {
                            for (Cookie c : cookies) {
                                if (c.getName().equals("register")) {
                                    if (!c.getValue().equals("true")) {
                                        out.print(c.getValue());
                                    }
                                }
                            }
                        }
                    %>
                </span>
                <div class="form-group">
                    <span for="registerName">用户名称(4-15位)</span>
                    <br/>
                    <input
                            type="text"
                            class="text-input"
                            id="registerName"
                            name="registerName"
                            placeholder="enter your name here"
                            required
                    />
                </div>
                <div class="form-group">
                    <span for="registerEmail">邮箱</span>
                    <br/>
                    <input
                            type="text"
                            class="text-input"
                            id="registerEmail"
                            name="registerEmail"
                            placeholder="enter your email here"
                            required
                    />
                </div>
                <div class="form-group">
                    <span for="registerPassword">密码(6-12位)</span>
                    <br/>
                    <input
                            onKeyUp="pwStrength(this.value)"
                            onBlur="pwStrength(this.value)"
                            type="password"
                            class="text-input"
                            id="registerPassword"
                            name="registerPassword"
                            placeholder="enter your password here" required
                    />
                    <table width="217" border="1" cellspacing="0" cellpadding="1" bordercolor="#cccccc" height="23"
                           style='display:inline'>
                        <tr align="center" bgcolor="#eeeeee">
                            <td width="33%" id="strength_L">弱</td>
                            <td width="33%" id="strength_M">中</td>
                            <td width="33%" id="strength_H">强</td>
                        </tr>
                    </table>
                </div>
                <div class="form-group">
                    <span for="registerRepassword">确认密码</span>
                    <br/>
                    <input
                            type="password"
                            class="text-input"
                            id="registerRePassword"
                            name="registerRePassword"
                            placeholder="enter your password here again" required
                    />
                </div>
                <button type="submit" class="btn btn-success" style="width:70%">提交注册表单</button>
            </form>
        </div>
    </div>
</div>
<script>

    function checkStrong(sPW) {
        if(sPW.length<6){
            return 0;
        }else if(sPW.length<8){
            return 1;
        }else if(sPW.length<10){
            return 2;
        }else{
            return 3;
        }
    }

    //pwStrength函数
    //当密码框失去焦点时,根据不同级别显示不同颜色
    function pwStrength(pwd) {
        var O_color = "#eeeeee";
        var L_color = "#FF0000";
        var M_color = "#FF9900";
        var H_color = "#33CC00";
        var Lcolor;
        var Mcolor;
        var Hcolor;
        var S_level;
        if (pwd == null || pwd == '') {
            Lcolor = Mcolor = Hcolor = O_color;
        } else {
            S_level = checkStrong(pwd);
            switch (S_level) {
                case 0:
                    Lcolor = Mcolor = Hcolor = O_color;
                    break;
                case 1:
                    Lcolor = L_color;
                    Mcolor = Hcolor = O_color;
                    break;
                case 2:
                    Lcolor = Mcolor = M_color;
                    Hcolor = O_color;
                    break;
                default:
                    Lcolor = Mcolor = Hcolor = H_color;
            }
        }
        document.getElementById("strength_L").style.background = Lcolor;
        document.getElementById("strength_M").style.background = Mcolor;
        document.getElementById("strength_H").style.background = Hcolor;
        return;
    }
</script>
</body>
</html>
