package vn.hcmuaf.fit.drillsell.controller.register;


import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.dao.EmailDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "RegisterController", value = "/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();


        // Lấy các thông tin từ form
        String fullName = request.getParameter("full-name-register");
        String birthDate = request.getParameter("birth-date-register");
        String address = request.getParameter("address-register");
        String phoneNumber = request.getParameter("phone-number-register");
        String email = request.getParameter("email-register");
        String username = request.getParameter("username-register");
        String password = request.getParameter("password-register");
        String confirmPassword = request.getParameter("confirm-password-register");
        String agreeToTerms = request.getParameter("agree-to-terms");
        String gender = request.getParameter("gender");

//Lưu user vào session để refill vào form khi nhập thông tin không hợp lệ
        User userRegister = new User(fullName, address, phoneNumber, email, username, password, gender, birthDate);
        session.setAttribute("user-register", userRegister);
        //Kiểm tra thông tin đăng kí có hợp lệ không

        ValidationForm.getInstance().validationRegister(session, request, response, fullName, birthDate, address, phoneNumber, email, username, password, confirmPassword, agreeToTerms, gender);
            //        Xóa user khỏi session sau khi check valid để tối ưu bộ nhớ
            session.removeAttribute("user-register");
//            registerSuccess(fullName, address, phoneNumber, email, username, password, gender, birthDate, UUID.randomUUID().toString().substring(0, 6));





    }


//        User user = new User(fullName, address, phoneNumber, email, username, password, gender, birthDate, confirmationCode);
//
//        UsersDAO.getInstance().addUser(user);




}

