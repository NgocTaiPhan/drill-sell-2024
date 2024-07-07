
package vn.hcmuaf.fit.drillsell.controller.account;

import com.google.gson.Gson;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.controller.register.ValidationForm;
import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/updateUserInfo")
public class UpdateUserInfor extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");

        if (user != null) {
            // Nhận dữ liệu từ yêu cầu POST
            String requestBody = request.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);

            // Chuyển đổi JSON thành đối tượng User
            Gson gson = new Gson();
            User updatedUser = gson.fromJson(requestBody, User.class);
            updatedUser.setId(user.getId()); // Đảm bảo ID không thay đổi

            // Validate thông tin người dùng
            ValidationForm validationForm = ValidationForm.getInstance();
            String address = updatedUser.getAddress();

            // Split address into parts assuming it's comma-separated
            String[] addressParts = address.split(",");

            if (addressParts.length < 3) {
                // Handle case where address is not in expected format
                Notify.errorNotify(response, "Invalid address format", Page.NULL_PAGE);
                return;
            }

            // Trim leading and trailing whitespace from each part
            String provinceId = addressParts[0].trim();
            String districtId = addressParts[1].trim();
            String wardId = addressParts[2].trim();

            // Validate các thông tin khác ngoại trừ email và username
            boolean isValid = validationForm.validateUserData(response, updatedUser.getFullname(), updatedUser.getYearOfBirth(),
                    updatedUser.getPhone(), user.getUsername(), updatedUser.getUsername(), provinceId, districtId, wardId, user.getEmail(), updatedUser.getEmail());
            if (!isValid) {
                return; // Dừng xử lý nếu các thông tin không hợp lệ
            }

            // Cập nhật thông tin người dùng vào cơ sở dữ liệu
            UsersDAO userDAO = new UsersDAO(); // Tạo đối tượng DAO để thao tác với cơ sở dữ liệu
            boolean success = userDAO.updateUser(updatedUser);

            if (success) {
                // Cập nhật thông tin người dùng trong session
                session.setAttribute("auth", updatedUser);

                // Trả về phản hồi JSON
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"message\": \"Update successful\"}");
            } else {
                // Cập nhật không thành công, gửi thông báo lỗi cụ thể về client
                Notify.errorNotify(response, "Đã xảy ra lỗi khi cập nhật thông tin người dùng", Page.NULL_PAGE);
            }
        } else {
            // Người dùng chưa đăng nhập, trả về lỗi 401 Unauthorized
            Notify.errorNotify(response, "Unauthorized access", Page.NULL_PAGE);
        }
    }
}
