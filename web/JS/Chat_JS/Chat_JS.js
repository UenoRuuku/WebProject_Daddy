function put(username) {
    var content = $("#enter").val();
    $.ajax(
        {
            url: "/daddy/chat",
            data: {
                action:"put",
                username: username,
                content:encodeURI(content)
            },
            type: "POST",
            dataType: "JSON",
            success: function (data) {
            }
        }
    )
}

function get() {
    $.ajax(
        {
            url: "/daddy/chat",
            data: {
                action:"get"
            },
            type: "POST",
            dataType: "TEXT",
            success: function (data) {
                console.log(data);
                $("#chat").html(decodeURIComponent(data))
            }
        }
    )
}

function initial() {
    var timer = window.setInterval(function(){
        get();//要执行的方法
    },500);
}