package vn.hcmuaf.fit.drillsell.controller.mail;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.dao.EmailDAO;

import java.io.IOException;

import static vn.hcmuaf.fit.drillsell.db.Db.username;

@WebServlet(name = "ConfirmRegistration", value = "/vertify-code")
public class VertifyInputCodeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputCode = request.getParameter("otp");
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user-forgot-pass");
        if (inputCode.equals(UsersDAO.getInstance().getVerifyCode(u.getUsername(),u.getEmail()))) {
            response.sendRedirect("change-pass.jsp?forgot-pass=1");
        }


    }
}