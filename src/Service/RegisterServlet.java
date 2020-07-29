package Service;

import JDBC.JdbcUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.regex.Pattern;

@WebServlet(name = "registerServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    private final JdbcUtil jdbcUtil = new JdbcUtil();
    private final Connection connection = jdbcUtil.getConnection();
    private final String reg = "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String password = request.getParameter("registerPassword");
        String username = request.getParameter("registerName");
        String email = request.getParameter("registerEmail");
        String repassword = request.getParameter("registerRePassword");
        Cookie cookie1;
        if (!Pattern.matches(reg, email)) {
            cookie1 = new Cookie("register", "wrongEmail");
            cookie1.setMaxAge(-1);
            cookie1.setPath("/");
            response.addCookie(cookie1);
            response.sendRedirect("Auth/auth.jsp");
            return;
        }
        if (!password.equals(repassword)) {
            cookie1 = new Cookie("register", "differentPassword");
            cookie1.setMaxAge(-1);
            cookie1.setPath("/");
            response.addCookie(cookie1);
            response.sendRedirect("Auth/auth.jsp");
            return;
        }
        if(password.length() < 6 || password.length()>12){
            cookie1 = new Cookie("register", "passwordBetween6And12isRequired");
            cookie1.setMaxAge(-1);
            cookie1.setPath("/");
            response.addCookie(cookie1);
            response.sendRedirect("Auth/auth.jsp");
            return;
        }
        if(username.length() <4 || username.length()>15){
            cookie1 = new Cookie("register", "usernameBetween4And15isRequired");
            cookie1.setMaxAge(-1);
            cookie1.setPath("/");
            response.addCookie(cookie1);
            response.sendRedirect("Auth/auth.jsp");
            return;
        }
        try {
            Statement stmt = connection.createStatement();
            String sql = "select * from user where username='" + username + "';";
            ResultSet res = stmt.executeQuery(sql);
            if (res.next()) {
//                request.setAttribute("register", false);
                cookie1 = new Cookie("register", "userExist");
                cookie1.setMaxAge(-1);
                cookie1.setPath("/");
                response.addCookie(cookie1);
                response.sendRedirect("Auth/auth.jsp");
                return;
            } else {
//                request.setAttribute("register",true);
//                request.getRequestDispatcher("Auth/auth.jsp").forward(request,response);
                stmt = connection.createStatement();
                stmt.execute("INSERT INTO user ( username,password,email ) VALUES ('" +
                        username + "','" + password + "','" + email
                        + "');");
                cookie1 = new Cookie("register", "true");
                cookie1.setMaxAge(60 * 60 * 24 * 30);
                cookie1.setPath("/");
                response.addCookie(cookie1);
                Cookie cookie2 = new Cookie("login","true");
                Cookie cookie3 = new Cookie("username","username");
                cookie2.setPath("/");
                cookie3.setPath("/");
                cookie2.setMaxAge(60*60*60*24);
                cookie3.setMaxAge(-1);
                System.out.println("register success");
            }
            res.close();
            stmt.close();
            connection.close();
            response.sendRedirect("index.jsp");
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
}
