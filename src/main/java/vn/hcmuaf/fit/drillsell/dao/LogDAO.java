package vn.hcmuaf.fit.drillsell.dao;

import vn.hcmuaf.fit.drillsell.db.DbConnector;
import vn.hcmuaf.fit.drillsell.model.Cart;
import vn.hcmuaf.fit.drillsell.model.Log;
import vn.hcmuaf.fit.drillsell.model.Order;
import vn.hcmuaf.fit.drillsell.model.OrderItem;

import java.net.InetAddress;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class LogDAO {
    public static boolean insertLoginTrue(Log log) {
        return DbConnector.me().get().inTransaction(handle -> {
            try {
                String ipAddress = InetAddress.getLocalHost().getHostAddress();
                int row = handle.createUpdate("INSERT INTO log(userId, ip, statuss, levels) VALUES (:userId, :ip, 'Login susess', 'INFO')")
                        .bind("userId", log.getUserId())
                        .bind("ip", ipAddress)
                        .execute();
                return row > 0;
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        });

    }


    public static boolean inserLoginFalse(Log log) {

        return DbConnector.me().get().inTransaction(handle -> {
            try {


                String ipAddress = InetAddress.getLocalHost().getHostAddress();
                int row = handle.createUpdate("INSERT INTO log(userId, ip, statuss, levels) VALUES (:userId, :ip, 'Login False', 'ERROR')")
                        .bind("userId", log.getUserId())
                        .bind("ip", ipAddress)
                        .execute();
                return row > 0;

            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }

        });
    }


    public static boolean checkLogin(Log log) {
        return DbConnector.me().get().inTransaction(handle -> {
            // Kiểm tra nếu tài khoản đang bị khóa
            Optional<Instant> lockedUntil = handle.createQuery("SELECT locked_until FROM users WHERE id = :id")
                    .bind("id", log.getUserId())
                    .mapTo(Instant.class)
                    .findOne();

            if (lockedUntil.isPresent() && lockedUntil.get().isAfter(Instant.now())) {
                // Tài khoản đang bị khóa, không cho phép đăng nhập
                return false;
            }

            // Kiểm tra số lần đăng nhập thất bại trong vòng 5 phút
            Optional<Log> re = handle.createQuery("SELECT userId, ip, COUNT(userId) AS SL " +
                            "FROM log " +
                            "WHERE timeLogin >= DATE_SUB(NOW(), INTERVAL 5 MINUTE) AND log.statuss = 'Login False' " +
                            "GROUP BY userId, ip " +
                            "HAVING SL >= 3")
                    .mapToBean(Log.class)
                    .findOne();

            if (re.isPresent()) {
                try {
                    String ipAddress = InetAddress.getLocalHost().getHostAddress();
                    int row = 0;

                    // Kiểm tra số lần đăng nhập sai để quyết định trạng thái
                    if (re.get().getSL() >= 5) {
                        row = handle.createUpdate("INSERT INTO log(userId, ip, statuss, levels) VALUES (:userId, :ip, 'Login DANGER', 'DANGER')")
                                .bind("userId", log.getUserId())
                                .bind("ip", ipAddress)
                                .execute();

                        // Chặn đăng nhập trong 10 phút
                        handle.createUpdate("UPDATE users SET locked_until = DATE_ADD(NOW(), INTERVAL 10 MINUTE) WHERE id = :id")
                                .bind("id", log.getUserId())
                                .execute();
                    } else if (re.get().getSL() >= 3) {
                        row = handle.createUpdate("INSERT INTO log(userId, ip, statuss, levels) VALUES (:userId, :ip, 'Login WARNING', 'WARNING')")
                                .bind("userId", log.getUserId())
                                .bind("ip", ipAddress)
                                .execute();
                    }

                    return row > 0;
                } catch (Exception e) {
                    e.printStackTrace();
                    return false;
                }
            } else {
                // Trả về false nếu không có người dùng nào có 3 lần đăng nhập thất bại trong 5 phút
                return false;
            }
        });
    }


    public static List<Log> showLog() {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT log.id, log.userId, log.ip, log.timeLogin, log.statuss, log.levels, log.valuess, log.previousInfo " +
                            "FROM log")
                    .mapToBean(Log.class)
                    .list();
        });
    }



    public static boolean insertUpdateOrderInLog(Log log, String previousInfo) {
        return DbConnector.me().get().inTransaction(handle -> {
            try {
                String ipAddress = InetAddress.getLocalHost().getHostAddress();
                int row = handle.createUpdate("INSERT INTO log(userId, ip, statuss, levels, valuess, previousInfo) VALUES (:userId, :ip, 'Update Order', 'INFO', :valuess, :previousInfo)")
                        .bind("userId", log.getUserId())
                        .bind("ip", ipAddress)
                        .bind("valuess", log.getValuess())
                        .bind("previousInfo", previousInfo)
                        .execute();
                return row > 0;
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        });
    }






    public static void main(String[] args) {
        Log log = new Log();
        log.setUserId(7); // Đặt giá trị userId thực tế
        log.setStatuss("Đã xác nhận"); // Đặt giá trị status thực tế
        log.setAddress("123 Fake Street"); // Đặt giá trị address thực tế

        // Giả sử bạn có ID của đơn hàng muốn lấy
        int orderId = 3;
//
//        // Lấy thông tin đơn hàng trước khi cập nhật từ cơ sở dữ liệu
        Order previousOrder = OrderDAO.getOrderById(orderId);

        // Tạo chuỗi thông tin trước khi update từ đơn hàng
        String previousInfo = "Order ID: " + previousOrder.getOrderId() + ", Status: " + previousOrder.getStauss()+ ", Quantity: " +  ", Address: " + previousOrder.getAddress() ;

        // Tạo chuỗi thông tin cập nhật log
        String logDetails = "Order ID: " + orderId + ", Status: " + log.getStatuss() + ", Address: " + log.getAddress();
        log.setValuess(logDetails);

        // In ra thông tin trước và sau khi cập nhật
        System.out.println("Previous Info: " + previousInfo);
        System.out.println("Log Update: " + insertUpdateOrderInLog(log, previousInfo));

    }
}
