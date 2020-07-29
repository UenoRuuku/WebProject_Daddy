let isFriend = false;
let privacy = false;

function initial(is, p) {
    isFriend = is;
    privacy = p;
}

function addFriend(mainUser, sideUser) {
    const request = ajaxFunction();
    //2. 发送请求
    request.open("POST", "/daddy/addFriend", true);
    //如果使用的是post方式带数据，那么 这里要添加头， 说明提交的数据类型是一个经过url编码的form表单数据
    request.setRequestHeader("Content-type",
        "application/x-www-form-urlencoded");
    //带数据过去  ， 在send方法里面写表单数据。
    request.send("mainUser=" + mainUser + "&sideUser=" + sideUser + "&isFriend=" + isFriend);
    if (isFriend) {
        $("#addFriend").html(
            "<svg width=\"1em\" height=\"1em\" viewBox=\"0 0 16 16\" class=\"bi bi-person-plus-fill\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n" +
            "  <path fill-rule=\"evenodd\" d=\"M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm7.5-3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z\"/>\n" +
            "  <path fill-rule=\"evenodd\" d=\"M13 7.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0v-2z\"/>\n" +
            "</svg> follow"
        )
    } else {
        $("#addFriend").html(
            "<svg width=\"1em\" height=\"1em\" viewBox=\"0 0 16 16\" class=\"bi bi-person-plus-fill\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n" +
            "  <path fill-rule=\"evenodd\" d=\"M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm7.5-3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z\"/>\n" +
            "  <path fill-rule=\"evenodd\" d=\"M13 7.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0v-2z\"/>\n" +
            "</svg> unfollow"
        )
    }
    isFriend = !isFriend;
}

function setPrivacy(username) {
    const request = ajaxFunction();
    //2. 发送请求
    request.open("POST", "/daddy/privacy", true);
    //如果使用的是post方式带数据，那么 这里要添加头， 说明提交的数据类型是一个经过url编码的form表单数据
    request.setRequestHeader("Content-type",
        "application/x-www-form-urlencoded");
    //带数据过去  ， 在send方法里面写表单数据。
    console.log(privacy);
    request.send("username=" + username + "&privacy=" + privacy);
    if (privacy) {
        $("#privacy").html(
            "设置访问权限"
        )
    } else {
        $("#privacy").html(
            "设置可以访问"
        )
    }
    privacy = !privacy;
}

function ajaxFunction() {
    let xmlHttp;
    try { // Firefox, Opera 8.0+, Safari
        xmlHttp = new XMLHttpRequest();
    } catch (e) {
        try {// Internet Explorer
            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) {
            }
        }
    }
    return xmlHttp;
}

function logout() {
}