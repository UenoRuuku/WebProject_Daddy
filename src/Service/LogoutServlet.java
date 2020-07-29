package Service;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Cookie newCookie = new Cookie("username", null); //假如要删除名bai称为username的Cookie
        newCookie.setMaxAge(0); //立即删除型
        newCookie.setPath("/"); //项目所有目录均有效，这句很关键，否则不敢保证删除
        response.addCookie(newCookie); //重新写入，将覆盖之前的
        Cookie newCookie2 = new Cookie("login", "false"); //假如要删除名bai称为username的Cookie
        newCookie2.setMaxAge(0); //立即删除型
        newCookie2.setPath("/"); //项目所有目录均有效，这句很关键，否则不敢保证删除
        response.addCookie(newCookie2); //重新写入，将覆盖之前的
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request,response);
    }
}
