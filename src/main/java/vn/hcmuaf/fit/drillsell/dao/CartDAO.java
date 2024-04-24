package vn.hcmuaf.fit.drillsell.dao;

import jakarta.ws.rs.DELETE;
import vn.hcmuaf.fit.drillsell.db.DbConnector;
import vn.hcmuaf.fit.drillsell.model.Cart;

import java.util.List;
import java.util.Optional;

public class CartDAO {
    public static List<Cart> selectProduct(int userId) {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT cart.userId, cart.cartId, products.productId, products.productName, products.unitPrice, cart.quantity, products.image, (products.unitPrice * cart.quantity) AS totalPrice\n" +
                            "FROM products JOIN cart ON products.productId = cart.productId \n" +
                            "\t\t\t\t\t\t\tJOIN users ON cart.userId = users.id\n" +
                            "WHERE cart.userId = :userId")
                    .bind("userId", userId)
                    .mapToBean(Cart.class)
                    .list();
        });
    }
    public static boolean updateQuantityHight(int productId) {
        try {
            return DbConnector.me().get().inTransaction(handle -> {
                int rowsAffected = handle.createUpdate("UPDATE cart SET quantity = quantity + 1 WHERE productId = :productId")
                        .bind("productId", productId)
                        .execute();

                return rowsAffected > 0;
            });
        } catch (Exception e) {
            // Xử lý ngoại lệ nếu có lỗi xảy ra
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateQuantityLow(int productId) {
        try {
            return DbConnector.me().get().inTransaction(handle -> {
                int rowsAffected = handle.createUpdate("UPDATE cart SET quantity = quantity - 1 WHERE productId = :productId AND quantity >1")
                        .bind("productId", productId)
                        .execute();

                return rowsAffected > 0;
            });
        } catch (Exception e) {
            // Xử lý ngoại lệ nếu có lỗi xảy ra
            e.printStackTrace();
            return false;
        }
    }

    public static boolean insertCartItem(int userId, int productId) {
        try {
            return DbConnector.me().get().inTransaction(handle -> {
                // Thực hiện truy vấn SQL để kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng chưa
                Optional<Cart> existingCartItem = handle.createQuery("SELECT * FROM cart WHERE productId = :productId AND userId = :userId ")
                        .bind("productId", productId)
                        .bind("userId", userId)
                        .mapToBean(Cart.class)
                        .findOne();

                // Nếu sản phẩm đã tồn tại trong giỏ hàng, tăng số lượng
                if (existingCartItem.isPresent()) {
                    int newQuantity = existingCartItem.get().getQuantity() + 1;

                    int rowsAffected = handle.createUpdate("UPDATE cart SET quantity = :quantity WHERE productId = :productId")
                            .bind("quantity", newQuantity)
                            .bind("productId", productId)
                            .execute();

                    return rowsAffected > 0;
                } else {
                    // Nếu sản phẩm chưa có trong giỏ hàng, thêm mới
                    int rowsAffected = handle.createUpdate("INSERT INTO cart (userId, productId, quantity) VALUES (:userId, :productId, 1)")
                            .bind("userId", userId)
                            .bind("productId", productId)
                            .execute();

                    return rowsAffected > 0;
                }
            });
        } catch (Exception e) {
            // Xử lý ngoại lệ nếu có lỗi xảy ra
            e.printStackTrace();
            return false;
        }
    }



    public static boolean delete(int productId){
        return DbConnector.me().get().inTransaction(handle -> {
            try{
                int deleteProduct = handle.createUpdate("DELETE FROM cart WHERE productId = :productId ")
                        .bind("productId", productId)
                        .execute();
                return deleteProduct > 0;
            }catch (Exception e ){
                e.printStackTrace();
                return false;
            }
        });
}








    public static void main(String[] args) {
//        System.out.println(getProductCart());
//            System.out.println(getCartByUserId(1));
        insertCartItem(2, 95);
        System.out.println(selectProduct(2));
    }
}


 



