package vn.hcmuaf.fit.drillsell.controller.order;

import vn.hcmuaf.fit.drillsell.dao.CheckOutDAO;
import vn.hcmuaf.fit.drillsell.model.Order;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/viewOrderCustomer")
public class viewOrderCustomer extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");
        if (user != null) {
            int userId = user.getId();
            List<Order> list = CheckOutDAO.showOrder(userId);
            request.setAttribute("viewOrderCustomer", list);
            request.getRequestDispatcher("myOrder.jsp").forward(request, response); // Điều hướng đến trang JSP
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        boolean updateStatus = CheckOutDAO.update(orderId);
        if (updateStatus) {
            response.getWriter().println("<script>alert('Đã hủy đơn hàng thành công'); window.location.href='"
                    + request.getContextPath() + "/viewOrderCustomer';</script>");
        } else {
            response.getWriter().println("<script>alert('Hủy đơn hàng thất bại'); window.location.href='"
                    + request.getContextPath() + "/viewOrderCustomer';</script>");
        }
    }
}


