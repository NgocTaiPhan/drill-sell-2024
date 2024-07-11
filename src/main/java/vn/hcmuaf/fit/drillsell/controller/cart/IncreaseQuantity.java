package vn.hcmuaf.fit.drillsell.controller.cart;

import vn.hcmuaf.fit.drillsell.dao.CartDAO;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/UpdateQuantityHight")
public class IncreaseQuantity extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy productId từ request
        String productIdParam = request.getParameter("productId");
        int productId = Integer.parseInt(productIdParam);

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");
        int userId = user.getId();

        // Kiểm tra nếu số lượng trong giỏ hàng vượt quá giới hạn
        if (CartDAO.getQuantity(userId, productId) >= CartDAO.getQuantityRepo(productId)) {
            // Thiết lập thông báo lỗi
            request.setAttribute("errQuantity", "Số lượng đã đạt mức giới hạn.");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        // Gọi phương thức updateQuantityHight nếu số lượng trong giỏ hàng nhỏ hơn số lượng trong kho
        boolean success = CartDAO.updateQuantityHight(userId, productId);

        // Gửi phản hồi về trình duyệt
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(String.valueOf(success));
    }
}
