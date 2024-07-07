package vn.hcmuaf.fit.drillsell.controller.admin.productsmanagerment;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.LogDAO;
import vn.hcmuaf.fit.drillsell.dao.ProductDAO;
import vn.hcmuaf.fit.drillsell.model.Log;
import vn.hcmuaf.fit.drillsell.model.Products;
import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AddProd {

    static void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String prodName = request.getParameter("productName");
        String image = request.getParameter("imageUrl");
        String describle = request.getParameter("describle");
        String specifions = request.getParameter("specifions");
        String nameProducer = request.getParameter("nameProducer");
        HttpSession session = request.getSession();
        User auth = (User) session.getAttribute("auth");

        if (auth == null) {
            Notify.errorNotify(response, "Bạn chưa đăng nhập", Page.LOGIN_PAGE);
            return;
        }

        int userId = auth.getId();

        System.out.println("prodName: " + prodName);
        System.out.println("image: " + image);
        System.out.println("describle: " + describle);
        System.out.println("specifions: " + specifions);
        System.out.println("nameProducer: " + nameProducer);

        double unitPrice = 0.0;
        int cateId = 0;

        if (prodName == null || prodName.isEmpty()) {
            Notify.errorNotify(response, "Hãy nhập tên sản phẩm", Page.NULL_PAGE);
            return;
        }
        if (image == null || image.isEmpty()) {
            Notify.errorNotify(response, "Hãy nhập hình ảnh sản phẩm", Page.NULL_PAGE);
            return;
        }
        if (describle == null || describle.isEmpty()) {
            Notify.errorNotify(response, "Hãy nhập mô tả sản phẩm", Page.NULL_PAGE);
            return;
        }
        if (specifions == null || specifions.isEmpty()) {
            Notify.errorNotify(response, "Hãy nhập thông số kỹ thuật", Page.NULL_PAGE);
            return;
        }
        if (nameProducer == null || nameProducer.isEmpty()) {
            Notify.errorNotify(response, "Hãy chọn nhà sản xuất", Page.NULL_PAGE);
            return;
        }
        if (ProductDAO.getInstance().isExistProdName(prodName)) {
            Notify.errorNotify(response, "Tên sản phẩm đã tồn tại", Page.NULL_PAGE);
            return;
        }

        try {
            unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
            cateId = Integer.parseInt(request.getParameter("categoryId"));

            if (unitPrice <= 0) {
                Notify.errorNotify(response, "Hãy nhập giá sản phẩm", Page.NULL_PAGE);
                return;
            }
            if (cateId <= 0) {
                Notify.errorNotify(response, "Hãy chọn loại sản phẩm", Page.NULL_PAGE);
                return;
            }
        } catch (NumberFormatException e) {
            Notify.errorNotify(response, "Hãy nhập số", Page.NULL_PAGE);
            return;
        }

        try {
            Products product = new Products(image, prodName, unitPrice, cateId, nameProducer, describle, specifions);
            ProductDAO.getInstance().addProduct(product);

            // Lấy sản phẩm vừa được thêm từ cơ sở dữ liệu
            Products addedProduct = ProductDAO.getInstance().getProductByName(prodName);

            Notify.successNotify(response, "Thêm sản phẩm thành công!", Page.NULL_PAGE);

            // Ghi log thông tin sản phẩm vừa thêm
            Log log = new Log();
            log.setStatuss("Thêm sản phẩm");
            log.setUserId(userId); // Thiết lập userId cho log
            log.setValuess(" " + addedProduct);
            LogDAO.insertUpdateOrderInLog(log, null);

        } catch (Exception e) {
            Notify.errorNotify(response, "Có lỗi trong quá trình thực hiện", Page.NULL_PAGE);
        }
    }

    public static void addProductFromExcel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
