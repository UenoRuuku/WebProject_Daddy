package Service;

import JDBC.JdbcUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import static java.lang.Integer.parseInt;

@WebServlet(value = "/maxPage")
public class MaxServlet extends HttpServlet {
    private final JdbcUtil jdbcUtil = new JdbcUtil();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String key = request.getParameter("key");
        Connection c = jdbcUtil.getConnection();
        String sql = "SELECT * From picture where picture_title like '%" + key + "%';";
        int num = 0;
        try {
            Statement s = c.createStatement();
            ResultSet r = s.executeQuery(sql);
            while (r.next()) {
                num++;
            }
            String json = "{\"data\":[";
            json+="{\"code\":\"200\"},";
            json+="{\"maxPage\":\""+num+"\"}";
            json+="]}";
            response.getWriter().write(json);
        } catch (SQLException | IOException throwables) {
            throwables.printStackTrace();
        }
    }
}
