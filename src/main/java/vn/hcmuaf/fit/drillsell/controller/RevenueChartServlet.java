package vn.hcmuaf.fit.drillsell.controller;

import vn.hcmuaf.fit.drillsell.dao.OrderDAO;
import vn.hcmuaf.fit.drillsell.model.MonthlyRevenue;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/revenueChart")
public class RevenueChartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<MonthlyRevenue> monthlyRevenues = OrderDAO.getMonthlyRevenue();
        request.setAttribute("monthlyRevenues", monthlyRevenues);
        String url = request.getContextPath() + "/revenueChart.jsp";
        request.getRequestDispatcher("/revenueChart.jsp").forward(request, response);
    }
}
