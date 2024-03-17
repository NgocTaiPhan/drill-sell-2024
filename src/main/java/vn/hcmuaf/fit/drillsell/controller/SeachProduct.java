package vn.hcmuaf.fit.drillsell.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.hcmuaf.fit.drillsell.bean.Products;
import vn.hcmuaf.fit.drillsell.service.SearchService;
import vn.hcmuaf.fit.drillsell.service.UserService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "SeachProduct", value = "/seachProduct")
public class SeachProduct extends HttpServlet {
    private SearchService searchService;

    public SeachProduct() {
        super();
        this.searchService = new SearchService();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("name");
        // Simulate product search (replace this with your actual search logic)
        List<Products> products = searchService.searchProductByName(keyword);
        // Chuyển danh sách sản phẩm thành JSON

        request.setAttribute("loadProduct", products);

        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("UTF-8");

        request.getRequestDispatcher("seachProduct.jsp").forward(request, response);

    }

    }





