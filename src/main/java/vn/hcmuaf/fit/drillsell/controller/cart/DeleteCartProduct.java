package vn.hcmuaf.fit.drillsell.controller.cart;

import vn.hcmuaf.fit.drillsell.dao.CartDAO;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/deleteCartProduct")
public class DeleteCartProduct extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       String productParama = request.getParameter("productId");
       int productId = Integer.parseInt(productParama);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");
        String userIdParam = String.valueOf(user.getId());
        int userId = Integer.parseInt(userIdParam);
       boolean deleteProduct = CartDAO.delete(userId, productId);
       response.setContentType("text/plain");
       response.setCharacterEncoding("UTF-8");
       response.getWriter().write(String.valueOf(deleteProduct));


    }
}
