package vn.hcmuaf.fit.drillsell.controller.mail;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.dao.EmailDAO;

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
        if (EmailDAO.getInstance().vertifyCode(user.getVerificationCode(), inputCode)) {

            response.sendRedirect("/user-service/change-pass.jsp");
        }


    }
}