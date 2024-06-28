package vn.hcmuaf.fit.drillsell.dao;

import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;
import vn.hcmuaf.fit.drillsell.db.DbConnector;
import vn.hcmuaf.fit.drillsell.model.Order;
import vn.hcmuaf.fit.drillsell.model.OrderItem;

import java.util.*;
import java.util.stream.Collectors;

public class OrderDAO {

    public static Order getOrderById(int orderId) {
        Jdbi jdbi = DbConnector.me().get();
        return jdbi.withHandle(handle -> {
            Order order = handle.createQuery("SELECT * FROM orders WHERE orderId = :orderId")
                    .bind("orderId", orderId)
                    .map((rs, ctx) -> {
                        Order o = new Order();
                        o.setOrderId(rs.getInt("orderId"));
                        o.setStauss(rs.getString("stauss"));
                        o.setPhone(rs.getString("phone"));
                        o.setAddress(rs.getString("address"));
                        return o;
                    })
                    .one();

            List<OrderItem> orderItems = handle.createQuery("SELECT * FROM orderitem WHERE orderId = :orderId")
                    .bind("orderId", orderId)
                    .map((rs, ctx) -> {
                        OrderItem oi = new OrderItem();
                        oi.setOrderId(rs.getInt("orderId"));
//                        oi.setProductId(rs.getInt("productId"));
                        oi.setQuantity(rs.getInt("quantity"));
                        oi.setExpectedDate(rs.getDate("expectedDate"));
                        return oi;
                    })
                    .list();

            order.setOrderItems(orderItems);
            return order;
        });
    }

