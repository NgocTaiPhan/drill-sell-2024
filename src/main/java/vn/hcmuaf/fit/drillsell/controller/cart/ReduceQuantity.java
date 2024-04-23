package vn.hcmuaf.fit.drillsell.controller.cart;

import vn.hcmuaf.fit.drillsell.dao.CartDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateQuantityLow")
public class ReduceQuantity extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       String productIdParameter = request.getParameter("productId");
       int productId = Integer.parseInt(productIdParameter);

       boolean reduceQuantity = CartDAO.updateQuantityLow(productId);

       response.setContentType("text/plain");
       response.setCharacterEncoding("UTF-8");
       response.getWriter().write(String.valueOf(reduceQuantity));

    }
}
