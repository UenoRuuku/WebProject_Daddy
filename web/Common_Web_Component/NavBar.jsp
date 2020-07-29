<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2020/7/20
  Time: 20:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark animated slideInDown" style="z-index:99">
    <a class="navbar-brand" href="#">Daddy</a>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="../index.jsp">
                    Home
                    <span class="sr-only">(current)</span>
                </a>
            </li>
            <form class="form-inline" action="../Picture/pictureSearchResult.jsp" method="GET">
                <input
                        class="form-control mr-sm-2"
                        type="search"
                        placeholder="Search"
                        aria-label="Search"
                        name="searchFor"
                />
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">
                    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-search" fill="currentColor"
                         xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd"
                              d="M10.442 10.442a1 1 0 0 1 1.415 0l3.85 3.85a1 1 0 0 1-1.414 1.415l-3.85-3.85a1 1 0 0 1 0-1.415z"/>
                        <path fill-rule="evenodd"
                              d="M6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11zM13 6.5a6.5 6.5 0 1 1-13 0 6.5 6.5 0 0 1 13 0z"/>
                    </svg>
                </button>
            </form>
        </ul>
    </div>
    <%
        boolean judgeLogin = false;
        Cookie[] cookies = request.getCookies();
        String name = "<a href=\"../Auth/auth.jsp\" class=\"navbar-text inverse-a\">log in timeout</a>";
        if (cookies.length > 0) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("login")) {
                    if (cookie.getValue().equals("true")) {
                        judgeLogin = true;
                    }
                    break;
                }
            }
            if (judgeLogin) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("username")) {
                        name = "<a href=\"../Personal/personalCenter.jsp?username=" + cookie.getValue() + "\" class=\"navbar-text inverse-a\">"
                                + cookie.getValue()
                                + "</a>";
                        break;
                    }
                }
            } else {
            }
        } else {
        }
    %>
    <%
        out.print(name);
    %>
</nav>
</body>
</html>
