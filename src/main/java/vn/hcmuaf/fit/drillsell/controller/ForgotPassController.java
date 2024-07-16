package vn.hcmuaf.fit.drillsell.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vn.hcmuaf.fit.drillsell.dao.EmailDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.User;

import java.io.IOException;


@WebServlet(name = "ForgotPassController", value = "/forgot-pass")
public class ForgotPassController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

  doGet(request,response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("input-username");
        String email = request.getParameter("input-email");
        HttpSession session = request.getSession();


        //Tạo user và set usename and email
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        System.out.println(user);
        session.setAttribute("user-forgot-pass", user);
        String verifyCode = UsersDAO.getInstance().getVerifyCode(username, email);
        session.setAttribute("vertificationCode", verifyCode);
        if (verifyCode != null) {
            // Gửi email chứa mã OTP (tạm thời comment lại vì đây là phần tạo my-modal.js)
            EmailDAO.getInstance().sendMailOTP(email, "Lấy lại mật khẩu", verifyCode);
            System.out.println(verifyCode);
            response.sendRedirect("input-code.jsp");

        } else {
            // Thông báo không thể gửi OTP và chuyển hướng người dùng về trang login
            response.sendRedirect("login.jsp");
        }

    }


}