package vn.hcmuaf.fit.drillsell.controller.admin.productsmanagerment;

import vn.hcmuaf.fit.drillsell.controller.notify.Notify;
import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.dao.ProductDAO;
import vn.hcmuaf.fit.drillsell.model.Products;
import vn.hcmuaf.fit.drillsell.utils.ProductUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.util.List;

@WebServlet(name = "AddExcel", value = "/admin/add-excel")
public class AddExcel extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Đọc file Excel từ request
        Part filePart = request.getPart("excelFile");
        String fileName = filePart.getSubmittedFileName();

        String uploadPath = "D:/uploads/"; // Thay đổi đường dẫn lưu file tùy vào môi trường của bạn
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Lưu file vào thư mục upload
        try (InputStream input = filePart.getInputStream();
             OutputStream output = new FileOutputStream(uploadPath + fileName)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Xử lý file Excel đã lưu trong readExcel() method
        List<Products> products = ProductUtils.readExcels(uploadPath + fileName);
        ProductDAO.getInstance().addProdFormExcel(products);
        // Gửi danh sách sản phẩm (nếu cần) về client
        // Ví dụ: có thể gửi về JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Notify.successNotify(response, "Xử lý thành công", Page.NULL_PAGE);

    }
}
