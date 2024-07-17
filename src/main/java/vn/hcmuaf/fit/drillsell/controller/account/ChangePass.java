
package vn.hcmuaf.fit.drillsell.controller.account;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.controller.register.ValidationForm;
import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.utils.UserUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/change-password"})
public class ChangePass extends HttpServlet {
    private static final long serialVersionUID = 1L;


@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    String forgotPass = request.getParameter("forgot-pass");

    if ("1".equals(forgotPass)) {
        handleForgotPassword(request, response, session);
    } else {
        handleChangePassword(request, response, session);
    }
}

    private void handleForgotPassword(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
        User u = (User) session.getAttribute("user-forgot-pass");
        if (u == null) {
            Notify.errorNotify(response, "Không tìm thấy tài khoản!", Page.NULL_PAGE);
            return;
        }

        String pass = request.getParameter("pass");
        String cfPass = request.getParameter("cf-pass");
        ValidationForm validationForm = ValidationForm.getInstance();
        boolean isValid = validationForm.isValidForgotPassword(response, pass, cfPass);
        if (!isValid) {
            return;
        }
        if (pass.equals(cfPass)) {
            UsersDAO.getInstance().changePassword(u.getUsername(), pass);
            Notify.successNotify(response, "Đổi mật khẩu thành công!", Page.LOGIN_PAGE);
        } else {
            Notify.errorNotify(response, "Mật khẩu không khớp!", Page.NULL_PAGE);
        }
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
        User currentUser = (User) session.getAttribute("auth");

        if (currentUser == null) {
            Notify.errorNotify(response, "Không tìm thấy tài khoản!", Page.NULL_PAGE);
            return;
        }

        String oldPassword = request.getParameter("old-pass");
        String newPassword = request.getParameter("pass");
        String confirmPassword = request.getParameter("cf-pass");

        ValidationForm validationForm = ValidationForm.getInstance();
        boolean isValid = validationForm.isValidChangePassword(response, oldPassword, currentUser.getPasswords(), newPassword, confirmPassword);
        if (!isValid) {
            return;
        }

        boolean isPasswordChanged = UsersDAO.getInstance().changePassword(currentUser.getUsername(), newPassword);

        if (isPasswordChanged) {
            currentUser.setPasswords(UserUtils.hashPassword(newPassword));
            session.setAttribute("auth", currentUser);
            Notify.successNotify(response, "Đổi mật khẩu thành công!", Page.HOME_PAGE);
        } else {
            Notify.warningNotify(response, "Đã có lỗi xảy ra vui lòng thử lại!", Page.NULL_PAGE);
        }
    }
}
