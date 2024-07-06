package vn.hcmuaf.fit.drillsell.controller.admin.productsmanagerment;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.ProductDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class HideProd {
    static void hideProd(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //Lấy id từ client sau đó ẩn sản phẩm dựa vào id
        String id = request.getParameter("productId");
        if (id != null) {
            int prodId = Integer.parseInt(id);
            ProductDAO.getInstance().hideProd(prodId);
            Notify.successNotify(response, "Ẩn sản phẩm thành công!", Page.NULL_PAGE);
        } else {
            Notify.errorNotify(response, "Xảy ra lỗi khi ẩn sản phẩm!", Page.NULL_PAGE);
        }

    }
}
