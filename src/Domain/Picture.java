package Domain;

import java.sql.Date;

public class Picture {
    private String  name;
    private int ID;
    private String url;
    private String city;
    private String country;
    private String detail;
    private Date date = new Date(1999,12,21);
    private int count = 0;
    private String theme;

    public String getName() {
        return name;
    }

    public int getID() {
        return ID;
    }

    public String getUrl() {
        return url;
    }

    public String getCity() {
        return city;
    }

    public String getCountry() {
        return country;
    }

    public String getDetail() {
        return detail;
    }

    public Date getDate() {
        return date;
    }

    public int getCount() {
        return count;
    }

    public String getTheme() {
        return theme;
    }

    public Picture(){}

    public Picture(String name, int ID, String url, String city, String country, String detail, Date date, int count,String theme) {
        this.name = name;
        this.ID = ID;
        this.url = url;
        this.city = city;
        this.country = country;
        this.detail = detail;
        this.date = date;
        this.count = count;
        this.theme = theme;
    }
}
