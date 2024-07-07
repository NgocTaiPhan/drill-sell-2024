package vn.hcmuaf.fit.drillsell.controller.register;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;


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
public boolean validateUserData(
        HttpServletResponse response,
        String fullname,
        String yearOfBirth,
        String phone,
        String currentUsername,
        String newUsername,
        String provinceId,
        String districtId,
        String wardId,
        String currentEmail,
        String newEmail
) throws IOException {
    if (isNullOrEmpty(fullname)) {
        Notify.errorNotify(response, "Hãy nhập họ và tên!", Page.NULL_PAGE);
        return false;
    }
    if (isNullOrEmpty(yearOfBirth)) {
        Notify.errorNotify(response, "Hãy chọn ngày sinh!", Page.NULL_PAGE);
        return false;
    }
    if (!isValidAge(yearOfBirth)) {
        Notify.errorNotify(response, "Bạn chưa đủ 18 tuổi!", Page.NULL_PAGE);
        return false;
    }
    if (isNullOrEmpty(phone)) {
        Notify.errorNotify(response, "Hãy nhập số điện thoại!", Page.NULL_PAGE);
        return false;
    }
    if (!isValidPhoneNumber(phone)) {
        Notify.errorNotify(response, "Số điện thoại không hợp lệ!", Page.NULL_PAGE);
        return false;
    }
    if (!currentEmail.equals(newEmail)) {
        if (isNullOrEmpty(newEmail)) {
            Notify.errorNotify(response, "Hãy nhập email!", Page.NULL_PAGE);
            return false;
        }
        if (!isValidEmail(newEmail)) {
            Notify.errorNotify(response, "Email không hợp lệ!", Page.NULL_PAGE);
            return false;
        }
        if (UsersDAO.getInstance().isEmailExists(newEmail)) {
            Notify.errorNotify(response, "Email đã tồn tại!", Page.NULL_PAGE);
            return false;
        }
    }
    if (!currentUsername.equals(newUsername)) {
        if (isNullOrEmpty(newUsername)) {
            Notify.errorNotify(response, "Hãy nhập tên đăng nhập!", Page.NULL_PAGE);
            return false;
        }
        if (UsersDAO.getInstance().isUsernameDuplicate(newUsername)) {
            Notify.errorNotify(response, "Tên đăng nhập đã tồn tại!", Page.NULL_PAGE);
            return false;
        }
    }
    if ("0".equals(provinceId)) {
        Notify.errorNotify(response, "Hãy chọn tỉnh/thành phố!", Page.NULL_PAGE);
        return false;
    }
    if ("0".equals(districtId)) {
        Notify.errorNotify(response, "Hãy chọn quận/huyện!", Page.NULL_PAGE);
        return false;
    }
    if ("0".equals(wardId)) {
        Notify.errorNotify(response, "Hãy chọn xã/phường!", Page.NULL_PAGE);
        return false;
    }

    return true;
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
    public boolean checkValid(
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
            Notify.errorNotify(response, "Hãy nhập họ và tên!", Page.NULL_PAGE);
            return false;
        }
        if (isNullOrEmpty(birthDate)) {
            Notify.errorNotify(response, "Hãy chọn ngày sinh!", Page.NULL_PAGE);
            return false;
        }
        if (!isValidAge(birthDate)) {
            Notify.errorNotify(response, "Bạn chưa đủ 18 tuổi!", Page.NULL_PAGE);
            return false;
        }
        if (isInvalidAddress(provinceId, districtId, wardId)) {
            Notify.errorNotify(response, "Hãy chọn địa chỉ!", Page.NULL_PAGE);
            return false;
        }
        if (isNullOrEmpty(phoneNumber)) {
            Notify.errorNotify(response, "Hãy nhập số điện thoại!", Page.NULL_PAGE);
            return false;
        }
        if (!isValidPhoneNumber(phoneNumber)) {
            Notify.errorNotify(response, "Số điện thoại không hợp lệ!", Page.NULL_PAGE);
            return false;
        }
        if (isNullOrEmpty(email)) {
            Notify.errorNotify(response, "Hãy nhập email!", Page.NULL_PAGE);
            return false;
        }
        if (!isValidEmail(email)) {
            Notify.errorNotify(response, "Email không hợp lệ!", Page.NULL_PAGE);
            return false;
        }
        if (UsersDAO.getInstance().isEmailExists(email)) {
            Notify.errorNotify(response, "Email đã tồn tại!", Page.NULL_PAGE);
            return false;
        }
        if (isNullOrEmpty(username)) {
            Notify.errorNotify(response, "Hãy nhập tên đăng nhập!", Page.NULL_PAGE);
            return false;
        }
        if (UsersDAO.getInstance().isUsernameDuplicate(username)) {
            Notify.errorNotify(response, "Tên đăng nhập đã tồn tại!", Page.NULL_PAGE);
            return false;
        }
        if (isNullOrEmpty(password)) {
            Notify.errorNotify(response, "Hãy nhập mật khẩu!", Page.NULL_PAGE);
            return false;
        }
        if (!isValidPassword(password)) {
            Notify.errorNotify(response, "Mật khẩu không hợp lệ! (Phải chứa chữ hoa, chữ thường, số và ít nhất 8 ký tự)", Page.NULL_PAGE);

            return false;
        }
        if (isNullOrEmpty(confirmPassword)) {
            Notify.errorNotify(response, "Hãy nhập lại mật khẩu!", Page.NULL_PAGE);
            return false;
        }
        if (!password.equals(confirmPassword)) {
            Notify.errorNotify(response, "Mật khẩu không trùng khớp!", Page.NULL_PAGE);
            return false;
        }
        if (!"on".equals(agreeToTerms)) {
            Notify.errorNotify(response, "Hãy đồng ý với điều khoản của chúng tôi!", Page.NULL_PAGE);
            return false;
        }
        return true;

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

