package vn.hcmuaf.fit.drillsell.controller.admin.productsmanagerment;

import vn.hcmuaf.fit.drillsell.dao.ProductDAO;
import vn.hcmuaf.fit.drillsell.model.Products;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static vn.hcmuaf.fit.drillsell.controller.notify.Notify.sendResponseText;

public class AddProd {

    static void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//       Lấy dữ liệu đã nhập
        String prodName = request.getParameter("productName");
        String image = request.getParameter("imageUrl");
        String describle = request.getParameter("describle");
        String specifions = request.getParameter("specifions");
        String nameProducer = request.getParameter("nameProducer");

//        Kiểm tra dữ liệu đã nhập đã qua chưa
        System.out.println("prodName: " + prodName);
        System.out.println("image: " + image);
        System.out.println("describle: " + describle);
        System.out.println("specifions: " + specifions);
        System.out.println("nameProducer: " + nameProducer);

        // Khởi tạo biến với giá trị mặc định
        double unitPrice = 0.0;
        int cateId = 0;

        // Kiểm tra tất cả trường đã nhập
        if (prodName == null || prodName.isEmpty() || image == null || nameProducer == null) {
            sendResponseText(response, "Hãy điền đầy đủ thông tin sản phẩm", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        //Kiểm tra ảnh sản phẩm
        if (image.isEmpty() || image == null) {

            sendResponseText(response, "Hãy nhập hình ảnh sản phẩm", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        //Kiểm tra mô tả
        if (describle.isEmpty() || describle == null) {

            sendResponseText(response, "Hãy nhập mô tả sản phẩm", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        //Kiểm tra thông số kỹ thuật
        if (specifions.isEmpty() || specifions == null) {

            sendResponseText(response, "Hãy nhập thông số kỹ thuật", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
//        Kiểm tra tên nhà sản xuất
        if (nameProducer.isEmpty() || nameProducer == null) {

            sendResponseText(response, "Hãy chọn nhà sản xuất", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        //Kiểm tra tên sản phẩm
        if (prodName.isEmpty() || prodName == null) {

            sendResponseText(response, "Hãy nhập tên sản phẩm", HttpServletResponse.SC_BAD_REQUEST);
            return;

            //Kiểm tra tên sản phẩm có trùng không
        } else if (ProductDAO.getInstance().isExistProdName(prodName)) {
            sendResponseText(response, "Tên sản phẩm đã tồn tại", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            //Chuyển đổi string thành int
            unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
            cateId = Integer.parseInt(request.getParameter("categoryId"));

            //Kiểm tra giá có hợp lệ không
            if (unitPrice <= 0) {
                sendResponseText(response, "Hãy nhập giá sản phẩm", HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            //Kiểm tra loại sản phẩm có hợp lệ không
            if (cateId <= 0) {
                sendResponseText(response, "Hãy chọn loại sản phẩm", HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

        } catch (NumberFormatException e) {
            //Bắt lỗi khi không nhập giá
            sendResponseText(response, "Hãy nhập số", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        try {
            //Nếu không có lỗi sẽ truyền thông tin các trường vào biến product để thực hiện thêm sản phẩm
            Products product = new Products(image, prodName, unitPrice, cateId, nameProducer, describle, specifions);
//            System.out.println(product); //In ra sản phẩm sau khi đã kiểm tra
            ProductDAO.getInstance().addProduct(product);
            sendResponseText(response, "Thêm sản phẩm thành công!", HttpServletResponse.SC_OK);
        } catch (Exception e) {
            sendResponseText(response, "Có lỗi trong quá trình thực hiện", HttpServletResponse.SC_BAD_REQUEST);
        }

    }
}
