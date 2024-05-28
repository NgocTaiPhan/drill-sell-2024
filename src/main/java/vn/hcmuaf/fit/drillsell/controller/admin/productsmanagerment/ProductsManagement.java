package vn.hcmuaf.fit.drillsell.controller.admin.productsmanagerment;

import com.google.gson.Gson;
import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.dao.ProductDAO;
import vn.hcmuaf.fit.drillsell.model.Products;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "ProductsManagement", urlPatterns = {"/admin/load-all-prods", "/admin/add-prod", "/admin/remove-prod", "/admin/update-prod", "/admin/hide-prod"})
public class ProductsManagement extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("UTF-8");
        String servletPath = request.getServletPath();
        switch (servletPath) {
            case "/admin/add-prod" -> addProduct(request, response);
            case "/admin/load-all-prods" -> loadAllProduct(request, response);
            case "/admin/remove-prod" -> removeProd(request, response);
            case "/admin/update-prod" -> updateProd(request, response);
            case "/admin/hide-prod" -> hideProd(request, response);
        }
    }

    private void hideProd(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("productId"));
        ProductDAO.getInstance().hideProd(id);
    }

    private void updateProd(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("productId"));
        String prodName = request.getParameter("productName");
        String image = request.getParameter("productImage");
        double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String nameProducer = request.getParameter("nameProducer");
        String describle = request.getParameter("describle");
        String specifions = request.getParameter("specifions");
        Products prod = new Products(id, image, prodName, unitPrice, categoryId, nameProducer, describle, specifions);
        ProductDAO productDAO = new ProductDAO();
        productDAO.updateProd(prod);
    }

    private void removeProd(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("productId"));

        if (id != 0) {
            ProductDAO productDAO = new ProductDAO();
            productDAO.removeProduct(id);
        }
    }

    private void loadAllProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Products> products = ProductDAO.getInstance().getAllProds();
        Gson gson = new Gson();
//        hiển thị danh sách người dùng
        String json = gson.toJson(products);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(json);
        response.getWriter().flush();
    }

    public static void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String prodName = request.getParameter("productName");
        String image = request.getParameter("productImage");
        double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String nameProducer = request.getParameter("nameProducer");
        String describle = request.getParameter("describle");
        String specifions = request.getParameter("specifions");
        Notify notify;
        try {
            if (prodName == null || prodName.isEmpty()) {
                notify = new Notify("Lỗi", "Hãy điền tên sản phẩm!.", "error");
                response.setContentType("application/json");

                PrintWriter writter = response.getWriter();
                writter.print(notify);
                writter.flush();
                return;
            }
            Products product = new Products(image, prodName, unitPrice, categoryId, nameProducer, describle, specifions);
            ProductDAO.getInstance().addProduct(product);
            notify = new Notify("Thành công", "Thêm sản phẩm thành công!.", "success");
            response.setContentType("application/json");

            PrintWriter writter = response.getWriter();
            writter.print(notify);
            writter.flush();

        } catch (Exception e) {
            notify = new Notify("Thành công", "Thêm sản phẩm thành công!.", "success");
            response.setContentType("application/json");

            PrintWriter writter = response.getWriter();
            writter.print(notify);
            writter.flush();
        }


    }
}