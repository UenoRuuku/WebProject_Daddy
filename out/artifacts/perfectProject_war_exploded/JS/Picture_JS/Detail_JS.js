var judge = false;

function collect(username,id){

    if(username === ""){
        window.location.href='../Auth/auth.jsp';
        return;
    }
    const request = ajaxFunction();
    //2. 发送请求
    request.open("POST", "/daddy/collect", true);
    // //想获取服务器传送过来的数据， 加一个状态的监听。
    // request.onreadystatechange = function() {
    //     if (request.readyState == 4 && request.status == 200) {
    //         alert("post：" + request.responseText);
    //     }
    // }
    //如果使用的是post方式带数据，那么 这里要添加头， 说明提交的数据类型是一个经过url编码的form表单数据
    request.setRequestHeader("Content-type",
        "application/x-www-form-urlencoded");
    //带数据过去  ， 在send方法里面写表单数据。
    request.send("username="+username+"&picID="+id+"&judge="+judge);
    console.log(judge);
    if(judge){
        $("#collect").html("<svg width=\"1em\" height=\"1em\" viewBox=\"0 0 16 16\" class=\"bi bi-heart-fill\" fill=\"currentColor\"\n" +
            "                         xmlns=\"http://www.w3.org/2000/svg\">\n" +
            "                        <path fill-rule=\"evenodd\"\n" +
            "                              d=\"M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z\"></path>\n" +
            "                    </svg>\n" +
            "                    收藏");
    }else{
        $("#collect").html('<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-heart-half" fill="currentColor" xmlns="http://www.w3.org/2000/svg">\n' +
            '  <path fill-rule="evenodd" d="M8 1.314C3.562-3.248-7.534 4.735 8 15V1.314z"/>\n' +
            '  <path fill-rule="evenodd" d="M8 2.748l-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>\n' +
            '</svg> 已收藏');
        console.log("该执行的要执行的")
    }
    judge = !judge;
}

function initial(j) {
    judge = j;
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