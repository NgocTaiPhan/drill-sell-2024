package vn.hcmuaf.fit.drillsell.controller.user;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.EmailDAO;
import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.utils.UserUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.Instant;

@WebServlet(name = "ResetPassword", value = "/reset-password")
public class ResetPassword extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");
        String resetPasswordCode = UserUtils.generateVerifyCode(6);
        Instant expiryTime = UserUtils.setTimeTo(2 * 60);

        session.setAttribute("resetPasswordCode", resetPasswordCode);
        session.setAttribute("expiryTimeResetPass", expiryTime);
        System.out.println(resetPasswordCode + expiryTime);
        EmailDAO.getInstance().sendMailOTP(user.getEmail(), "Đổi mật khẩu", resetPasswordCode);
//        request.getRequestDispatcher("confirm.jsp").forward(request, response);
        Notify.successNotify(response, "Hãy kiểm tra email để đổi mật khẩu", Page.MAIL_PAGE);
    }
}