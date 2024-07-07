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

        String statuss = request.getParameter("statuss");
        String orderIdItemStr = request.getParameter("OrderIdItem");
        String quantityStr = request.getParameter("quantity");
        String expectedDateStr = request.getParameter("expectedDate"); // Sử dụng chuỗi ngày tháng trực tiếp

        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        int userId = Integer.parseInt(request.getParameter("userId"));

        // Lấy ngày dự kiến hiện tại từ cơ sở dữ liệu
        Order previousOrder = OrderDAO.getOrderById(orderId);
        Date currentExpectedDate = (Date) previousOrder.getExpectedDate(); // Lấy ngày dự kiến hiện tại từ cơ sở dữ liệu

        // Kiểm tra ngày dự kiến mới phải lớn hơn ngày dự kiến hiện tại
        if (Date.valueOf(expectedDateStr).toLocalDate().isBefore(currentExpectedDate.toLocalDate()) || Date.valueOf(expectedDateStr).toLocalDate().isEqual(currentExpectedDate.toLocalDate())) {
            PrintWriter out = response.getWriter();
            out.println("<script>alert('Ngày dự kiến phải lớn hơn ngày hiện tại trong cơ sở dữ liệu');window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderId + "'</script>");
            return;
        }

        String previousInfo = "Order ID: " + previousOrder.getOrderId() + ", Status: " + previousOrder.getStauss() + ", Address: " + previousOrder.getAddress() + ", Phone: " + previousOrder.getPhone();
        previousInfo += ", Expected Date: " + previousOrder.getExpectedDate();
        boolean update = false;
        order.setOrderId(orderId);
        order.setPhone(phone);
        order.setAddress(address);
        order.setExpectedDate(Date.valueOf(expectedDateStr)); // Chuyển đổi chuỗi thành java.sql.Date
        OrderItem orderItem = new OrderItem();
        orderItem.setOrderId(Integer.parseInt(orderIdItemStr));
        orderItem.setQuantity(Integer.parseInt(quantityStr));
        orderItem.setExpectedDate(Date.valueOf(expectedDateStr)); // Chuyển đổi chuỗi thành java.sql.Date
        order.setOrderItems(Arrays.asList(orderItem));
        update = OrderDAO.updates(order);

        if (update) {
            PrintWriter out = response.getWriter();
            out.println("<script>alert('Cập nhật thông tin đơn hàng thành công');window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderId + "';</script>");
            Log log = new Log();
            log.setUserId(userId);
            String logDetails = "Order ID: " + orderId + ", Status: " + statuss + ", Address: " + address + ", Phone: " + phone  + ", Expected Date: " + expectedDateStr;
            log.setValuess(logDetails);
            String status = "Cập nhật thông tin đơn hàng";
            log.setStatuss(status);
            LogDAO.insertUpdateOrderInLog(log, previousInfo);
        } else {
            PrintWriter out = response.getWriter();
            out.println("<script>alert('Cập nhật thông tin đơn hàng không thành công');window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderId + "';</script>");
        }
    }
}
