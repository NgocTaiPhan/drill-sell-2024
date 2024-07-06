package vn.hcmuaf.fit.drillsell.controller.register;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.utils.FormUtils;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
 * Lớp ValidationForm thực hiện xác thực các thông tin đăng ký người dùng từ form.
 */
public class ValidationForm {
    private static ValidationForm instance;
    FormUtils formUtils;

    public ValidationForm() {
    }

    public static ValidationForm getInstance() {
        if (instance == null) instance = new ValidationForm();
        return instance;
    }

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
        if (FormUtils.isNullOrEmpty(fullName)) {
            Notify.errorNotify(response, "Hãy nhập họ và tên!", Page.NULL_PAGE);
            return false;
        }
        if (FormUtils.isNullOrEmpty(birthDate)) {
            Notify.errorNotify(response, "Hãy chọn ngày sinh!", Page.NULL_PAGE);
            return false;
        }
        if (!FormUtils.isValidAge(birthDate)) {
            Notify.errorNotify(response, "Bạn chưa đủ 18 tuổi!", Page.NULL_PAGE);
            return false;
        }
        if (FormUtils.isInvalidAddress(provinceId, districtId, wardId)) {
            Notify.errorNotify(response, "Hãy chọn địa chỉ!", Page.NULL_PAGE);
            return false;
        }
        if (FormUtils.isNullOrEmpty(phoneNumber)) {
            Notify.errorNotify(response, "Hãy nhập số điện thoại!", Page.NULL_PAGE);
            return false;
        }
        if (!FormUtils.isValidPhoneNumber(phoneNumber)) {
            Notify.errorNotify(response, "Số điện thoại không hợp lệ!", Page.NULL_PAGE);
            return false;
        }
        if (FormUtils.isNullOrEmpty(email)) {
            Notify.errorNotify(response, "Hãy nhập email!", Page.NULL_PAGE);
            return false;
        }
        if (!FormUtils.isValidEmail(email)) {
            Notify.errorNotify(response, "Email không hợp lệ!", Page.NULL_PAGE);
            return false;
        }
        if (UsersDAO.getInstance().isEmailExists(email)) {
            Notify.errorNotify(response, "Email đã tồn tại!", Page.NULL_PAGE);
            return false;
        }
        if (FormUtils.isNullOrEmpty(username)) {
            Notify.errorNotify(response, "Hãy nhập tên đăng nhập!", Page.NULL_PAGE);
            return false;
        }
        if (UsersDAO.getInstance().isUsernameDuplicate(username)) {
            Notify.errorNotify(response, "Tên đăng nhập đã tồn tại!", Page.NULL_PAGE);
            return false;
        }
        if (FormUtils.isNullOrEmpty(password)) {
            Notify.errorNotify(response, "Hãy nhập mật khẩu!", Page.NULL_PAGE);
            return false;
        }
        if (!FormUtils.isValidPassword(password)) {
            Notify.errorNotify(response, "Mật khẩu không hợp lệ! (Phải chứa chữ hoa, chữ thường, số và ít nhất 8 ký tự)", Page.NULL_PAGE);

            return false;
        }
        if (FormUtils.isNullOrEmpty(confirmPassword)) {
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



}

