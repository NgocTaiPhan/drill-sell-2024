package vn.hcmuaf.fit.drillsell.controller.revenue;

import vn.hcmuaf.fit.drillsell.dao.OrderDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet("/show-revenue")
public class Revenue extends HttpServlet {




    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    doPost(req,resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
       Map<String,Object> revenue = OrderDAO.getDailyOrderStats();
       session.setAttribute("revenue",revenue);
        System.out.println(revenue+"test");
       req.getRequestDispatcher("/admin/dashboard.jsp").forward(req,resp);


    }
}
