package vn.hcmuaf.fit.drillsell.controller.userManager;

import vn.hcmuaf.fit.drillsell.dao.IUserDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet("/admin/deleteUser")
public class DeleteUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null ) {
            // Chuyển đổi chuỗi thành số nguyên
            int id = Integer.parseInt(idStr);

            IUserDAO userDao = new UsersDAO();
//            xóa người dùng trong quản lý người dùng
            boolean deleted = userDao.deleteUser(id,1);
            if (deleted) {
                resp.setContentType("text/plain");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("Xóa người dùng thành công");




            } else {

            }
        } else {

        }


    }
}



