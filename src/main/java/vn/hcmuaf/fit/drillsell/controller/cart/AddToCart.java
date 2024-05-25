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
import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.dao.CartDAO;
import vn.hcmuaf.fit.drillsell.model.User;


@WebServlet("/cart")
public class AddToCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdParam = request.getParameter("productId");
        // Kiểm tra xem người dùng đã đăng nhập hay chưa
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");
        if (user == null) {
            Notify.getInstance().sendNotify(session, request, response, "not-logged");
            response.sendRedirect("load-detail?productId=" + productIdParam);
            return;
        }

        String userIdParam = String.valueOf(user.getId()); // Lấy userId từ thông tin người dùng trong session

        // Xử lý thêm sản phẩm vào giỏ hàng
        int productId = Integer.parseInt(productIdParam);
        int userId = Integer.parseInt(userIdParam);

        boolean insertProduct = CartDAO.insertCartItem(userId, productId);

        if (insertProduct) {
            // Nếu sản phẩm được thêm thành công vào giỏ hàng, chuyển hướng người dùng đến trang detail.jsp
            request.getRequestDispatcher("/detail").forward(request, response);
        } else {
            // Nếu có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng, gửi thông báo lỗi cho người dùng
            response.getWriter().write("Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng!");
        }
    }


}









