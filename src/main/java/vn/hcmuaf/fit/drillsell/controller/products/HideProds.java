package vn.hcmuaf.fit.drillsell.controller.products;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.dao.ProductDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "HideProds", value = "/hide-prod")
public class HideProds extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("productId"));
        ProductDAO.getInstance().changProductStatus(id, 2);
        Notify.getInstance().sendNotify(session, "hide-success");
        response.sendRedirect("admin/products-management.jsp");
//        request.getRequestDispatcher("products-management.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }
}