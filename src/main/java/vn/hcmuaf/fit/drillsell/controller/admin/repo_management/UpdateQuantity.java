package vn.hcmuaf.fit.drillsell.controller.admin.repo_management;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.CartDAO;
import vn.hcmuaf.fit.drillsell.dao.LogDAO;
import vn.hcmuaf.fit.drillsell.dao.repo.RepoDAO;
import vn.hcmuaf.fit.drillsell.model.Log;
import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.utils.FormUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class UpdateQuantity {
    public static void updateQuantity(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId = FormUtils.assignInput(request, "productId");
        int quantity = FormUtils.assignInput(request, "quantity");
        if (checkValid(productId, quantity, response)) {
            updateQuantityProcess(productId, quantity, response, request);
        } else {
//            Notify.errorNotify(response, "Lỗi trong quá trình thực hiện!", Page.NULL_PAGE);
        }

    }

    public static boolean checkValid(int productId, int quantity, HttpServletResponse response) throws
            IOException {
//        int oldQuantity = (int) RepoDAO.getInstance().getRepoWithProdId(productId).get("importQuantity");
        if (productId == 0) {
            Notify.errorNotify(response, "Lỗi trong quá trình thực hiện!", Page.NULL_PAGE);
            return false;
        }
        if (quantity == 0) {
            Notify.errorNotify(response, "Bạn chưa nhập số lượng mới", Page.NULL_PAGE);
            return false;
        }
//        if (quantity - oldQuantity < 0) {
//            Notify.errorNotify(response, "Số lượng mới không được nhỏ hơn số lượng có trong kho", Page.NULL_PAGE);
//            return false;
//        }
        return true;
    }
    public static void updateQuantityProcess(int productId, int quantity, HttpServletResponse response, HttpServletRequest request) throws
            IOException {
        HttpSession session = request.getSession();
        User auth = (User) session.getAttribute("auth");
        String previousInfo = "Mã sản phẩm: " + productId + ", Số lượng: " + CartDAO.getQuantityRepo(productId) ;

        RepoDAO.getInstance().addQuantity(productId, quantity);
        Log log = new Log();
        log.setUserId(auth.getId());
        String values = "Mã sản phẩm: " + productId + ", Số lượng: " + CartDAO.getQuantityRepo(productId);
        log.setValuess(values);
        log.setStatuss("Cập nhật kho hàng");
        LogDAO.insertUpdateOrderInLog(log, previousInfo);
        Notify.successNotify(response, "Thay đổi số lượng thành công", Page.NULL_PAGE);

    }
}

