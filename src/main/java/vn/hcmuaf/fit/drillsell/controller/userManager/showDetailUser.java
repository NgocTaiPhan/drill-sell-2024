package vn.hcmuaf.fit.drillsell.controller.userManager;

import com.google.gson.Gson;
import vn.hcmuaf.fit.drillsell.dao.IUserDAO;
import vn.hcmuaf.fit.drillsell.dao.LogDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.Log;
import vn.hcmuaf.fit.drillsell.model.Products;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
@WebServlet("/admin/showDetailUser")
public class showDetailUser extends HttpServlet {
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
        String sex = req.getParameter("sex");
        String yearOfBirth = req.getParameter("yearOfBirth");
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
            user.setSex(Boolean.parseBoolean(sex));
            user.setYearOfBirth(yearOfBirth);
            User getUserByID = userDao.getUserById(user);
            Gson gson = new Gson();
            String json = gson.toJson(user);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(json);
            Log log = new Log();
            log.setUserId(Integer.parseInt(idStr));
            String previousInfo = "user ID: " + idStr + ", fullname: " + fullname + ", address: " + address + ", phone: " + phone + ", email: " + email + ", username: " + userName + ", sex: " + sex + ", yearOfBirth: " + yearOfBirth;
            String values = null;
            log.setValuess(values);
            log.setStatuss("Xem chi tiết user: " + idStr);
            LogDAO.insertUpdateOrderInLog(log, previousInfo);
        }


    }}