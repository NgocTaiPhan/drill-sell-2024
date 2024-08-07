package vn.hcmuaf.fit.drillsell.controller.products;

import vn.hcmuaf.fit.drillsell.model.Review;
import vn.hcmuaf.fit.drillsell.utils.ReviewUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AddReview", value = "/add-review")
public class AddReview extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int prodId = Integer.parseInt(request.getParameter("prodId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        int ratingStar = Integer.parseInt(request.getParameter("rating"));
        String mess = request.getParameter("mess");
        System.out.println(ratingStar + mess);

        ReviewUtils.addReview(new Review(userId, prodId, ratingStar, mess));
        response.sendRedirect("load-detail?productId=" + prodId);
    }
}