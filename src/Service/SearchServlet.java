package Service;

import JDBC.JdbcUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.beans.PropertyEditorSupport;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import static java.lang.Integer.parseInt;

@WebServlet(value = "/search")
public class SearchServlet extends HttpServlet {
    private final JdbcUtil jdbcUtil = new JdbcUtil();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        String key = request.getParameter("key");
        int page = parseInt(request.getParameter("page"));
        Connection c = jdbcUtil.getConnection();
        String json = "{\"data\":[";
        String sql = "SELECT * From picture where picture_title like '%" + key + "%' LIMIT " + (page - 1) * 10  + "," + page * 10 + ";";
        try {
            Statement s = c.createStatement();
            ResultSet r = s.executeQuery(sql);
            json+="{\"code\":\"200\"},";
            while (r.next()) {
                String title = r.getString("picture_title");
                int ID = r.getInt("picture_ID");
                String url = r.getString("url");
                json += "{\"title\":\"" + title + "\",\"ID\":\"" + ID + "\",\"url\":\"" + url + "\",\"title\":\""+title+"\"";
                json += "},";
            }
            json = json.substring(0, json.length() - 1);
            json += "]}";
            response.getWriter().write(json);
        } catch (SQLException | IOException throwables) {
            throwables.printStackTrace();
        }

    }
}
