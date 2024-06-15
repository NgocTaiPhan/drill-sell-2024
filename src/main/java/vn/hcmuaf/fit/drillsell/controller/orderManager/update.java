package vn.hcmuaf.fit.drillsell.controller.orderManager;

import vn.hcmuaf.fit.drillsell.dao.CheckOutDAO;
import vn.hcmuaf.fit.drillsell.dao.OrderDAO;
import vn.hcmuaf.fit.drillsell.model.Order;
import vn.hcmuaf.fit.drillsell.model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;

@WebServlet("/showUpdateOrder")
public class update extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        List<Order> list = CheckOutDAO.showItemOrder(orderId);
        request.setAttribute("showUpdateOrder", list);
        request.getRequestDispatcher("/detailOrderManager.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Order order = new Order();

        // Retrieve form parameters
        String statuss = request.getParameter("statuss");
        String orderIdItemStr = request.getParameter("OrderIdItem");
        String quantityStr = request.getParameter("quantity");
        Date expectedDateStr = Date.valueOf(request.getParameter("expectedDate"));
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        // Get current status of the order
        String currentStatuss = OrderDAO.getCurrentStatus(orderId); // Assuming you have a method to get current status from order

        // Check if status update is valid
        if (!OrderDAO.isValidStatuss(currentStatuss, statuss)) {
            PrintWriter out = response.getWriter();
            out.println("<script>alert('Cập nhật trạng thái đơn hàng không thành công'); window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderId + "';</script>");
            return;
        }

        order.setStauss(statuss); // Assuming setStauss was a typo and it should be setStatus
        if (!OrderDAO.updateStatuss(orderId, statuss)) {
            PrintWriter out = response.getWriter();
            out.println("<script>alert('Cập nhật trạng thái đơn hàng không thành công'); window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderId + "';</script>");
            return;
        }

        // Perform updates based on different status conditions
        boolean update = false;
        if ("Đã xác nhận".equals(statuss) || "Đang xử lý".equals(statuss) || "Người bán đang chuẩn bị hàng".equals(statuss)) {
                order.setOrderId(orderId);
                order.setPhone(phone);
                order.setAddress(address);
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(Integer.parseInt(orderIdItemStr)); // Assuming this is the correct setter
                orderItem.setQuantity(Integer.parseInt(quantityStr));
                orderItem.setExpectedDate(expectedDateStr);
                order.setOrderItems(Arrays.asList(orderItem));
                update = OrderDAO.updates(order);
        }

        PrintWriter out = response.getWriter();
        if (update) {
            out.println("<script>window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderId + "';</script>");
        } else {

            out.println("<script>window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderId + "';</script>");
        }
    }

}


