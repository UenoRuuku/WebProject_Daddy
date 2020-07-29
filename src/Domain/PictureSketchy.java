package Domain;

import java.sql.Date;

public class PictureSketchy {
    private String  name;
    private int ID;
    private String url;
    private Date date = new Date(1999,12,21);
    private int count = 0;

    public PictureSketchy(String name, int ID, String url) {
        this.name = name;
        this.ID = ID;
        this.url = url;
    }

    public PictureSketchy(String name, int ID, String url, int count) {
        this.name = name;
        this.ID = ID;
        this.url = url;
        this.count = count;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public PictureSketchy(String name, int ID, String url, Date date) {
        this.name = name;
        this.ID = ID;
        this.url = url;
        this.date = date;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
