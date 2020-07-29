package Domain;

public class Track {
    private String user;
    private String title;
    private int id;

    public Track(String user, String title, int id) {
        this.user = user;
        this.title = title;
        this.id = id;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
