//package vn.hcmuaf.fit.drillsell.controller.order;
//
//
//import vn.hcmuaf.fit.drillsell.dao.OrderDAO;
//import vn.hcmuaf.fit.drillsell.model.Order;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet("/deleteList")
//public class viewList extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        int id = Integer.parseInt(request.getParameter("id"));
//        boolean s = OrderDAO.deleteOrder(id);
//       response.getWriter().write(Boolean.toString(s));
//    }
//}
