package vn.hcmuaf.fit.drillsell.utils;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;

public class FormUtils {
    public static boolean isNullOrEmpty(String formInput) {
        return formInput == null || formInput.trim().isEmpty();
    }

    public static boolean isValidAge(String birthDate) {
        LocalDate inputDate = LocalDate.parse(birthDate);
        LocalDate eighteenYearsAgo = LocalDate.now().minusYears(18);
        return !inputDate.isAfter(eighteenYearsAgo);
    }

    public static boolean isInvalidAddress(String provinceId, String districtId, String wardId) {
        return "0".equals(provinceId) || "0".equals(districtId) || "0".equals(wardId);
    }

    public static boolean isValidPhoneNumber(String phoneNumber) {
        return phoneNumber.matches("^(\\+84|0)[0-9]{9}$");
    }

    public static boolean isValidEmail(String email) {
        return email.matches("^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,63}$");
    }

    public static boolean isValidPassword(String password) {
        return password.matches("^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$");
    }

    public static int assignInput(HttpServletRequest request, String parameter) {
        String inputParam = request.getParameter(parameter);
        if (!(inputParam == null || inputParam.equals(""))) {
            return Integer.parseInt(inputParam);
        }
        return 0;
    }
}
