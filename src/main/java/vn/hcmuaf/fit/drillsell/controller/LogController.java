package vn.hcmuaf.fit.drillsell.controller;

import vn.hcmuaf.fit.drillsell.dao.LogDAO;
import vn.hcmuaf.fit.drillsell.model.Log;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/log")
public class LogController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra xem người dùng đã đăng nhập hay chưa
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");

        // Ghi nhật ký thử đăng nhập
        Log log = new Log();
        log.setUserId(user != null ? user.getId() : 0);
        boolean loginSuccess = user != null;

        if (loginSuccess) {
            log.setLevels(Log.INFO);
        } else {
            log.setLevels(Log.ERROR);
        }

        // Chèn nhật ký đăng nhập
        boolean logInserted = false;

        if (loginSuccess) {
            logInserted = LogDAO.insertLoginTrue(log);
        } else {
            logInserted = LogDAO.inserLoginFalse(log);
        }

        if (!loginSuccess || !logInserted) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
    }
}
