package vn.hcmuaf.fit.drillsell.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.hcmuaf.fit.drillsell.service.EmailService;
import vn.hcmuaf.fit.drillsell.service.UserService;

import java.io.IOException;

@WebServlet(name = "ForgotPassController", value = "/forgot-pas")
public class ForgotPassController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        HttpSession session = request.getSession();
        session.setAttribute("username-forgot-pass",username);
        String vertifyCode = UserService.getInstance().getVerifyCode(username, email);
        if (vertifyCode != null) {
            EmailService.getInstance().sendMailOTP(email, "Lấy lại mật khẩu", vertifyCode);
        }

    }
}