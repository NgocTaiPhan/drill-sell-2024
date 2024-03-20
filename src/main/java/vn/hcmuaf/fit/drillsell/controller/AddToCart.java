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
import vn.hcmuaf.fit.drillsell.bean.CartItem;
import vn.hcmuaf.fit.drillsell.service.CartService;

@WebServlet("/cart")
public class AddToCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy id sản phẩm từ request parameter
        int productId = Integer.parseInt(request.getParameter("productId"));

        // Lấy số lượng từ request parameter (thêm kiểm tra null để tránh lỗi)
        String quantityParam = request.getParameter("quantity");
        int quantity = (quantityParam != null) ? Integer.parseInt(quantityParam) : 1 ;
        double amount;
        // Lấy hoặc tạo giỏ hàng từ session
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cartMap = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cartMap == null) {
            cartMap = new HashMap<>();
            session.setAttribute("cart", cartMap);
        }
        // Thay đổi cách cập nhật giỏ hàng trong phương thức doGet
        // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng chưa
        if (cartMap.containsKey(productId)) {
            // Nếu sản phẩm đã tồn tại trong giỏ hàng, tăng số lượng
            CartItem item = cartMap.get(productId);
            item.setQuantity(item.getQuantity() + 1);
            cartMap.put(productId, item); // Cập nhật lại thông tin sản phẩm trong giỏ hàng
        } else {
            // Nếu sản phẩm chưa tồn tại trong giỏ hàng, thêm mới
            List<CartItem> cartItems = CartService.getProductById(productId);
            if (!cartItems.isEmpty()) {
                CartItem cartItem = cartItems.get(0); // Lấy sản phẩm đầu tiên từ danh sách
                cartMap.put(productId, cartItem);
            }
        }

        // Chuyển hướng đến trang cart.jsp
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }



}
