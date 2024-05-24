package vn.hcmuaf.fit.drillsell.controller.order;

import vn.hcmuaf.fit.drillsell.dao.CheckOutDAO;
import vn.hcmuaf.fit.drillsell.model.Order;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/detailOrder")
public class DetailOrder extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            int idItem = Integer.parseInt(request.getParameter("idItem")) ;
            Order list = CheckOutDAO.showItemOrder(idItem);
            request.setAttribute("detailOrder", list);
            request.getRequestDispatcher("DetailOrder.jsp").forward(request, response); // Điều hướng đến trang JSP
        }
    }



