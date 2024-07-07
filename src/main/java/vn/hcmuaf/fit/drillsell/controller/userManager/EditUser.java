
package vn.hcmuaf.fit.drillsell.controller.userManager;

import com.google.gson.Gson;
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
        String idStr = req.getParameter("id");
        String fullname = req.getParameter("fullname");
        String userName = req.getParameter("username");
        String passwords = req.getParameter("passwords");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String sexStr = req.getParameter("sex");
        String yearOfBirth = req.getParameter("yearOfBirth");
        String roleUserStr = req.getParameter("roleUser");

        if (idStr != null) {
            int id = Integer.parseInt(idStr); // Chuyển đổi chuỗi thành số nguyên
            IUserDAO userDao = new UsersDAO();
            User user = new User();
            user.setId(id);
            user.setFullname(fullname);
            user.setUsername(userName);
            user.setEmail(email);
            user.setAddress(address);
            user.setPhone(phone);

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
            String successMessage = "Bạn đã cập nhật thành công";
            Gson gson = new Gson();
            String json = gson.toJson(successMessage);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(json);

            // Log the update
            User previousUser = UsersDAO.getInstance().getUserById(id);
            String previousInfo = "user ID: " + previousUser.getId()
                    + ", fullname: " + previousUser.getFullname()
                    + ", address: " + previousUser.getAddress()
                    + ", phone: " + previousUser.getPhone()
                    + ", email: " + previousUser.getEmail()
                    + ", username: " + previousUser.getUsername()
                    + ", sex: " + setGender(previousUser.getSex())
                    + ", yearOfBirth: " + previousUser.getYearOfBirth()
                    + ", role: " + setRole(previousUser.isRoleUser());

            Log log = new Log();
            log.setUserId(id);
            String values = "user ID: " + idStr + ", fullname: " + fullname + ", address: " + address + ", phone: " + phone + ", email: " + email + ", username: " + userName + ", sex: " + sexStr + ", yearOfBirth: " + yearOfBirth + ", role: " + roleUserStr;
            log.setValuess(values);
            log.setStatuss("Cập nhật User");
            LogDAO.insertUpdateOrderInLog(log, previousInfo);
        } else {
            // Xử lý khi không có id trong request
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing user ID");
        }
    }

    private String setGender(boolean gender) {
        return gender ? "Nam" : "Nữ";
    }

    private String setRole(boolean roleUser) {
        return roleUser ? "Admin" : "User";
    }

}
