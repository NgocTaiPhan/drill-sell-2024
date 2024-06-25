package vn.hcmuaf.fit.drillsell.controller.admin.productsmanagerment;

import vn.hcmuaf.fit.drillsell.dao.ProductDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import static vn.hcmuaf.fit.drillsell.controller.notify.Notify.sendResponeText;

public class RemoveProd {

    static void removeProd(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("productId"));

        ProductDAO productDAO = new ProductDAO();
        productDAO.removeProduct(id);
        sendResponeText(response, "Xóa sản phẩm thành công!", HttpServletResponse.SC_OK);
    }
}
