package Service;

import JDBC.JdbcUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(value = "/privacy")
public class PrivacyServlet extends HttpServlet {


    private final JdbcUtil jdbcUtil = new JdbcUtil();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response){
        String username = request.getParameter("username");
        String privacy = request.getParameter("privacy");
        Connection connection = jdbcUtil.getConnection();
        String sql = "";
        System.out.println(privacy);
        if(privacy.equals("true")){
            sql = "UPDATE user SET privacy='0' where username="+"'"+ username +"';";
        }else{
            sql = "UPDATE user SET privacy='1' where username="+"'"+ username +"';";
        }
        try {
            Statement stmt = connection.createStatement();
            stmt.execute(sql);
            stmt.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

    }
}
