package vn.hcmuaf.fit.drillsell.dao;

import vn.hcmuaf.fit.drillsell.db.DbConnector;
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



    public static void main(String[] args) {
        Log log = new Log();
        log.setUserId(0);
//        insertLoginTrue(log);
        inserLoginFalse(log);
    }
}
