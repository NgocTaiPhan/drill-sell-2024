package vn.hcmuaf.fit.drillsell.controller.admin.repo_management;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.utils.FormUtils;
import vn.hcmuaf.fit.drillsell.utils.RepoUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class UpdateQuantity {
    public static void updateQuantity(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");
        int productId = FormUtils.assignInput(request, "productId");
        int quantity = FormUtils.assignInput(request, "quantity");
        if (checkValid(productId, quantity, response)) {
            updateQuantityProcess(productId, quantity, user.getId(), response);
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
        if (quantity < 0) {
            Notify.errorNotify(response, "Số nhập vào không hợp lệ", Page.NULL_PAGE);
            return false;
        }
        return true;
    }

    public static void updateQuantityProcess(int productId, int quantity, int userId, HttpServletResponse response) throws
            IOException {
        RepoUtils.addQuantity(productId, quantity, userId);
        Notify.successNotify(response, "Thay đổi số lượng thành công", Page.NULL_PAGE);

    }
}

