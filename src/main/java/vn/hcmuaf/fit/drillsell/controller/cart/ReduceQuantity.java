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

@WebServlet("/updateQuantityLow")
public class ReduceQuantity extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       String productIdParameter = request.getParameter("productId");
       int productId = Integer.parseInt(productIdParameter);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");
        String userIdParam = String.valueOf(user.getId()); // Lấy userId từ thông tin người dùng trong session
        int userId = Integer.parseInt(userIdParam);
       boolean reduceQuantity = CartDAO.updateQuantityLow(userId, productId);

       response.setContentType("text/plain");
       response.setCharacterEncoding("UTF-8");
       response.getWriter().write(String.valueOf(reduceQuantity));

    }
}
