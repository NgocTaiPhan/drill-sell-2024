
package vn.hcmuaf.fit.drillsell.controller;

import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import static vn.hcmuaf.fit.drillsell.controller.notify.Notify.sendResponseText;

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
        if (confirmationCode != null && confirmationCode.equals(code) && userRegister != null) {
            // Thêm user vào cơ sở dữ liệu
            UsersDAO.getInstance().addUser(userRegister,confirmationCode);

            // Xóa user khỏi session sau khi thêm vào cơ sở dữ liệu
            session.removeAttribute("user-register");
            session.removeAttribute("confirmationCode");

            // Chuyển hướng đến trang đăng nhập
            sendResponseText(response, "Tài khoản đã được xác nhận", HttpServletResponse.SC_BAD_REQUEST);
        } else if (!code.equals(confirmationCode)) {
            // Mã xác nhận không hợp lệ hoặc hết hạn
            sendResponseText(response, "Mã xác nhận không hợp lệ!", HttpServletResponse.SC_BAD_REQUEST);
        } else {
            sendResponseText(response, "Mã xác nhận đã hết hạn!", HttpServletResponse.SC_BAD_REQUEST);

        }
    }
}
