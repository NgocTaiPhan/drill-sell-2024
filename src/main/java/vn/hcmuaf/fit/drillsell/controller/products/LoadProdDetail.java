package vn.hcmuaf.fit.drillsell.controller.products;

import vn.hcmuaf.fit.drillsell.model.Products;
import vn.hcmuaf.fit.drillsell.model.Review;
import vn.hcmuaf.fit.drillsell.utils.ProductUtils;
import vn.hcmuaf.fit.drillsell.utils.ReviewUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

        Products prod = ProductUtils.getProductById(pId);
        List<Review> reviews = ReviewUtils.getAllReviewByPID(pId);
        request.setAttribute("prods", prod);
        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("detail.jsp").forward(request, response);
    }
}