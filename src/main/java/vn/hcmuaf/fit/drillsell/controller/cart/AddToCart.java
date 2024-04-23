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

@WebServlet("/cart")
public class AddToCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy id sản phẩm từ request parameter
        String productIdParam = request.getParameter("productId");
        String userIdParam = request.getParameter("userId");

//        // Kiểm tra xem userId có tồn tại hay không
//        if (userIdParam == null || userIdParam.isEmpty()) {
//            // Nếu userId không tồn tại hoặc rỗng, hiển thị thông báo yêu cầu đăng nhập
//            response.getWriter().write("Bạn phải đăng nhập để thực hiện thao tác này!");
//            return; // Kết thúc phương thức để ngăn không thực hiện các thao tác tiếp theo
//        }

//        // Chuyển đổi userId từ chuỗi sang số nguyên
//        int userId = Integer.parseInt(userIdParam);
        int productId = Integer.parseInt(productIdParam);
//
//        // Lấy danh sách giỏ hàng của userId
//        List<Cart> carts = CartDAO.getCartByUserId(userId);
        boolean insertProduct = CartDAO.insertCartItem(productId);

        // Kiểm tra kết quả sau khi thêm sản phẩm vào giỏ hàng
        if (insertProduct) {
            List<Cart> products = CartDAO.selectProduct();
            request.setAttribute("products", products);
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        } else {
            response.getWriter().write("Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng!");
        }




    }






}
