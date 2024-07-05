package vn.hcmuaf.fit.drillsell.controller.account;

import com.google.gson.Gson;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/showUserInfor")
public class ShowUserInfor extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");

        if (user != null) {
            // Sử dụng Gson để chuyển đổi đối tượng người dùng thành JSON
            Gson gson = new Gson();
            String userJson = gson.toJson(user);

            // In ra log để kiểm tra
            System.out.println("User JSON: " + userJson);

            // Thiết lập kiểu phản hồi là JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(userJson);
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }
}
