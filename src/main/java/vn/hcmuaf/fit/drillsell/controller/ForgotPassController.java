package vn.hcmuaf.fit.drillsell.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vn.hcmuaf.fit.drillsell.dao.EmailDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ForgotPassController", value = "/forgot-pas")
public class ForgotPassController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("input-username");
        String email = request.getParameter("input-email");
        HttpSession session = request.getSession();
        checkUserName(username, response);
        session.setAttribute("username-forgot-pass", username);
        String verifyCode = UsersDAO.getInstance().getVerifyCode(username, email);
        session.setAttribute("vertificationCode", verifyCode);
        if (verifyCode != null) {
            // Gửi email chứa mã OTP (tạm thời comment lại vì đây là phần tạo modal)
            // EmailDAO.getInstance().sendMailOTP(email, "Lấy lại mật khẩu", verifyCode);

            response.sendRedirect("input-code.jsp");

        } else {
            // Thông báo không thể gửi OTP và chuyển hướng người dùng về trang login
            response.sendRedirect("login.jsp");
        }
    }

    private void checkUserName(String username, HttpServletResponse resp) throws IOException {
        if (UsersDAO.getInstance().getUserByUsername(username) == null) {
            resp.sendRedirect("login.jsp?#");
        }
    }


}