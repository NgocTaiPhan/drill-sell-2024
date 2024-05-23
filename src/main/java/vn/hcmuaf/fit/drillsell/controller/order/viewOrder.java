package vn.hcmuaf.fit.drillsell.controller.order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vn.hcmuaf.fit.drillsell.dao.CheckOutDAO;
import vn.hcmuaf.fit.drillsell.model.Order;
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
            // Nếu user là null, chuyển hướng đến trang đăng nhập hoặc hiển thị thông báo lỗi
            // Ví dụ: response.sendRedirect("login.jsp");
            response.getWriter().write("Vui lòng đăng nhập để thực hiện thanh toán!");
            return;
        }

        // Nếu user không null, tiếp tục xử lý
        int userId = user.getId();
        List<OrderItem> checkOuts = new ArrayList<>();
        if (selectedProducts != null) {
            for (String productId : selectedProducts) {
                checkOuts.addAll(CheckOutDAO.showProducts(userId, Integer.parseInt(productId)));
            }
        }
        request.setAttribute("checkOuts", checkOuts);
        request.getRequestDispatcher("order.jsp").forward(request, response);
    }

}
