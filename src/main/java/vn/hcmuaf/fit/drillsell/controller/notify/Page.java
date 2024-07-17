package vn.hcmuaf.fit.drillsell.controller.notify;

public class Page {

    private String key,
            namePage,
            pageUrl;

    public static final Page LOGIN_PAGE = new Page("login", "Đăng nhập", "login.jsp");
    public static final Page HOME_PAGE = new Page("home", "Trang chủ", "home.jsp");
    public static final Page MAIL_PAGE = new Page("email", "Kiểm tra email", "https://mail.google.com/");
    public static final Page CONFIRM_CODE_PAGE = new Page("confirm", "Xác nhận", "confirm.jsp");
    public static final Page NULL_PAGE = new Page("nullPage", "", "");
    public static final Page CHANGE_PASS_PAGE = new Page("changePass", "Đổi mật khẩu", "change-pass.jsp?forgot-pass=1");

    public Page(String key, String namePage, String pageUrl) {
        this.key = key;
        this.namePage = namePage;
        this.pageUrl = pageUrl;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getNamePage() {
        return namePage;
    }

    public void setNamePage(String namePage) {
        this.namePage = namePage;
    }

    public String getPageUrl() {
        return pageUrl;
    }

    public void setPageUrl(String pageUrl) {
        this.pageUrl = pageUrl;
    }
}
