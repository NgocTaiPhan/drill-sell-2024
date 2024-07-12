package vn.hcmuaf.fit.drillsell.controller.admin.productsmanagerment;

import com.google.gson.Gson;
import vn.hcmuaf.fit.drillsell.model.Products;
import vn.hcmuaf.fit.drillsell.utils.ProductUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class LoadProdInAdmin {
    static void loadAllProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Products> products = ProductUtils.getAllProducts();
        Gson gson = new Gson();
//Chuyển danh sách sản phẩm sang json để gửi đến client
        String json = gson.toJson(products);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(json);
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
