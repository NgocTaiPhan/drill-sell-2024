
package vn.hcmuaf.fit.drillsell.controller;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "Confirm", value = "/confirm")
public class Confirm extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        HttpSession session = request.getSession();
        String confirmationCode = (String) session.getAttribute("confirmationCode");
        User userRegister = (User) session.getAttribute("user-register");

        // Kiểm tra mã xác nhận
        if (code == null || code.equals("")) {
            Notify.errorNotify(response, "Hãy nhập mã xác nhận!", Page.NULL_PAGE);
        } else if (userRegister == null) {
            Notify.errorNotify(response, "Hãy đăng nhập!", Page.LOGIN_PAGE);

        } else {
            if (confirmationCode != null && confirmationCode.equals(code) && userRegister != null) {
                // Thêm user vào cơ sở dữ liệu
                UsersDAO.getInstance().addUser(userRegister,confirmationCode);

                // Xóa user khỏi session sau khi thêm vào cơ sở dữ liệu
                session.removeAttribute("user-register");
                session.removeAttribute("confirmationCode");

                // Chuyển hướng đến trang đăng nhập
                Notify.successNotify(response, "Tài khoản đã được xác nhận!", Page.LOGIN_PAGE);
            } else if (!code.equals(confirmationCode)) {
                // Mã xác nhận không hợp lệ hoặc hết hạn
                Notify.errorNotify(response, "Mã xác nhận không hợp lệ!", Page.NULL_PAGE);
            } else {
                Notify.errorNotify(response, "Có lỗi trong quá trình xử lý!", Page.NULL_PAGE);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}