package vn.hcmuaf.fit.drillsell.controller.admin.productsmanagerment;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.ProductDAO;
import vn.hcmuaf.fit.drillsell.model.Products;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

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
        if (prodName == null || prodName.isEmpty() ) {
            Notify.errorNotify(response, "Hãy nhập tên sản phẩm", Page.NULL_PAGE);
            return;
        }
        //Kiểm tra ảnh sản phẩm
        if (image.isEmpty() || image == null) {

            Notify.errorNotify(response, "Hãy nhập hình ảnh sản phẩm", Page.NULL_PAGE);
            return;
        }
        //Kiểm tra mô tả
        if (describle.isEmpty() || describle == null) {

            Notify.errorNotify(response, "Hãy nhập mô tả sản phẩm", Page.NULL_PAGE);
            return;
        }
        //Kiểm tra thông số kỹ thuật
        if (specifions.isEmpty() || specifions == null) {

            Notify.errorNotify(response, "Hãy nhập thông số kỹ thuật", Page.NULL_PAGE);
            return;
        }
//        Kiểm tra tên nhà sản xuất
        if (nameProducer.isEmpty() || nameProducer == null) {

            Notify.errorNotify(response, "Hãy chọn nhà sản xuất", Page.NULL_PAGE);
            return;
        }
        //Kiểm tra tên sản phẩm
        if (prodName.isEmpty() || prodName == null) {

            Notify.errorNotify(response, "Hãy nhập tên sản phẩm", Page.NULL_PAGE);
            return;

            //Kiểm tra tên sản phẩm có trùng không
        } else if (ProductDAO.getInstance().isExistProdName(prodName)) {
            Notify.errorNotify(response, "Tên sản phẩm đã tồn tại", Page.NULL_PAGE);
            return;
        }

        try {
            //Chuyển đổi string thành int
            unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
            cateId = Integer.parseInt(request.getParameter("categoryId"));

            //Kiểm tra giá có hợp lệ không
            if (unitPrice <= 0) {
                Notify.errorNotify(response, "Hãy nhập giá sản phẩm", Page.NULL_PAGE);
                return;
            }
            //Kiểm tra loại sản phẩm có hợp lệ không
            if (cateId <= 0) {
                Notify.errorNotify(response, "Hãy chọn loại sản phẩm", Page.NULL_PAGE);
                return;
            }

        } catch (NumberFormatException e) {
            //Bắt lỗi khi không nhập giá
            Notify.errorNotify(response, "Hãy nhập số", Page.NULL_PAGE);
            return;
        }
        try {
            //Nếu không có lỗi sẽ truyền thông tin các trường vào biến product để thực hiện thêm sản phẩm
            Products product = new Products(image, prodName, unitPrice, cateId, nameProducer, describle, specifions);
//            System.out.println(product); //In ra sản phẩm sau khi đã kiểm tra
            ProductDAO.getInstance().addProduct(product);
            Notify.successNotify(response, "Thêm sản phẩm thành công!", Page.NULL_PAGE);
        } catch (Exception e) {
            Notify.errorNotify(response, "Có lỗi trong quá trình thực hiện", Page.NULL_PAGE);
        }

    }
}
