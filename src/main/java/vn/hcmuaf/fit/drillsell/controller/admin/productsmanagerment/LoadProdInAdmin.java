package vn.hcmuaf.fit.drillsell.controller.admin.productsmanagerment;

import com.google.gson.Gson;
import vn.hcmuaf.fit.drillsell.dao.ProductDAO;
import vn.hcmuaf.fit.drillsell.model.Products;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class LoadProdInAdmin {
    static void loadAllProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Products> products = ProductDAO.getInstance().getAllProds();
        Gson gson = new Gson();
//Chuyển danh sách sản phẩm sang json để gửi đến client
        String json = gson.toJson(products);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(json);
        response.getWriter().flush();
    }

    static void loadHideProd(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Products> products = ProductDAO.getInstance().getHideProds();
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
        Products prod = ProductDAO.getInstance().getProdById(id);
        Gson gson = new Gson();
        String json = gson.toJson(prod);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(json);
        response.getWriter().flush();
    }
}
