package vn.hcmuaf.fit.drillsell.controller.notify;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class Notify {

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

    // Thêm hàm sendNotifyPopup để hiển thị thông báo pop-up
    public void sendNotifyPopup(HttpSession session, HttpServletRequest request, HttpServletResponse response, String mess, String url) throws ServletException, IOException {
        session.setAttribute("popupNotify", mess);
        System.out.println("Popup Notify: " + mess);
        response.sendRedirect(url);
    }
}
