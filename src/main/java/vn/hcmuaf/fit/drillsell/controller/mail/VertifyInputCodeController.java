package vn.hcmuaf.fit.drillsell.controller.mail;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.hcmuaf.fit.drillsell.bean.User;
import vn.hcmuaf.fit.drillsell.service.EmailService;
import vn.hcmuaf.fit.drillsell.service.UserService;

import java.io.IOException;

@WebServlet(name = "ConfirmRegistration", value = "/vertify-code")
public class VertifyInputCodeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputCode = request.getParameter("input-code");
        User user = (User) request.getAttribute("confirmation");
        if (EmailService.getInstance().vertifyCode(user.getVerificationCode(), inputCode)) {

            response.sendRedirect("/user-service/change-pass.jsp");
        }


    }
}