//package vn.hcmuaf.fit.drillsell.controller.userManager;
//
//import com.google.gson.Gson;
//import vn.hcmuaf.fit.drillsell.dao.IUserDAO;
//import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
//import vn.hcmuaf.fit.drillsell.model.User;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//@WebServlet("/admin/editUser")
//public class EditUser extends HttpServlet {
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        doPost(req, resp);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String idStr = req.getParameter("id");
//        String fullname = req.getParameter("fullname");
//        String userName = req.getParameter("username");
//        String address = req.getParameter("address");
//        String phone = req.getParameter("phone");
//        String email = req.getParameter("email");
//        String sexStr = req.getParameter("sex");
//        String yearOfBirth = req.getParameter("yearOfBirth");
//        String roleUserStr = req.getParameter("roleUser");
//
//        if (idStr != null) {
//            int id = Integer.parseInt(idStr); // Chuyển đổi chuỗi thành số nguyên
//            IUserDAO userDao = new UsersDAO();
//            User user = new User();
//            user.setId(id);
//            user.setFullname(fullname);
//            user.setUsername(userName);
//            user.setEmail(email);
//            user.setAddress(address);
//            user.setPhone(phone);
//           boolean sex ="Nam".equalsIgnoreCase(sexStr);
//           user.setSex(sex);
//            user.setYearOfBirth(yearOfBirth);
////            user.setRoleUser(Boolean.parseBoolean(roleUser));
//            boolean roleUser = "Admin".equalsIgnoreCase(roleUserStr);
//            user.setRoleUser(roleUser);
//            // Cập nhật thông tin người dùng trong cơ sở dữ liệu
//            userDao.updateUser(user);
//
//            Gson gson = new Gson();
//            String json = gson.toJson(user);
//            resp.setContentType("application/json");
//            resp.setCharacterEncoding("UTF-8");
//            resp.getWriter().write(json);
//        } else {
//            // Xử lý khi không có id trong request
//            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing user ID");
//        }
//    }
//}
package vn.hcmuaf.fit.drillsell.controller.userManager;

import com.google.gson.Gson;
import vn.hcmuaf.fit.drillsell.dao.IUserDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
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
            boolean sex = "Nam".equalsIgnoreCase(sexStr);
            user.setSex(sex);
            user.setYearOfBirth(yearOfBirth);
            boolean roleUser = "Admin".equalsIgnoreCase(roleUserStr);
            user.setRoleUser(roleUser);

            // Cập nhật thông tin người dùng trong cơ sở dữ liệu
            userDao.updateUser(user);

            // Return success message
            String successMessage = "Bạn đã cập nhật thành công";
            Gson gson = new Gson();
            String json = gson.toJson(successMessage);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(json);
        } else {
            // Xử lý khi không có id trong request
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing user ID");
        }
    }
}