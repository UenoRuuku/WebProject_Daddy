var timer1 = "";

$("#switchToRegister").click(function () {
    console.log("aaaaaaa")
    var aim = document.getElementById("login");
    var target = document.getElementById("register");
    var link = document.getElementById("goToRegister");
    var link2 = document.getElementById("goToLogin");
    aim.className = "animated slideOutUp";
    link.className = "animated slideOutDown link";
    clearTimeout(this.timer1);
    timer1 = setTimeout(() => {
        aim.className = "d-see";
        target.className = "animated slideInDown";
        link2.className = "animated slideInUp link";
    }, 1000);
});

$("#switchToLogin").click(function () {
    var aim = document.getElementById("login");
    var target = document.getElementById("register");
    var link = document.getElementById("goToRegister");
    var link2 = document.getElementById("goToLogin");
    target.className = "animated slideOutUp";
    link2.className = "animated slideOutDown link";
    clearTimeout(this.timer1);
    this.timer1 = setTimeout(() => {
        target.className = "d-see";
        aim.className = "animated slideInDown";
        link.className = "animated slideInUp link";
    }, 1000);
});