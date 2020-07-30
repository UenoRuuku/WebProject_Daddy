package Service;

import JDBC.JdbcUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.UUID;

@MultipartConfig
@WebServlet(name = "PictureUploadServlet", value = "/picUpload")
public class PictureUploadServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final JdbcUtil jdbcUtil = new JdbcUtil();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Cookie[] cookies = request.getCookies();
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
        Part part = request.getPart("file");
        System.out.println(part);

        String name = part.getHeader("content-disposition");
        String str = name.substring(name.lastIndexOf("."), name.length() - 1);
        if(!str.equals(".jpg") && !str.equals(".jpeg") && !str.equals(".png")){
            Cookie cookie = new Cookie("upload","wrongFileType");
            cookie.setPath("/");
            cookie.setMaxAge(-1);
            response.addCookie(cookie);
            response.sendRedirect("Picture/pictureUpload.jsp");
            return;
        }
        String root = request.getServletContext().getRealPath("/assets/picRepo");
        String filesqlName = UUID.randomUUID().toString() + str;
        String filename = root + "\\" + filesqlName;
        Connection c = jdbcUtil.getConnection();
        Statement s = null;
        String sql = "INSERT INTO picture (picture_title,picture_user,picture_date," +
                "picture_country,picture_city,picture_detail,count,picture_theme,url)" +
                " VALUES ('" + title + "','" + username + "','" + new java.sql.Date(new java.util.Date().getTime())
                + "','" + country + "','" + city + "',\"" + detail + "\",'0','" + theme + "','" + filesqlName +
                "');";
        System.out.println(sql);
        try {
            s = c.createStatement();
            s.execute(sql);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        part.write(filename);
        Cookie c1 = new Cookie("upload","true");
        c1.setMaxAge(-1);
        c1.setPath("/");
        response.addCookie(c1);
        response.sendRedirect("Personal/personalPic.jsp?username="+username);
    }
}
