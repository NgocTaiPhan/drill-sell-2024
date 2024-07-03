package vn.hcmuaf.fit.drillsell.controller.register;

import vn.hcmuaf.fit.drillsell.dao.UsersDAO;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

import static vn.hcmuaf.fit.drillsell.controller.notify.Notify.sendResponseText;

/**
 * Lớp ValidationForm thực hiện xác thực các thông tin đăng ký người dùng từ form.
 */
public class ValidationForm {
    private static volatile ValidationForm instance;

    private ValidationForm() {
    }

    /**
     * Phương thức getInstance() để lấy instance duy nhất của ValidationForm (Singleton pattern).
     *
     * @return instance của ValidationForm
     */
    public static ValidationForm getInstance() {
        if (instance == null) {
            synchronized (ValidationForm.class) {
                if (instance == null) {
                    instance = new ValidationForm();
                }
            }
        }
        return instance;
    }

    /**
     * Phương thức validate để kiểm tra và xác thực các thông tin đăng ký người dùng.
     * @param response       HttpServletResponse để gửi phản hồi khi có lỗi
     * @param fullName       Họ và tên từ form
     * @param birthDate      Ngày sinh từ form
     * @param provinceId     ID tỉnh/thành phố từ form
     * @param districtId     ID quận/huyện từ form
     * @param wardId         ID phường/xã từ form
     * @param phoneNumber    Số điện thoại từ form
     * @param email          Email từ form
     * @param username       Tên đăng nhập từ form
     * @param password       Mật khẩu từ form
     * @param confirmPassword Nhập lại mật khẩu từ form
     * @param agreeToTerms   Đồng ý với điều khoản từ form
     * @throws IOException      nếu có lỗi xảy ra trong quá trình xử lý IO
     */
    public void checkValid(
            HttpServletResponse response,
            String fullName,
            String birthDate,
            String provinceId,
            String districtId,
            String wardId,
            String phoneNumber,
            String email,
            String username,
            String password,
            String confirmPassword,
            String agreeToTerms
    )
            throws IOException {

        // Kiểm tra từng điều kiện xác thực và gửi phản hồi lỗi nếu có
        if (isNullOrEmpty(fullName)) {
            sendResponseText(response, "Hãy nhập họ và tên!", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (isNullOrEmpty(birthDate)) {
            sendResponseText(response, "Hãy chọn ngày sinh!", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (!isValidAge(birthDate)) {
            sendResponseText(response, "Bạn chưa đủ 18 tuổi!", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (isInvalidAddress(provinceId, districtId, wardId)) {
            sendResponseText(response, "Hãy chọn địa chỉ!", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (isNullOrEmpty(phoneNumber)) {
            sendResponseText(response, "Hãy nhập số điện thoại!", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (!isValidPhoneNumber(phoneNumber)) {
            sendResponseText(response, "Số điện thoại không hợp lệ!", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (isNullOrEmpty(email)) {
            sendResponseText(response, "Hãy nhập email!", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (!isValidEmail(email)) {
            sendResponseText(response, "Email không hợp lệ!", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (UsersDAO.getInstance().isEmailExists(email)) {
            sendResponseText(response, "Email đã tồn tại!", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (isNullOrEmpty(username)) {
            sendResponseText(response, "Hãy nhập tên đăng nhập!", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (UsersDAO.getInstance().isUsernameDuplicate(username)) {
            sendResponseText(response, "Tên đăng nhập đã tồn tại!", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (isNullOrEmpty(password)) {
            sendResponseText(response, "Hãy nhập mật khẩu!", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (!isValidPassword(password)) {
            sendResponseText(response, "Mật khẩu không hợp lệ! (Phải chứa chữ hoa, chữ thường, số và ít nhất 8 ký tự)", HttpServletResponse.SC_BAD_REQUEST);

            return;
        }
        if (isNullOrEmpty(confirmPassword)) {
            sendResponseText(response, "Hãy nhập lại mật khẩu!", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (!password.equals(confirmPassword)) {
            sendResponseText(response, "Mật khẩu không trùng khớp!", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (agreeToTerms == null || !"on".equals(agreeToTerms)) {
            sendResponseText(response, "Hãy đồng ý với điều khoản của chúng tôi!", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

    }

    // Các phương thức hỗ trợ kiểm tra dữ liệu
    private static boolean isNullOrEmpty(String formInput) {
        return formInput == null || formInput.trim().isEmpty();
    }

    private static boolean isValidAge(String birthDate) {
        LocalDate inputDate = LocalDate.parse(birthDate);
        LocalDate eighteenYearsAgo = LocalDate.now().minusYears(18);
        return !inputDate.isAfter(eighteenYearsAgo);
    }

    private static boolean isInvalidAddress(String provinceId, String districtId, String wardId) {
        return "0".equals(provinceId) || "0".equals(districtId) || "0".equals(wardId);
    }

    private static boolean isValidPhoneNumber(String phoneNumber) {
        return phoneNumber.matches("^(\\+84|0)[0-9]{9}$");
    }

    private static boolean isValidEmail(String email) {
        return email.matches("^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,63}$");
    }

    private static boolean isValidPassword(String password) {
        return password.matches("^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$");
    }

}

