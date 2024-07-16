package vn.hcmuaf.fit.drillsell.controller.order;

import vn.hcmuaf.fit.drillsell.dao.CartDAO;
import vn.hcmuaf.fit.drillsell.dao.CheckOutDAO;
import vn.hcmuaf.fit.drillsell.model.DataRespone;
import vn.hcmuaf.fit.drillsell.model.Order;
import vn.hcmuaf.fit.drillsell.model.OrderItem;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/order")
public class OrderController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String nameCustomer = request.getParameter("nameCustomer");
//        String address = request.getParameter("address");
        String provinceId = request.getParameter("tinh");
        String districtId = request.getParameter("quan");
        String wardId = request.getParameter("phuong");
        String address = provinceId + "," + districtId + "," + wardId;
        String phone = request.getParameter("phone");
        String[] quantities = request.getParameterValues("quantityInput");
        String[] cartIds = request.getParameterValues("cartId");
        String[] productIds = request.getParameterValues("productId");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");
        int userId = user.getId();

        if (nameCustomer == null || nameCustomer.isEmpty() || address == null || address.isEmpty() || phone == null || phone.isEmpty()) {
            request.setAttribute("err", "Vui lòng điền đầy đủ thông tin giao hàng");
            request.getRequestDispatcher("order.jsp").forward(request, response);
        } else {
            List<Order> orders = new ArrayList<>();

            Order order = new Order(userId, nameCustomer, phone, address);

            List<OrderItem> orderItems = new ArrayList<>();
            for (int i = 0; i < productIds.length; i++) {
                OrderItem orderItem = new OrderItem();
                orderItem.setQuantity(Integer.parseInt(quantities[i]));
                orderItem.setCartId(Integer.parseInt(cartIds[i]));
                orderItem.setProductId(Integer.parseInt(productIds[i]));
                orderItems.add(orderItem);
            }
            DataRespone dataRespone = ApiGHN.getData(address, districtId, wardId);
            order.setOrderItems(orderItems);
            order.setShippingFee(dataRespone.getDeliveryFee());
            order.setExpectedDate(dataRespone.getDeliveryDate());
            orders.add(order);



            boolean insert = CheckOutDAO.insertOrders(orders);

            if (insert) {
                    response.sendRedirect("viewOrderCustomer?orderSuccess=true");
            } else {
                response.getWriter().write("Có lỗi xảy ra khi tạo đơn hàng.");
            }
        }
    }

}


