package vn.hcmuaf.fit.drillsell.controller.category;

import org.w3c.dom.ls.LSOutput;
import vn.hcmuaf.fit.drillsell.bean.Products;
import vn.hcmuaf.fit.drillsell.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "LoadProdsByCategory", value = "/load-by-category")
public class LoadProdsByCategory extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String prName = request.getParameter("producer-name");
        String cateId = request.getParameter("category-id");

        if (cateId != null && !cateId.isEmpty()) {
            int categoryId = Integer.parseInt(cateId);
            ProductService productService = ProductService.getInstance();
            List<Products> prodsList = productService.getProductsByCategory(categoryId);
            String label = productService.getNameCategoryById(categoryId);
            request.setAttribute("product-list", prodsList);
            request.setAttribute("label", label);
        } else if (prName != null && !prName.isEmpty()) {
            ProductService productService = ProductService.getInstance();
            List<Products> prodsList = productService.getProductByProducer(prName);
            request.setAttribute("product-list", prodsList);
            request.setAttribute("label", prName);
        }

        request.getRequestDispatcher("product-filter.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}