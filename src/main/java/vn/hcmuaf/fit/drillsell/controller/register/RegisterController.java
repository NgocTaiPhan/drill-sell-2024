package vn.hcmuaf.fit.drillsell.controller.register;


import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.dao.EmailDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;

@WebServlet(name = "RegisterController", value = "/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();


        // Lấy các thông tin từ form
        String fullName = request.getParameter("full-name-register");
        String birthDate = request.getParameter("birth-date-register");
        String address = request.getParameter("address-register");
        String phoneNumber = request.getParameter("phone-number-register");
        String email = request.getParameter("email-register");
        String username = request.getParameter("username-register");
        String password = request.getParameter("password-register");
        String confirmPassword = request.getParameter("confirm-password-register");
        String agreeToTerms = request.getParameter("agree-to-terms");
        String gender = request.getParameter("gender");

//        Trả dữ liệu đã nhập cho người dùng khi nhập
        session.setAttribute("fullName", fullName);
        session.setAttribute("birthDate", birthDate);
        session.setAttribute("phoneNumber", phoneNumber);
        session.setAttribute("email", email);
        session.setAttribute("username", username);

//Kiểm tra form đăng kí có hợp lệ không
        if (!ValidationForm.validationForm(fullName, birthDate, address, phoneNumber, email, username, password, confirmPassword, agreeToTerms, response, session)) {
            return; // Return if validation fails
        }

        response.sendRedirect("login.jsp?notify=register-success");


        //        String confirmationCode = UUID.randomUUID().toString().substring(0, 6);
//        User user = new User(fullName, address, phoneNumber, email, username, password, gender, birthDate, confirmationCode, false, false);
////        session.setAttribute("confirmation", user);
//        UsersDAO.getInstance().addUser(user);
//        EmailDAO.getInstance().sendMailWelcome(email, "Xác thực tài khoản", confirmationCode);
//
//        response.sendRedirect("user-service/input-code.jsp");

    }


}

