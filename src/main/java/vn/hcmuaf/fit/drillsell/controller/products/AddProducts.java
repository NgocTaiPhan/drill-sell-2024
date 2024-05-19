package vn.hcmuaf.fit.drillsell.controller.products;

import vn.hcmuaf.fit.drillsell.dao.ProductDAO;
import vn.hcmuaf.fit.drillsell.model.Products;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AddProducts", value = "/add-products")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 100)
public class AddProducts extends HttpServlet {
    private String dataPath = "D:/Laptrinhweb/TTLTWeb_BD/src/main/webapp/Image";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Lấy các tham số từ form
        String productName = request.getParameter("productName");
        String productDescription = request.getParameter("productDescription");
        double productPrice = Double.parseDouble(request.getParameter("productPrice"));
        String manufacturerId = request.getParameter("manufacturerId");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String imageUrl = request.getParameter("imageUrl");
        String specifications = request.getParameter("specifications");

        // Tạo đối tượng Product và thiết lập các thuộc tính
        Products product = new Products();
        product.setProductName(productName);
        product.setDescrible(productDescription);
        product.setUnitPrice(productPrice);
        product.setNameProducer(manufacturerId);
        product.setCategoryId(categoryId);
        product.setImage(imageUrl);
        product.setSpecifions(specifications);

        // Xử lý tệp tin tải lên
        for (Part part : request.getParts()) {
            String fileName = part.getSubmittedFileName();
            if (fileName == null || fileName.isEmpty()) {
                continue;
            }

            String imagePath = dataPath + "/" + productName + "_" + fileName;
            part.write(imagePath);
            product.setImage("Image/" + productName + "_" + fileName); // Cập nhật đường dẫn ảnh
        }

        // Lưu sản phẩm vào cơ sở dữ liệu
        ProductDAO productDAO = ProductDAO.getInstance();
        productDAO.addProduct(product);

        // Chuyển hướng tới trang quản lý sản phẩm
        request.getRequestDispatcher("admin/products-management.jsp").forward(request, response);
    }

}