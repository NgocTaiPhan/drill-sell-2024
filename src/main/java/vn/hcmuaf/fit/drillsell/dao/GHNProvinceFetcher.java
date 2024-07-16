package vn.hcmuaf.fit.drillsell.dao;
import java.util.HashMap;
import java.util.Map;
public class GHNProvinceFetcher {
//    private static final String API_URL = "https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/province";
//    private static final String TOKEN = "80117275-f321-11ee-8bfa-8a2dda8ec551"; // Replace with your actual token
//
//    public static void main(String[] args) {
//        fetchProvinces();
//    }
//
//    public static void fetchProvinces() {
//        try {
//            URL url = new URL(API_URL);
//            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
//            connection.setRequestMethod("GET");
//            connection.setRequestProperty("Content-Type", "application/json");
//            connection.setRequestProperty("Token", TOKEN);
//
//            int responseCode = connection.getResponseCode();
//            System.out.println("Response Code: " + responseCode);
//
//            BufferedReader in;
//            if (responseCode == HttpURLConnection.HTTP_OK) {
//                in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
//            } else {
//                in = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
//            }
//
//            StringBuilder response = new StringBuilder();
//            String inputLine;
//            while ((inputLine = in.readLine()) != null) {
//                response.append(inputLine);
//            }
//            in.close();
//
//            // Parse JSON response
//            Gson gson = new Gson();
//            JsonObject jsonResponse = gson.fromJson(response.toString(), JsonObject.class);
//            JsonArray data = jsonResponse.getAsJsonArray("data");
//
//            // Iterate through provinces
//            for (JsonElement element : data) {
//                JsonObject province = element.getAsJsonObject();
//                String provinceId = province.get("ProvinceID").getAsString();
//                String provinceName = province.get("ProvinceName").getAsString();
//
//                System.out.println("Province ID: " + provinceId + ", Province Name: " + provinceName);
//            }
//
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }
    private static final Map<String, String> provinceNameMap = new HashMap<>();

    static {
        // Thêm tất cả các cặp key-value vào map
        provinceNameMap.put("269", "Lào Cai");
        provinceNameMap.put("268", "Hưng Yên");
        provinceNameMap.put("267", "Hòa Bình");
        provinceNameMap.put("266", "Sơn La");
        provinceNameMap.put("265", "Điện Biên");
        provinceNameMap.put("264", "Lai Châu");
        provinceNameMap.put("263", "Yên Bái");
        provinceNameMap.put("262", "Bình Định");
        provinceNameMap.put("261", "Ninh Thuận");
        provinceNameMap.put("260", "Phú Yên");
        provinceNameMap.put("259", "Kon Tum");
        provinceNameMap.put("258", "Bình Thuận");
        provinceNameMap.put("253", "Bạc Liêu");
        provinceNameMap.put("252", "Cà Mau");
        provinceNameMap.put("250", "Hậu Giang");
        provinceNameMap.put("249", "Bắc Ninh");
        provinceNameMap.put("248", "Bắc Giang");
        provinceNameMap.put("247", "Lạng Sơn");
        provinceNameMap.put("246", "Cao Bằng");
        provinceNameMap.put("245", "Bắc Kạn");
        provinceNameMap.put("244", "Thái Nguyên");
        provinceNameMap.put("243", "Quảng Nam");
        provinceNameMap.put("242", "Quảng Ngãi");
        provinceNameMap.put("241", "Đắk Nông");
        provinceNameMap.put("240", "Tây Ninh");
        provinceNameMap.put("239", "Bình Phước");
        provinceNameMap.put("238", "Quảng Trị");
        provinceNameMap.put("237", "Quảng Bình");
        provinceNameMap.put("236", "Hà Tĩnh");
        provinceNameMap.put("235", "Nghệ An");
        provinceNameMap.put("234", "Thanh Hóa");
        provinceNameMap.put("233", "Ninh Bình");
        provinceNameMap.put("232", "Hà Nam");
        provinceNameMap.put("231", "Nam Định");
        provinceNameMap.put("230", "Quảng Ninh");
        provinceNameMap.put("229", "Phú Thọ");
        provinceNameMap.put("228", "Tuyên Quang");
        provinceNameMap.put("227", "Hà Giang");
        provinceNameMap.put("226", "Thái Bình");
        provinceNameMap.put("225", "Hải Dương");
        provinceNameMap.put("224", "Hải Phòng");
        provinceNameMap.put("223", "Thừa Thiên - Huế");
        provinceNameMap.put("221", "Vĩnh Phúc");
        provinceNameMap.put("220", "Cần Thơ");
        provinceNameMap.put("219", "Kiên Giang");
        provinceNameMap.put("218", "Sóc Trăng");
        provinceNameMap.put("217", "An Giang");
        provinceNameMap.put("216", "Đồng Tháp");
        provinceNameMap.put("215", "Vĩnh Long");
        provinceNameMap.put("214", "Trà Vinh");
        provinceNameMap.put("213", "Bến Tre");
        provinceNameMap.put("212", "Tiền Giang");
        provinceNameMap.put("211", "Long An");
        provinceNameMap.put("210", "Đắk Lắk");
        provinceNameMap.put("209", "Lâm Đồng");
        provinceNameMap.put("208", "Khánh Hòa");
        provinceNameMap.put("207", "Gia Lai");
        provinceNameMap.put("206", "Bà Rịa - Vũng Tàu");
        provinceNameMap.put("205", "Bình Dương");
        provinceNameMap.put("204", "Đồng Nai");
        provinceNameMap.put("203", "Đà Nẵng");
        provinceNameMap.put("202", "Hồ Chí Minh");
        provinceNameMap.put("201", "Hà Nội");
    }

    public static String getProvinceNameById(String provinceId) {
        return provinceNameMap.getOrDefault(provinceId, provinceId);
    }
}
