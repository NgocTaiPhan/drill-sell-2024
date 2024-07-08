package vn.hcmuaf.fit.drillsell.controller.login;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.LogDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.Log;
import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.utils.UserUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.Instant;
import java.util.Optional;

public class Login {
    static UserUtils userUtils;
    public static void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username-login");
        String password = request.getParameter("pass-login");
        HttpSession session = request.getSession();
        Log log = new Log();

        if (!validInput(username, password)) {
            Notify.errorNotify(response, "Hãy điền đầy đủ thông tin đăng nhập", Page.NULL_PAGE);
            return;
        }

        User user = UsersDAO.getInstance().getUserByUsername(username);
        if (user != null) {
            Optional<Instant> lockedUntil = UsersDAO.getInstance().getLockedUntil(user.getId());
            if (lockedUntil.isPresent() && lockedUntil.get().isAfter(Instant.now())) {
                Notify.errorNotify(response, "Tài khoản của bạn đã bị khóa. Hãy đăng nhập lại sau 10 phút.", Page.NULL_PAGE);
                return;
            }
        }

        User auth = UsersDAO.getInstance().getUser(username, userUtils.hashPassword(password));
        if (auth != null) {
            System.out.println(auth);
            log.setUserId(auth.getId());
            session.setAttribute("auth", auth);
            LogDAO.insertLoginTrue(log);


                // Nếu không có redirectURL, mặc định chuyển hướng đến trang chủ hoặc trang mặc định
                Notify.successNotify(response, "Đăng nhập thành công", Page.HOME_PAGE);

        } else {
            log.setUserId(user != null ? user.getId() : 0);
            LogDAO.inserLoginFalse(log);
            LogDAO.checkLogin(log);
            Notify.errorNotify(response, "Không tìm thấy tài khoản", Page.NULL_PAGE);
        }
    }

    public static void loginAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        // Lấy username, pass nhập từ màn hình
        String username = request.getParameter("username-login");
        String password = request.getParameter("pass-login");
        HttpSession session = request.getSession();
        Log log = new Log();

        // In thông tin người dùng nhập khi đăng nhập
//        System.out.println(username + password);

        if (validInput(username, password)) {
            User user = UsersDAO.getInstance().getUserByUsername(username);

            if (user != null) {
                Optional<Instant> lockedUntil = UsersDAO.getInstance().getLockedUntil(user.getId());
                if (lockedUntil.isPresent() && lockedUntil.get().isAfter(Instant.now())) {
//                    PrintWriter out = response.getWriter();
//                    out.println("<script>alert('Tài khoản của bạn đã bị khóa. Vui lòng đăng nhập lại sau 10 phút.'); window.location.href='" + request.getContextPath() + "/login.jsp ';</script>");
//                    return;
                    Notify.errorNotify(response, "Tài khoản của bạn đã bị khóa. Hãy đăng nhập lại sau 10 phút.", Page.NULL_PAGE);
                }
            }

            // Mã hóa mật khẩu người dùng nhập sau đó so sánh với mật khẩu đã mã hóa trong database
            User auth = UsersDAO.getInstance().getUser(username, userUtils.hashPassword(password));

            // Tìm thấy thông tin người dùng
            if (auth != null) {
                // Nếu tìm thấy thông tin người dùng thì sẽ set userId trong log là id của người dùng
                log.setUserId(auth.getId());
                session.setAttribute("auth", auth); // Gửi thông tin tài khoản để frontend xử lý
                LogDAO.insertLoginTrue(log); // Ghi nhật ký đăng nhập thành công

                // Kiểm tra vai trò người dùng
                if (auth.isRoleUser()) {
                    // Lấy URL ban đầu từ session
                    String redirectURL = (String) session.getAttribute("redirectAfterLogin");
                    if (redirectURL != null) {
                        session.removeAttribute("redirectAfterLogin"); // Xóa URL sau khi sử dụng
                        response.sendRedirect(redirectURL); // Điều hướng tới URL ban đầu
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/user-manager.jsp"); // Điều hướng mặc định
                    }
                } else {
                    // Nếu không phải admin, xóa thông tin đăng nhập và thông báo lỗi
                    session.removeAttribute("auth");
                    Notify.errorNotify(response, "Tài khoản của bạn không có quyền truy cập!", Page.NULL_PAGE);
                }
            } else {
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
                Notify.errorNotify(response, "Không tìm thấy tài khoản!", Page.NULL_PAGE);
            }
        } else {
            // Báo lỗi khi người dùng chưa điền thông tin đăng nhập
            Notify.errorNotify(response, "Hãy điền đầy đủ thông tin đăng nhập!", Page.NULL_PAGE);
        }
    }

    public static void checkLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        if (request.getSession().getAttribute("auth") != null) {
            Notify.successNotify(response, "Đăng nhập thành công", Page.HOME_PAGE);
        } else {
            Notify.warningNotify(response, "Bạn chưa đăng nhập", Page.LOGIN_PAGE);
        }
    }
    public static boolean validInput(String username, String password) {
        return username != null && password != null && !username.isEmpty() && !password.isEmpty();
    }
}
