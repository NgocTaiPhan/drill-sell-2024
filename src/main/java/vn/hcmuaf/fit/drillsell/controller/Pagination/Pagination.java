package vn.hcmuaf.fit.drillsell.controller.Pagination;

import vn.hcmuaf.fit.drillsell.dao.ProductDAO;
import vn.hcmuaf.fit.drillsell.model.Products;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

//Phân trang sản phẩm
@WebServlet(name = "Pagination", value = "/pagination")
public class Pagination extends HttpServlet {

    private static final int PRODUCTS_PER_PAGE = 12; // Số sản phẩm trên mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO pDAO = new ProductDAO();

        // Lấy vị trí hiện tại
        int currentPage = 1;
        try {
            currentPage = Integer.parseInt(request.getParameter("index"));
        } catch (NumberFormatException e) {
            System.out.println(e.getMessage());
        }

        int totalProducts = pDAO.getAllCategory().size();
        int totalPages = (int) Math.ceil((double) totalProducts / PRODUCTS_PER_PAGE);

        // Đảm bảo trang hiện tại hợp lệ
        currentPage = Math.max(1, Math.min(currentPage, totalPages));

        // Tính toán vị trí bắt đầu của sản phẩm trên trang hiện tại
        int offset = (currentPage - 1) * PRODUCTS_PER_PAGE;

        // Lấy danh sách sản phẩm cho trang hiện tại
        List<Products> products = pDAO.getProductsByPage(offset, PRODUCTS_PER_PAGE);

        request.setAttribute("products", products);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        // Không cần xử lý POST trong trường hợp này
    }
}