    public static List<Order> showOrder() {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT orders.orderId, orders.nameCustomer, orders.address, orders.phone, orders.stauss\n" +
                            "FROM orders")
                    .mapToBean(Order.class)
                    .list();
        });
    }


    public static List<Order> show(int orderId) {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT orders.userId, orders.orderId, orderitem.idItem, products.unitPrice,  products.productName,  orderitem.quantity, (products.unitPrice * orderitem.quantity) AS totalPrice\n" +
                            "FROM orders JOIN orderitem ON orders.orderId = orderitem.orderId\n" +
                            "JOIN products ON orderitem.productId = products.productId\n" +
                            "WHERE orders.orderId = :orderId")
                    .bind("orderId", orderId)
                    .map((rs, ctx) -> {
                        int currentOrderId = rs.getInt("orderId");
                        OrderItem item = new OrderItem();
                        item.setOrderId(currentOrderId);
                        item.setIdItem(rs.getInt("idItem"));
                        item.setProductName(rs.getString("productName"));
                        item.setUnitPrice(rs.getDouble("unitPrice"));
                        item.setQuantity(rs.getInt("quantity"));
                        item.setTotalPrice(rs.getDouble("totalPrice"));

                        Order order = new Order();
                        order.setOrderId(currentOrderId);
                        order.setUserId(rs.getInt("userId"));
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



    public static boolean updates(Order order) {
        return DbConnector.me().get().inTransaction(handle -> {
            int rowsOrderUpdate = 0;
            rowsOrderUpdate = handle.createUpdate("UPDATE orders " +
                            "SET phone = :phone, address = :address " +
                            "WHERE orderId = :orderId")
                    .bind("phone", order.getPhone())
                    .bind("address", order.getAddress())
                    .bind("orderId", order.getOrderId())
                    .execute();

            int rowsOrderItemUpdate = 0;

            for (OrderItem item : order.getOrderItems()) {
                rowsOrderItemUpdate += handle.createUpdate("UPDATE orderitem " +
                                "SET quantity = :quantity, expectedDate = :expectedDate " +
                                "WHERE orderId = :orderId")
                        .bind("quantity", item.getQuantity())
                        .bind("expectedDate", item.getExpectedDate())
                        .bind("orderId", item.getOrderId())
                        .execute();
            }
            // Return true if status update is successful, and either there are no details to update or details update is successful
            return rowsOrderUpdate > 0 && rowsOrderItemUpdate > 0;
        });
    }


    public static boolean isValidStatuss(String currentStatuss, String newStatuss) {
        // Kiểm tra tính hợp lệ của trạng thái mới
        switch (currentStatuss) {
            case "Đang xử lý":
                return newStatuss.equals("Đã xác nhận") || newStatuss.equals("Đang xử lý") || newStatuss.equals("Đã hủy");
            case "Đã xác nhận":
                return newStatuss.equals("Người bán đang chuẩn bị hàng") || newStatuss.equals("Đã xác nhận") || newStatuss.equals("Đã hủy");
            case "Người bán đang chuẩn bị hàng":
                return newStatuss.equals("Đã bàn giao cho đơn vị vận chuyển GHTK") || newStatuss.equals("Người bán đang chuẩn bị hàng") || newStatuss.equals("Đã hủy");
            case "Đã bàn giao cho đơn vị vận chuyển GHTK":
                return newStatuss.equals("Đang giao hàng") || newStatuss.equals("Đã bàn giao cho đơn vị vận chuyển GHTK") || newStatuss.equals("Đã hủy");
            case "Đang giao hàng":
                return newStatuss.equals("Đã giao hàng") || newStatuss.equals("Đang giao hàng") || newStatuss.equals("Đã hủy");
            case "Đã giao hàng":
                return newStatuss.equals("Đã hoàn trả") || newStatuss.equals("Đã giao hàng");
            case "Đã hoàn trả":
                return newStatuss.equals("Đã hoàn trả") || newStatuss.equals("Đã hoàn trả");
            case "Đã hủy":
                return newStatuss.equals("Đã hủy");
        }
        return false;
    }

    public static boolean updateStatuss(int orderId, String status) {
        return DbConnector.me().get().inTransaction(handle -> {
            int rows = handle.createUpdate("UPDATE orders " +
                            "SET stauss = :stauss " +
                            "WHERE orderId = :orderId ")
                    .bind("stauss", status)
                    .bind("orderId", orderId)
                    .execute();
            return rows > 0;

        });
    }

    public static String getCurrentStatus(int orderId) {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT orders.stauss FROM orders WHERE orderId= :orderId")
                    .bind("orderId", orderId)
                    .mapTo(String.class)
                    .one();
        });
    }

    public static boolean deleteOrder(int id) {
        return DbConnector.me().get().inTransaction(handle -> {
            int row = handle.createUpdate("DELETE FROM orders WHERE id= :id")
                    .bind("id", id)
                    .execute();
            return row > 0;
        });
    }
    public static Map<String, Object> getDailyOrderStats() {
        Jdbi jdbi = DbConnector.me().get();
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(orders.orderId) AS numberOfOrders, SUM(orderitem.quantity) AS quantityProduct, " +
                                "SUM(products.unitPrice * orderitem.quantity) AS sumTotalDay " +
                                "FROM orders " +
                                "JOIN orderitem ON orders.orderId = orderitem.orderId " +
                                "JOIN products ON orderitem.productId = products.productId " +
                                "WHERE orders.stauss NOT IN ( 'Đã hủy', 'Đã hoàn trả') AND DATE(orderitem.timeOrder) = CURDATE()")
                        .mapToMap()
                        .one()
        );
    }

    public static Order getDaily() {
        return DbConnector.me().get().withHandle(handle -> {
            handle.registerRowMapper(BeanMapper.factory(Order.class));
            return handle.createQuery("SELECT COUNT(orders.orderId) AS numberOfOrders, " +
                            "SUM(orderitem.quantity) AS quantityProduct, " +
                            "SUM(products.unitPrice * orderitem.quantity) AS sumTotalDay " +
                            "FROM orders " +
                            "JOIN orderitem ON orders.orderId = orderitem.orderId " +
                            "JOIN products ON orderitem.productId = products.productId" +
                            " WHERE orders.stauss NOT IN ( 'Đã hủy', 'Đã hoàn trả') AND DATE(orderitem.timeOrder) = CURDATE()")
                    .mapTo(Order.class)
                    .one();
        });
    }

    public static void main(String[] args) {
//// Khởi tạo các đối tượng cần thiết cho đơn hàng và mục đơn hàng
//        OrderItem item1 = new OrderItem();
//        item1.setOrderId(14);
//        item1.setQuantity(3);
//        item1.setExpectedDate(Date.valueOf("2024-08-17 00:00:00"));
//
//        List<OrderItem> orderItems = Arrays.asList(item1);
//
//        Order order = new Order();
//        order.setOrderId(14); // Đặt orderId phù hợp với đơn hàng đã tồn tại trong cơ sở dữ liệu
//        order.setPhone("0348434274");
//        order.setAddress("Cát Hưng");
//        order.setStauss("Đã xác nhận");
//        order.setOrderItems(orderItems);
//
//        // Thực hiện cập nhật đơn hàng và in kết quả
//        boolean result = OrderDAO.updates(order);
//        System.out.println(result);
//        System.out.println(getOrderById(7));
        System.out.println(getDaily());

    }
}



