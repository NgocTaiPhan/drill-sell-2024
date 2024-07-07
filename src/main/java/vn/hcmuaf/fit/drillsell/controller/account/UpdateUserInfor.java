
package vn.hcmuaf.fit.drillsell.controller.account;

import com.google.gson.Gson;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
//
//@WebServlet("/updateUserInfo")
//public class UpdateUserInfor extends HttpServlet {
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("auth");
//
//        if (user != null) {
//            // Nhận dữ liệu từ yêu cầu POST
//            String requestBody = request.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
//
//            // Chuyển đổi JSON thành đối tượng User
//            Gson gson = new Gson();
//            User updatedUser = gson.fromJson(requestBody, User.class);
//            updatedUser.setId(user.getId()); // Đảm bảo ID không thay đổi
//
//            // Cập nhật thông tin người dùng vào cơ sở dữ liệu
//            UsersDAO userDAO = new UsersDAO(); // Tạo đối tượng DAO để thao tác với cơ sở dữ liệu
//            boolean success = userDAO.adminUpdateUser(updatedUser);
//
//            if (success) {
//                // Cập nhật thông tin người dùng trong session
//                session.setAttribute("auth", updatedUser);
//
//                // Trả về phản hồi JSON
//                response.setContentType("application/json");
//                response.setCharacterEncoding("UTF-8");
//                response.getWriter().write("{\"message\": \"Update successful\"}");
//            } else {
//                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Hoặc mã lỗi khác tương ứng
//            }
//        } else {
//            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
//        }
//    }
//}
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

            // Kiểm tra giá trị dob nhận từ client
            System.out.println("DOB: " + updatedUser.getYearOfBirth());

            // Cập nhật thông tin người dùng vào cơ sở dữ liệu
            UsersDAO userDAO = new UsersDAO(); // Tạo đối tượng DAO để thao tác với cơ sở dữ liệu
            boolean success = userDAO.adminUpdateUser(updatedUser);

            if (success) {
                // Cập nhật thông tin người dùng trong session
                session.setAttribute("auth", updatedUser);

                // Trả về phản hồi JSON
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"message\": \"Update successful\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Hoặc mã lỗi khác tương ứng
            }
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }
}
