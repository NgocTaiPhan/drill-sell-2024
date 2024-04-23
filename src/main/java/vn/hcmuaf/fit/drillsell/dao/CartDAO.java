package vn.hcmuaf.fit.drillsell.dao;

import vn.hcmuaf.fit.drillsell.db.DbConnector;
import vn.hcmuaf.fit.drillsell.model.Cart;

import java.util.List;
import java.util.Optional;

public class CartDAO {
    public static List<Cart> selectProduct() {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT cart.cartId, products.productId, products.productName, products.unitPrice, cart.quantity, products.image, (products.unitPrice * cart.quantity) AS totalPrice\n" +
                            "FROM products JOIN cart ON products.productId = cart.productId")
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

    public static boolean insertCartItem(int productId) {
        try {
            return DbConnector.me().get().inTransaction(handle -> {
                // Thực hiện truy vấn SQL để kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng chưa
                Optional<Cart> existingCartItem = handle.createQuery("SELECT * FROM cart WHERE productId = :productId")
                        .bind("productId", productId)
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
                    int rowsAffected = handle.createUpdate("INSERT INTO cart (productId, quantity) VALUES (:productId, 1)")
                            .bind("productId", productId)
                            .execute();

                    return rowsAffected > 0;
                }
            });
        }
        catch (Exception e) {
            // Xử lý ngoại lệ nếu có lỗi xảy ra
            e.printStackTrace();
            return false;
        }
    }











    public static void main(String[] args) {
//        System.out.println(getProductCart());
//            System.out.println(getCartByUserId(1));
//        insertCartItem(85);
        System.out.println(selectProduct());
    }
}


 



