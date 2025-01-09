package mail;

public class Email {
    private String username;
    private String password;
    private String sub;
    private String body;

    public Email(String username, String password, String sub, String body) {
        this.username = username;
        this.password = password;
        this.sub = sub;
        this.body = body;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSub() {
        return sub;
    }

    public void setSub(String sub) {
        this.sub = sub;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }
}
