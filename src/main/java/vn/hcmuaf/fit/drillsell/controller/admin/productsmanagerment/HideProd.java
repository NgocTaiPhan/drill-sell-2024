package vn.hcmuaf.fit.drillsell.controller.admin.productsmanagerment;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.LogDAO;
import vn.hcmuaf.fit.drillsell.model.Log;
import vn.hcmuaf.fit.drillsell.model.Products;
import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.utils.ProductUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
public class HideProd {
    static void hideProd(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //Lấy id từ client sau đó ẩn sản phẩm dựa vào id
        String id = request.getParameter("productId");
        HttpSession session = request.getSession();
        User auth = (User) session.getAttribute("auth");
        Products productId = ProductUtils.getProductById(Integer.parseInt(id));


        if (auth == null) {
            Notify.errorNotify(response, "Bạn chưa đăng nhập", Page.LOGIN_PAGE);
            return;
        }

        int userId = auth.getId();
        if (id != null) {
            int prodId = Integer.parseInt(id);
            ProductUtils.hideProduct(prodId);
            Notify.successNotify(response, "Ẩn sản phẩm thành công!", Page.NULL_PAGE);
            Log log = new Log();
            log.setStatuss("Đã ẩn sản phẩm có mã : " + productId.getProductId());
            log.setUserId(userId);
            String pre = " "+ productId;
            log.setValuess(null);
            LogDAO.insertUpdateOrderInLog(log, pre);
        } else {
            Notify.errorNotify(response, "Xảy ra lỗi khi ẩn sản phẩm!", Page.NULL_PAGE);
        }
    }
}
