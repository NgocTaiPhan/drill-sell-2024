package vn.hcmuaf.fit.drillsell.controller.orderManager;

import vn.hcmuaf.fit.drillsell.dao.CheckOutDAO;
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
import java.sql.Date;
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
        int userId = Integer.parseInt(request.getParameter("userId"));

        // Get current status of the order
        String currentStatuss = OrderDAO.getCurrentStatus(orderId);

        // Check if status update is valid
        if (!OrderDAO.isValidStatuss(currentStatuss, statuss)) {
            PrintWriter out = response.getWriter();
            out.println("<script>alert('Cập nhật trạng thái đơn hàng không thành công'); window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderId + "';</script>");
            return;
        }

        // Get the previous order information
        Order previousOrder = OrderDAO.getOrderById(orderId);
        String previousInfo = "Order ID: " + previousOrder.getOrderId() + ", Status: " + previousOrder.getStauss() + ", Address: " + previousOrder.getAddress() + ", Phone: " + previousOrder.getPhone();

        // Append expected date to previousInfo
        previousInfo += ", Expected Date: " + previousOrder.getExpectedDate();

        order.setStauss(statuss);
        if (!OrderDAO.updateStatuss(orderId, statuss)) {
            PrintWriter out = response.getWriter();
            out.println("<script>alert('Cập nhật trạng thái đơn hàng không thành công'); window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderId + "';</script>");
            return;
        }

        // Perform updates based on different status conditions
        boolean update = false;
        order.setOrderId(orderId);
        order.setPhone(phone);
        order.setAddress(address);
        order.setExpectedDate(expectedDateStr);  // Set the expected date for the order
        OrderItem orderItem = new OrderItem();
        orderItem.setOrderId(Integer.parseInt(orderIdItemStr));
        orderItem.setQuantity(Integer.parseInt(quantityStr));
        orderItem.setExpectedDate(expectedDateStr);
        order.setOrderItems(Arrays.asList(orderItem));
        update = OrderDAO.updates(order);

        if (update) {
            PrintWriter out = response.getWriter();
            out.println("<script>window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderId + "';</script>");
            Log log = new Log();
            log.setUserId(userId);
            String logDetails = "Order ID: " + orderId + ", Status: " + statuss + ", Address: " + address + ", Phone: " + phone  + ", Expected Date: " + expectedDateStr;
            log.setValuess(logDetails);
            String status = "Update Order";
            log.setStatuss(status);
            LogDAO.insertUpdateOrderInLog(log, previousInfo); // Insert log with previous info
        } else {
            PrintWriter out = response.getWriter();
            out.println("<script>window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderId + "';</script>");
        }
    }
}
