package vn.hcmuaf.fit.drillsell.dao;

import vn.hcmuaf.fit.drillsell.db.DbConnector;
import vn.hcmuaf.fit.drillsell.model.Cart;
import vn.hcmuaf.fit.drillsell.model.Log;

import java.net.InetAddress;
import java.util.Optional;

public class LogDAO {
    public static boolean insertLoginTrue(Log log){
        return DbConnector.me().get().inTransaction(handle -> {
            try{
                String ipAddress = InetAddress.getLocalHost().getHostAddress();
                int row = handle.createUpdate("INSERT INTO log(userId, ip, statuss, levels) VALUES (:userId, :ip, 'Login susess', :levels)")
                        .bind("userId", log.getUserId())
                        .bind("ip", ipAddress)
                        .bind("levels", log.INFO)
                        .execute();
                return row >0;
            }
            catch (Exception e){
                e.printStackTrace();
                return false;
            }
        });

    }


    public static boolean inserLoginFalse(Log log){

        return DbConnector.me().get().inTransaction(handle -> {
            try{


                String ipAddress = InetAddress.getLocalHost().getHostAddress();
                int row = handle.createUpdate("INSERT INTO log(userId, ip, statuss, levels) VALUES (:userId, :ip, 'Login False', :levels)")
                        .bind("userId", log.getUserId())
                        .bind("ip", ipAddress)
                        .bind("levels", log.ERROR)
                        .execute();
                return row > 0;

            }
            catch (Exception e){
                e.printStackTrace();
                return false;
            }

        });
    }


    public static boolean checkLogin(Log log) {
        return DbConnector.me().get().inTransaction(handle -> {
            Optional<Log> re = handle.createQuery("SELECT userId, ip, COUNT(ip) AS SL " +
                            "FROM log " +
                            "WHERE timeLogin >= DATE_SUB(NOW(), INTERVAL 5 MINUTE) AND log.statuss = 'Login False' " +
                            "GROUP BY userId, ip " +
                            "HAVING SL > 3 ")
                    .mapToBean(Log.class)
                    .findOne();

            if (re.isPresent()) {
                try {
                    String ipAddress = InetAddress.getLocalHost().getHostAddress();
                    int row = handle.createUpdate("INSERT INTO log(userId, ip, statuss, levels) VALUES (:userId, :ip, 'Login WARNING', :levels)")
                            .bind("userId", log.getUserId())
                            .bind("ip", ipAddress)
                            .bind("levels", log.WARNING)
                            .execute();
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



    public static void main(String[] args) {
        Log log = new Log();
        log.setUserId(3);
//        insertLoginTrue(log);
//        inserLoginFalse(log);
        System.out.println(checkLogin(log));
    }
}
