//package vn.hcmuaf.fit.drillsell.dao;
//
//import vn.hcmuaf.fit.drillsell.model.Cart;
//import vn.hcmuaf.fit.drillsell.db.DbConnector;
//import vn.hcmuaf.fit.drillsell.model.CheckOut;
//import vn.hcmuaf.fit.drillsell.model.Product;
//
//import java.math.BigDecimal;
//import java.util.ArrayList;
//import java.util.List;
//
//public class CheckOutDAO {
//    public static List<CheckOut> showProducts(int productIds) {
//           return DbConnector.me().get().withHandle(handle -> {
//                return handle.createQuery("\n" +
//                                "SELECT  cart.productId, products.productName, products.unitPrice, cart.quantity, (products.unitPrice * cart.quantity) AS totalPrice\n" +
//                                "FROM products JOIN cart ON products.productId = cart.productId" +
//                                " WHERE cart.productId = :productId" )
//                        .bind("productId", productIds)
//                        .mapToBean(CheckOut.class)
//                        .list();
//            });
//
//    }
//
//
//
//    public static void main(String[] args) {
//        String[] selectedProducts = {"2", "14"}; // Mảng các ID sản phẩm đã chọn
//        System.out.println(showProducts(2));
//    }
//
//}