package Service;

import JDBC.JdbcUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    private final JdbcUtil jdbcUtil = new JdbcUtil();

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse response) throws IOException {
        response.getWriter().println("HelloWOrld");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Connection connection = jdbcUtil.getConnection();
        String sql = "select * from user where username='" + username + "';";
        Cookie cookie1;
        Cookie cookie2;
        Cookie cookie4 = new Cookie("loginUser",username);
        cookie4.setMaxAge(60*60*24*30);
        cookie4.setPath("/");
        response.addCookie(cookie4);
        try {
            Statement stmt = connection.createStatement();
            ResultSet re = stmt.executeQuery(sql);
            if (re.next()) {
                String pwd = re.getString("password");
                if (pwd.equals(password)) {
                    cookie1 = new Cookie("login", "true");
                    cookie1.setMaxAge(60 * 60 * 24 * 30);
                    cookie1.setPath("/");
                    cookie2 = new Cookie("username", username);
                    cookie2.setMaxAge(60 * 60 * 24 * 30);
                    cookie2.setPath("/");
                    response.addCookie(cookie1);
                    response.addCookie(cookie2);
                    response.sendRedirect("index.jsp");
                } else {
                    cookie1 = new Cookie("login", "false");
                    cookie1.setMaxAge(-1);
                    cookie1.setPath("/");
                    response.addCookie(cookie1);
                    Cookie cookie3 = new Cookie("register", "true");
                    cookie3.setMaxAge(0);
                    cookie3.setPath("/");
                    response.addCookie(cookie3);
                    response.sendRedirect("Auth/auth.jsp");
                }
            } else {
                cookie1 = new Cookie("login", "false");
                cookie1.setMaxAge(-1);
                cookie1.setPath("/");
                response.addCookie(cookie1);
                Cookie cookie3 = new Cookie("register", "true");
                cookie3.setMaxAge(0);
                cookie3.setPath("/");
                response.addCookie(cookie3);
                response.sendRedirect("Auth/auth.jsp");
            }
            stmt.close();
            re.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }


}
