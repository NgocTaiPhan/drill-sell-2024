package vn.hcmuaf.fit.drillsell.controller.orderManager;

import vn.hcmuaf.fit.drillsell.dao.LogDAO;
import vn.hcmuaf.fit.drillsell.dao.OrderDAO;
import vn.hcmuaf.fit.drillsell.model.Log;
import vn.hcmuaf.fit.drillsell.model.Order;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/updateStatus")
public class updateStatus extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing orderId parameter");
            return;
        }
        int orderId = Integer.parseInt(orderIdParam);
        Order order = OrderDAO.getStatuss(orderId);
        request.setAttribute("updateStatus", order);
        request.getRequestDispatcher("/admin/UpdateStatus.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String statuss = request.getParameter("status");
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        HttpSession session = request.getSession();
        User auth = (User) session.getAttribute("auth");
        Order order = new Order();
        // Get current status of the order
        Order getStatus = OrderDAO.getStatuss(orderId);
        String currentStatuss = OrderDAO.getCurrentStatus(orderId);
//         Check if status update is valid
        if (!OrderDAO.isValidStatuss(currentStatuss, statuss)) {
            PrintWriter out = response.getWriter();
            out.println("<script>alert('Cập nhật trạng thái đơn hàng không thành công'); window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderId + "';</script>");
            return;
        }


        order.setStauss(statuss);
        if (!OrderDAO.updateStatuss(orderId, statuss)) {
            PrintWriter out = response.getWriter();
            out.println("<script>alert('Cập nhật trạng thái đơn hàng không thành công'); window.location.href='" + request.getContextPath() + "/showUpdateOrder?orderId=" + orderId + "';</script>");
            return;
        }
        PrintWriter out = response.getWriter();
        out.println("<script>window.location.href='" + request.getContextPath() + "/admin/viewOrderMa"  + "';</script>");
        Log log = new Log();
        log.setUserId(auth.getId());
        String logDetails = "Order ID: " + orderId + ", Status: " + statuss ;
        log.setValuess(logDetails);
        String status = "Cập nhật trạng thái đơn hàng";
        String previousInfo = "Order ID: " + getStatus.getOrderId() + ", Status: " + getStatus.getStauss();
        log.setStatuss(status);
        LogDAO.insertUpdateOrderInLog(log, previousInfo); // Insert log with previous info
    }
}
