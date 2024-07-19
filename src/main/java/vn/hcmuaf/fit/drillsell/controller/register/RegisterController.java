package vn.hcmuaf.fit.drillsell.controller.register;

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

@WebServlet(name = "RegisterController", value = "/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        // Lấy các thông tin từ form
        String fullName = request.getParameter("full-name-register");
        String birthDate = request.getParameter("birth-date-register");
        String provinceId = request.getParameter("tinh");
        String districtId = request.getParameter("quan");
        String wardId = request.getParameter("phuong");
        String address = provinceId + "," + districtId + ", " + wardId;
        String phoneNumber = request.getParameter("phone-number-register");
        String email = request.getParameter("email-register");
        String username = request.getParameter("username-register");
        String password = request.getParameter("password-register");
        String confirmPassword = request.getParameter("confirm-password-register");
        String agreeToTerms = request.getParameter("agree-to-terms");
        String genderStr = request.getParameter("gender");
        boolean gender = Boolean.parseBoolean(genderStr);
        // Lưu user vào session để refill vào form khi nhập thông tin không hợp lệ
        User userRegister = new User(fullName, address, phoneNumber, email, username, password, gender, birthDate, "");
        session.setAttribute("user-register", userRegister);

        // Kiểm tra thông tin đăng kí có hợp lệ không
        boolean isValidRegister = ValidationForm.getInstance().checkValid(response, fullName, birthDate,
                provinceId, districtId, wardId, phoneNumber, email, username, password, confirmPassword, agreeToTerms);
        if (isValidRegister) {


            // Tạo mã xác nhận và lưu vào session
            String confirmationCode = UserUtils.generateVerifyCode(6);
            session.setAttribute("confirmationCode", confirmationCode);

            // Gửi email xác nhận
            EmailDAO.getInstance().sendMailWelcome(email, "Xác thực tài khoản", confirmationCode,"Để hoàn tất quá trình đăng ký và kích hoạt tài khoản của bạn, vui lòng xác nhận địa chỉ email của bạn bằng cách nhấp vào liên kết dưới đây:");

            Notify.successNotify(response, "Đăng kí thành công! Hãy kiểm tra email của bạn để xác nhận tài khoản!", Page.MAIL_PAGE);
        }

    }
}
//@Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String code = request.getParameter("code");
//        HttpSession session = request.getSession();
//        String confirmationCode = (String) session.getAttribute("confirmationCode");
//        User u = (User) session.getAttribute("user-forgot-pass");
//        // Kiểm tra mã xác nhận
//        if (code == null || code.equals("")) {
//            response.getWriter().write("Hãy nhập mã xác nhận!");
//        }  else {
//            if (u != null && code.equals(UsersDAO.getInstance().getVerifyCode(u.getUsername(), u.getEmail()))) {
//
//                response.sendRedirect("change-pass.jsp?forgot-pass=1");
//            } else if (!code.equals(confirmationCode)) {
//
//                response.getWriter().write("Mã xác nhận không hợp lệ!");
//            } else {
//
//                response.getWriter().write("Có lỗi trong quá trình xử lý!");
//            }
//        }
//    }