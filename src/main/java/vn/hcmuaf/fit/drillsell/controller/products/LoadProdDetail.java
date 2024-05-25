package vn.hcmuaf.fit.drillsell.controller.products;

import vn.hcmuaf.fit.drillsell.dao.ProductDAO;
import vn.hcmuaf.fit.drillsell.model.Products;
import vn.hcmuaf.fit.drillsell.model.Review;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "LoadProdDetail", value = "/load-detail")
public class LoadProdDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int pId = Integer.parseInt(request.getParameter("productId"));

        Products prod = ProductDAO.getInstance().getProdById(pId);
        List<Review> reviews = ProductDAO.getInstance().getAllReviewByPID(pId);
        request.setAttribute("prods", prod);
        request.setAttribute("reviews", reviews);
        System.out.println(reviews);
        request.getRequestDispatcher("detail.jsp").forward(request, response);
    }
}