
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
import vn.hcmuaf.fit.drillsell.dao.LogDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.InetAddress;
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
        String roleUserStr = req.getParameter("roleUser");
        boolean gender = "Nam".equalsIgnoreCase(genderStr);
        boolean roleUser = "Admin".equalsIgnoreCase(roleUserStr);


        String birthDateString = birthDate;
        java.sql.Date sqlDate = null;
        if (birthDate != null && !birthDate.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date utilDate = sdf.parse(birthDate);
                sqlDate = new java.sql.Date(utilDate.getTime());
            } catch (Exception e) {
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
        newUser.setSex(gender);
        newUser.setYearOfBirth(birthDateString);
        newUser.setRoleUser("Admin".equals(roleUser));
        User addUser = UsersDAO.getUsers(userId);
            String confirmationCode = UUID.randomUUID().toString().substring(0, 6);
            session.setAttribute("confirmationCode", confirmationCode);
        boolean addUserResult = UsersDAO.getInstance().AdminaddUser(newUser,confirmationCode);
        newUser.setRoleUser(roleUser);
       
      String confirmationCode = UUID.randomUUID().toString().substring(0, 6);
        session.setAttribute("confirmationCode", confirmationCode);
        boolean addUserResult = UsersDAO.getInstance().AdminaddUser(newUser, confirmationCode);
        if (addUserResult) {
            // Lấy ID của người dùng mới thêm sau khi thêm thành công
            int newUserId = UsersDAO.getInstance().getUserByUsername(username).getId();
            newUser.setId(newUserId);

            // Ghi log khi thêm người dùng thành công
            Log log = new Log();
            log.setUserId(newUserId); // Sử dụng ID người dùng mới thêm
            log.setStatuss("Thêm thành công user có ID: " + newUserId );
            log.setLevels("INFO");
            log.setIp(InetAddress.getLocalHost().getHostAddress());

            String previousInfo = null;
            String values = "user ID: " + newUserId + ", fullname: " + fullName + ", address: " + address + ", phone: " + phoneNumber + ", email: " + email + ", username: " + username + ", sex: " + setGender(gender) + ", yearOfBirth: " + birthDate + ", role: " + setRole(roleUser);
            log.setValuess(values);
            LogDAO.insertUpdateOrderInLog(log, previousInfo);
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
    }
    private String setGender(boolean gender) {
        if (gender)return "Nam";
        return "Nữ";
    }
    private String setRole(boolean roleUser) {
        if (roleUser)return "Admin";
        return "User";
    }
}
