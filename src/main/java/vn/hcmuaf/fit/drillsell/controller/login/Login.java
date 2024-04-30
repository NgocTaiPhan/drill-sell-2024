package vn.hcmuaf.fit.drillsell.controller.login;

import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class Login {
    public static void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Lấy username, pass nhập từ màn hình
        String username = request.getParameter("username-login");
        String password = request.getParameter("pass-login");
        boolean logged = false;
        System.out.println(username + password);

        if (validInput(username, password)) {

            UsersDAO usersDAO = UsersDAO.getInstance();
            //Mã hóa mật khẩu người dùng nhập sau đó so sánh với mật khẩu đã mã hóa trong database
            User auth = usersDAO.getUser(username, UsersDAO.getInstance().hashPassword(password));

            logged = true;
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
                session.setAttribute("logged", logged);
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

    public static boolean validInput(String username, String password) {
        return username != null && password != null && !username.isEmpty() && !password.isEmpty();
    }
}
