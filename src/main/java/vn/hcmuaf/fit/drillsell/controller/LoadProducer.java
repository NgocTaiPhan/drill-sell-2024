package vn.hcmuaf.fit.drillsell.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vn.hcmuaf.fit.drillsell.model.Products;
import vn.hcmuaf.fit.drillsell.dao.ProductDAO;

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
        List<Products> listProd = ProductDAO.getInstance().getProductByProducer(pdName);
        request.setAttribute("list-prod", listProd);
        response.sendRedirect("product-filter.jsp");
    }
}