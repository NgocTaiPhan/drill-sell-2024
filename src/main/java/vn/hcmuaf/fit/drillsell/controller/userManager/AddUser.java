package vn.hcmuaf.fit.drillsell.controller.userManager;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.controller.register.ValidationForm;
import vn.hcmuaf.fit.drillsell.dao.LogDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.Log;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
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

        ValidationForm validationForm = ValidationForm.getInstance();
        boolean isValid = validationForm.validateAddUser(resp, fullName, username, email, password, provinceId, districtId, wardId, phoneNumber, birthDate);

        // Lưu user vào session để refill vào form khi nhập thông tin không hợp lệ
        if (!isValid) {
            return; // Dừng xử lý nếu các thông tin không hợp lệ
        }
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
        boolean addUserResult = UsersDAO.getInstance().AdminaddUser(newUser, confirmationCode);
        if (addUserResult) {

            Notify.successNotify(resp, "Người dùng đã được thêm thành công!", Page.NULL_PAGE);

            // Ghi log thông tin sản phẩm vừa thêm
            Log log = new Log();
            log.setStatuss("Thêm người dùng");
            log.setUserId(userId); // Thiết lập userId cho log
            log.setValuess(" " + addUser);
            LogDAO.insertUpdateOrderInLog(log, null);
        } else {
            Notify.errorNotify(resp, "Thêm người dùng thất bại", Page.NULL_PAGE);
        }
        // Chuyển hướng người dùng đến trang thông báo kiểm tra email
//            req.getRequestDispatcher("check-email.jsp").forward(req, resp);

    }
}


