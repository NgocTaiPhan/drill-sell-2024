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
                    double shippingFee = calculateShippingFee(order.getAddress());

                    orderId = handle.createUpdate("INSERT INTO orders(userId, stauss, nameCustomer, address, phone, shippingFee) " +
                                    "VALUES (:userId, 'Đang xử lý', :nameCustomer, :address, :phone, :shippingFee)")
                            .bind("userId", order.getUserId())
                            .bind("nameCustomer", order.getNameCustomer())
                            .bind("phone", order.getPhone())
                            .bind("address", order.getAddress())
                            .bind("shippingFee", shippingFee)
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

    // Phương thức để tính toán phí vận chuyển
    private static double calculateShippingFee(String address) {
        // Miền Bắc
        if (address.contains("Hà Nội") || address.contains("Hải Phòng") || address.contains("Quảng Ninh")
                || address.contains("Bắc Kạn") || address.contains("Bắc Ninh") || address.contains("Thái Bình")
                || address.contains("Phú Thọ") || address.contains("Tuyên Quang") || address.contains("Điện Biên")
                || address.contains("Hà Nam") || address.contains("Nam Định") || address.contains("Bắc Giang")
                || address.contains("Hà Giang") || address.contains("Lai Châu") || address.contains("Hưng Yên")
                || address.contains("Ninh Bình") || address.contains("Lạng Sơn") || address.contains("Lào Cai")
                || address.contains("Sơn La") || address.contains("Hải Dương") || address.contains("Thái Nguyên")
                || address.contains("Cao Bằng") || address.contains("Yên Bái") || address.contains("Hòa Bình")
                || address.contains("Vĩnh Phúc")) {
            return 40;
        }

        // Miền Trung
        else if (address.contains("Thừa Thiên Huế") || address.contains("Đà Nẵng") || address.contains("Quảng Nam")
                || address.contains("Quảng Ngãi") || address.contains("Bình Định") || address.contains("Phú Yên")
                || address.contains("Khánh Hòa") || address.contains("Ninh Thuận") || address.contains("Bình Thuận")
                || address.contains("Kon Tum") || address.contains("Gia Lai") || address.contains("Đắk Lắk")
                || address.contains("Quảng Bình") || address.contains("Đắk Nông") || address.contains("Quảng Trị")
                || address.contains("Thanh Hóa") || address.contains("Nghệ An") || address.contains("Hà Tĩnh")) {
            return 35;
        }
        // Miền Nam
        else if (address.contains("TP.HCM") || address.contains("Hồ Chí Minh") || address.contains("Long An")
                || address.contains("Bình Dương") || address.contains("Đồng Nai") || address.contains("Tây Ninh")
                || address.contains("Bà Rịa - Vũng Tàu") || address.contains("Bình Phước")) {
            return 10;
        }
        // Đồng bằng sông Cửu Long
        else if (address.contains("Tiền Giang") || address.contains("Bến Tre") || address.contains("Vĩnh Long")
                || address.contains("Trà Vinh") || address.contains("Sóc Trăng") || address.contains("Bạc Liêu")
                || address.contains("Cà Mau") || address.contains("Đồng Tháp") || address.contains("An Giang")
                || address.contains("Kiên Giang") || address.contains("Cần Thơ") || address.contains("Hậu Giang")) {
            return 20;
        }
        // Phí vận chuyển mặc định nếu không thuộc các địa chỉ trên
        return 0.0;
    }




    public static List<Order> showOrder(int userId) {
        return DbConnector.me().get().inTransaction(handle -> {
            String query = "SELECT  orders.orderId, orders.stauss, orders.userId, orders.nameCustomer, orders.phone, orders.address\n" +
                    "FROM orders" +
                    " WHERE orders.userId = :userId";

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
                            "SET stauss= 'Đã Hủy'\n" +
                            "WHERE orderId = :orderId AND stauss IN ('Đợi xác nhận', 'Đã xác nhận'); ")
                    .bind("orderId", orderId)
                    .execute();
            return row > 0;
        });
    }

    public static boolean updateEx(int orderId) {
        return DbConnector.me().get().withHandle(handle -> {
            int row = handle.createUpdate("UPDATE orderItem oi " +
                            "JOIN orders o ON oi.orderId = o.orderId " +
                            "SET o.expectedDate = CASE " +

                            // Miền Trung
                            "    WHEN o.address LIKE '%Thừa Thiên Huế%' " +
                            "    OR o.address LIKE '%Đà Nẵng%' " +
                            "    OR o.address LIKE '%Quảng Nam%' " +
                            "    OR o.address LIKE '%Quảng Ngãi%' " +
                            "    OR o.address LIKE '%Bình Định%' " +
                            "    OR o.address LIKE '%Phú Yên%' " +
                            "    OR o.address LIKE '%Khánh Hòa%' " +
                            "    OR o.address LIKE '%Ninh Thuận%' " +
                            "    OR o.address LIKE '%Bình Thuận%' " +
                            "    OR o.address LIKE '%Kon Tum%' " +
                            "    OR o.address LIKE '%Gia Lai%' " +
                            "    OR o.address LIKE '%Đắk Lắk%' " +
                            "    OR o.address LIKE '%Đắk Nông%' " +
                            "    OR o.address LIKE '%Quảng Bình%' " +
                            "    OR o.address LIKE '%Quảng Trị%' " +
                            "    OR o.address LIKE '%Thanh Hóa%' " +
                            "    OR o.address LIKE '%Nghệ An%' " +
                            "    OR o.address LIKE '%Hà Tĩnh%' THEN DATE_ADD(oi.timeOrder, INTERVAL 5 DAY) " +

                            // Miền Nam
                            "    WHEN o.address LIKE '%TP.HCM%' " +
                            "    OR o.address LIKE '%Hồ Chí Minh%' " +
                            "    OR o.address LIKE '%Long An%' " +
                            "    OR o.address LIKE '%Bình Dương%' " +
                            "    OR o.address LIKE '%Đồng Nai%' " +
                            "    OR o.address LIKE '%Tây Ninh%' " +
                            "    OR o.address LIKE '%Bà Rịa - Vũng Tàu%' " +
                            "    OR o.address LIKE '%Bình Phước%' " +
                            "    OR o.address LIKE '%Tiền Giang%' " +
                            "    OR o.address LIKE '%Bến Tre%' " +
                            "    OR o.address LIKE '%Vĩnh Long%' " +
                            "    OR o.address LIKE '%Trà Vinh%' " +
                            "    OR o.address LIKE '%Sóc Trăng%' " +
                            "    OR o.address LIKE '%Bạc Liêu%' " +
                            "    OR o.address LIKE '%Cà Mau%' " +
                            "    OR o.address LIKE '%Đồng Tháp%' " +
                            "    OR o.address LIKE '%An Giang%' " +
                            "    OR o.address LIKE '%Kiên Giang%' " +
                            "    OR o.address LIKE '%Cần Thơ%' " +
                            "    OR o.address LIKE '%Hậu Giang%' THEN DATE_ADD(oi.timeOrder, INTERVAL 3 DAY) " +

                            // Miền Bắc
                            "    WHEN o.address LIKE '%Hà Nội%' " +
                            "    OR o.address LIKE '%Hải Phòng%' " +
                            "    OR o.address LIKE '%Quảng Ninh%' " +
                            "    OR o.address LIKE '%Bắc Kạn%' " +
                            "    OR o.address LIKE '%Bắc Ninh%' " +
                            "    OR o.address LIKE '%Thái Bình%' " +
                            "    OR o.address LIKE '%Phú Thọ%' " +
                            "    OR o.address LIKE '%Tuyên Quang%' " +
                            "    OR o.address LIKE '%Điện Biên%' " +
                            "    OR o.address LIKE '%Hà Nam%' " +
                            "    OR o.address LIKE '%Nam Định%' " +
                            "    OR o.address LIKE '%Bắc Giang%' " +
                            "    OR o.address LIKE '%Hà Giang%' " +
                            "    OR o.address LIKE '%Lai Châu%' " +
                            "    OR o.address LIKE '%Hưng Yên%' " +
                            "    OR o.address LIKE '%Ninh Bình%' " +
                            "    OR o.address LIKE '%Lạng Sơn%' " +
                            "    OR o.address LIKE '%Lào Cai%' " +
                            "    OR o.address LIKE '%Sơn La%' " +
                            "    OR o.address LIKE '%Hải Dương%' " +
                            "    OR o.address LIKE '%Thái Nguyên%' " +
                            "    OR o.address LIKE '%Cao Bằng%' " +
                            "    OR o.address LIKE '%Yên Bái%' " +
                            "    OR o.address LIKE '%Hòa Bình%' " +
                            "    OR o.address LIKE '%Vĩnh Phúc%' " +
                            "    OR o.address LIKE '%Hà Đông%' THEN DATE_ADD(oi.timeOrder, INTERVAL 7 DAY) " +

                            "    ELSE o.expectedDate " + // Giữ nguyên ngày dự kiến giao hàng nếu không thuộc các nhóm trên
                            "END " +
                            "WHERE oi.orderId = :orderId")
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
        System.out.println(showItemOrder(4));
    }

}