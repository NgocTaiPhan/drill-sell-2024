package vn.hcmuaf.fit.drillsell.utils;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import vn.hcmuaf.fit.drillsell.dao.ProductDAO;
import vn.hcmuaf.fit.drillsell.model.Products;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.*;

public class ProductUtils {

    public static class ProductStatus {
        public static final int NORMAL = 0;
        public static final int REMOVED = 1;
        public static final int HIDDEN = 2;
    }

    public static class Category {
        public static final int BATTERY_DRILL = 1; // Máy khoan pin
        public static final int CONCRETE_DRILL = 2; // Máy khoan bê tông, Máy khoan búa
        public static final int IMPACT_DRILL = 3; // Máy khoan động lực
        public static final int HANDHELD_DRILL = 4; // Máy khoan cầm tay gia đình
        public static final int MINI_DRILL = 5; // Máy khoan mini
        public static final int DRILL_BATTERY = 6; // Pin máy khoan
        public static final int DRILL_CHARGER = 7; // Sạc pin máy khoan
        public static final int DRILL_BIT = 8; // Mũi khoan

        //        Phụ kiện máy khoan
        public static final Set<Integer> ACCESSORY = Set.of(DRILL_BATTERY, DRILL_CHARGER, DRILL_BIT);
    }
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

    public static String getFormattedUnitPrice(Products product) {
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        return currencyFormat.format(product.getUnitPrice() * 1000);
    }

    public static List<Products> getAllProducts() {
        return ProductDAO.getInstance().getAllProds(ProductStatus.NORMAL);
    }

    public static List<Products> getRemovedProducts() {
        return ProductDAO.getInstance().getAllProds(ProductStatus.REMOVED);
    }

    public static List<Products> getHiddenProducts() {
        return ProductDAO.getInstance().getAllProds(ProductStatus.HIDDEN);
    }

    public static void removeProduct(int productId) {
        ProductDAO.getInstance().changeProductStatus(productId, ProductStatus.REMOVED);
    }

    public static void hideProduct(int productId) {
        ProductDAO.getInstance().changeProductStatus(productId, ProductStatus.HIDDEN);
    }

    public static void addProduct(Products product) {
        ProductDAO.getInstance().addProduct(product);
    }

    public static void updateProduct(Products prod) {
        ProductDAO.getInstance().updateProd(prod);
    }

    public static Products getProductByName(String productName) {
        return ProductDAO.getInstance().getProductByName(productName);
    }

    public static List<Products> getAccessory() {
        return ProductDAO.getInstance().getProductByCategory(Category.ACCESSORY, ProductStatus.NORMAL);
    }

    public static List<Products> getProductByCategory(int categoryId) {
        return ProductDAO.getInstance().getProductByCategory(Set.of(categoryId), ProductStatus.NORMAL);
    }

    public static List<Products> getProductByProducer(String producerName) {
        return ProductDAO.getInstance().getProductByProducer(producerName, ProductStatus.NORMAL);

    }

    public static Products getProductById(int productId) {
        return ProductDAO.getInstance().getProdById(productId);
    }

    public static List<Products> getProductsByPage(int limit, int offset) {
        return ProductDAO.getInstance().getProductsByPage(limit, offset);
    }

    public static boolean isExistProdName(String productName) {
        Products product = ProductDAO.getInstance().getProductByName(productName);
        return product != null;

    }
    public static void main(String[] args) {
        String excelFilePath = "D:\\WorkSpace\\PraticeWebPrograming\\database\\drill-sell.xlsx";
        List<Products> products = readExcels(excelFilePath);

//        System.out.println(ProductUtils.getAccessory());

    }


}
