package vn.hcmuaf.fit.drillsell.utils;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import vn.hcmuaf.fit.drillsell.dao.repo.RepoDAO;

import java.io.FileOutputStream;
import java.util.List;
import java.util.Map;

public class RepoUtils {
    public static List<Map<String, Object>> getRepo() {
        List<Map<String, Object>> repoValue = RepoDAO.getInstance().getRepo();
        for (Map<String, Object> repoMap : repoValue) {
            int productId = (int) repoMap.get("productId");
            RepoDAO.getInstance().updateImportQuantityByProductId(productId, getAllQuantityFromRepoByProductId(productId));
            int importQuantity = (int) repoMap.get("importQuantity");
        }
        return repoValue;

    }

    public static void addQuantity(int productId, int quantity, int userId) {
        RepoDAO.getInstance().addQuantity(productId, quantity, userId);
    }

    public static int getAllQuantityFromRepoByProductId(int productId) {
        return RepoDAO.getInstance().getAllQuantityFromRepoByProductId(productId);
    }

    public static void export() {
        List<Map<String, Object>> repoList = RepoUtils.getRepo(); // Thay đổi RepoUtils bằng class của bạn

        // Tạo file trên server
        String filePath = "D:\\Downloads\\repo.xlsx";
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Repo Data");

            // Tạo dòng tiêu đề
            Row headerRow = sheet.createRow(0);
            String[] headers = {"Repo ID", "User ID", "Product ID", "Import Quantity", "Import Date", "Import Price", "Price", "Product Name"};
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
            }

            // Điền dữ liệu
            int rowNum = 1;
            for (Map<String, Object> repo : repoList) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(repo.get("repoId").toString());
                row.createCell(1).setCellValue(repo.get("userId").toString());
                row.createCell(2).setCellValue(repo.get("productId").toString());
                row.createCell(3).setCellValue(repo.get("importQuantity").toString());
                row.createCell(4).setCellValue(repo.get("importDate") != null ? repo.get("importDate").toString() : "");
                row.createCell(5).setCellValue(repo.get("importPrice").toString());
                row.createCell(6).setCellValue(repo.get("price").toString());
                row.createCell(7).setCellValue(repo.get("productName").toString());
            }

            // Ghi vào file
            try (FileOutputStream fileOut = new FileOutputStream(filePath)) {
                workbook.write(fileOut);
            }

            // Gửi phản hồi tới client
            System.out.println("Thành công");
        } catch (Exception e) {
            e.printStackTrace();
//        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while creating the Excel file.");
        }


    }

    public static void main(String[] args) {
        System.out.println(getAllQuantityFromRepoByProductId(2));
    }
}
