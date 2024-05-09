package vn.hcmuaf.fit.drillsell.controller.login;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class Logout {
    public static void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("auth");
        session.removeAttribute("auth-google");
        session.removeAttribute("notify");
        session.invalidate();
        response.sendRedirect("home.jsp");
    }
}
