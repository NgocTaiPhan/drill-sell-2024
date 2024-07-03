package vn.hcmuaf.fit.drillsell.controller.notify;

public class Page {
    String namePage, pageUrl;

    public Page(String namePage, String pageUrl) {
        this.namePage = namePage;
        this.pageUrl = pageUrl;
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
