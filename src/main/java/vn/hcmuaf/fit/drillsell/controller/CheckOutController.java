//package vn.hcmuaf.fit.drillsell.controller;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import vn.hcmuaf.fit.drillsell.dao.CheckOutDAO;
//import vn.hcmuaf.fit.drillsell.model.Cart;
//import vn.hcmuaf.fit.drillsell.model.CheckOut;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.List;
//import java.util.Map;
//
//@WebServlet("/checkOut")
//public class CheckOutController extends HttpServlet {
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String[] selectedProducts = request.getParameterValues("selectedProducts");
//        List<CheckOut> checkOuts = new ArrayList<>();
//        if (selectedProducts != null) {
//            for (String productId : selectedProducts) {
//                checkOuts.addAll(CheckOutDAO.showProducts(Integer.parseInt(productId)));
//            }
//        }
//        request.setAttribute("checkOuts", checkOuts);
//        request.getRequestDispatcher("order.jsp").forward(request, response);
//    }
//
//}