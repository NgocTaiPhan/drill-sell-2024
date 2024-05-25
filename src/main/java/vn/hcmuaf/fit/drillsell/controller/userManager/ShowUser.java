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
import java.util.List;
@WebServlet("/admin/ShowUser")
public class ShowUser extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        IUserDAO userDao = new UsersDAO();
        List<User> userList = userDao.showUser();
        Gson gson = new Gson();
//        hiển thị danh sách người dùng
        String json = gson.toJson(userList);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(json);
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);

    }
}
