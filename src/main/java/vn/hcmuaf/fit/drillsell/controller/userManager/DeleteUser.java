package vn.hcmuaf.fit.drillsell.controller.userManager;

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

@WebServlet("/admin/deleteUser")
public class DeleteUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            IUserDAO userDao = new UsersDAO();
            boolean deleted = userDao.deleteUser(id, 1);
            String message;
            if (deleted) {
                message = "Xóa người dùng thành công";
                resp.setStatus(HttpServletResponse.SC_OK); // 200
                Log log = new Log();
                log.setUserId(Integer.parseInt(idStr));
                String values = null;
                String previousInfo = null;
                log.setValuess(values);
                log.setStatuss("Xóa user: " + idStr);
                LogDAO.insertUpdateOrderInLog(log, previousInfo);
            } else {
                message = "Không thể xóa tài khoản Admin";
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
            }
            resp.setContentType("text/plain");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(message);
        } else {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
            resp.setContentType("text/plain");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("ID người dùng không hợp lệ");
        }
    }
}



