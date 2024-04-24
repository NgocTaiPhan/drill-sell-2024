package vn.hcmuaf.fit.drillsell.controller.login;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;


import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = {"/login", "/logout","/login-google"})
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("UTF-8");
        String servletPath = request.getServletPath();
        if (servletPath.equals("/login")) {
            Login.login(request,response);
        } else if (servletPath.equals("/logout")) {
            Logout.logout(request,response);
        } else if (servletPath.equals("/login-google")) {
            LoginGoogle.loginGoogle(request,response);
        }


    }









}
