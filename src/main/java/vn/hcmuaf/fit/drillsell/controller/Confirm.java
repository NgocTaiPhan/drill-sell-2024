package vn.hcmuaf.fit.drillsell.controller;

import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ConfirmRegistrationServlet", value = "/confirm-registration")
public class Confirm extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String confirmationCode = request.getParameter("code");
        String username = request.getParameter("username");

        // Lấy user từ session
        HttpSession session = request.getSession();
        User userRegister = (User) session.getAttribute("user-register");

        if (userRegister != null) {
            // Thêm user vào cơ sở dữ liệu
            UsersDAO.getInstance().addUser(userRegister);
            // Xóa user khỏi session sau khi thêm vào cơ sở dữ liệu
            session.removeAttribute("user-register");
            response.sendRedirect("http://localhost:8080/drillsell_war/login.jsp");

        } else {
            response.getWriter().write("Thông tin không hợp lệ hoặc đã hết hạn.");
        }
    }
}
