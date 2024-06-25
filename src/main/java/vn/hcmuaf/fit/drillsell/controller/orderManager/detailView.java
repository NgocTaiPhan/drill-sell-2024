package vn.hcmuaf.fit.drillsell.controller.orderManager;

import vn.hcmuaf.fit.drillsell.dao.OrderDAO;
import vn.hcmuaf.fit.drillsell.model.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/viewOrderManager")
public class detailView extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        List<Order> list = OrderDAO.show(orderId);
        request.setAttribute("showOrderManager", list);
        request.getRequestDispatcher("/detailOrderManager.jsp").forward(request, response);
    }
}
