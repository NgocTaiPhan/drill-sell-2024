package vn.hcmuaf.fit.drillsell.controller;

import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import vn.hcmuaf.fit.drillsell.bean.CartItem;

@WebServlet("/removeFromCart")
public class RemoveFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy id sản phẩm cần xóa từ request parameter
        int productId = Integer.parseInt(request.getParameter("productId"));

        // Lấy giỏ hàng từ session
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cartMap = (Map<Integer, CartItem>) session.getAttribute("cart");

        // Kiểm tra nếu giỏ hàng không rỗng và sản phẩm cần xóa có trong giỏ hàng thì xóa sản phẩm đó
        if (cartMap != null && cartMap.containsKey(productId)) {
            cartMap.remove(productId);
        }

        // Chuyển hướng lại trang cart.jsp sau khi xóa sản phẩm thành công
        response.sendRedirect("cart.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
