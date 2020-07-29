package Service;

import JDBC.JdbcUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(value = "/delete")
public class DeleteServlet extends HttpServlet {
    private final JdbcUtil jdbcUtil = new JdbcUtil();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String num = request.getParameter("id");
        Connection c = jdbcUtil.getConnection();
        String sql = "DELETE FROM picture WHERE picture_ID = '" + num + "';";
        try {
            Statement s = c.createStatement();
            s.execute(sql);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

    }
}
