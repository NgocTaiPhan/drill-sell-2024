package vn.hcmuaf.fit.drillsell.controller.login;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
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
        // Lấy username, pass nhập từ màn hình
        String username = request.getParameter("username-login");
        String password = request.getParameter("pass-login");
        HttpSession session = request.getSession();
        Log log = new Log();

        // In thông tin người dùng nhập khi đăng nhập
        System.out.println(username + password);

        if (validInput(username, password)) {
            // Mã hóa mật khẩu người dùng nhập sau đó so sánh với mật khẩu đã mã hóa trong database
            User auth = UsersDAO.getInstance().getUser(username, UsersDAO.getInstance().hashPassword(password));
//            Tìm thấy thông tin người dùng
            if (auth != null) {//Nếu tìm thấy thông tin người dùng thì sẽ set userId trong log là id của người dùng

                log.setUserId(auth.getId());
                session.setAttribute("auth", auth); // Gửi thông tin tài khoản để frontend xử lý
                LogDAO.insertLoginTrue(log); // Ghi nhật ký đăng nhập thành công

                response.sendRedirect("home.jsp");
            } else {
                User user = UsersDAO.getInstance().getUserByUsername(username);
                // Ghi nhật ký đăng nhập thất bại trước khi chuyển hướng
                if (user != null) {
                    // Lấy userId của người dùng từ dữ liệu
                    log.setUserId(user.getId());
                } else {
                    // Nếu không tìm thấy người dùng, gán userId là 0
                    log.setUserId(0);
                }
                LogDAO.inserLoginFalse(log); // Ghi nhật ký đăng nhập thất bại
                LogDAO.checkLogin(log);

                // Báo lỗi khi không tìm thấy thông tin đăng nhập
                Notify.getInstance().sendNotify(request.getSession(), request, response, "not-found-user");
                return;
            }
        } else {
            // Báo lỗi khi người dùng chưa điền thông tin đăng nhập
            Notify.getInstance().sendNotify(session, request, response, "null-user-login");
            return;
        }
    }

    public static boolean validInput(String username, String password) {
        return username != null && password != null && !username.isEmpty() && !password.isEmpty();
    }
}
