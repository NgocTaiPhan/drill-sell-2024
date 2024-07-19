package vn.hcmuaf.fit.drillsell.controller.orderManager;

import vn.hcmuaf.fit.drillsell.dao.*;
import vn.hcmuaf.fit.drillsell.model.Order;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/admin/viewOrderMa")
public class showOder extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");

        if (user != null) {
            int userId = user.getId();

            List<Order> list = CheckOutDAO.showOrder(userId);
            list.forEach(order -> {
                String[] addressIds = order.getAddress().split(",");
                order.setAddress(formatAddress(addressIds[0], addressIds[1], addressIds[2],  addressIds[3]));
                String getStatus = OrderDAO.getUpdateStatus(order.getStauss());
                order.setStauss(getStatus);
            });

            request.setAttribute("viewOrderMa", list);
            request.getRequestDispatcher("/admin/order-management.jsp").forward(request, response); // Điều hướng đến trang JSP
        }
    }


    private String formatAddress(String provinceId, String districtId, String wardId, String street) {
        String provinceName = GHNProvinceFetcher.getProvinceNameById(provinceId);
        String districtName = GHNDistricFetcher.getDistrictNameById(districtId);
        String wardName = GHNWardFetcher.getWardNameById(districtId, wardId);

        return street + ", " + wardName + ", " + districtName + ", " + provinceName;
    }

}
