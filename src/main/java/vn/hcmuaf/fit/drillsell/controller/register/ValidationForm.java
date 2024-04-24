package vn.hcmuaf.fit.drillsell.controller.register;

import vn.hcmuaf.fit.drillsell.dao.UsersDAO;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;

public class ValidationForm {
    public static boolean validationForm(String fullName, String birthDate, String address, String phoneNumber, String email, String username, String password, String confirmPassword, String agreeToTerms, HttpServletResponse response, HttpSession session) throws IOException {
        return checkFullName(fullName, response) &&
                checkBirthDate(birthDate, response) &&
                checkAddress(address, response, session) &&
                checkPhoneNumber(phoneNumber, response) &&
                checkEmail(email, response) &&
                checkUsername(username, response) &&
                checkPassword(password, response) &&
                checkConfirmPassword(password, confirmPassword, response) &&
                checkAgreeToTerms(agreeToTerms, response);
    }

    public static boolean checkFullName(String fullName, HttpServletResponse response) throws IOException {
        if (fullName == null || fullName.trim().isEmpty()) {
            response.sendRedirect("login.jsp?notify=null-fullname");
            return false;
        }
        return true;
    }

    public static boolean checkBirthDate(String birthDate, HttpServletResponse response) throws IOException {
        if (birthDate == null || birthDate.trim().isEmpty()) {
            response.sendRedirect("login.jsp?notify=null-birthday");
            return false;
        } else {
            LocalDate inputDate = LocalDate.parse(birthDate);
            if (inputDate.isAfter(LocalDate.now())) {
                response.sendRedirect("login.jsp?notify=future-birthday");
                return false;
            }
        }
        return true;
    }

    public static boolean checkAddress(String address, HttpServletResponse response, HttpSession session) throws IOException {
        if (address == null || address.trim().isEmpty()) {
            response.sendRedirect("login.jsp?notify=null-address");
            return false;
        }
        session.setAttribute("address", address);
        return true;
    }

    public static boolean checkPhoneNumber(String phoneNumber, HttpServletResponse response) throws IOException {
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            response.sendRedirect("login.jsp?notify=null-phone");
            return false;
        } else {
            if (!phoneNumber.matches("^(\\+84|0)[0-9]{9}$")) {
                response.sendRedirect("login.jsp?notify=invalid-phone");
                return false;
            }
        }
        return true;
    }

    public static boolean checkEmail(String email, HttpServletResponse response) throws IOException {
        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect("login.jsp?notify=null-email");
            return false;
        } else {
            if (!email.matches("^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,63}$")) {
                response.sendRedirect("login.jsp?notify=invalid-email");
                return false;
            }
        }
        return true;
    }

    public static boolean checkUsername(String username, HttpServletResponse response) throws IOException {
        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect("login.jsp?notify=null-username");
            return false;
        } else {
            if (UsersDAO.getInstance().isUsernameDuplicate(username)) {
                response.sendRedirect("login.jsp?notify=duplicate-acc");
                return false;
            }
        }
        return true;
    }

    public static boolean checkPassword(String password, HttpServletResponse response) throws IOException {
        if (password == null || password.trim().isEmpty()) {
            response.sendRedirect("login.jsp?notify=null-pass");
            return false;
        } else {
            if (!password.matches("^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,}")) {
                response.sendRedirect("login.jsp?notify=invalid-password");
                return false;
            }
        }
        return true;
    }

    public static boolean checkConfirmPassword(String password, String confirmPassword, HttpServletResponse response) throws IOException {
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            response.sendRedirect("login.jsp?notify=null-cfpass");
            return false;
        } else {
            if (!password.equals(confirmPassword)) {
                response.sendRedirect("login.jsp?notify=pass-not-match");
                return false;
            }
        }
        return true;
    }

    public static boolean checkAgreeToTerms(String agreeToTerms, HttpServletResponse response) throws IOException {
        if (agreeToTerms == null || !agreeToTerms.equals("on")) {
            response.sendRedirect("login.jsp?notify=null-agree");
            return false;
        }
        return true;
    }
}
