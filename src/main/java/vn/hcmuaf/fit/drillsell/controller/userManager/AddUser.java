
package vn.hcmuaf.fit.drillsell.controller.userManager;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.controller.register.ValidationForm;
import vn.hcmuaf.fit.drillsell.dao.EmailDAO;
import vn.hcmuaf.fit.drillsell.dao.LogDAO;
import vn.hcmuaf.fit.drillsell.dao.ProductDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.Log;
import vn.hcmuaf.fit.drillsell.model.Products;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

@WebServlet("/admin/addUser")
public class AddUser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User auth = (User) session.getAttribute("auth");

        int userId = auth.getId();
        // Lấy các thông tin từ form
        String fullName = req.getParameter("fullname");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("passwords");

        String provinceId = req.getParameter("tinh");
        String districtId = req.getParameter("quan");
        String wardId = req.getParameter("phuong");
        String address = provinceId + "," + districtId + ", " + wardId;
        String phoneNumber = req.getParameter("phone");
        String genderStr = req.getParameter("sex");
        String birthDate = req.getParameter("yearOfBirth");
        String roleUser = req.getParameter("roleUser");
        boolean gender = Boolean.parseBoolean(genderStr);
        System.out.println("Dữ liệu nhận được:");
        System.out.println("Fullname: " + fullName);
        System.out.println("Username: " + username);
        System.out.println("Email: " + email);
        System.out.println("Password: " + password);
        System.out.println("Address: " + address);
        System.out.println("Phone: " + phoneNumber);
        System.out.println("Sex: " + gender);
        System.out.println("Year of Birth: " + birthDate);
        System.out.println("Role User: " + roleUser);


        String birthDateString = birthDate;
        java.sql.Date sqlDate = null;
        if (birthDate != null && !birthDate.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date utilDate = sdf.parse(birthDate);
                sqlDate = new java.sql.Date(utilDate.getTime());
            } catch (Exception e) {
                // Handle parsing exception (e.g., log the error)
                System.err.println("Error parsing birthDate: " + e.getMessage());
            }
        }


        // Lưu user vào session để refill vào form khi nhập thông tin không hợp lệ
        User newUser = new User();
        newUser.setFullname(fullName);
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPasswords(password);
        newUser.setAddress(address);
        newUser.setPhone(phoneNumber);
        newUser.setSex("Nam".equals(gender));
        newUser.setYearOfBirth(birthDateString);
        newUser.setRoleUser("Admin".equals(roleUser));
        // Lấy sản phẩm vừa được thêm từ cơ sở dữ liệu
        User addUser = UsersDAO.getUsers(userId);
        String confirmationCode = UUID.randomUUID().toString().substring(0, 6);
        session.setAttribute("confirmationCode", confirmationCode);
        boolean addUserResult = UsersDAO.getInstance().AdminaddUser(newUser,confirmationCode);
        if (addUserResult) {
            resp.getWriter().write("Người dùng đã được thêm thành công!");
            // Ghi log thông tin sản phẩm vừa thêm
            Log log = new Log();
            log.setStatuss("Thêm người dùng");
            log.setUserId(userId); // Thiết lập userId cho log
            log.setValuess(" " + addUser);
            LogDAO.insertUpdateOrderInLog(log, null);
        } else {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Thêm người dùng không thành công!");
        }
        // Chuyển hướng người dùng đến trang thông báo kiểm tra email
//            req.getRequestDispatcher("check-email.jsp").forward(req, resp);

    }
}
//        req.setCharacterEncoding("UTF-8");
//        resp.setCharacterEncoding("UTF-8");
//
//        // Lấy dữ liệu từ request
//        String fullname = req.getParameter("fullname");
//        String username = req.getParameter("username");
//        String email = req.getParameter("email");
////        String password = req.getParameter("password");
//        String address = req.getParameter("address");
//        String phone = req.getParameter("phone");
//        String sex = req.getParameter("sex");
////        String yearOfBirth = req.getParameter("yearOfBirth");
//        String roleUser = req.getParameter("roleUser");
//
//        System.out.println("Dữ liệu nhận được:");
//        System.out.println("Fullname: " + fullname);
//        System.out.println("Username: " + username);
//        System.out.println("Email: " + email);
////        System.out.println("Password: " + password);
//        System.out.println("Address: " + address);
//        System.out.println("Phone: " + phone);
//        System.out.println("Sex: " + sex);
////        System.out.println("Year of Birth: " + yearOfBirth);
//        System.out.println("Role User: " + roleUser);
//
//        // Tạo đối tượng User từ dữ liệu nhận được từ request
//        User newUser = new User();
//        newUser.setFullname(fullname);
//        newUser.setUsername(username);
//        newUser.setEmail(email);
////        newUser.setPasswords(password); // Bạn có thể mã hóa mật khẩu tại đây nếu cần thiết
//        newUser.setAddress(address);
//        newUser.setPhone(phone);
//        newUser.setSex("Nam".equals(sex));
////        newUser.setYearOfBirth(yearOfBirth);
//        newUser.setRoleUser("Admin".equals(roleUser));
//
//        // Gọi phương thức addUser của UserDAO để thêm người dùng vào cơ sở dữ liệu
//        String confirmationCode = generateConfirmationCode();
//        UsersDAO userDao = new UsersDAO();
//        boolean addUserResult = userDao.addUser(newUser, confirmationCode);
//
//        // Xử lý kết quả và gửi phản hồi về cho client (trang web)
//        if (addUserResult) {
//            resp.getWriter().write("Người dùng đã được thêm thành công!");
//        } else {
//            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Thêm người dùng không thành công!");
//        }
//    }
//
//    private String generateConfirmationCode() {
//        return UUID.randomUUID().toString().substring(0, 6);
//    }