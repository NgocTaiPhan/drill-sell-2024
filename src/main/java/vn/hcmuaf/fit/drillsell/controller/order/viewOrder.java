package vn.hcmuaf.fit.drillsell.controller.order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import vn.hcmuaf.fit.drillsell.dao.CheckOutDAO;
import vn.hcmuaf.fit.drillsell.model.OrderItem;
import vn.hcmuaf.fit.drillsell.model.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkOut")
public class viewOrder extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] selectedProducts = request.getParameterValues("selectedProducts");

        // Kiểm tra xem người dùng đã đăng nhập hay chưa
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");

        // Kiểm tra xem user có null hay không
        if (user == null) {
            request.setAttribute("err", "Vui lòng đăng nhập để tiếp tục.");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        // Nếu user không null, tiếp tục xử lý
        int userId = user.getId();
        List<OrderItem> checkOuts = new ArrayList<>();

        // Kiểm tra nếu selectedProducts là null hoặc rỗng
        if (selectedProducts == null || selectedProducts.length == 0) {
            // Hiển thị thông báo lỗi hoặc giữ lại trang hiện tại
            request.setAttribute("err", "Vui lòng chọn ít nhất một sản phẩm để tiếp tục!");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        // Xử lý các sản phẩm đã chọn
        for (String productId : selectedProducts) {
            checkOuts.addAll(CheckOutDAO.showProducts(userId, Integer.parseInt(productId)));
        }

        session.setAttribute("checkOuts", checkOuts);
        request.getRequestDispatcher("order.jsp").forward(request, response);
    }
}
