package vn.hcmuaf.fit.drillsell.controller.orderManager;

import vn.hcmuaf.fit.drillsell.dao.CartDAO;
import vn.hcmuaf.fit.drillsell.dao.LogDAO;
import vn.hcmuaf.fit.drillsell.dao.OrderDAO;
import vn.hcmuaf.fit.drillsell.model.Log;
import vn.hcmuaf.fit.drillsell.model.Order;
import vn.hcmuaf.fit.drillsell.model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/updateOrderQuantity")
public class updateQuantity extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing orderId parameter");
            return;
        }
        int orderId = Integer.parseInt(orderIdParam);
        List<Order> order = OrderDAO.showItemOrder(orderId);
        System.out.println(order);
        request.setAttribute("order", order);
        request.getRequestDispatcher("/admin/UpdateQuantity.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String productIdParam = request.getParameter("productId");
        String orderIdParam = request.getParameter("orderId");
        String quantityParam = request.getParameter("quantity");
        int userId = Integer.parseInt(request.getParameter("userId"));

        if (productIdParam == null || productIdParam.isEmpty() ||
                orderIdParam == null || orderIdParam.isEmpty() ||
                quantityParam == null || quantityParam.isEmpty()) {
            PrintWriter out = response.getWriter();
            out.println("<script>alert('All fields are required.'); window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderIdParam + "';</script>");
            return;
        }

        int productId = Integer.parseInt(productIdParam);
        int orderId = Integer.parseInt(orderIdParam);
        int quantity = Integer.parseInt(quantityParam);

        // Lấy thông tin đơn hàng và sản phẩm trước khi cập nhật
        Order previousOrder = OrderDAO.getOrderById(orderId);
        OrderItem previousOrderItem = previousOrder.getOrderItems().stream()
                .filter(oi -> oi.getProductId() == productId)
                .findFirst()
                .orElse(null);

        String previousInfo = "";
        if (previousOrderItem != null) {
            previousInfo = "Order ID: " + orderId + ", Product ID: " + productId + ", Previous Quantity: " + previousOrderItem.getQuantity();
        }

        // Lấy số lượng tồn kho hiện tại
        int stockQuantity = CartDAO.getQuantityRepo(productId);

        // Kiểm tra xem số lượng cập nhật có lớn hơn số lượng tồn kho không
        if (quantity > stockQuantity) {
            PrintWriter out = response.getWriter();
            out.println("<script>alert('Số lượng hiện tại lớn hơn số lượng trong kho'); window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderId + "';</script>");
            return;
        }

        OrderItem item = new OrderItem();
        item.setProductId(productId);
        item.setOrderId(orderId);
        item.setQuantity(quantity);

        boolean updateSuccess = OrderDAO.updateQuantity(item);
        if (!updateSuccess) {
            PrintWriter out = response.getWriter();
            out.println("<script>alert('Cập nhật số lượng không thành công'); window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderId + "';</script>");
            return;
        }

        // Lấy thông tin đơn hàng và sản phẩm sau khi cập nhật
        Order updatedOrder = OrderDAO.getOrderById(orderId);
        OrderItem updatedOrderItem = updatedOrder.getOrderItems().stream()
                .filter(oi -> oi.getProductId() == productId)
                .findFirst()
                .orElse(null);

        String updatedInfo = "";
        if (updatedOrderItem != null) {
            updatedInfo = "Order ID: " + orderId + ", Product ID: " + productId + ", Updated Quantity: " + updatedOrderItem.getQuantity();
        }

        Log log = new Log();
        String logDetails = updatedInfo;
        log.setValuess(logDetails);
        log.setUserId(userId);
        String status = "Cập nhật số lượng sản phẩm trong đơn hàng";
        log.setStatuss(status);
        LogDAO.insertUpdateOrderInLog(log, previousInfo); // Insert log with previous info

        response.sendRedirect(request.getContextPath() + "/showUpdateOrder?orderId=" + orderId);
    }
}
