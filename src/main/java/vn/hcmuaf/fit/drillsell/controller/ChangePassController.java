package vn.hcmuaf.fit.drillsell.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vn.hcmuaf.fit.drillsell.dao.UsersDAO;

import java.io.IOException;

@WebServlet(name = "ChangePassController", value = "/change-pass")
public class ChangePassController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pass = request.getParameter("pass");
        String cfPass = request.getParameter("cf-pass");
        if (pass.equals(cfPass)) {
            HttpSession session = request.getSession();
            UsersDAO.getInstance().changePassword((String) session.getAttribute("username-forgot-pass"), UsersDAO.getInstance().hashPassword(pass));
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}