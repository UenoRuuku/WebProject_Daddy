
function buttonOn(num) {
    $("#buttonContainer1" + num).html(
        "<button class=\"btn btn-outline-warning animated fadeIn\" onclick=\"deletePic(" + num + ")\"" + num + ">确认</button>");
    $("#buttonContainer2" + num).html(
        "<button class=\"btn btn-outline-light animated fadeIn\" onclick=\"buttonOff(" + num + ")\"" + num + ">取消</button>"
    );
}

function buttonOff(num) {
    $("#buttonContainer1" + num).html(
        "<button class=\"btn btn-outline-light animated fadeIn\" onclick=\"window.location.href='../Picture/pictureModify.jsp?ID=" + num + "'\">修改</button>"
    );
    $("#buttonContainer2" + num).html(
        "<button class=\"btn btn-outline-warning animated fadeIn\" onclick=\"buttonOn(" + num + ")\"" + num + ">删除</button>"
    )
}

function deletePic(num) {
    $.ajax(
        {
            url: "/daddy/delete",
            data: {
                id: num,
            },
            type: "POST",
            dataType: "JSON",
            success: function (data) {
            }
        }
    )
}