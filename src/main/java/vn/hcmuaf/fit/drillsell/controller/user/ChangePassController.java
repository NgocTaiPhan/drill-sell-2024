package vn.hcmuaf.fit.drillsell.controller.user;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.utils.FormUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "ChangePassController", value = "/change-pass")
public class ChangePassController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pass = request.getParameter("pass");
        String cfPass = request.getParameter("cf-pass");

        if (checkValid(pass, cfPass, response)) {
            HttpSession session = request.getSession();
            User u = (User) session.getAttribute("user-forgot-pass");
            UsersDAO.getInstance().changePassword(u.getUsername(), pass);
            Notify.successNotify(response, "Thay đổi mật khẩu thành công!", Page.LOGIN_PAGE);
        }
    }

    private boolean checkValid(String pass, String cfPass, HttpServletResponse response) throws IOException {
        if (FormUtils.isNullOrEmpty(pass)) {
            Notify.errorNotify(response, "Hãy nhập mật khẩu", Page.NULL_PAGE);
            return false;
        }
        if (FormUtils.isNullOrEmpty(cfPass)) {
            Notify.errorNotify(response, "Hãy nhập lại mật khẩu", Page.NULL_PAGE);
            return false;
        }
        if (!pass.equals(cfPass)) {
            Notify.errorNotify(response, "Email không hợp lệ", Page.NULL_PAGE);
            return false;
        }
        return true;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @WebServlet(name = "ChangeInforUserController", value = "/change-infor-user")
    public static class ChangeInforUserController extends HttpServlet {
        private static final long serialVersionUID = 1L;

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doPost(request, response);
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String fullName = request.getParameter("full-name-register");
            String birthDate = request.getParameter("birth-date-register");
            String address = request.getParameter("address-register");
            String phoneNumber = request.getParameter("phone-number-register");
            String email = request.getParameter("email-register");
            String username = request.getParameter("username-register");
            String password = request.getParameter("password-register");
            String confirmPassword = request.getParameter("confirm-password-register");
            String gender = request.getParameter("gender");


            //        validFullName(request.getParameter("full-name-register"));
            //        validBirthDate(request.getParameter("birth-date-register"));
            //        validPhoneNumber(request.getParameter("phone-number-register"));
            //        validEmail(request.getParameter("email-register"));
            //        validPassword(request.getParameter("password-register"),request.getParameter("confirm-password-register"));
            //        validẠgreeToTerms(request.getParameter("agree-to-terms"));


            //        Map<String, String> registerFormValue = new HashMap<>();

            //// Use map to set attributes
            //        registerFormValue.put("fullName", request.getParameter("full-name-register"));
            //        registerFormValue.put("birthDate", request.getParameter("birth-date-register"));
            //        registerFormValue.put("address", request.getParameter("address-register"));
            //        registerFormValue.put("phoneNumber", request.getParameter("phone-number-register"));
            //        registerFormValue.put("email", request.getParameter("email-register"));
            //        registerFormValue.put("username", request.getParameter("username-register"));
            //
            //        request.setAttribute("registerFormValue",registerFormValue);


            request.setAttribute("full-name", fullName);
            request.setAttribute("birth-date", birthDate);
            request.setAttribute("address", address);
            request.setAttribute("phone-number", phoneNumber);
            request.setAttribute("email", email);
            request.setAttribute("username", username);
            request.setAttribute("password", password);
            request.setAttribute("confirm-password", confirmPassword);
            // Kiểm tra các điều kiện lỗi
            // Nếu có lỗi, chuyển hướng với tham số error
            if (fullName == null || fullName.trim().isEmpty()) {
                response.sendRedirect("login.jsp?notify=null-fullname");
                return;
            }
            if (birthDate == null || birthDate.trim().isEmpty()) {
                response.sendRedirect("login.jsp?notify=null-birthday");
                return;
            } else {
                //            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDate inputDate = LocalDate.parse(birthDate);

                // LocalDate.now() trả về ngày hiện tại
                if (inputDate.isAfter(LocalDate.now())) {
                    response.sendRedirect("login.jsp?notify=future-birthday");
                    return;
                }

            }

            if (address == null || address.trim().isEmpty()) {
                response.sendRedirect("login.jsp?notify=null-address");
                return;
            }
            if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
                response.sendRedirect("login.jsp?notify=null-phone");
                return;
            } else {
                if (!phoneNumber.matches("^(\\+84|0)[0-9]{9}$")) {
                    response.sendRedirect("login.jsp?notify=invalid-phone");
                    return;

                }
            }
            if (email == null || email.trim().isEmpty()) {
                response.sendRedirect("login.jsp?notify=null-email");
                return;
            } else {
                if (!email.matches("^[a-zA-Z0-9_+&*-/=?\\^\\s{|}]+@[a-zA-Z0-9-]+\\.[a-zA-Z]+$")) {
                    response.sendRedirect("login.jsp?notify=invalid-email");
                    return;
                }
            }
            if (username == null || username.trim().isEmpty()) {
                response.sendRedirect("login.jsp?notify=null-username");
                return;
            } else {
                if (!UsersDAO.getInstance().isUsernameDuplicate(username)) {
                    response.sendRedirect("login.jsp?notify=duplicate-acc");

                }
            }
            if (password == null || password.trim().isEmpty()) {
                response.sendRedirect("login.jsp?notify=null-pass");
                return;
            }
            if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
                response.sendRedirect("login.jsp?notify=null-cfpass");
                return;
            } else {
                if (!password.equals(confirmPassword)) {
                    response.sendRedirect("login.jsp?notify=pass-not-match");
                    return;
                }
            }
            User user;
            //       user.setFullname();
            //       UserService.getInstance().changeInfoUser(user);


        }
    }
}