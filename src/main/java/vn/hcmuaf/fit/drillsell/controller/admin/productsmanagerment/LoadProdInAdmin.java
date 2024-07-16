package vn.hcmuaf.fit.drillsell.controller.admin.productsmanagerment;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import vn.hcmuaf.fit.drillsell.model.Products;
import vn.hcmuaf.fit.drillsell.utils.ProductUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class LoadProdInAdmin {
    static void loadAllProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Products> products = ProductUtils.getAllProducts();

        JsonArray jsonArray = new JsonArray();
        for (Products product : products) {
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("productId", product.getProductId());
            jsonObject.addProperty("productName", product.getProductName());
            jsonObject.addProperty("unitPrice", product.getUnitPrice());
            jsonObject.addProperty("productsSold", ProductUtils.getProductSold(product.getProductId()));
            jsonObject.addProperty("productInStock", ProductUtils.getQuantityProductInStock(product.getProductId()));
            jsonArray.add(jsonObject);
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(jsonArray);
        response.getWriter().flush();
    }


    static void loadHideProd(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Products> products = ProductUtils.getHiddenProducts();
        Gson gson = new Gson();

        String json = gson.toJson(products);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(json);
        response.getWriter().flush();

    }

    static void loadDetail(HttpServletRequest request, HttpServletResponse response) throws IOException {
//Lấy thông id từ client rồi sau đó xử lý để gửi thông tin sản phẩm
        int id = Integer.parseInt(request.getParameter("productId"));
        Products prod = ProductUtils.getProductById(id);
        Gson gson = new Gson();
        String json = gson.toJson(prod);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(json);
        response.getWriter().flush();
    }

    public static void loadRemovedProd(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Products> removedProdList = ProductUtils.getRemovedProducts();
        Gson gson = new Gson();

        String json = gson.toJson(removedProdList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(json);
        response.getWriter().flush();
    }
}
