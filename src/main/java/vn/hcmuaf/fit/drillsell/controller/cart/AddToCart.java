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

import static vn.hcmuaf.fit.drillsell.controller.notify.Notify.sendResponseText;

@WebServlet("/cart")
public class AddToCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdParam = request.getParameter("productId");
        HttpSession session = request.getSession(false);

        User user = (User) session.getAttribute("auth");
        String userIdParam = String.valueOf(user.getId()); // Lấy userId từ thông tin người dùng trong session

        // Xử lý thêm sản phẩm vào giỏ hàng
        int productId = Integer.parseInt(productIdParam);
        int userId = Integer.parseInt(userIdParam);

        boolean insertProduct = CartDAO.insertCartItem(userId, productId);


        if (insertProduct) {
            // Nếu sản phẩm được thêm thành công vào giỏ hàng
            sendResponseText(response, "Thêm sản phẩm vào giỏ hàng thành công", HttpServletResponse.SC_OK);
        } else {
            // Nếu có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng
            sendResponseText(response, "Lỗi khi thêm sản phẩm vào giỏ hàng", HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
