package vn.hcmuaf.fit.drillsell.controller.login;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.hcmuaf.fit.drillsell.bean.User;
import vn.hcmuaf.fit.drillsell.service.UserService;


import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = {"/login", "/logout"})
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
            login(request, response);
        } else if (servletPath.equals("/logout")) {
            logout(request, response);
        }


    }

    public void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Lấy username, pass nhập từ màn hình
        String username = request.getParameter("username-login");
        String password = request.getParameter("pass-login");

        if (validInput(username, password)) {

            UserService userService = UserService.getInstance();
            User auth = userService.getUser(username, UserService.getInstance().hashPassword(password));


            if (auth != null) {
                HttpSession session = request.getSession();
                String url = "login.jsp";
                if (auth.isRoleUser()) {

                    response.sendRedirect("login.jsp?notify=admin");

                } else {
                    response.sendRedirect("login.jsp?notify=user");

                }
                session.setAttribute("auth", auth);
//                session.setMaxInactiveInterval(30);
                boolean isAdmin = false;
                isAdmin = auth.isRoleUser();
                session.setAttribute("role-acc", auth.isRoleUser());

            } else {
                response.sendRedirect("login.jsp?notify=not-found-user-login");
            }
        } else {
            response.sendRedirect("login.jsp?notify=null-value-login");
        }
    }

    public void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("auth");
        response.sendRedirect("home.jsp");
    }

    public boolean validInput(String username, String password) {
        return username != null && password != null && !username.isEmpty() && !password.isEmpty();
    }

}
