package vn.hcmuaf.fit.drillsell.controller.account;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.EmailDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.User;

import java.io.IOException;


@WebServlet(name = "ForgotPassController", value = "/forgot-pass")
public class ForgotPassController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("input-username");
        String email = request.getParameter("input-email");
        HttpSession session = request.getSession();

        // Kiểm tra thông tin người dùng
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        session.setAttribute("user-forgot-pass", user);

        // Lấy mã xác nhận từ UsersDAO
        String verifyCode = UsersDAO.getInstance().getVerifyCode(username, email);

        if (verifyCode != null) {
            // Nếu có mã xác nhận, gửi email và thông báo thành công
            session.setAttribute("confirmationCode", verifyCode);
            Notify.successNotify(response, "Hãy kiểm tra mã xác nhận được gửi về " + email, Page.MAIL_PAGE);
            EmailDAO.getInstance().sendMailOTP(email, "Lấy lại mật khẩu", verifyCode,"Để hoàn tất quá trình lấy lại mật khẩu , vui lòng xác nhận địa chỉ email của bạn bằng cách nhấp vào liên kết dưới đây:");
            System.out.println(verifyCode);
        } else {
            // Nếu không có mã xác nhận, thông báo lỗi và chuyển hướng về trang login
            Notify.errorNotify(response, "Tên người dùng hoặc email không đúng hoặc không tồn tại. Vui lòng thử lại.", Page.NULL_PAGE);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

  doGet(request,response);
    }




}