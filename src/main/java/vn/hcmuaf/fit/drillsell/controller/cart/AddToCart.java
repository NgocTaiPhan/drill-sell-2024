package vn.hcmuaf.fit.drillsell.controller.cart;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import vn.hcmuaf.fit.drillsell.dao.CartDAO;
import vn.hcmuaf.fit.drillsell.model.User;


@WebServlet("/cart")
public class AddToCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int productId = Integer.parseInt(request.getParameter("productId"));
        // Kiểm tra xem người dùng đã đăng nhập hay chưa
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");
        if (user != null && productId != 0) {
        boolean logCart = CartDAO.insertLogCart(userId, cartId);
        if (insertProduct) {
            // Nếu sản phẩm được thêm thành công vào giỏ hàng, chuyển hướng người dùng đến trang detail.jsp
            request.getRequestDispatcher("/detail").forward(request, response);
            CartDAO.insertCartItem(user.getId(), productId);//Trả về boolean
            response.sendRedirect("cart.jsp");
        } else {

        }


    }

}







