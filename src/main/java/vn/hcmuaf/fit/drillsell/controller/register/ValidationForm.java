package vn.hcmuaf.fit.drillsell.controller.register;

import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.function.Predicate;

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
     * Map các Predicate và message lỗi tương ứng cho từng loại kiểm tra.
     */
    private static final Map<Predicate<ValidationInput>, String> VALIDATIONS = new LinkedHashMap<>();

    static {
        VALIDATIONS.put(input -> isNullOrEmpty(input.fullName), "Hãy nhập họ và tên!");
        VALIDATIONS.put(input -> isNullOrEmpty(input.birthDate), "Hãy chọn ngày sinh!");
        VALIDATIONS.put(input -> !isValidAge(input.birthDate), "Bạn chưa đủ 18 tuổi!");
        VALIDATIONS.put(input -> isInvalidAddress(input.provinceId, input.districtId, input.wardId), "Hãy chọn địa chỉ!");
        VALIDATIONS.put(input -> isNullOrEmpty(input.phoneNumber), "Hãy nhập số điện thoại!");
        VALIDATIONS.put(input -> !isValidPhoneNumber(input.phoneNumber), "Số điện thoại không hợp lệ!");
        VALIDATIONS.put(input -> isNullOrEmpty(input.email), "Hãy nhập email!");
        VALIDATIONS.put(input -> !isValidEmail(input.email), "Email không hợp lệ!");
        VALIDATIONS.put(input -> UsersDAO.getInstance().isEmailExists(input.email), "Email đã tồn tại!");
        VALIDATIONS.put(input -> isNullOrEmpty(input.username), "Hãy nhập tên đăng nhập");
        VALIDATIONS.put(input -> UsersDAO.getInstance().isUsernameDuplicate(input.username), "Tên đăng nhập đã tồn tại");
        VALIDATIONS.put(input -> isNullOrEmpty(input.password), "Hãy nhập mật khẩu");
        VALIDATIONS.put(input -> !isValidPassword(input.password), "Mật khẩu không hợp lệ!(Phải chứa chữ hoa, chữ thường, số và ít nhất 8 kí tự)");
        VALIDATIONS.put(input -> isNullOrEmpty(input.confirmPassword), "Hãy nhập lại mật khẩu!");
        VALIDATIONS.put(input -> !input.password.equals(input.confirmPassword), "Mật khẩu không trùng khớp");
        VALIDATIONS.put(input -> input.agreeToTerms == null || !"on".equals(input.agreeToTerms), "Hãy đồng ý với điều khoản của chúng tôi");
    }

    /**
     * Phương thức validate để kiểm tra và xác thực các thông tin đăng ký người dùng.
     *
     * @param session        HttpSession để lưu trữ dữ liệu phiên
     * @param request        HttpServletRequest để lấy thông tin từ form
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
     * @param gender         Giới tính từ form
     * @return ValidationResult chứa kết quả kiểm tra và thông báo lỗi (nếu có)
     * @throws ServletException nếu có lỗi xảy ra trong Servlet
     * @throws IOException      nếu có lỗi xảy ra trong quá trình xử lý IO
     */
    public ValidationResult validate(
            HttpSession session,
            HttpServletRequest request,
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
            String agreeToTerms,
            boolean gender
    )
            throws ServletException, IOException {

        // Tạo đối tượng ValidationInput từ các tham số đầu vào
        ValidationInput registerInput = new ValidationInput(
                fullName,
                birthDate,
                provinceId,
                districtId,
                wardId,
                phoneNumber,
                email,
                username,
                password,
                confirmPassword,
                agreeToTerms,
                gender
        );

        // Duyệt qua từng rule trong VALIDATIONS để kiểm tra
        for (Map.Entry<Predicate<ValidationInput>, String> validation : VALIDATIONS.entrySet()) {
            if (validation.getKey().test(registerInput)) {
                // Gửi phản hồi lỗi nếu có lỗi xảy ra
                sendResponseText(response, validation.getValue(), HttpServletResponse.SC_BAD_REQUEST);
                return new ValidationResult(false, validation.getValue());
            }
        }

        // Trả về ValidationResult là hợp lệ nếu không có lỗi nào được tìm thấy
        return new ValidationResult(true, null);
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

/**
 * Lớp ValidationInput để đóng gói các thông tin đăng ký từ form.
 */
class ValidationInput {
    String fullName;
    String birthDate;
    String provinceId;
    String districtId;
    String wardId;
    String phoneNumber;
    String email;
    String username;
    String password;
    String confirmPassword;
    String agreeToTerms;
    boolean gender;

    public ValidationInput(String fullName, String birthDate, String provinceId, String districtId, String wardId,
                           String phoneNumber, String email, String username, String password, String confirmPassword,
                           String agreeToTerms, boolean gender) {
        this.fullName = fullName;
        this.birthDate = birthDate;
        this.provinceId = provinceId;
        this.districtId = districtId;
        this.wardId = wardId;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.username = username;
        this.password = password;
        this.confirmPassword = confirmPassword;
        this.agreeToTerms = agreeToTerms;
        this.gender = gender;
    }
}

/**
 * Lớp ValidationResult để đóng gói kết quả kiểm tra và thông báo lỗi (nếu có).
 */
class ValidationResult {
    boolean isValid;
    String errorMessage;

    public ValidationResult(boolean isValid, String errorMessage) {
        this.isValid = isValid;
        this.errorMessage = errorMessage;
    }

    public boolean isValid() {
        return isValid;
    }

    public String getErrorMessage() {
        return errorMessage;
    }
}
