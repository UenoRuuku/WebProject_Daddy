package Service;


import JDBC.JdbcUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.UUID;

@WebServlet(value = "/picModify")
public class ModifyServlet extends HttpServlet {
    private final JdbcUtil jdbcUtil = new JdbcUtil();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Cookie[] cookies = request.getCookies();
        String ID = request.getParameter("ID");
        String username = "";
        if (cookies.length > 0) {
            for (Cookie c : cookies) {
                if (c.getName().equals("login")) {
                    if (c.getValue().equals("true")) {
                        for (Cookie c1 : cookies) {
                            if (c1.getName().equals("username")) {
                                username = c1.getValue();
                                break;
                            }
                        }
                    } else {
                        response.sendRedirect("Auth/auth.jsp");
                        return;
                    }
                    break;
                }
            }
        }
        String title = request.getParameter("name");
        String theme = request.getParameter("theme");
        String country = request.getParameter("country");
        String city = request.getParameter("city");
        String detail = request.getParameter("detail");

        Connection c = jdbcUtil.getConnection();
        Statement s = null;
        String sql = "UPDATE picture SET picture_title='"+title+"', picture_theme='"+theme+"'," +
                "picture_country='"+country+"',picture_city='"+city+"',picture_detail=\""+detail+"\"" +
                " WHERE picture_ID='"+ID+"';";
        System.out.println(sql);
        try {
            s = c.createStatement();
            s.execute(sql);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        Cookie c1 = new Cookie("upload","true");
        c1.setMaxAge(-1);
        c1.setPath("/");
        response.addCookie(c1);
        response.sendRedirect("Personal/personalPic.jsp?username="+username);
    }
}
