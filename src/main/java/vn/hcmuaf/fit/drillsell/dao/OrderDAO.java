package vn.hcmuaf.fit.drillsell.dao;

import vn.hcmuaf.fit.drillsell.db.DbConnector;
import vn.hcmuaf.fit.drillsell.model.Order;
import java.util.List;

public class OrderDAO {

    public static List<Order> showOrder(){
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("\n" +
                            "SELECT orders.id, orders.cartId, orders.userId, products.productId,  products.productName, orders.quantity, " +
                            "(products.unitPrice * orders.quantity) AS totalPrice, orders.stauss, orders.phone, orders.nameCustom ,orders.address\n" +
                            "FROM orders JOIN cart ON orders.cartId = cart.cartId\n" +
                            "\t\t\t\t\t\tJOIN products ON cart.productId = products.productId")
                    .mapToBean(Order.class)
                    .list();
        });
    }

    public static List<Order> show(int id){
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT orders.id, orders.cartId, orders.userId, products.productId, " +
                            " products.productName, cart.quantity, (products.unitPrice * cart.quantity) AS totalPrice, " +
                            "orders.stauss, orders.phone, orders.nameCustom ,orders.address\n" +
                    "FROM orders JOIN cart ON orders.cartId = cart.cartId\n" +
                    "\t\t\t\t\t\tJOIN products ON cart.productId = products.productId WHERE id= :id")
                    .bind("id", id)
                    .mapToBean(Order.class)
                    .list();
        });
    }

    public static boolean updateOrder(Order order){
        return DbConnector.me().get().inTransaction(handle -> {
           int row = handle.createUpdate("UPDATE orders SET  stauss = :stauss WHERE id = :id ")
                   .bind("id", order.getId())
                   .bind("quantity", order.getQuantity())
                   .bind("stauss", order.getStauss())
                   .execute();
           return row >0;
        });
    }

    public static String getCurrentStatus (int id){
        return DbConnector.me().get().withHandle(handle -> {
           return handle.createQuery("SELECT orders.stauss FROM orders WHERE id= :id")
                   .bind("id", id)
                   .mapTo(String.class)
                   .one();
        });
    }

    public  static boolean deleteOrder(int id){
        return DbConnector.me().get().inTransaction(handle -> {
           int row = handle.createUpdate("DELETE FROM orders WHERE id= :id")
                   .bind("id", id)
                   .execute();
           return row >0;
        });
    }


    public static void main(String[] args) {
////        System.out.println(show(2));
//            Order order = new Order();
//            order.setId(5);
//            order.setQuantity(7);
//            order.setStauss("Đã xác nhận");
//            System.out.println(updateOrder(order));
            System.out.println(showOrder());

    }
}
