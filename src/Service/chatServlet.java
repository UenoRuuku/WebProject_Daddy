package Service;

import Domain.Chat;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static java.lang.Long.parseLong;

@WebServlet(value = "/chat")
public class chatServlet extends HttpServlet {
    private List<Chat> chatList = new ArrayList<>();

    public void init() {
        chatList.add(new Chat("Chat room has been set.", "System", String.valueOf(new Date().getTime())));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        StringBuilder anwser = new StringBuilder();
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("UTF-8");
        System.out.println("doPost");
        switch (action) {
            case "get":
                for (Chat c : chatList) {
                    anwser.append("<p style=\"color:orange\">").append(getDateToString(parseLong(c.getTime())));
                    anwser.append("</p>");
                    anwser.append("<p1>").append(c.getUser()).append(":</p1>");
                    anwser.append("<span>").append(c.getStr()).append("</span>");
                }
                System.out.println("get");
                response.getWriter().write(anwser.toString());
                break;
            case "put":
                String content = request.getParameter("content");

                String user = request.getParameter("username");
                String time = String.valueOf(new Date().getTime());
                chatList.add(new Chat(content, user, time));
                break;
            default:
                break;
        }
    }

    public static String getDateToString(long time) {
        Date d = new Date(time);
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sf.format(d);
    }
}
