package vn.hcmuaf.fit.drillsell.controller.cart;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vn.hcmuaf.fit.drillsell.controller.login.Login;
import vn.hcmuaf.fit.drillsell.dao.CartDAO;
import vn.hcmuaf.fit.drillsell.dao.UsersDAO;
import vn.hcmuaf.fit.drillsell.model.Cart;
import vn.hcmuaf.fit.drillsell.model.User;

import static java.lang.System.out;

@WebServlet("/cart")
public class AddToCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        // Kiểm tra xem người dùng đã đăng nhập hay chưa
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");
        if (user != null && productId != 0) {


            CartDAO.insertCartItem(user.getId(), productId);//Trả về boolean
            response.sendRedirect("cart.jsp");
        } else {

        }


    }

}







