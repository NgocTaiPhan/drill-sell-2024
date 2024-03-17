package vn.hcmuaf.fit.drillsell.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.hcmuaf.fit.drillsell.bean.Products;
import vn.hcmuaf.fit.drillsell.service.ProductService;
import vn.hcmuaf.fit.drillsell.service.UserService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "LoadProducer", value = "/load-by-producer")
public class LoadProducer extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pdName = request.getParameter("producer");
        List<Products> listProd = ProductService.getInstance().getProductByProducer(pdName);
        request.setAttribute("list-prod", listProd);
        response.sendRedirect("product-filter.jsp");
    }
}