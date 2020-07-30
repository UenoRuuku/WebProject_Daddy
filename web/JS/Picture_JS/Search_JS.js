var page = 1;
var key = "";
var maxPage = 0;
var isFinished = true;

function initial(k) {
    key = k;
    max(k);
    $("#currentPage").html(page);
    search();
    $(window).scroll(function () {
        var scrollTop = $(this).scrollTop(); // 页面卷上去的高度
        var windowHeight = document.body.clientHeight; // 当前屏幕上页面的高度
        var docHeight = $(document).height(); // 文档的高度
// 表示，如果滑到距离底部将近50px的时候，开始触发事件
        if (docHeight - (scrollTop + windowHeight) < 5) {
            if (page <= maxPage && isFinished) {
                isFinished = false;
                search();
            }
// do something
        }
    });
}

function max(key) {
    $.ajax(
        {
            url: "/daddy/maxPage",
            data: {
                key: key,
            },
            type: "POST",
            dataType: "JSON",
            success: function (data) {
                var aim = data["data"];
                for (var k in aim) {
                    if (aim[k]["code"] != null || aim[k]["code"] != undefined) {
                        continue;
                    }
                    if (k["maxPage"] % 10 !== 0) {
                        maxPage = Math.floor(aim[k]["maxPage"] / 10) + 1;
                    } else {
                        maxPage = Math.floor(aim[k]["maxPage"] / 10);
                    }
                }
                $("#totalPage").html(maxPage);
            }
        }
    )
}


function search() {
    $.ajax(
        {
            url: "/daddy/search",
            data: {
                key: key,
                page: page,
            },
            type: "POST",
            dataType: "JSON",
            success: function (data) {
                var str = "";
                var aim = data["data"]
                for (var k in aim) {
                    // str += "<tr><td>" + data[k].AreaCode + "</td><td>" + data[k].AreaName + "</td><td>" + data[k].ParentAreaCode + "</td></tr>";
                    if (aim[k]["code"] != null || aim[k]["code"] != undefined) {
                        continue;
                    }
                    str += "<div class=\"row animated fadeInUp pic-content\">\n" + "<div class=\"col-4\">";
                    str += "<img src=\"/daddy/assets/picRepo/" + aim[k].url + "\" class=\"img-thumbnail\">\n";
                    str += "</div><div class=\"col-6 m-auto\">";
                    str += "<a href=\"../Picture/pictureDetail.jsp?ID=" + aim[k].ID + "\">";
                    str += "<p1>" + aim[k].title + "</p1>";
                    str += "</a></div><div class=\"col-2 m-auto\">";
                    str += "</div></div>";
                }
                $("#searchResult").append(str);
                $("#currentPage").html(page);
                page++;
                isFinished = true;
            }
        }
    )
}

function backToTop() {
    $('html,body').animate({scrollTop: '0px'}, 800);
}


