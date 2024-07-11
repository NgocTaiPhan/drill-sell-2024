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

//    validation cập nhật thông tin ngươif dùng
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
    if (FormUtils.isNullOrEmpty(fullname)) {
        Notify.errorNotify(response, "Hãy nhập họ và tên!", Page.NULL_PAGE);
        return false;
    }
    if (FormUtils.isNullOrEmpty(yearOfBirth)) {
        Notify.errorNotify(response, "Hãy chọn ngày sinh!", Page.NULL_PAGE);
        return false;
    }
    if (!FormUtils.isValidAge(yearOfBirth)) {
        Notify.errorNotify(response, "Bạn chưa đủ 18 tuổi!", Page.NULL_PAGE);
        return false;
    }
    if (FormUtils.isNullOrEmpty(phone)) {
        Notify.errorNotify(response, "Hãy nhập số điện thoại!", Page.NULL_PAGE);
        return false;
    }
    if (!FormUtils.isValidPhoneNumber(phone)) {
        Notify.errorNotify(response, "Số điện thoại không hợp lệ!", Page.NULL_PAGE);
        return false;
    }
    if (!currentEmail.equals(newEmail)) {
        if (FormUtils.isNullOrEmpty(newEmail)) {
            Notify.errorNotify(response, "Hãy nhập email!", Page.NULL_PAGE);
            return false;
        }
        if (!FormUtils.isValidEmail(newEmail)) {
            Notify.errorNotify(response, "Email không hợp lệ!", Page.NULL_PAGE);
            return false;
        }
        if (UsersDAO.getInstance().isEmailExists(newEmail)) {
            Notify.errorNotify(response, "Email đã tồn tại!", Page.NULL_PAGE);
            return false;
        }
    }
    if (!currentUsername.equals(newUsername)) {
        if (FormUtils.isNullOrEmpty(newUsername)) {
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

    public boolean validateAddUser(
            HttpServletResponse response,
            String fullName,
            String username,
            String email,
            String password,
            String provinceId,
            String districtId,
            String wardId,
            String phoneNumber,
            String birthDate

    )
            throws IOException {
        // Kiểm tra từng điều kiện xác thực và gửi phản hồi lỗi nếu có
        if (FormUtils.isNullOrEmpty(fullName)) {
            Notify.errorNotify(response, "Hãy nhập họ và tên!", Page.NULL_PAGE);
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
        if (FormUtils.isNullOrEmpty(password)) {
            Notify.errorNotify(response, "Hãy nhập mật khẩu!", Page.NULL_PAGE);
            return false;
        }
        if (!FormUtils.isValidPassword(password)) {
            Notify.errorNotify(response, "Mật khẩu không hợp lệ! (Phải chứa chữ hoa, chữ thường, số và ít nhất 8 ký tự)", Page.NULL_PAGE);

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
        if (FormUtils.isNullOrEmpty(birthDate)) {
            Notify.errorNotify(response, "Hãy chọn ngày sinh!", Page.NULL_PAGE);
            return false;
        }
        if (!FormUtils.isValidAge(birthDate)) {
            Notify.errorNotify(response, "Bạn chưa đủ 18 tuổi!", Page.NULL_PAGE);
            return false;
        }

        return true;

    }
//    validation admin chỉnh sửa thông tin người dùng
    public boolean validateAdminEditUser(
            HttpServletResponse response,
            String fullName,
            String userName,
            String currentUsername,
            String passwords,
            String province,
            String district,
            String ward,
            String phone,
            String email,
            String currentEmail,
            String yearOfBirth
    ) throws IOException {
        if (FormUtils.isNullOrEmpty(fullName)) {
            Notify.errorNotify(response, "Hãy nhập họ và tên!", Page.NULL_PAGE);
            return false;
        }
        if (!currentUsername.equals(userName)) {
            if (FormUtils.isNullOrEmpty(userName)) {
                Notify.errorNotify(response, "Hãy nhập tên đăng nhập!", Page.NULL_PAGE);
                return false;
            }
            if (UsersDAO.getInstance().isUsernameDuplicate(userName)) {
                Notify.errorNotify(response, "Tên đăng nhập đã tồn tại!", Page.NULL_PAGE);
                return false;
            }
        }
        if (!FormUtils.isNullOrEmpty(passwords) && !FormUtils.isValidPassword(passwords)) {
            Notify.errorNotify(response, "Mật khẩu không hợp lệ! (Phải chứa chữ hoa, chữ thường, số và ít nhất 8 ký tự)", Page.NULL_PAGE);
            return false;
        }
        if (!currentEmail.equals(email)) {
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
        }
        if (FormUtils.isInvalidAddress(province, district, ward)) {
            Notify.errorNotify(response, "Hãy chọn địa chỉ!", Page.NULL_PAGE);
            return false;
        }
        if (FormUtils.isNullOrEmpty(phone)) {
            Notify.errorNotify(response, "Hãy nhập số điện thoại!", Page.NULL_PAGE);
            return false;
        }
        if (!FormUtils.isValidPhoneNumber(phone)) {
            Notify.errorNotify(response, "Số điện thoại không hợp lệ!", Page.NULL_PAGE);
            return false;
        }
        if (FormUtils.isNullOrEmpty(yearOfBirth)) {
            Notify.errorNotify(response, "Hãy chọn ngày sinh!", Page.NULL_PAGE);
            return false;
        }
        if (!FormUtils.isValidAge(yearOfBirth)) {
            Notify.errorNotify(response, "Bạn chưa đủ 18 tuổi!", Page.NULL_PAGE);
            return false;
        }

        return true;
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