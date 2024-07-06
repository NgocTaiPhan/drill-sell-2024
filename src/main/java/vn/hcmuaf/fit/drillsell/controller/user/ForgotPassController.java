package vn.hcmuaf.fit.drillsell.controller.user;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.EmailDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.utils.FormUtils;
import vn.hcmuaf.fit.drillsell.utils.UserUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ForgotPassController", value = "/forgot-pass")
public class ForgotPassController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("input-username");
        String email = request.getParameter("input-email");
        HttpSession session = request.getSession();

        if (checkValid(username, email, response)) {

            User user = UsersDAO.getInstance().getUserByUserNameAndEmail(username, email);
            if (user == null) {
                Notify.errorNotify(response, "Không tìm thấy tài khoản", Page.NULL_PAGE);
                return;
            }

            session.setAttribute("user-forgot-pass", user);
            String verifyCode = UserUtils.generateVerifyCode(6);
            session.setAttribute("verificationCode", verifyCode);

            UsersDAO.getInstance().updateVerifyCode(user.getId(), verifyCode);
            Notify.successNotify(response, "Hãy kiểm tra mã xác nhận được gửi về " + email, Page.MAIL_PAGE);
            EmailDAO.getInstance().sendMailOTP(email, "Lấy lại mật khẩu", verifyCode);
        }
    }

    private boolean checkValid(String username, String email, HttpServletResponse response) throws IOException {
        if (FormUtils.isNullOrEmpty(username)) {
            Notify.errorNotify(response, "Hãy nhập tên đăng nhập", Page.NULL_PAGE);
            return false;
        }
        if (FormUtils.isNullOrEmpty(email)) {
            Notify.errorNotify(response, "Hãy nhập email", Page.NULL_PAGE);
            return false;
        }
        if (!FormUtils.isValidEmail(email)) {
            Notify.errorNotify(response, "Email không hợp lệ", Page.NULL_PAGE);
            return false;
        }
        return true;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
