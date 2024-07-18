package vn.hcmuaf.fit.drillsell.controller.order;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.CheckOutDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/Cancel")
public class Huy extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        boolean s = CheckOutDAO.update(orderId);
//        HttpSession session = request.getSession();
        if (s) {
            request.setAttribute("notificationMessage", "Hủy đơn hàng thành công.");
            request.getRequestDispatcher("/viewOrderCustomer").forward(request, response);
        }
        else {
            request.setAttribute("notificationMessage", "Hủy đơn hàng không thành công.");
            request.getRequestDispatcher("/viewOrderCustomer").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
