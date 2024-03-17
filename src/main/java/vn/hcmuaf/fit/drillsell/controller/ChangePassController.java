package vn.hcmuaf.fit.drillsell.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.hcmuaf.fit.drillsell.service.UserService;


import java.io.IOException;

@WebServlet(name = "ChangePassController", value = "/change-pass")
public class ChangePassController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pass = request.getParameter("pass");
        String cfPass = request.getParameter("cf-pass");
        if (pass.equalsIgnoreCase(cfPass)) {
            HttpSession session = request.getSession();
            UserService.getInstance().changePassword((String) session.getAttribute("username-forgot-pass"), pass);
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}