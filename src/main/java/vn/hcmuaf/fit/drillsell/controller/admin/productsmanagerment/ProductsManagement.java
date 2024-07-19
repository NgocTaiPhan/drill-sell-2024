package vn.hcmuaf.fit.drillsell.controller.admin.productsmanagerment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ProductsManagement", urlPatterns = {"/admin/load-all-prods", "/admin/show-detail", "/admin/add-prod", "/admin/remove-prod", "/admin/update-prod", "/admin/hide-prod"})
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
            case "/admin/add-prod" -> AddProd.addProduct(request, response);
//            case "/admin/add-prods" -> AddProd.addProductFromExcel(request, response);
            case "/admin/load-all-prods" -> LoadProdInAdmin.loadAllProduct(request, response);
            case "/admin/remove-prod" -> RemoveProd.removeProd(request, response);
            case "/admin/update-prod" -> UpdateProd.updateProd(request, response);
            case "/admin/hide-prod" -> HideProd.hideProd(request, response);
            case "/admin/show-detail" -> LoadProdInAdmin.loadDetail(request, response);
        }
    }


}


//    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        // Lấy các tham số từ request
//        String prodName = request.getParameter("productName");
//        String image = request.getParameter("imageUrl");
//        String describle = request.getParameter("describle");
//        String specifions = request.getParameter("specifions");
//        String nameProducer = request.getParameter("nameProducer");
//
//        // In ra từng biến trên một dòng mới (chỉ để kiểm tra, có thể xóa sau)
//        System.out.println("prodName: " + prodName);
//        System.out.println("image: " + image);
//        System.out.println("describle: " + describle);
//        System.out.println("specifions: " + specifions);
//        System.out.println("nameProducer: " + nameProducer);
//
//        // Khởi tạo biến với giá trị mặc định
//        double unitPrice = 0.0;
//        int cateId = 0;
//
//        // Kiểm tra các tham số bắt buộc
//        if (prodName == null || prodName.isEmpty() || image == null || nameProducer == null) {
//            sendResponeText(response, "Hãy điền đầy đủ thông tin!");
//            return;
//        }
//
//        try {
//            // Chuyển đổi giá và danh mục thành số
//            unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
//            cateId = Integer.parseInt(request.getParameter("categoryId"));
//
//            // Kiểm tra giá trị mặc định (hoặc giá trị không hợp lệ)
//            if (unitPrice <= 0 || cateId <= 0) {
//                sendResponeText(response, "Giá bán và danh mục phải là số dương!");
//                return;
//            }
//
//        } catch (NumberFormatException e) {
//            sendResponeText(response, "Định dạng giá hoặc danh mục không hợp lệ!");
//            return;
//        }
//
//        // Tạo đối tượng Products và thêm vào cơ sở dữ liệu
//        Products product = new Products(image, prodName, unitPrice, cateId, nameProducer, describle, specifions);
//        System.out.println(product); // In thông tin sản phẩm (chỉ để kiểm tra)
//
//        ProductDAO.getInstance().addProduct(product);
//        sendResponeText(response, "Thêm sản phẩm thành công!");
//    }

