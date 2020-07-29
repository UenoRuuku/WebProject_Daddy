package Domain;

import java.util.Date;

public class Chat {
    private String str;
    private String user;
    private String time;

    public Chat(String str, String user, String time) {
        this.str = str;
        this.user = user;
        this.time = time;
    }

    public String getStr() {
        return str;
    }

    public String getUser() {
        return user;
    }

    public String getTime() {
        return time;
    }
}
