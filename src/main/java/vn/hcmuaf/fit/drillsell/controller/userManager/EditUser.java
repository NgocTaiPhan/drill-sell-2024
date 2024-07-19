
package vn.hcmuaf.fit.drillsell.controller.userManager;

import com.google.gson.Gson;
import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.controller.register.ValidationForm;
import vn.hcmuaf.fit.drillsell.dao.IUserDAO;
import vn.hcmuaf.fit.drillsell.dao.LogDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.Log;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/editUser")
public class EditUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("editUserId"); // Ensure this matches your form field name
        String fullName = req.getParameter("editFullname");
        String userName = req.getParameter("editUsername");
        String passwords = req.getParameter("editPasswords");
        String province = req.getParameter("editTinh");
        String district = req.getParameter("editQuan");
        String ward = req.getParameter("editPhuong");
        String phone = req.getParameter("editPhone");
        String email = req.getParameter("editEmail");
        String sexStr = req.getParameter("editSex");
        String yearOfBirth = req.getParameter("editYearOfBirth");
        String roleUserStr = req.getParameter("editRoleUser");

//        IUserDAO userDao = new UsersDAO();
//        User userWithId = new User();
//        userWithId.setId(Integer.parseInt(idStr));
        User currentUser = UsersDAO.getInstance().getUserById(Integer.parseInt(idStr));
        String currentUsername = currentUser.getUsername();
        String currentEmail = currentUser.getEmail();
        ValidationForm validationForm = ValidationForm.getInstance();
        boolean isValid = validationForm.validateAdminEditUser(
                resp,
                fullName,
                userName,
                currentUsername,
                passwords,
                province,
                district,
                ward,
                phone,
                email,
                currentEmail,
                yearOfBirth
        );


        // Lưu user vào session để refill vào form khi nhập thông tin không hợp lệ
        if (!isValid) {
            return; // Dừng xử lý nếu các thông tin không hợp lệ
        }
        if (idStr != null && !idStr.isEmpty()) {
            try {

                int id = Integer.parseInt(idStr); // Convert string to integer
                User previousUser = UsersDAO.getInstance().getUser(id);
                String previousInfo = "user ID: " + previousUser.getId()
                        + ", fullName: " + previousUser.getFullname()
                        + ", address: " + previousUser.getAddress()
                        + ", phone: " + previousUser.getPhone()
                        + ", email: " + previousUser.getEmail()
                        + ", username: " + previousUser.getUsername()
                        + ", sex: " + setGender(previousUser.getSex())
                        + ", yearOfBirth: " + previousUser.getYearOfBirth()
                        + ", role: " + setRole(previousUser.isRoleUser());
                IUserDAO userDao = new UsersDAO();
                User user = new User();
                user.setId(id);
                user.setFullname(fullName);
                user.setUsername(userName);
                user.setEmail(email);
                user.setPhone(phone);

                // Concatenate province, district, ward into one string
                String address = province.trim() + ", " + district.trim() + ", " + ward.trim();
                user.setAddress(address);

                if (passwords != null && !passwords.isEmpty()) {
                    user.setPasswords(passwords);
                }

                boolean sex = "Nam".equalsIgnoreCase(sexStr);
                user.setSex(sex);
                user.setYearOfBirth(yearOfBirth);
                boolean roleUser = "Admin".equalsIgnoreCase(roleUserStr);
                user.setRoleUser(roleUser);

                // Cập nhật thông tin người dùng trong cơ sở dữ liệu
                userDao.adminupdateUser(user);

                // Return success message
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");

                Notify.successNotify(resp,"Cập nhật thông tin thành công", Page.NULL_PAGE);

                // Log the update


                Log log = new Log();
                log.setUserId(id);
                String values = "user ID: " + idStr + ", fullname: " + fullName + ", address: " + address + ", phone: " + phone + ", email: " + email + ", username: " + userName + ", sex: " + sexStr + ", yearOfBirth: " + yearOfBirth + ", role: " + roleUserStr;
                log.setValuess(values);
                log.setStatuss("Cập nhật User");
                LogDAO.insertUpdateOrderInLog(log, previousInfo);
            } catch (NumberFormatException e) {
                Notify.errorNotify(resp, "Đã xảy ra lỗi khi cập nhật thông tin người dùng", Page.NULL_PAGE);
            }
        } else {
            Notify.errorNotify(resp, "Không tìm thấy ID", Page.NULL_PAGE);
        }
    }

    private String setGender(boolean gender) {
        return gender ? "Nam" : "Nữ";
    }

    private String setRole(boolean roleUser) {
        return roleUser ? "Admin" : "User";
    }
}