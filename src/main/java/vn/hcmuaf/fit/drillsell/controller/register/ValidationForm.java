package vn.hcmuaf.fit.drillsell.controller.register;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;

public class ValidationForm {
    private static ValidationForm instance;


    public static ValidationForm getInstance() {
        if (instance == null) instance = new ValidationForm();
        return instance;
    }


    public void validationRegister(HttpSession session, HttpServletRequest request, HttpServletResponse response, String fullName, String birthDate, String address, String phoneNumber, String email, String username, String password, String confirmPassword, String agreeToTerms, String gender) throws ServletException, IOException {

        if (fullName == null || fullName.trim().isEmpty()) {
            Notify.getInstance().sendNotify(session, request, response, "null-fullname");
            return;
        }
//        else if (!fullName.matches(".\\d.")) {
//            Notify.getInstance().registerNotify(session, request, response, "invalid-fullname");
//            return;
//        }
        if (birthDate == null || birthDate.trim().isEmpty()) {
            Notify.getInstance().sendNotify(session, request, response, "null-birthday");
            return;
        } else {
            LocalDate inputDate = LocalDate.parse(birthDate);
            if (inputDate.isAfter(LocalDate.now())) {
                Notify.getInstance().sendNotify(session, request, response, "future-birthday");
                return;
            }

        }
        if (address == null || address.trim().isEmpty()) {
            Notify.getInstance().sendNotify(session, request, response, "null-address");
            return;
        }
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            Notify.getInstance().sendNotify(session, request, response, "null-phone");
            return;
        } else {
            if (!phoneNumber.matches("^(\\+84|0)[0-9]{9}$")) {
                Notify.getInstance().sendNotify(session, request, response, "invalid-phone");
                return;
            }
        }
        if (email == null || email.trim().isEmpty()) {
            Notify.getInstance().sendNotify(session, request, response, "null-email");
            return;
        } else {
            if (!email.matches("^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,63}$")) {
                Notify.getInstance().sendNotify(session, request, response, "invalid-email");
                return;
            }
        }
        if (username == null || username.trim().isEmpty()) {
            Notify.getInstance().sendNotify(session, request, response, "null-username");
            return;
        } else {
            if (UsersDAO.getInstance().isUsernameDuplicate(username)) {
                Notify.getInstance().sendNotify(session, request, response, "duplicate-acc");
                return;
            }
        }
        //Kiểm tra mật khẩu
        if (password == null || password.trim().isEmpty()) {
            Notify.getInstance().sendNotify(session, request, response, "null-pass");
            return;
        } else {
            if (!password.matches("^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,}")) {
                Notify.getInstance().sendNotify(session, request, response, "invalid-pass");
                return;
            }
        }
//        Kiểm tra mật khẩu nhập lại
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            Notify.getInstance().sendNotify(session, request, response, "null-cfpass");
            return;
        } else {
            if (!password.equals(confirmPassword)) {
                Notify.getInstance().sendNotify(session, request, response, "pass-not-match");
                return;
            }
        }
        if (agreeToTerms == null || !agreeToTerms.equals("on")) {
            Notify.getInstance().sendNotify(session, request, response, "null-agree");
            return;
        }
        Notify.getInstance().sendNotify(session, request, response, "register-success");

    }
}
