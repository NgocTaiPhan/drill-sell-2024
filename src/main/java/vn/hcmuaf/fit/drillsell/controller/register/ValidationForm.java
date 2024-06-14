package vn.hcmuaf.fit.drillsell.controller.register;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.dao.EmailDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;

public class ValidationForm {
    public ValidationForm() {
    }

    private static ValidationForm instance;


    public static ValidationForm getInstance() {
        if (instance == null) instance = new ValidationForm();
        return instance;
    }


    public boolean validationRegister(HttpSession session, HttpServletRequest request, HttpServletResponse response, String fullName, String birthDate, String address, String phoneNumber, String email, String username, String password, String confirmPassword, String agreeToTerms, boolean gender) throws ServletException, IOException {
        if (fullName == null || fullName.trim().isEmpty()) {
            Notify.getInstance().sendNotify(session, request, response, "null-fullname");
            return false;
        }
//        else if (!fullName.matches(".\\d.")) {
//            Notify.getInstance().registerNotify(session, request, response, "invalid-fullname");
//            return;
//        }
        if (birthDate == null || birthDate.trim().isEmpty()) {
            Notify.getInstance().sendNotify(session, request, response, "null-birthday");
            return false;
        } else {
            LocalDate inputDate = LocalDate.parse(birthDate);
            LocalDate eighteenYearsAgo = LocalDate.now().minusYears(18);

            if (inputDate.isAfter(eighteenYearsAgo)) {
                Notify.getInstance().sendNotify(session, request, response, "not-enough-18");
                return false;
            }

        }
        if (address == null || address.trim().isEmpty()) {
            Notify.getInstance().sendNotify(session, request, response, "null-address");
            return false;
        }
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            Notify.getInstance().sendNotify(session, request, response, "null-phone");
            return false;
        } else {
            if (!phoneNumber.matches("^(\\+84|0)[0-9]{9}$")) {
                Notify.getInstance().sendNotify(session, request, response, "invalid-phone");
                return false;
            }
        }
        if (email == null || email.trim().isEmpty()) {
            Notify.getInstance().sendNotify(session, request, response, "null-email");
            return false;
        } else {
            if (!email.matches("^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,63}$")) {
                Notify.getInstance().sendNotify(session, request, response, "invalid-email");
                return false;
            }
        }
        if (username == null || username.trim().isEmpty()) {
            Notify.getInstance().sendNotify(session, request, response, "null-username");
            return false;
        } else {
            if (UsersDAO.getInstance().isUsernameDuplicate(username)) {
                Notify.getInstance().sendNotify(session, request, response, "duplicate-acc");
                return false;
            }
        }
        //Kiểm tra mật khẩu
        if (password == null || password.trim().isEmpty()) {

            Notify.getInstance().sendNotify(session, request, response, "null-pass");
            return false;
        } else {
            if (!password.matches("^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,}")) {
                Notify.getInstance().sendNotify(session, request, response, "invalid-pass");
                return false;

            }
        }
//        Kiểm tra mật khẩu nhập lại
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            Notify.getInstance().sendNotify(session, request, response, "null-cfpass");
            return false;
        } else {
            if (!password.equals(confirmPassword)) {
                Notify.getInstance().sendNotify(session, request, response, "pass-not-match");
                return false;
            }
        }
        if (agreeToTerms == null || !agreeToTerms.equals("on")) {
            Notify.getInstance().sendNotify(session, request, response, "null-agree");
            return false;
        }
//        String cfCode = UUID.randomUUID().toString().substring(0, 6);
//        Notify.getInstance().sendNotify(session, request, response, "register-success");
//        User user = new User(fullName, address, phoneNumber, email, username, password, gender, birthDate, cfCode);
//        EmailDAO.getInstance().sendMailWelcome(email, "Xác thực tài khoản", cfCode);
//        request.getRequestDispatcher("login.jsp").forward(request, response);
//        UsersDAO.getInstance().addUser(user);
//        String confirmationCode = UUID.randomUUID().toString().substring(0, 6);
//

        return true;
    }


}
