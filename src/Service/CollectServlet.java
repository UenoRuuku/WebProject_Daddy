package Service;

import JDBC.JdbcUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(value = "/collect")
public class CollectServlet extends HttpServlet {
    private final JdbcUtil jdbcUtil = new JdbcUtil();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        Connection c = jdbcUtil.getConnection();
        Connection c1 = jdbcUtil.getConnection();
        try {
            Statement s = c.createStatement();
            if (request.getParameter("judge").equals("true")) {
                s.execute("delete from collection where user = '" + request.getParameter("username")
                        + "' AND ID='" + request.getParameter("picID") + "';");
            } else {
                Statement s2 = c1.createStatement();
                ResultSet r = s2.executeQuery("SELECT * FROM picture where picture_ID='"
                        + request.getParameter("picID") + "';");
                while (r.next()) {
                    s.execute("INSERT into collection (user,title,ID,url) values ('" +
                            request.getParameter("username") + "','"
                            + r.getString("picture_title") + "','"
                            + request.getParameter("picID") + "','"
                            + r.getString("url") +
                            "');");
                }
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }


    }
}
