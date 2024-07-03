package vn.hcmuaf.fit.drillsell.controller.register;

import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.EmailDAO;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

import static vn.hcmuaf.fit.drillsell.controller.notify.Notify.sendResponseAndRedirect;

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
        User userRegister = new User(fullName, address, phoneNumber, email, username, password, gender, birthDate);
        session.setAttribute("user-register", userRegister);

        // Kiểm tra thông tin đăng kí có hợp lệ không
        ValidationForm.getInstance().checkValid(response, fullName, birthDate,
                provinceId, districtId, wardId, phoneNumber, email, username, password, confirmPassword, agreeToTerms);

            // Tạo mã xác nhận và lưu vào session
            String confirmationCode = UUID.randomUUID().toString().substring(0, 6);
            session.setAttribute("confirmationCode", confirmationCode);

            // Gửi email xác nhận
            EmailDAO.getInstance().sendMailWelcome(email, "Xác thực tài khoản", confirmationCode);
        Page loginPage = new Page("Đăng nhập", "login.jsp");
        sendResponseAndRedirect(response, "Đăng kí thành công! Hãy kiểm tra email của bạn để xác nhận tài khoản!", loginPage, HttpServletResponse.SC_OK);
    }
}
