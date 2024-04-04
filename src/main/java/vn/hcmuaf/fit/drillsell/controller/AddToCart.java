package vn.hcmuaf.fit.drillsell.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vn.hcmuaf.fit.drillsell.dao.CartDAO;

@WebServlet("/cart")
public class AddToCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy id sản phẩm từ request parameter
        int productId = Integer.parseInt(request.getParameter("productId"));

        // Lấy số lượng từ request parameter (thêm kiểm tra null để tránh lỗi)
        String quantityParam = request.getParameter("quantity");
        int quantity = (quantityParam != null) ? Integer.parseInt(quantityParam) : 1;

        // Lấy hoặc tạo giỏ hàng từ session
        HttpSession session = request.getSession();
        Map<Integer, vn.hcmuaf.fit.drillsell.model.Cart> cartMap = (Map<Integer, vn.hcmuaf.fit.drillsell.model.Cart>) session.getAttribute("cart");
        if (cartMap == null) {
            cartMap = new HashMap<>();
            session.setAttribute("cart", cartMap);
        }

        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
        vn.hcmuaf.fit.drillsell.model.Cart existingCartItem = cartMap.get(productId);
        if (existingCartItem != null) {
            // Nếu có, tăng số lượng
            existingCartItem.setQuantity(existingCartItem.getQuantity() + quantity);
            existingCartItem.setTotalPrice(existingCartItem.getUnitPrice() * existingCartItem.getQuantity());
        } else {
            // Nếu chưa có, thêm sản phẩm vào giỏ hàng
            List<vn.hcmuaf.fit.drillsell.model.Cart> cartItems = CartDAO.getProductById(productId);
            vn.hcmuaf.fit.drillsell.model.Cart cartItem = cartItems.get(0);
            cartMap.put(productId, cartItem);
        }

        // Chuyển hướng đến trang cart.jsp
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
}
