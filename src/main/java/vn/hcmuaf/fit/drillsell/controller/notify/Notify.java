package vn.hcmuaf.fit.drillsell.controller.notify;

import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class Notify {
    public static final String SUCCESS = "success";
    public static final String ERROR = "error";
    public static final String WARNING = "warning";
    public static final String QUESTION = "question";
    private String title, mess, type;
    private static Notify instance;

    private Notify() {
    }

    public static Notify getInstance() {
        if (instance == null) instance = new Notify();
        return instance;
    }

    public void sendNotify(HttpSession session, String mess) throws ServletException, IOException {
        session.setAttribute("notify", mess);
        System.out.println(mess);

    }

    public void sendNotify(HttpSession session, HttpServletRequest request, HttpServletResponse response, String mess) throws ServletException, IOException {
        session.setAttribute("notify", mess);
        System.out.println(mess);
        request.getRequestDispatcher("login.jsp").forward(request, response);

    }

    public void sendNotify(HttpSession session, HttpServletRequest request, HttpServletResponse response, String mess, String url) throws ServletException, IOException {
        session.setAttribute("notify", mess);
        System.out.println(mess);
        request.getRequestDispatcher(url).forward(request, response);

    }


    public Notify(String title, String mess, String type) {
        this.title = title;
        this.mess = mess;
        this.type = type;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getMess() {
        return mess;
    }

    public void setMess(String mess) {
        this.mess = mess;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String notifys(String title, String mess, String type) {
        Notify notify = new Notify(title, mess, type);
        return notify.toJsonNotify();
    }

    private String toJsonNotify() {
        return new Gson().toJson(this);
    }

    @Override
    public String toString() {
        return "Notify{" +
                "title='" + title + '\'' +
                ", mess='" + mess + '\'' +
                ", type='" + type + '\'' +
                '}';
    }
}
