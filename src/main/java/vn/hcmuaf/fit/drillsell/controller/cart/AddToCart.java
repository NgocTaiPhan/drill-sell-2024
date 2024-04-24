package vn.hcmuaf.fit.drillsell.controller.cart;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vn.hcmuaf.fit.drillsell.dao.CartDAO;
import vn.hcmuaf.fit.drillsell.model.Cart;

import static java.lang.System.out;

@WebServlet("/cart")
public class AddToCart extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String jsonResponse;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdParam = request.getParameter("productId");
        String userIdParam = request.getParameter("userId");

        int productId = Integer.parseInt(productIdParam);

        boolean insertProduct = CartDAO.insertCartItem(productId);

        if (insertProduct) {
            // Nếu sản phẩm được thêm thành công vào giỏ hàng, chuyển hướng người dùng đến trang detail.jsp
            request.getRequestDispatcher("/detail").forward(request, response);

        } else {
            // Nếu có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng, có thể gửi thông báo lỗi cho người dùng hoặc xử lý theo cách khác tùy thuộc vào yêu cầu của bạn
            response.getWriter().write("Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng!");
        }
    }


}







