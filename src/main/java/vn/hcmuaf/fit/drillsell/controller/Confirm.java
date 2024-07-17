
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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        HttpSession session = req.getSession();
        String confirmationCode = (String) session.getAttribute("confirmationCode");
        User userRegister = (User) session.getAttribute("user-register");
        User u = (User) session.getAttribute("user-forgot-pass");
        // Kiểm tra mã xác nhận
        if (code == null || code.equals("")) {
            Notify.errorNotify(resp, "Hãy nhập mã xác nhận!", Page.NULL_PAGE);
        }else {
            if (confirmationCode != null && confirmationCode.equals(code)) {
                if (u != null) {
                    Notify.successNotify(resp, "Hãy đổi mật khẩu mới!", Page.CHANGE_PASS_PAGE);
                }
                if (userRegister != null) {
                    UsersDAO.getInstance().addUser(userRegister, confirmationCode);

                    // Xóa user khỏi session sau khi thêm vào cơ sở dữ liệu
                    session.removeAttribute("user-register");
                    session.removeAttribute("confirmationCode");

                    Notify.successNotify(resp, "Đăng ký thành công!", Page.LOGIN_PAGE);
                }

            }else{
                Notify.errorNotify(resp, "Mã xác nhận không hợp lệ!", Page.NULL_PAGE);
            }


        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
doPost(request,response);

    }


}