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
        System.out.println(username + password);

        if (validInput(username, password)) {

            UsersDAO usersDAO = UsersDAO.getInstance();
            //Mã hóa mật khẩu người dùng nhập sau đó so sánh với mật khẩu đã mã hóa trong database
            User auth = usersDAO.getUser(username, UsersDAO.getInstance().hashPassword(password));


            if (auth != null) {
                HttpSession session = request.getSession();
                String url = "login.jsp";
                //Kiểm tra quyền của tài khoản
                if (auth.isRoleUser()) {
//admin
                    response.sendRedirect("login.jsp?notify=admin");

                } else {
                    //user
                    response.sendRedirect("login.jsp?notify=user");

                }
                //Lưu thông tin tài khoản và trạng thái "đã đăng nhập" vào session
                session.setAttribute("auth", auth);
                session.setAttribute("logged", true);
                boolean isAdmin = false;
                isAdmin = auth.isRoleUser();
                session.setAttribute("role-acc", auth.isRoleUser());

            } else {
                //Báo lỗi khi không tìm thấy thông tin đăng nhập
                response.sendRedirect("login.jsp?notify=not-found-user-login");
            }
        } else {
            //Báo lỗi khi người dùng chưa điền thông tin đăng nhập
            response.sendRedirect("login.jsp?notify=null-value-login");
        }
    }

    //Thực hiện đăng xuất bằng remove các attribute
    public void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("auth");
        session.removeAttribute("auth-google");
        response.sendRedirect("home.jsp");
    }

    public boolean validInput(String username, String password) {
        return username != null && password != null && !username.isEmpty() && !password.isEmpty();
    }

}
