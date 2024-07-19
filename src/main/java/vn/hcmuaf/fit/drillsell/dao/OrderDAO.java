package vn.hcmuaf.fit.drillsell.dao;

import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;
import vn.hcmuaf.fit.drillsell.db.DbConnector;
import vn.hcmuaf.fit.drillsell.model.MonthlyRevenue;
import vn.hcmuaf.fit.drillsell.model.Order;
import vn.hcmuaf.fit.drillsell.model.OrderItem;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

public class OrderDAO {
    public static Order getOrderId(int orderId) {
        return DbConnector.me().get().withHandle(handle ->
                handle.createQuery("SELECT * FROM orders WHERE orderId = :orderId")
                        .bind("orderId", orderId)
                        .mapToBean(Order.class)
                        .findOne()
                        .orElse(null)
        );
    }
    public static List<Order> showItemOrder(int orderId) {
        return DbConnector.me().get().inTransaction(handle -> {
            String query = "SELECT products.productId, orderitem.orderId, orderitem.idItem, orders.userId, " +
                    "  products.productName, orderitem.quantity " +
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

                        OrderItem item = new OrderItem();
                        item.setOrderId(rs.getInt("orderId"));
                        item.setIdItem(rs.getInt("idItem"));
                        item.setProductName(rs.getString("productName"));
                        item.setQuantity(rs.getInt("quantity"));
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
    public static Order getStatuss(int orderId) {
        return DbConnector.me().get().withHandle(handle ->
                handle.createQuery("SELECT stauss, orderId, userId  FROM orders WHERE orderId = :orderId")
                        .bind("orderId", orderId)
                        .mapToBean(Order.class)
                        .findOne()
                        .orElse(null)
        );
    }

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
                        o.setExpectedDate(rs.getDate("expectedDate"));

                        return o;
                    })
                    .one();

            List<OrderItem> orderItems = handle.createQuery("SELECT * FROM orderitem WHERE orderId = :orderId")
                    .bind("orderId", orderId)
                    .map((rs, ctx) -> {
                        OrderItem oi = new OrderItem();
                        oi.setOrderId(rs.getInt("orderId"));
                        oi.setProductId(rs.getInt("productId"));
                        oi.setQuantity(rs.getInt("quantity"));
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
            return handle.createQuery("SELECT products.productId,  orders.userId, orders.orderId, orderitem.idItem, products.unitPrice,  products.productName,  orderitem.quantity, (products.unitPrice * orderitem.quantity) AS totalPrice\n" +
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
                        item.setProductId(rs.getInt("productId"));


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
            int rows = handle.createUpdate("UPDATE orders SET address = :address, phone = :phone, expectedDate = :expectedDate  WHERE orderId = :orderId AND stauss IN ('1', '2', '3')")
                    .bind("address", order.getAddress())
                    .bind("phone", order.getPhone())
                    .bind("expectedDate", order.getExpectedDate())
                    .bind("orderId", order.getOrderId())
                    .execute();
            return rows > 0;
        });
    }

    public static String getUpdateStatus(String status) {
        switch (status) {
            case "1":
                return "Đang xử lý";
            case "2":
                return "Đã xác nhận";
            case "3":
                return "Người bán đang chuẩn bị hàng";
            case "4":
                return "Đã bàn giao cho đơn vị vận chuyển GHTK";
            case "5":
                return "Đang giao hàng";
            case "6":
                return "Đã giao hàng";
            case "7":
                return "Đã hoàn trả";
            case "8":
                return "Đã hủy";
            default:
                return status;
        }
    }





    public static boolean isValidStatuss(String currentStatuss, String newStatuss) {
        // Kiểm tra tính hợp lệ của trạng thái mới
        switch (currentStatuss) {
            case "1":
                return newStatuss.equals("2")  || newStatuss.equals("8");
            case "2":
                return newStatuss.equals("3")  || newStatuss.equals("8");
            case "3":
                return newStatuss.equals("4")  || newStatuss.equals("8");
            case "4":
                return newStatuss.equals("5")  || newStatuss.equals("8");
            case "5":
                return newStatuss.equals("6")  || newStatuss.equals("8");
            case "6":
                return newStatuss.equals("7") ;
            case "7":
                return  newStatuss.equals("8");
        }
        return false;
    }

    public static Order getStatus(int orderId){
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT orderId,  stauss  FROM order WHERE orderId = :orderId ")
                    .bind("orderId", orderId)
                    .mapTo(Order.class)
                    .one();
        });
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

