package vn.hcmuaf.fit.drillsell.utils;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import vn.hcmuaf.fit.drillsell.model.Products;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.*;

public class ProductUtils {
    public static List<Products> readExcel(String excelFilePath) {
        List<Products> products = new ArrayList<>();

        try (Scanner scanner = new Scanner(new File(excelFilePath))) {

            // Bỏ qua dòng tiêu đề nếu có
            if (scanner.hasNextLine()) {
                scanner.nextLine(); // Bỏ qua dòng tiêu đề
            }

            while (scanner.hasNextLine()) {
                String line = scanner.nextLine();
                String[] values = line.split(","); // Phân tích dữ liệu từng dòng

                // Xử lý từng giá trị
                if (values.length >= 6) { // Chỉ xử lý nếu đủ số lượng cột
                    String image = values[0].trim();
                    String productName = values[1].trim();
                    double unitPrice = Double.parseDouble(values[2].trim());
                    int categoryId = Integer.parseInt(values[3].trim());
                    String nameProducer = values[4].trim();
                    String describle = values[5].trim();
                    String specifions = values[6].trim();

                    Products product = new Products(image, productName, unitPrice, categoryId, nameProducer, describle, specifions);
                    products.add(product);
                }
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        return products;
    }

    public static List<Products> readExcels(String excelFilePath) {
        List<Products> products = new ArrayList<>();

        try (FileInputStream fis = new FileInputStream(new File(excelFilePath));
             Workbook workbook = new XSSFWorkbook(fis)) {

            Sheet sheet = workbook.getSheetAt(0); // Lấy sheet đầu tiên
            Iterator<Row> iterator = sheet.iterator();

            // Bỏ qua dòng tiêu đề nếu có
            if (iterator.hasNext()) {
                iterator.next(); // Bỏ qua dòng tiêu đề
            }

            while (iterator.hasNext()) {
                Row currentRow = iterator.next();
                Iterator<Cell> cellIterator = currentRow.iterator();

                // Xử lý từng cell trong dòng
                if (cellIterator.hasNext()) {
                    String image = cellIterator.next().getStringCellValue().trim();
                    String productName = cellIterator.next().getStringCellValue().trim();
                    double unitPrice = cellIterator.next().getNumericCellValue();
                    int categoryId = (int) cellIterator.next().getNumericCellValue();
                    String nameProducer = cellIterator.next().getStringCellValue().trim();
                    String describle = cellIterator.next().getStringCellValue().trim();
                    String specifications = cellIterator.next().getStringCellValue().trim();

                    Products product = new Products(image, productName, unitPrice, categoryId, nameProducer, describle, specifications);
                    products.add(product);
                }
            }

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return products;
    }


    public static void main(String[] args) {
        String excelFilePath = "D:\\WorkSpace\\PraticeWebPrograming\\database\\drill-sell.xlsx";
        List<Products> products = readExcels(excelFilePath);

        System.out.println(products.size());

    }
}
