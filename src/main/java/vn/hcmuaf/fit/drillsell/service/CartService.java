package vn.hcmuaf.fit.drillsell.service;


import vn.hcmuaf.fit.drillsell.bean.CartItem;
import vn.hcmuaf.fit.drillsell.db.DbConnector;

import java.util.ArrayList;
import java.util.List;

public class CartService {

    public static List<CartItem> getProductById(int id) {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT " +
                            "    products.image, " +
                            "    products.productName, " +
                            "    products.productId, " +
                            "    products.statuss, " +
                            "    products.unitPrice, " +
                            "    COUNT(*) as quantity " + // Chuyển vị trí của COUNT(*) xuống dòng mới
                            "FROM  products " +
                            "WHERE products.productId = :id ") // Sửa tên tham số từ "productId" thành ":id"
                    .bind("id", id)  // Sửa tên tham số từ "productId" thành ":id"
                    .map((rs, ctx) -> {
                        // Tạo một đối tượng Cart với giá tiền đã được giảm
                        CartItem cart = new CartItem();
                        cart.setImage(rs.getString("image"));
                        cart.setProductName(rs.getString("productName"));
                        cart.setProductId(rs.getInt("productId"));
                        cart.setUnitPrice(rs.getDouble("unitPrice"));
                        cart.setStatuss(rs.getInt("statuss"));
                        // Lấy giá trị quantity từ kết quả truy vấn
                        int quantity = rs.getInt("quantity");
                        double totalPrice = cart.getUnitPrice() * quantity;
                        cart.setQuantity(quantity);
                        cart.setTotalPrice(totalPrice);

                        return cart;
                    })
                    .list();
        });
    }


    public static void main(String[] args) {
        System.out.println(getProductById(1));
    }


}
