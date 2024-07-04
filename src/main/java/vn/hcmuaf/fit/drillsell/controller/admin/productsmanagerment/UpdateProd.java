package vn.hcmuaf.fit.drillsell.controller.admin.productsmanagerment;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.ProductDAO;
import vn.hcmuaf.fit.drillsell.model.Products;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UpdateProd {
    static void updateProd(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("productId"));
        String prodName = request.getParameter("productName");
        String image = request.getParameter("productImage");
        double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String nameProducer = request.getParameter("nameProducer");
        String describle = request.getParameter("describle");
        String specifions = request.getParameter("specifions");
        try {
            Products prod = new Products(id, image, prodName, unitPrice, categoryId, nameProducer, describle, specifions);
            ProductDAO productDAO = new ProductDAO();
            productDAO.updateProd(prod);
            Notify.successNotify(response, "Sửa thông tin sản phẩm thành công", Page.NULL_PAGE);
        } catch (Exception e) {
            Notify.errorNotify(response, "Có lỗi trong quá trình thực hiện", Page.NULL_PAGE);

        }


    }
}
