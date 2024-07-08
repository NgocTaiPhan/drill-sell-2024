
package vn.hcmuaf.fit.drillsell.controller.account;

import com.google.gson.Gson;
import org.jfree.data.json.impl.JSONObject;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
@WebServlet("/showUserInfor")
public class ShowUserInfor extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");

        if (user != null) {
            String address = user.getAddress();

            // Phân tích chuỗi địa chỉ thành các thành phần riêng biệt
            String[] addressParts = address.split(",");

            String province = "";
            String district = "";
            String ward = "";

            if (addressParts.length > 0) {
                province = addressParts[0].trim(); // Tỉnh/thành phố
            }
            if (addressParts.length > 1) {
                district = addressParts[1].trim(); // Quận/huyện
            }
            if (addressParts.length > 2) {
                ward = addressParts[2].trim(); // Phường/xã
            }

            // Tạo đối tượng JSON từ dữ liệu người dùng
            JSONObject userData = new JSONObject();
            userData.put("fullname", user.getFullname());
            userData.put("username", user.getUsername());
            userData.put("email", user.getEmail());
            userData.put("sex", user.isSex() ? "Nam" : "Nữ");
            userData.put("yearOfBirth", user.getYearOfBirth());
            userData.put("phone", user.getPhone());
            userData.put("accountType", user.isRoleUser() ? "Quản trị" : "Người dùng");
            userData.put("province", province); // Gửi dữ liệu tỉnh/thành phố
            userData.put("district", district); // Gửi dữ liệu quận/huyện
            userData.put("ward", ward); // Gửi dữ liệu phường/xã

            // Chuyển đổi JSON thành chuỗi và gửi về client
            String userJson = userData.toString();

            // Thiết lập kiểu phản hồi là JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(userJson);
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }
}
