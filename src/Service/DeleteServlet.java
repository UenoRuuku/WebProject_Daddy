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
        Connection c2 = jdbcUtil.getConnection();
        String sql = "DELETE FROM picture WHERE picture_ID = '" + num + "';";
        String sql2 = "DELETE FROM track WHERE id='"+num+"';";
        try {
            Statement s = c.createStatement();
            s.execute(sql);
            Statement s2 = c2.createStatement();
            s2.execute(sql2);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

    }
}
