package vn.hcmuaf.fit.drillsell.dao;

import org.jetbrains.annotations.Nullable;
import vn.hcmuaf.fit.drillsell.db.DbConnector;

import vn.hcmuaf.fit.drillsell.model.Order;
import vn.hcmuaf.fit.drillsell.model.OrderItem;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class CheckOutDAO {


    public static List<OrderItem> showProducts(int userId, int productIds) {
        Order order = new Order();
           return DbConnector.me().get().withHandle(handle -> {
                return handle.createQuery("\n" +
                                "SELECT cart.cartId, products.productId, products.productName, cart.userId, products.unitPrice, products.image, cart.quantity, (products.unitPrice * cart.quantity) AS totalPrice\n" +
                                "FROM cart JOIN products ON cart.productId = products.productId" +
                                " WHERE cart.productId = :productId AND userId = :userId" )
                        .bind("productId", productIds)
                        .bind("userId", userId)
                        .mapToBean(OrderItem.class)
                        .list();
            });

    }



    public static boolean insertOrders(List<Order> orders) {
        return DbConnector.me().get().inTransaction(handle -> {
            // Sử dụng orderId đầu tiên cho tất cả các OrderItem
            int orderId = -1;

            for (Order order : orders) {
                // Chỉ thêm một đơn hàng mới vào bảng orders nếu orderId chưa được thiết lập
                if (orderId == -1) {
                    orderId = handle.createUpdate("INSERT INTO orders(userId, stauss, nameCustomer, address, phone) " +
                                    "VALUES (:userId, 'Đợi xác nhận', :nameCustomer, :address, :phone)")
                            .bind("userId", order.getUserId())
                            .bind("nameCustomer", order.getName())
                            .bind("phone", order.getPhone())
                            .bind("address", order.getAddress())
                            .executeAndReturnGeneratedKeys("orderId")
                            .mapTo(int.class)
                            .one();
                }

                // Sử dụng orderId đã được thiết lập cho tất cả các OrderItem của đơn hàng này
                for (OrderItem orderItem : order.getOrderItems()) {
                    handle.createUpdate("INSERT INTO orderItem(orderId, cartId, productId, quantity) " +
                                    "VALUES (:orderId, :cartId, :productId, :quantity)")
                            .bind("orderId", orderId)
                            .bind("quantity", orderItem.getQuantity())
                            .bind("cartId", orderItem.getCartId())
                            .bind("productId", orderItem.getProductId())
                            .execute();
                }
            }
            return true;
        });
    }



    public static void main(String[] args) {
//        // Tạo danh sách các đối tượng Order với danh sách OrderItem
//        OrderItem orderItem1 = new OrderItem(1, 120, 3, 3);
//        OrderItem orderItem2 = new OrderItem(1, 142, 4, 6);
//        OrderItem orderItem3 = new OrderItem(1, 163, 5, 2);
//        Order order1 = new Order(1, "Pham Thi Ngoc Hoa", "0348439274", "Phu Giao - Cat Thang - Phu Cat - Binh Dinh", Arrays.asList(orderItem1, orderItem2, orderItem3));
//        List<Order> orders = Arrays.asList(order1);
//
//        boolean areOrdersInserted = CheckOutDAO.insertOrders(orders);
//        System.out.println("Orders inserted: " + areOrdersInserted);
    }

}