    public static int getCountOrder() {
        return DbConnector.me().get().withHandle(handle -> {
            handle.registerRowMapper(BeanMapper.factory(Order.class));
            return handle.createQuery("SELECT COUNT(orders.orderId) AS quantity\n" +
                            "FROM orders\n" +
                            "WHERE orders.stauss NOT IN ('8') AND  DATE(orders.timeOrder) = CURDATE();")
                    .mapTo(Integer.class)
                    .one();
        });
    }

    public static List<MonthlyRevenue> getMonthlyRevenue() {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT YEAR(orders.timeOrder) AS year, " +
                            "       MONTH(orders.timeOrder) AS month, " +
                            "       SUM(products.unitPrice * orderitem.quantity) AS totalRevenue " +
                            "FROM orders " +
                            "JOIN orderitem ON orders.orderId = orderitem.orderId " +
                            "JOIN products ON orderitem.productId = products.productId " +
                            "WHERE orders.stauss = '6' " +
                            "GROUP BY YEAR(orders.timeOrder), MONTH(orders.timeOrder) " +
                            "ORDER BY YEAR(orders.timeOrder), MONTH(orders.timeOrder)")
                    .map((rs, ctx) -> {
                        MonthlyRevenue revenue = new MonthlyRevenue();
                        revenue.setYear(rs.getInt("year"));
                        revenue.setMonth(rs.getInt("month"));
                        revenue.setTotalRevenue(rs.getDouble("totalRevenue"));
                        return revenue;
                    })
                    .list();
        });
    }

    public static long revenue() {
        return DbConnector.me().get().withHandle(handle ->
                handle.createQuery("SELECT COALESCE(SUM(oi.quantity * p.unitPrice), 0) AS revenue " +
                                "FROM orders o " +
                                "JOIN orderitem oi ON o.orderId = oi.orderId " +
                                "JOIN products p ON oi.productId = p.productId " +
                                "WHERE o.stauss = '6' " +
                                "AND MONTH(o.timeOrder) = MONTH(CURRENT_DATE()) " +
                                "AND YEAR(o.timeOrder) = YEAR(CURRENT_DATE());")
                        .mapTo(Long.class) // Map kết quả tới Long
                        .findOne() // Sử dụng findOne() thay vì one()
                        .orElse(0L) // Trả về 0 nếu không có kết quả
        );
    }

    public static boolean updateQuantity(OrderItem item) {
        return DbConnector.me().get().inTransaction(handle -> {
            int rows = handle.createUpdate("UPDATE orderitem oi " +
                            "JOIN orders o ON oi.orderId = o.orderId " +
                            "SET oi.quantity = :quantity " +
                            "WHERE oi.orderId = :orderId AND oi.productId = :productId " +
                            "AND o.stauss NOT IN ('4', '5', '6', '7', '8')")
                    .bind("quantity", item.getQuantity())
                    .bind("orderId", item.getOrderId())
                    .bind("productId", item.getProductId())
                    .execute();
            return rows > 0;
        });
    }

    public static int getAllQuantityFromOrderByProductId(int productId) {
        return DbConnector.me().get().withHandle(handle ->
                handle.createQuery("SELECT SUM(quantity) " +
                                "FROM orderItem " +
                                "WHERE productId = :productId")
                        .bind("productId", productId)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0));

    }




    public static void main(String[] args) {

// Khởi tạo các đối tượng cần thiết cho đơn hàng và mục đơn hàng
//        OrderItem item1 = new OrderItem();
//        item1.setOrderId(27);
//        item1.setQuantity(3);
////        item1.setExpectedDate(Date.valueOf("2024-08-17 00:00:00"));
//
//        List<OrderItem> orderItems = Arrays.asList(item1);
//
//        Order order = new Order();
//        order.setOrderId(27); // Đặt orderId phù hợp với đơn hàng đã tồn tại trong cơ sở dữ liệu
//        order.setPhone("0348434274");
//        order.setAddress("Cát Hưng");
//        order.setStauss("Đã xác nhận");
//        order.setOrderItems(orderItems);
//
//        // Thực hiện cập nhật đơn hàng và in kết quả
//        boolean result = OrderDAO.updates(order);
//        System.out.println(result);
//        System.out.println(getOrderId(26));
//                OrderItem item1 = new OrderItem();
//        item1.setOrderId(30);
//        item1.setProductId(7);
//        item1.setQuantity(2);

    }
}



