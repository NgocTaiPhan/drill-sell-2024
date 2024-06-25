package vn.hcmuaf.fit.drillsell.controller.admin.productsmanagerment;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@WebServlet(name = "UpLoadImage", value = "/upload")
public class UpLoadImage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Part filePart = request.getPart("upload");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            InputStream fileContent = filePart.getInputStream();

            // Lưu file vào thư mục (chú ý bảo mật và kiểm tra loại file)
            String uploadPath = getServletContext().getRealPath("/") + "uploads/" + fileName;
            Files.copy(fileContent, Paths.get(uploadPath), StandardCopyOption.REPLACE_EXISTING);

            // Trả về URL của file đã upload cho CKFinder
            String fileUrl = request.getContextPath() + "/uploads/" + fileName;
            response.getWriter().write("<script>window.parent.CKFinder.tools.callFunction(1, '" + fileUrl + "');</script>");
        } catch (Exception e) {
            // Xử lý lỗi
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("<script>window.parent.CKFinder.tools.callFunction(1, '', 'Lỗi khi tải lên file.');</script>");
        }
    }
}