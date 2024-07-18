package vn.hcmuaf.fit.drillsell.controller.login;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = {"/login", "/logout", "/login-google", "/loginAdmin", "/logged"})
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("UTF-8");
        String servletPath = request.getServletPath();
        HttpSession session = request.getSession();

        // Kiểm tra captcha
        if (servletPath.equals("/login")) {
            String captcha = (String) session.getAttribute("captcha_security");
            String verifyCaptcha = request.getParameter("captcha");
            if (!captcha.equals(verifyCaptcha)) {
                Notify.warningNotify(response, "Mã captcha không chính xác", Page.LOGIN_PAGE);
                return; // Dừng lại nếu captcha sai
            }
        }
        if (servletPath.equals("/login")) {
            Login.login(request,response);
        } else if (servletPath.equals("/loginAdmin")) {
            Login.loginAdmin(request,response);
        } else if (servletPath.equals("/logout")) {
            Logout.logout(request,response);
        } else if (servletPath.equals("/login-google")) {
            LoginGoogle.loginGoogle(request,response);
        } else if (servletPath.equals("/logged")) {
            Login.checkLogin(request, response);
        }

    }









}
