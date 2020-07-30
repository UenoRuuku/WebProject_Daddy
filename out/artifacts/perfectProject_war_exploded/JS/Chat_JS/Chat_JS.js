function put(username) {
    var content = $("#enter").val();
    $.ajax(
        {
            url: "/daddy/chat",
            data: {
                action:"put",
                username: username,
                content:content
            },
            type: "POST",
            dataType: "JSON",
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
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
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (data) {
                console.log(data);
                $("#chat").html(data)
            }
        }
    )
}

function initial() {
    var timer = window.setInterval(function(){
        get();//要执行的方法
    },500);
}