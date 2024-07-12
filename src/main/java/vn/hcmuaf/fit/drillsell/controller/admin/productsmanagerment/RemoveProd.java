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


public class RemoveProd {

    static void removeProd(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("productId"));
        HttpSession session = request.getSession();
        User auth = (User) session.getAttribute("auth");

        if (auth == null) {
            Notify.errorNotify(response, "Bạn chưa đăng nhập", Page.LOGIN_PAGE);
            return;
        }

        int userId = auth.getId();
        Products productId = ProductUtils.getProductById(id);
        ProductUtils.removeProduct(id);
        Notify.successNotify(response, "Xóa sản phẩm thành công!", Page.NULL_PAGE);
        Log log = new Log();
        log.setStatuss("Đã xóa sản phẩm có mã : " + productId.getProductId());
        log.setUserId(userId);
        String pre = " "+ productId;
        log.setValuess(null);
        LogDAO.insertUpdateOrderInLog(log, pre);
    }
}
