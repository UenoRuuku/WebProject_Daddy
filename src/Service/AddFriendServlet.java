package Service;

import JDBC.JdbcUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(value = "/addFriend")
public class AddFriendServlet extends HttpServlet {
    private final JdbcUtil jdbcUtil = new JdbcUtil();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response){
        String isFriend = request.getParameter("isFriend");
        String mainUser = request.getParameter("mainUser");
        String sideUser = request.getParameter("sideUser");
        String sql = "";
        System.out.println(isFriend);
        if(isFriend.equals("true")){
            sql = "DELETE from friend where mainUser='"+mainUser+"' AND sideUser='"+sideUser+"';";
        }else{
            sql = "INSERT INTO friend (mainUser,sideUser) Values ('"+mainUser+"','"+sideUser+"');";
        }
        Connection c = jdbcUtil.getConnection();
        try {
            Statement s = c.createStatement();
            s.execute(sql);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }


    }
}
