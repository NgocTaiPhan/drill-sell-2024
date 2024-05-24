package vn.hcmuaf.fit.drillsell.dao;

import org.jetbrains.annotations.Nullable;
import vn.hcmuaf.fit.drillsell.db.DbConnector;

import vn.hcmuaf.fit.drillsell.model.Order;
import vn.hcmuaf.fit.drillsell.model.OrderItem;


import java.util.*;
import java.util.stream.Collectors;

public class CheckOutDAO {


    public static List<OrderItem> showProducts(int userId, int productIds) {
        Order order = new Order();
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("\n" +
                            "SELECT cart.cartId, products.productId, products.productName, cart.userId, products.unitPrice, products.image, cart.quantity, (products.unitPrice * cart.quantity) AS totalPrice\n" +
                            "FROM cart JOIN products ON cart.productId = products.productId" +
                            " WHERE cart.productId = :productId AND userId = :userId")
                    .bind("productId", productIds)
                    .bind("userId", userId)
                    .mapToBean(OrderItem.class)
                    .list();
        });

    }


    public static boolean insertOrders(List<Order> orders) {
        return DbConnector.me().get().inTransaction(handle -> {
            int orderId = -1;

            for (Order order : orders) {
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

                for (OrderItem orderItem : order.getOrderItems()) {
                    handle.createUpdate("INSERT INTO orderItem(orderId, productId, quantity) " +
                                    "VALUES (:orderId, :productId, :quantity)")
                            .bind("orderId", orderId)
//                            .bind("cartId", orderItem.getCartId())
                            .bind("productId", orderItem.getProductId())
                            .bind("quantity", orderItem.getQuantity())
                            .execute();
                }

                // Xóa các sản phẩm tương ứng trong giỏ hàng
                for (OrderItem orderItem : order.getOrderItems()) {
                    handle.createUpdate("DELETE FROM cart WHERE cartId = :cartId")
                            .bind("cartId", orderItem.getCartId())
                            .execute();
                }
            }
            return true;
        });
    }


    public static List<Order> showOrder(int userId) {
        return DbConnector.me().get().withHandle(handle -> {
            String query = "SELECT oi.idItem, o.orderId, o.userId, o.nameCustomer, o.phone, o.address, o.stauss, " +
                    "oi.productId, oi.quantity, (oi.quantity * p.unitPrice) as totalPrice, " +
                    "p.productName, p.image " +
                    "FROM orders o " +
                    "JOIN orderitem oi ON o.orderId = oi.orderId " +
                    "JOIN products p ON oi.productId = p.productId " +
                    "WHERE o.userId = :userId";

            return handle.createQuery(query)
                    .bind("userId", userId)
                    .map((rs, ctx) -> {
                        Order order = new Order();
                        order.setOrderId(rs.getInt("orderId"));
                        order.setUserId(rs.getInt("userId"));
                        order.setName(rs.getString("nameCustomer"));
                        order.setPhone(rs.getString("phone"));
                        order.setAddress(rs.getString("address"));
                        order.setStauss(rs.getString("stauss"));

                        OrderItem item = new OrderItem();
                        item.setOrderId(rs.getInt("orderId"));
                        item.setIdItem(rs.getInt("idItem"));
                        item.setProductId(rs.getInt("productId"));
                        item.setQuantity(rs.getInt("quantity"));
                        item.setTotalPrice(rs.getDouble("totalPrice"));
                        item.setProductName(rs.getString("productName"));

                        Map.Entry<Order, OrderItem> entry = new AbstractMap.SimpleEntry<>(order, item);
                        return entry;
                    })
                    .list()
                    .stream()
                    .collect(Collectors.groupingBy(Map.Entry::getKey))
                    .entrySet()
                    .stream()
                    .map(e -> {
                        Order order = e.getKey();
                        List<OrderItem> items = e.getValue().stream().map(Map.Entry::getValue).collect(Collectors.toList());
                        order.setOrderItems(items);
                        return order;
                    })
                    .collect(Collectors.toList());
        });
    }




    public static Order showItemOrder(int idItem) {
        return DbConnector.me().get().withHandle(handle -> {
            String query = "SELECT orderitem.idItem, orders.userId, orders.nameCustomer, orders.phone, orders.address, " +
                    "products.unitPrice, orders.stauss, orderitem.orderId, products.productId, products.productName, orderitem.quantity, " +
                    "(orderitem.quantity * products.unitPrice) as totalPrice " +
                    "FROM products " +
                    "JOIN orderitem ON products.productId = orderitem.productId " +
                    "JOIN orders ON orderitem.orderId = orders.orderId " +
                    "WHERE orderitem.idItem = :idItem ";


            List<Order> orders = handle.createQuery(query)
                    .bind("idItem", idItem)
//                    .bind("productId", productId)
                    .map((rs, ctx) -> {
                        Order order = new Order();
                        order.setOrderId(rs.getInt("orderId"));
                        order.setUserId(rs.getInt("userId"));
                        order.setName(rs.getString("nameCustomer"));
                        order.setPhone(rs.getString("phone"));
                        order.setAddress(rs.getString("address"));
                        order.setStauss(rs.getString("stauss"));

                        OrderItem item = new OrderItem();
                        item.setOrderId(rs.getInt("orderId"));
                        item.setIdItem(rs.getInt("idItem"));
                        item.setProductId(rs.getInt("productId"));
                        item.setQuantity(rs.getInt("quantity"));
                        item.setTotalPrice(rs.getDouble("totalPrice"));
                        item.setProductName(rs.getString("productName"));

                        order.setOrderItems(Collections.singletonList(item)); // Set items as a list containing only one item
                        return order;
                    })
                    .list();

            if (!orders.isEmpty()) {
                return orders.get(0); // Return the first (and only) order
            } else {
                return null; // No order found with the given orderId
            }
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
////        deleteCart(3);
        System.out.println(showItemOrder(1));
    }

}