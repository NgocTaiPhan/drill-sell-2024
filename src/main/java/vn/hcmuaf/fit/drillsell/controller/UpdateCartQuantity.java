package vn.hcmuaf.fit.drillsell.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.hcmuaf.fit.drillsell.bean.Cart;
import vn.hcmuaf.fit.drillsell.service.UserService;

import java.util.Map;

@WebServlet("/UpdateCartQuantity")
public class UpdateCartQuantity extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Retrieve the cart from the session and update the quantity
        HttpSession session = request.getSession();
        Map<Integer, Cart> cartMap = (Map<Integer, Cart>) session.getAttribute("cart");

        if (cartMap != null && cartMap.containsKey(productId)) {
            Cart cartItem = cartMap.get(productId);
            cartItem.setQuantity(quantity);
            // Update other properties if needed
        }

        // Update the session
        session.setAttribute("cart", cartMap);
    }
}
