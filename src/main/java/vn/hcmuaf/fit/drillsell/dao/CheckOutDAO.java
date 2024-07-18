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
                    // Tính toán phí vận chuyển
//                    double shippingFee = calculateShippingFee(order.getAddress());

                    orderId = handle.createUpdate("INSERT INTO orders(userId, stauss, nameCustomer, address, phone, shippingFee, expectedDate) " +
                                    "VALUES (:userId, '1', :nameCustomer, :address, :phone, :shippingFee, :expectedDate)")
                            .bind("userId", order.getUserId())
                            .bind("nameCustomer", order.getNameCustomer())
                            .bind("phone", order.getPhone())
                            .bind("address", order.getAddress())
                            .bind("shippingFee", order.getShippingFee())
                            .bind("expectedDate", order.getExpectedDate())
                            .executeAndReturnGeneratedKeys("orderId")
                            .mapTo(int.class)
                            .one();
                }

                for (OrderItem orderItem : order.getOrderItems()) {
                    handle.createUpdate("INSERT INTO orderItem(orderId, productId, quantity) " +
                                    "VALUES (:orderId, :productId, :quantity)")
                            .bind("orderId", orderId)
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
        return DbConnector.me().get().inTransaction(handle -> {
            String query = "SELECT  orders.orderId, orders.stauss, orders.userId, orders.nameCustomer, orders.phone, orders.address\n" +
                    "FROM orders" +
                    " WHERE orders.userId = :userId " +
                    " ORDER BY orderId DESC";

            return handle.createQuery(query)
                    .bind("userId", userId)
                    .mapToBean(Order.class)
                    .list();
        });
    }


    public static List<Order> showItemOrder(int orderId) {
        return DbConnector.me().get().inTransaction(handle -> {
            String query = "SELECT products.productId, orders.shippingFee, orderitem.orderId, orderitem.idItem, orders.userId, orders.nameCustomer, orders.phone, orders.address, " +
                    " orders.expectedDate, products.productName, orderitem.quantity, (orderitem.quantity * products.unitPrice) AS totalPrice, orders.stauss " +
                    "FROM products " +
                    "JOIN orderitem ON products.productId = orderitem.productId " +
                    "JOIN orders ON orderitem.orderId = orders.orderId " +
                    "WHERE orderitem.orderId = :orderId";

            return handle.createQuery(query)
                    .bind("orderId", orderId)
                    .map((rs, ctx) -> {
                        Order order = new Order();
                        order.setOrderId(rs.getInt("orderId"));
                        order.setUserId(rs.getInt("userId"));
                        order.setNameCustomer(rs.getString("nameCustomer"));
                        order.setPhone(rs.getString("phone"));
                        order.setAddress(rs.getString("address"));
                        order.setStauss(rs.getString("stauss"));
                        order.setExpectedDate(rs.getDate("expectedDate"));
                        order.setShippingFee(rs.getDouble("shippingFee"));

                        OrderItem item = new OrderItem();
                        item.setOrderId(rs.getInt("orderId"));
                        item.setIdItem(rs.getInt("idItem"));
                        item.setProductName(rs.getString("productName"));
                        item.setQuantity(rs.getInt("quantity"));
                        item.setTotalPrice(rs.getDouble("totalPrice"));
                        item.setProductId(rs.getInt("productId"));


                        order.setOrderItems(new ArrayList<>()); // Initialize the list of order items
                        order.getOrderItems().add(item); // Add the item to the order's item list

                        return order;
                    })
                    .reduce(new HashMap<Integer, Order>(), (map, order) -> {
                        if (map.containsKey(order.getOrderId())) {
                            map.get(order.getOrderId()).getOrderItems().addAll(order.getOrderItems());
                        } else {
                            map.put(order.getOrderId(), order);
                        }
                        return map;
                    })
                    .values().stream().collect(Collectors.toList());
        });
    }

    public static boolean update(int orderId) {
        return DbConnector.me().get().withHandle(handle -> {
            int row = handle.createUpdate("UPDATE orders\n" +
                            "SET stauss= '8'\n" +
                            "WHERE orderId = :orderId AND stauss IN ('1', '2'); ")
                    .bind("orderId", orderId)
                    .execute();
            return row > 0;
        });
    }
    public static int getOrderId() {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT orderId FROM orders ORDER BY orderId DESC LIMIT 1")
                    .mapTo(int.class)
                    .findOne()
                    .orElseThrow(() -> new IllegalStateException("No orderId found"));
        });
    }



    public static void main(String[] args) {
        // Tạo danh sách các đối tượng Order với danh sách OrderItem
//        OrderItem orderItem1 = new OrderItem(1, 120, 3, 3);
//        OrderItem orderItem2 = new OrderItem(1, 142, 4, 6);
//        OrderItem orderItem3 = new OrderItem(1, 163, 5, 2);
//        Order order1 = new Order(1, "Pham Thi Ngoc Hoa", "0348439274", "Phu Giao - Cat Thang - Phu Cat - Binh Dinh", Arrays.asList(orderItem1, orderItem2, orderItem3));
//        List<Order> orders = Arrays.asList(order1);
//
//        boolean areOrdersInserted = CheckOutDAO.insertOrders(orders);
//        System.out.println("Orders inserted: " + areOrdersInserted);
////        deleteCart(3);
        System.out.println(update(82));
    }

}