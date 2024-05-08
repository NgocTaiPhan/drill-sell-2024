package vn.hcmuaf.fit.drillsell.controller.login;

import vn.hcmuaf.fit.drillsell.dao.LogDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.Log;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class Login {
    public static void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy username và password nhập từ màn hình
        String username = request.getParameter("username-login");
        String password = request.getParameter("pass-login");

        // Kiểm tra tính hợp lệ của dữ liệu đầu vào
        if (validInput(username, password)) {
            UsersDAO usersDAO = UsersDAO.getInstance();
            // Xác thực người dùng
            User auth = usersDAO.getUser(username, UsersDAO.getInstance().hashPassword(password));

            if (auth != null) {
                // Tạo phiên làm việc
                HttpSession session = request.getSession();
                String url = "login.jsp";

                // Ghi nhật ký đăng nhập thành công
                Log log = new Log();
                log.setUserId(auth.getId());
                LogDAO.insertLoginTrue(log);

                // Kiểm tra quyền của tài khoản và chuyển hướng
                if (auth.isRoleUser()) {
                    // Admin
                    response.sendRedirect("login.jsp?notify=admin");
                } else {
                    // User
                    response.sendRedirect("login.jsp?notify=user");
                }

                // Lưu thông tin tài khoản và trạng thái "đã đăng nhập" vào session
                session.setAttribute("auth", auth);
                session.setAttribute("logged", true);
                session.setAttribute("role-acc", auth.isRoleUser());
            } else {
                User user = UsersDAO.getInstance().getUserByUsername(username);
                // Ghi nhật ký đăng nhập thất bại trước khi chuyển hướng
                Log log = new Log();
                if (user != null) {
                    // Lấy userId của người dùng từ dữ liệu
                    log.setUserId(user.getId());



                } else {
                    // Nếu không tìm thấy người dùng, gán userId là 0
                    log.setUserId(0);

                }
                LogDAO.inserLoginFalse(log);
                LogDAO.checkLogin(log);

                // Chuyển hướng khi không tìm thấy thông tin người dùng
                response.sendRedirect("login.jsp?notify=not-found-user-login");
            }
        } else {
            // Báo lỗi khi người dùng chưa điền thông tin đăng nhập
            response.sendRedirect("login.jsp?notify=null-value-login");
        }
    }

    // Phương thức kiểm tra tính hợp lệ của dữ liệu đầu vào
    public static boolean validInput(String username, String password) {
        return username != null && password != null && !username.isEmpty() && !password.isEmpty();
    }
}
