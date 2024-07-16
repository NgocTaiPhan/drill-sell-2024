//package vn.hcmuaf.fit.drillsell.controller.test;
//
//import com.google.gson.Gson;
//import vn.hcmuaf.fit.drillsell.dao.ProductDAO;
//import vn.hcmuaf.fit.drillsell.model.Products;
//
//import javax.servlet.*;
//import javax.servlet.http.*;
//import javax.servlet.annotation.*;
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.util.List;
//
//@WebServlet(name = "TestLoadWithAjax", value = "/loadProducts")
//public class TestLoadWithAjax extends HttpServlet {
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        response.setContentType("application/json");
//        PrintWriter out = response.getWriter();
//
//        // Get product list from service
////        List<Products> listProds = ProductDAO.getInstance().showProd();
//
//        // Convert product list to JSON
//        Gson gson = new Gson();
//        String json = gson.toJson(listProds);
//
//        // Send JSON response
//        out.print(json);
//        out.flush();
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//    }
//}